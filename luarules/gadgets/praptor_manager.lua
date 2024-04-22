function gadget:GetInfo()
	return {
		name		= "Playable Raptors Extra Behaviour Handler",
		desc		= "Handles additional behaviour such us recyling when a factory upgrades itself",
		author		= "robert the pie",
		date		= "March 2024",
		license		= "GNU GPL, v2 or later",
		layer		= 1,
		enabled		= true,
	}
end

if Spring.GetModOptions().playableraptors ~= true then return false end


--------------------
--- GLOBAL SPACE ---
--------------------
--[[
	@TODO:
	Inherit health % on upgrade
]]

local reclaimable = {}
local skipGrowth = {}
local reclaimableMetal = {}
local mex = {
	[UnitDefNames.prap_mex_t1.id]=true
}
local foundling = {
	[UnitDefNames.prap_foundling.id]=true
}

for unitDefID, unitDef in pairs(UnitDefs) do
	if unitDef.customParams then
		if unitDef.customParams.upgradable then
		reclaimable[unitDefID] = unitDef.customParams.upgradable
		reclaimableMetal[unitDefID] = unitDef.metalCost
			if unitDef.customParams.skipgrowth then
				skipGrowth[unitDefID] = true
			end
		end
	end
end

-- is this unit ugrading itself
local function isUpgradee(unitID)
	local x, _, z = Spring.GetUnitPosition(unitID)
	local units = Spring.GetUnitsInCylinder(x, z, 10)
	for _, uID in pairs(units) do
		if uID ~= unitID then
			local uDefID = Spring.GetUnitDefID(uID)
			if reclaimable[uDefID] then
				return uID, uDefID
			end
		end
	end
	return false
end


--------------------
--- SYNCED SPACE ---
--------------------
if gadgetHandler:IsSyncedCode() then

local metalSpots = {}
local hiveMexSpots = {}

-- get all mexes in range, sorted
local function findChildMexes(a,b, range)
	local mexes = {}
	if metalSpots then
		local sqrdRange = range*range
		for i = 1, #metalSpots do
			local spot = metalSpots[i]
			local x = math.abs(spot.x - a)
			if x < range then
				local z = math.abs(spot.z - b)
				if z < range then
					if x*x + z*z < sqrdRange then
						mexes[#mexes+1] = spot
					end
				end
			end
		end
		table.sort(mexes, function(ms1, ms2)
			return math.distance2dSquared(ms1.x, ms1.z, a, b) < math.distance2dSquared(ms2.x, ms2.z, a, b)
		end)
	end
	return mexes
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	-- is this unit an upgrade of ours
	if reclaimable[unitDefID] then
		if builderID then
			local builderDefID = Spring.GetUnitDefID(builderID)
			if reclaimable[builderDefID] then

				-- put everything in the right state for upgrading
				Spring.SetUnitNoSelect(unitID, true)
				local env
				if not skipGrowth[unitDefID] then
					env = Spring.UnitScript.GetScriptEnv(unitID)
					if env then
						Spring.UnitScript.CallAsUnit(unitID, env.prepGrow)
					end
				end
				-- tell the builder that it is building an upgrade (so that it moves it to the centre)
				env = Spring.UnitScript.GetScriptEnv(builderID)
				if env then
					Spring.UnitScript.CallAsUnit(builderID, env.upgradeState)
				end

				-- inherit the list of locally sourcable metal spots
				hiveMexSpots[unitID] = hiveMexSpots[builderID]
			elseif foundling[builderDefID] then
				Spring.SetUnitHealth(unitID, {health=1,build=1})
				Spring.DestroyUnit(builderID, false, true)
			end
		end
		if not hiveMexSpots[unitID] then
			local x,y,z = Spring.GetUnitPosition(unitID)
			hiveMexSpots[unitID] = findChildMexes(x,z, UnitDefs[unitDefID].buildDistance + 30)
		end
	end
end

function gadget:AllowUnitCreation(unitDefID, builderID, builderTeam, x, y, z, facing)
	-- are we building a mex via a lab
	if mex[unitDefID] and builderID then
		local builderDefID = Spring.GetUnitDefID(builderID)
		if reclaimable[builderDefID] then

			-- animate the lab to be building at a free mex position, or cancel the order
			local env = Spring.UnitScript.GetScriptEnv(builderID)
			if env and hiveMexSpots[builderID] then

				-- find nearest free mex spot
				for i = 1, #hiveMexSpots[builderID] do
					local spot = hiveMexSpots[builderID][i]
					-- @TODO: convert if not blocked to read the returned list for a mex to upgrade
					if not Spring.GetGroundBlocked(spot.x-5,spot.z+5,spot.x-5,spot.z+5) then

						-- put the position into local space
						local x,y,z = Spring.GetUnitPosition(builderID)
						x = spot.x - x
						y = spot.y - y
						z = spot.z - z

						-- rotate the local cordiante to allaign with the building
						local facing = Spring.GetUnitBuildFacing(builderID)
						if facing == 1 then
							x, z = -z, x
						elseif facing == 2 then
							x, z = -x, -z
						elseif facing == 3 then
							x, z = z, -x
						end

						Spring.UnitScript.CallAsUnit(builderID, env.placingMex, x, y, z)
						return true
					end
				end
				return false
			end
		end
	end
	return true
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
	local upgradable = reclaimable[unitDefID]
	if upgradable then
		local parent, parentDefID = isUpgradee(unitID)
		if parent then

			-- prep the growth/upgrade animation
			local env = Spring.UnitScript.GetScriptEnv(unitID)
			if env then
				Spring.UnitScript.CallAsUnit(unitID, env.growOut)
			end
			Spring.SetUnitNoSelect(unitID, false)
			env = Spring.UnitScript.GetScriptEnv(parent)
			if env then
				Spring.UnitScript.CallAsUnit(parent, env[upgradable])
			end

			local commandQueue = Spring.GetUnitCommands(parent, -1)
			if commandQueue[1] then
				for _,command in pairs(commandQueue) do
					Spring.GiveOrderToUnit(unitID, command.id, command.params, command.options)
				end
			end

			-- refund the parent
			-- Spring.AddTeamResource(unitTeam, "metal", reclaimableMetal[parentDefID])
			Spring.SetUnitCosts(parent, {metalCost = 1,	energyCost = 1,})
			Spring.SetUnitCosts(unitID, {metalCost = reclaimableMetal[parentDefID] + reclaimableMetal[unitDefID]})

		end
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
	if reclaimable[unitDefID] then
		hiveMexSpots[unitID] = nil
	end
end

function gadget:Initialize()
	metalSpots = GG["resource_spot_finder"] and GG["resource_spot_finder"].metalSpotsList or nil
end


--------------------
-- UNSYNCED SPACE --
--------------------
else
local playerTeamID = Spring.GetLocalTeamID()

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
	-- if our upgrade unit finished, find its builder, see if it is selected, add this to selection
	local upgradable = reclaimable[unitDefID]
	if upgradable then
		local parent = isUpgradee(unitID)
		if parent then
			if unitTeam == playerTeamID and Spring.IsUnitSelected(parent) then
				Spring.SelectUnitArray ({[1] = unitID}, true) 
			end
			Spring.SetUnitNoSelect(parent, true)
		end
	end
end

end