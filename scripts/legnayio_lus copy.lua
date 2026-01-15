--- Temp Suppressants
---@diagnostic disable: duplicate-set-field
---@diagnostic disable-next-line: undefined-global
local script, piece, StartThread, Move, Turn = script, piece, StartThread, Move, Turn
-- End Of Suppressants

local	root,
		turnTable,
		head,
		base1,
		base2,
		base3,
		base4,
		base5,
		base6
= piece(
	"root",
	"turnTable",
	"head",
	"base1",
	"base2",
	"base3",
	"base4",
	"base5",
	"base6"
)
local length = 24

local rollingList = {
	[1] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[2] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[3] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[4] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[5] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[6] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[7] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
}

local _posDir
local function moveBase(_base, offset, pastOffset, progress)
	local xx, yy =
		pastOffset[1] - offset[1],
		pastOffset[3] - offset[3]
	Move(_base, 1, -_posDir[1] + (
		offset[1] + (xx) * progress
	))
	Move(_base, 2, -_posDir[2] + (
		offset[2] + (pastOffset[2] - offset[2]) * progress
	) + 16)
	Move(_base, 3, -_posDir[3] + (
		offset[3] + (yy) * progress
	))
	local turnY = math.atan2(xx, yy)
	
	Turn(_base, 2, turnY)
end

local function bodySlitherLoop()
	local point, tracker = 0, 0
	local _posDirHead
	while true do
		Sleep(1)
		_posDir = {Spring.GetUnitPiecePosDir(unitID, root)}
		_posDirHead = {Spring.GetUnitPiecePosDir(unitID, head)}
		local dist = math.distance3d(
			_posDirHead[1],
			_posDirHead[2],
			_posDirHead[3],
			rollingList[1][1],
			rollingList[1][2],
			rollingList[1][3]
		)
		tracker = dist / length
		local _, turnY = Spring.GetUnitRotation(unitID)
		Turn(turnTable, 2, turnY)
		moveBase(base1, rollingList[2], rollingList[1], tracker)
		moveBase(base2, rollingList[3], rollingList[2], tracker)
		moveBase(base3, rollingList[4], rollingList[3], tracker)
		moveBase(base4, rollingList[5], rollingList[4], tracker)
		moveBase(base5, rollingList[6], rollingList[5], tracker)
		moveBase(base6, rollingList[7], rollingList[6], tracker)
		point = point % 6 + 1
		if tracker >= 1 then
			rollingList[7] = rollingList[6]
			rollingList[6] = rollingList[5]
			rollingList[5] = rollingList[4]
			rollingList[4] = rollingList[3]
			rollingList[3] = rollingList[2]
			rollingList[2] = rollingList[1]
			rollingList[1] = _posDirHead
		end
	end
end

function script.Create()
	Move(head, 3, length * 3)
	local temp = {Spring.GetUnitPiecePosDir(unitID, head)}
	for i = 1, 7 do
		rollingList[i] = temp
	end
	StartThread(bodySlitherLoop)
end

function script.StartMoving()
end

function script.StopMoving()
end

function script.AimFromWeapon(weapon)
	return head
end

function script.AimWeapon(weapon, heading, pitch)
	return true
end

function script.FireWeapon(weapon)
	return true
end

function script.QueryWeapon(weapon)
	return head
end

function script.StartBuilding(heading, pitch)
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
	return true
end

function script.StopBuilding()
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, false)
	return true
end

function script.QueryNanoPiece()
	return head
end



function script.Killed()
	return 1
end
