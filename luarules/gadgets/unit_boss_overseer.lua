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

if gadgetHandler:IsSyncedCode() then
--------------
--- SYNCED ---
--------------

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
		leftNode = Spring.CreateUnit("corcatt4_leftpod", 1, 1, 1, 1, teamID)
		if not leftNode then
			Spring.DestroyUnit(unitID, false, true)
			Spring.Echo("Warning: Failed to handle Epic Catapult:[left]")
			return
		end
		rightNode = Spring.CreateUnit("corcatt4_leftpod", 1, 1, 1, 1, teamID)
		if not rightNode then
			Spring.Echo("Warning: Failed to handle Epic Catapult:[right]")
			Spring.DestroyUnit(leftNode, false, true)
			Spring.DestroyUnit(unitID, false, true)
			return
		end
		Spring.MoveCtrl.Enable(leftNode)
		Spring.MoveCtrl.Enable(rightNode)
		Spring.Echo("trying to send", cat, leftNode, rightNode)
		SendToUnsynced("setBossNodes", cat, leftNode, rightNode)
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
	local toRemove = UnitDefNames.corcatt4_leftpod.id
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

else
--------------
---UNSYNCED---
--------------
local cat, leftNode, rightNode
local function setNodes(a, b, c ,d)
	cat, leftNode, rightNode = b, c, d
end
function gadget:Initialize()
	gadgetHandler:AddSyncAction("setBossNodes", setNodes)
end
local last = false
function gadget:DrawScreen()
	local mouseX, mouseY = Spring.GetMouseState()
	local overType, overID = Spring.TraceScreenRay(mouseX, mouseY)
	if overType == "unit" then
		--[[if overID == cat then
			gl.SetUnitBufferUniforms(cat, {2}, 6)
		else]]if overID == leftNode then
			last = true
			gl.SetUnitBufferUniforms(cat, {4}, 6)
		elseif overID == rightNode then
			last = true
			gl.SetUnitBufferUniforms(cat, {12}, 6)
		end
		return
	end
	if last then
		gl.SetUnitBufferUniforms(cat, {0}, 6)
		last = false
	end
end
end
--------------
---   EOF  ---
--------------