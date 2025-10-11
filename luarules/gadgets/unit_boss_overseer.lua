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

local cat = nil
local leftNode, rightNode = nil, nil

function gadget:UnitCreated(unitID, unitDefID, teamID)
	if bossDefIDs[unitDefID] then
		cat = unitID
		Spring.Echo("cat found, adding fleas")
		leftNode = Spring.CreateUnit("corgol", 1, 1, 1, 1, teamID)
		rightNode = Spring.CreateUnit("corgol", 1, 1, 1, 1, teamID)
		Spring.MoveCtrl.Enable(leftNode)
		Spring.MoveCtrl.Enable(rightNode)
	end
end

function gadget:GameFrame(frame)
	if not cat then return end
	if leftNode then
		local x,y,z = Spring.GetUnitPiecePosDir(cat, 12)
		Spring.MoveCtrl.SetPosition(leftNode, x, y, z)
	end
	if rightNode then
		local x,y,z = Spring.GetUnitPiecePosDir(cat, 20)
		Spring.MoveCtrl.SetPosition(rightNode, x, y, z)
	end
end

function gadget:Initialize()
	local toRemove = UnitDefNames.corgol.id
	for _, unitID in ipairs(Spring.GetAllUnits()) do
		local unitDefID = Spring.GetUnitDefID(unitID)
		local unitTeamID = Spring.GetUnitTeam(unitID)
		if unitDefID == toRemove then
			Spring.DestroyUnit(unitID, false, true)
		else
		---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
		gadget:UnitCreated(unitID, unitDefID, unitTeamID)
		end
	end
end