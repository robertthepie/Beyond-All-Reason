---@diagnostic disable: duplicate-set-field
function gadget:GetInfo()
	return {
		name		= "Rail Transport Manager",
		desc		= "Supports the behaviour of rail transportation",
		author		= "",
		date		= "",
		license		= "GNU GPL, v2 or later",
		layer		= 0,
		enabled		= true
	}
end


local CMD_RAILUNLOAD= 38001
local CMD_DROPLOAD	= 38002

local connectables = {}
if UnitDefNames["legrailtrans"] then
	connectables[UnitDefNames["legrailtrans"].id] = true
end

--------------------------------------
if gadgetHandler:IsSyncedCode() then--
--------------------------------------

local rail_unload = {
	name = "_unload",
	action = "railunload",
	id = CMD_RAILUNLOAD,
	type = CMDTYPE.ICON_UNIT,
	tooltip = "_unload",
	cursor = "cursorunload",
}

function gadget:UnitCreated(unitID, unitDefID, teamID)
	if connectables[unitDefID] then
		Spring.InsertUnitCmdDesc(unitID, rail_unload)
	end
end

function gadget:Initialize()

	gadgetHandler:RegisterCMDID(CMD_RAILUNLOAD)
	gadgetHandler:RegisterAllowCommand(CMD_RAILUNLOAD)

	local units = Spring.GetAllUnits()
	for _, unitID in pairs(units) do
		local unitDefID = Spring.GetUnitDefID(unitID)
		if connectables[unitDefID] then
---@diagnostic disable-next-line: param-type-mismatch
			gadget:UnitCreated(unitID, unitDefID)
		end
	end
end

function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions, cmdTag, playerID, fromSynced, fromLua)
	if	cmdID == CMD_RAILUNLOAD	and
		connectables[unitDefID]	and
		cmdParams[1]			and
		connectables[Spring.GetUnitDefID(cmdParams[1])]
	then
		return true
	end
	return false
end

function gadget:CommandFallback(unitID, unitDefID, teamID, cmdID, cmdParams, param, cmdOptions)
	if cmdID ~= CMD_RAILUNLOAD then
		return false
	end

	local env = Spring.UnitScript.GetScriptEnv(unitID)
	if not env then
		return false
	end

	local x,y,z = Spring.GetUnitPosition(cmdParams[1])
	if not x then
		return false
	end
	local mx,my,mz = Spring.GetUnitPosition(unitID)
	if not mx then
		return false
	end

	x = x - mx
	y = y - my
	z = z - mz

	Spring.UnitScript.CallAsUnit(unitID, env.unloadat, x,y,z)

	return true, true
end

----------------
else--UNSYNCED--
----------------

function gadget:DefaultCommand(objType, objID) --> return: number cmdID 
	if objType ~= "unit" then
		return false
	end
	if connectables[Spring.GetUnitDefID(objID)] then
		local selectedUnits = Spring.GetSelectedUnits()
		for i = 1, #selectedUnits do
			if connectables[Spring.GetUnitDefID(selectedUnits[i])] then
				return CMD_RAILUNLOAD
			end
		end
	end
end

end--EOF