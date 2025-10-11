local gadget = gadget ---@type Gadget

function gadget:GetInfo()
	return {
		name	= "Boss Unit Manager",
		desc	= "Manages extra interactions a boss may have",
		author	= "",
		version	= "0.01",
		date	= "2025",
		license	= "GNU GPL, v2 or later",
		layer	= 0,
		enabled	= true
	}
end

if not gadgetHandler:IsSyncedCode() then
	return false
end

local bossDefIDs = {}
for _, name in ipairs({"corcatt4"}) do
	if UnitDefNames[name] then
		bossDefIDs[UnitDefNames[name].id] = true
	end
end
function gadget:UnitCreated(unitID, unitDefID, teamID)
	if bossDefIDs[unitDefID] then
		Spring.Echo("cat found, adding fleas")
		Spring.Echo(Spring.GetUnitPieceList(unitID))
		local flea = Spring.CreateUnit("corgol", 1, 1, 1, 1, teamID)
		Spring.UnitAttach(unitID, flea, 12)
		local flea = Spring.CreateUnit("corgol", 1, 1, 1, 1, teamID)
		Spring.UnitAttach(unitID, flea, 20)
	end
end

function gadget:Initialize()
	for _, unitID in ipairs(Spring.GetAllUnits()) do
		local unitDefID = Spring.GetUnitDefID(unitID)
		local unitTeamID = Spring.GetUnitTeam(unitID)
		---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
		gadget:UnitCreated(unitID, unitDefID, unitTeamID)
	end
end