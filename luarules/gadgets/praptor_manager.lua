if gadgetHandler:IsSyncedCode() then
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
	Active Selection on upgrade
	Inherit health % on upgrade
	Lower cost of upgrade, and undo cost differance once complete
]]

local reclaimable = {}
for unitDefID, unitDef in pairs(UnitDefs) do
	if unitDef.customParams and unitDef.customParams.upgradable then
		reclaimable[unitDefID] = unitDef.customParams.upgradable
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

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	if builderID then
		local builderDefID = Spring.GetUnitDefID(builderID)
		if reclaimable[builderDefID] and reclaimable[unitDefID] then
			Spring.SetUnitNoSelect(unitID, true)
			local env = Spring.UnitScript.GetScriptEnv(unitID)
			if env then -- otherwise this unit either doesn't exist? or uses cob
				Spring.UnitScript.CallAsUnit(unitID, env.prepGrow)
			end
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
		local parent, parentDef = isUpgradee(unitID)
		if parent then
			local env = Spring.UnitScript.GetScriptEnv(unitID)
			if env then -- otherwise this unit either doesn't exist? or uses cob
				Spring.UnitScript.CallAsUnit(unitID, env.growOut)
			end
			Spring.SetUnitNoSelect(unitID, false)
			Spring.SetUnitNoSelect(parent, true) -- TODO clear unit's queue
			env = Spring.UnitScript.GetScriptEnv(parent)
			if env then -- otherwise this unit either doesn't exist? or uses cob
				Spring.Echo(upgradable)
				Spring.UnitScript.CallAsUnit(parent, env[upgradable])
			end
			--Spring.DestroyUnit(parent, false, true)
		end
	end
end
end