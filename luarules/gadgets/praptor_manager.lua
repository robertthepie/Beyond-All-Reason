function gadget:GetInfo()
	return {
		name		= "Playable Raptors Extra Behaviour Handler",
		desc		= "Handles additional behaviour such us recyling when a factory upgrades itself",
		author		= "robert the pie", -- it is not robert the epie
		date		= "March 2024",
		license		= "GNU GPL, v2 or later",
		layer		= 0,
		enabled		= true,
	}
end



--[[
	@TODO
	Nest nest piece clips out of the body during growth animation
	HITBOXES
	Inherit health % on upgrade
]]

local reclaimable = {}
local reclaimableMetal = {}

for unitDefID, unitDef in pairs(UnitDefs) do
	if unitDef.customParams and unitDef.customParams.upgradable then
		reclaimable[unitDefID] = unitDef.customParams.upgradable
		reclaimableMetal[unitDefID] = unitDef.metalCost
	end
end

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

if gadgetHandler:IsSyncedCode() then

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	-- is this ours to upgrade
	if reclaimable[unitDefID] and builderID then
		local builderDefID = Spring.GetUnitDefID(builderID)
		if reclaimable[builderDefID] then

			-- put everything in the right state for upgrading
			Spring.SetUnitNoSelect(unitID, true)
			local env = Spring.UnitScript.GetScriptEnv(unitID)
			if env then -- otherwise this unit either doesn't exist? or uses cob
				Spring.UnitScript.CallAsUnit(unitID, env.prepGrow)
			end
			-- tell the builder that it is building an upgrade (so that it moves it to the centre)
			env = Spring.UnitScript.GetScriptEnv(builderID)
			if env then -- otherwise this unit either doesn't exist? or uses cob
				Spring.UnitScript.CallAsUnit(builderID, env.upgradeState)
			end
		end
	end
end

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
	local upgradable = reclaimable[unitDefID]
	if upgradable then
		local parent, parentDefID = isUpgradee(unitID)
		if parent then

			-- prep the growth/upgrade animation
			local env = Spring.UnitScript.GetScriptEnv(unitID)
			if env then -- otherwise this unit either doesn't exist? or uses cob
				Spring.UnitScript.CallAsUnit(unitID, env.growOut)
			end
			Spring.SetUnitNoSelect(unitID, false)
			env = Spring.UnitScript.GetScriptEnv(parent)
			if env then -- otherwise this unit either doesn't exist? or uses cob
				Spring.UnitScript.CallAsUnit(parent, env[upgradable])
			end

			

			-- refund the parent
			Spring.AddTeamResource(unitTeam, "metal", reclaimableMetal[parentDefID])
			Spring.SetUnitCosts(parent, {metalCost = 1,	energyCost = 1,})
		end
	end
end
else -- unsynced space
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