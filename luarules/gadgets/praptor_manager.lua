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
local mex,eco,foundling = {},{},{}
for _, name in pairs({
	"prap_mex_t1",
}) do
	if UnitDefNames[name] then
		mex[UnitDefNames[name].id] = true
	end
end
for _, name in pairs({
	"prap_sol_t1",
}) do
	if UnitDefNames[name] then
		eco[UnitDefNames[name].id] = true
	end
end
for _, name in pairs({
	"prap_foundling",
}) do
	if UnitDefNames[name] then
		foundling[UnitDefNames[name].id] = true
	end
end

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

local SPRAWL_OUT_POSITIONS_X = {
	-- inner ring
	[1]=120,
	[2]=37.1,
	[3]=-97.1,
	[4]=-97.1,
	[5]=37.1,
	-- outer ring
	[6]=240,
	[7]=74.2,
	[8]=-194.2,
	[9]=-194.2,
	[10]=74.2,
	-- two roots from 1-6-11/12
	[11]=240	+	97.1,
	[12]=240	+	97.1,
	-- two roots from 2-7-13/14
	[13]=74.2	-	37.1,
	[14]=74.2	+	97.1,
	-- two roots from 3-8-15/16
	[15]=-194.2	-	120,
	[16]=-194.2	-	37.1,
	-- two roots from 4-9-17/18
	[17]=-194.2	-	120,
	[18]=-194.2	-	37.1,
	-- two roots from 5-10-19/20
	[19]=74.2	+	97.1,
	[20]=74.2	-	37.1,
}
local SPRAWL_OUT_POSITIONS_Z = {
	-- inner ring
	[1]=0,
	[2]=114.1,
	[3]=70.5,
	[4]=-70.5,
	[5]=-114.1,
	-- outer ring
	[6]=0,
	[7]=228.2,
	[8]=141,
	[9]=-141,
	[10]=-228.2,
	-- two roots from 1-6-11/12
	[11]=0		+	70.5,
	[12]=0		-	70.5,
	-- two roots from 2-7-13/14
	[13]=228.2	+	114.1,
	[14]=228.2	+	70.5,
	-- two roots from 3-8-15/16
	[15]=141	+	0,
	[16]=141.5	+	114.1,
	-- two roots from 4-9-17/18
	[17]=-141	+	0,
	[18]=-141.5	-	114.1,
	-- two roots from 5-10-19/20
	[19]=-228.2	-	70.5,
	[20]=-228.2	-	114.1,
}

local metalSpots = {}
local hiveMexSpots = {}
local hiveEcoSpots = {}
-- points to the same table as hiveEcoSpots except it's keyed by each wind turbine pointing to the hive eco spot that it belongs to
local EcoEcoSpots = {}

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
				hiveEcoSpots[unitID] = hiveEcoSpots[builderID]
				hiveEcoSpots[builderID] = nil
			elseif foundling[builderDefID] then
				Spring.SetUnitHealth(unitID, {health=1,build=1})
				Spring.DestroyUnit(builderID, false, true)
			end
		end
		if not hiveMexSpots[unitID] then
			local x,y,z = Spring.GetUnitPosition(unitID)
			hiveMexSpots[unitID] = findChildMexes(x,z, UnitDefs[unitDefID].buildDistance + 30)
			hiveEcoSpots[unitID] = {[0]=0}
		end
	elseif eco[unitDefID] and builderID then
		local spots = hiveEcoSpots[builderID]
		if spots then
			for i = 1, 20 do
				if spots[i] == false then
					spots[i] = unitID
					EcoEcoSpots[unitID] = hiveEcoSpots[builderID]
				end
			end
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
					if not Spring.GetGroundBlocked(spot.x-4,spot.z-4,spot.x+4,spot.z+4) then

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
	elseif eco[unitDefID] and builderID then
		local builderDefID = Spring.GetUnitDefID(builderID)
		if reclaimable[builderDefID] then
			local env = Spring.UnitScript.GetScriptEnv(builderID)
			if env and hiveEcoSpots[builderID] then
				local spots = hiveEcoSpots[builderID]
				local bx,by,bz = Spring.GetUnitPosition(builderID)
				local bfacing = Spring.GetUnitBuildFacing(builderID)
				local px, pz
				if bfacing == 0 then
					for i = 1, 20 do
						px = bx + SPRAWL_OUT_POSITIONS_X[i]
						pz = bz + SPRAWL_OUT_POSITIONS_Z[i]
						if not spots[i] then
							if not Spring.GetGroundBlocked(
								px+4,
								pz+4,
								px-4,
								pz-4
							) then
								local height = Spring.GetGroundHeight(px,pz) - by
								spots[i] = false
								Spring.UnitScript.CallAsUnit(builderID, env.placingMex, SPRAWL_OUT_POSITIONS_X[i], height, SPRAWL_OUT_POSITIONS_Z[i])
								return true
							end
						end
					end
					return false
				elseif bfacing == 1 then
					for i = 1, 20 do
						px = bx - SPRAWL_OUT_POSITIONS_Z[i]
						pz = bz + SPRAWL_OUT_POSITIONS_X[i]
						if not spots[i] then
							if not Spring.GetGroundBlocked(
								px+4,
								pz+4,
								px-4,
								pz-4
							) then
								local height = Spring.GetGroundHeight(px,pz) - by
								spots[i] = false
								Spring.UnitScript.CallAsUnit(builderID, env.placingMex, SPRAWL_OUT_POSITIONS_X[i], height, SPRAWL_OUT_POSITIONS_Z[i])
								return true
							end
						end
					end
					return false
				elseif bfacing == 2 then
					for i = 1, 20 do
						px = bx - SPRAWL_OUT_POSITIONS_X[i]
						pz = bz - SPRAWL_OUT_POSITIONS_Z[i]
						if not spots[i] then
							if not Spring.GetGroundBlocked(
								px+4,
								pz+4,
								px-4,
								pz-4
							) then
								local height = Spring.GetGroundHeight(px,pz) - by
								spots[i] = false
								Spring.UnitScript.CallAsUnit(builderID, env.placingMex, SPRAWL_OUT_POSITIONS_X[i], height, SPRAWL_OUT_POSITIONS_Z[i])
								return true
							end
						end
					end
					return false
				elseif bfacing == 3 then
					for i = 1, 20 do
						px = bx - SPRAWL_OUT_POSITIONS_Z[i]
						pz = bz - SPRAWL_OUT_POSITIONS_X[i]
						if not spots[i] then
							if not Spring.GetGroundBlocked(
								px+4,
								pz+4,
								px-4,
								pz-4
							) then
								local height = Spring.GetGroundHeight(px,pz) - by
								spots[i] = false
								Spring.UnitScript.CallAsUnit(builderID, env.placingMex, SPRAWL_OUT_POSITIONS_X[i], height, SPRAWL_OUT_POSITIONS_Z[i])
								return true
							end
						end
					end
					return false
				end
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

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, attackerID, attackerDefID, attackerTeam)
	-- are we a hive?
	if reclaimable[unitDefID] then
		-- clean up our ownerships
		hiveMexSpots[unitID] = nil

		-- if we still have an eco table it means we got killed, not upgraded over
		if hiveEcoSpots[unitID] then
			local child
			for i = 1, 20 do
				child = EcoEcoSpots[unitID][i]
				if child then
					EcoEcoSpots[unitID] = nil
					Spring.DestroyUnit(child, false, false, attackerID)
				end
			end
			hiveEcoSpots[unitID] = nil
		end
	-- hive economy structures
	elseif eco[unitDefID] then
		if EcoEcoSpots[unitID] then
			for i = 1, 20 do
				if EcoEcoSpots[unitID][i] == unitID then
					EcoEcoSpots[unitID][i] = nil
					local child
					if i < 6 then	
						child = EcoEcoSpots[unitID][i+5]
						if child then
							Spring.DestroyUnit(child, false, false, attackerID)
						end
					elseif i < 11 then
						child = EcoEcoSpots[unitID][i+i-1]
						if child then
							Spring.DestroyUnit(child, false, false, attackerID)
						end
						child = EcoEcoSpots[unitID][i+i]
						if child then
							Spring.DestroyUnit(child, false, false, attackerID)
						end
					end
					break
				end
			end
			EcoEcoSpots[unitID] = nil
		end
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