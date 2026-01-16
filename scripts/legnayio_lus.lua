--- Temp Suppressants
---@diagnostic disable: duplicate-set-field
---@diagnostic disable-next-line: undefined-global
local script, piece, StartThread, Move, Turn = script, piece, StartThread, Move, Turn
-- End Of Suppressants

--[[
todos:
	- tail unused? consider revisitng reversing?
		\ or fully commit to moving head inwards on sharp turns
	- weapon aiming
	- any room for performance improvements?
	- figure out how to minimize rare cases where body is nowhere near the middle,the targeting point
		\ (using set mid point seems to give mixed results, cost of it is unknown)
	- consider moving snake behaviour twoards dragging the previous segment twoards the next, instead of the tails following the exact path of the head,
		\ or some form offset basic spline smoothing
]]

local	root, turnTable, head, tail,
		base1, base2, base3, base4, base5, base6
= piece("root", "turnTable", "head", "tail",
		"base1", "base2", "base3", "base4", "base5", "base6"
)

local legr1, legrb1, legl1, leglb1,
	legr2, legrb2, legl2, leglb2,
	legr3, legrb3, legl3, leglb3,
	legr4, legrb4, legl4, leglb4,
	legr5, legrb5, legl5, leglb5,
	legr6, legrb6, legl6, leglb6
= piece("legr1", "legrb1", "legl1", "leglb1",
	"legr2", "legrb2", "legl2", "leglb2",
	"legr3", "legrb3", "legl3", "leglb3",
	"legr4", "legrb4", "legl4", "leglb4",
	"legr5", "legrb5", "legl5", "leglb5",
	"legr6", "legrb6", "legl6", "leglb6"
	)
local leg1 = {
	{legr2, legrb2, legl1, leglb1}, {legl2, leglb2, legr1, legrb1},
	{legr4, legrb4, legl3, leglb3}, {legl4, leglb4, legr3, legrb3},
	{legr6, legrb6, legl5, leglb5}, {legl6, leglb6, legr5, legrb5},
}
local lerp	= math.mix
local cos	= math.cos
local sin	= math.sin
local abs	= math.abs

local rollingList = {
	[1] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[2] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[3] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[4] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[5] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[6] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
	[7] = {0.0,0.0,0.0, 0.0,0.0,0.0,},
}
local length= 24
local lengthHalf = length * 0.5

local _posDir
local function localizeAndLerp(pos1, pos2, progress)
	return
		lerp(pos2[1], pos1[1], progress) -_posDir[1],
		lerp(pos2[2], pos1[2], progress) -_posDir[2],
		lerp(pos2[3], pos1[3], progress) -_posDir[3]
end

local function toLocalRotation(x, z, vx, vz)
	return
		x * vz + z * -vx,
		x * vx + z * vz
end

local turnYold, turnYHistory

local function bodySlitherLoop()
	local progress, totalProgress = 0, 0
	local _posDirHead = {[5] = 1}
	turnYold, turnYHistory = -Spring.GetUnitHeading(unitID, true), 0
	while true do
		Sleep(1)

		local turnY = -Spring.GetUnitHeading(unitID, true)
		Turn(turnTable, 2, turnY)

		local dif = turnY - turnYold
		if dif > 3 then
			dif = dif - 6.283185
		elseif dif < -3 then
			dif = dif + 6.283185
		end
		turnYold = turnY
		turnYHistory = turnYHistory + (dif * 6.5)
		turnYHistory = turnYHistory * 0.94

		_posDir = {Spring.GetUnitPiecePosDir(unitID, root)}
		local _, groundNormalY = Spring.GetGroundNormal(_posDir[1], _posDir[3])
		if groundNormalY > _posDirHead[5] then
			groundNormalY = _posDirHead[5]
		end

		-- move the goal head forward based on:
		Move(head, 3,
			-- how flat the ground is, so that it doesn't point to the top of a clif when at the bottom
			groundNormalY*
			-- how quickly the unit is: to help lower (fails to) into self when switching turn directions, and lower body turn radius
			(lengthHalf * (7 - abs(turnYHistory))),
			24)


		-- prep head position, snap to ground, and adjust from ground normal on height((16))
		_posDirHead = {Spring.GetUnitPiecePosDir(unitID, head)}
		_posDirHead[2] = Spring.GetGroundHeight(_posDirHead[1], _posDirHead[3])
		_posDirHead[4], _posDirHead[5], _posDirHead[6] = Spring.GetGroundNormal(_posDirHead[1], _posDirHead[3])
		_posDirHead[1] = _posDirHead[1] + _posDirHead[4] * 16
		_posDirHead[2] = _posDirHead[2] + _posDirHead[5] * 16
		_posDirHead[3] = _posDirHead[3] + _posDirHead[6] * 16

		local dist = math.distance3d(
			_posDirHead[1],
			_posDirHead[2],
			_posDirHead[3],
			rollingList[1][1],
			rollingList[1][2],
			rollingList[1][3]
		)

		progress = dist / length

		--1
local	x1, y1, z1 =
			lerp(rollingList[2][1], rollingList[1][1], progress),
			lerp(rollingList[2][2], rollingList[1][2], progress),
			lerp(rollingList[2][3], rollingList[1][3], progress)
		turnY = math.atan2(_posDirHead[1]-x1, _posDirHead[3]-z1)
		Turn(base1, 2, turnY)
		x1, y1, z1 = x1 -_posDir[1], y1 -_posDir[2], z1 -_posDir[3]
		Move(base1, 1, x1) Move(base1, 2, y1) Move(base1, 3, z1)
local	turnX, turnZ = toLocalRotation(
			lerp(rollingList[2][4], rollingList[1][4], progress),
			lerp(rollingList[2][6], rollingList[1][6], progress),
			sin(turnY),
			cos(turnY)
		)
		Turn(base1, 1, turnZ)
		Turn(base1, 3, -turnX)

		--2
local	x2, y2, z2 = localizeAndLerp(rollingList[2], rollingList[3], progress)
		Move(base2, 1, x2) Move(base2, 2, y2) Move(base2, 3, z2)
		turnY = math.atan2(x1-x2, z1-z2)
		Turn(base2, 2, turnY)
		turnX, turnZ = toLocalRotation(
			lerp(rollingList[3][4], rollingList[2][4], progress),
			lerp(rollingList[3][6], rollingList[2][6], progress),
			sin(turnY),
			cos(turnY)
		)
		Turn(base2, 1, turnZ)
		Turn(base2, 3, -turnX)

		--3
		x1, y1, z1 = localizeAndLerp(rollingList[3], rollingList[4], progress)
		Move(base3, 1, x1) Move(base3, 2, y1) Move(base3, 3, z1)
		turnY = math.atan2(x2-x1, z2-z1)
		Turn(base3, 2, turnY)
		turnX, turnZ = toLocalRotation(
			lerp(rollingList[4][4], rollingList[3][4], progress),
			lerp(rollingList[4][6], rollingList[3][6], progress),
			sin(turnY),
			cos(turnY)
		)
		Turn(base3, 1, turnZ)
		Turn(base3, 3, -turnX)

		--4
		x2, y2, z2 = localizeAndLerp(rollingList[4], rollingList[5], progress)
		Move(base4, 1, x2) Move(base4, 2, y2) Move(base4, 3, z2)
		turnY = math.atan2(x1-x2, z1-z2)
		Turn(base4, 2, turnY)
		turnX, turnZ = toLocalRotation(
			lerp(rollingList[5][4], rollingList[4][4], progress),
			lerp(rollingList[5][6], rollingList[4][6], progress),
			sin(turnY),
			cos(turnY)
		)
		Turn(base4, 1, turnZ)
		Turn(base4, 3, -turnX)

		--5
		x1, y1, z1 = localizeAndLerp(rollingList[5], rollingList[6], progress)
		Move(base5, 1, x1) Move(base5, 2, y1) Move(base5, 3, z1)
		turnY = math.atan2(x2-x1, z2-z1)
		Turn(base5, 2, turnY)
		turnX, turnZ = toLocalRotation(
			lerp(rollingList[6][4], rollingList[5][4], progress),
			lerp(rollingList[6][6], rollingList[5][6], progress),
			sin(turnY),
			cos(turnY)
		)
		Turn(base5, 1, turnZ)
		Turn(base5, 3, -turnX)

		--6
		x2, y2, z2 = localizeAndLerp(rollingList[6], rollingList[7], progress)
		Move(base6, 1, x2) Move(base6, 2, y2) Move(base6, 3, z2)
		turnY = math.atan2(x1-x2, z1-z2)
		Turn(base6, 2, turnY)
		turnX, turnZ = toLocalRotation(
			lerp(rollingList[7][4], rollingList[6][4], progress),
			lerp(rollingList[7][6], rollingList[6][6], progress),
			sin(turnY),
			cos(turnY)
		)
		Turn(base6, 1, turnZ)
		Turn(base6, 3, -turnX)

		if progress >= 1 then
			rollingList[7] = rollingList[6]
			rollingList[6] = rollingList[5]
			rollingList[5] = rollingList[4]
			rollingList[4] = rollingList[3]
			rollingList[3] = rollingList[2]
			rollingList[2] = rollingList[1]
			rollingList[1] = _posDirHead
			totalProgress = totalProgress + progress
			progress = 0
		end

		progress=(totalProgress+progress)*3.1415
		local angle = math.max(math.min(math.sin(progress), 0.5), -0.5)
		local angle2 = math.cos(progress) * .5
		for _, left in pairs(leg1) do
			Turn(left[1], 3, -angle)
			Turn(left[1], 2, -angle2)

			Turn(left[2], 3, angle)


			Turn(left[3], 3, angle)
			Turn(left[3], 2, angle2)

			Turn(left[4], 3, -angle)
		end
	end
end

function script.Create()
	Move(head, 3, length * 3.5)
	Move(tail, 3, length)

	-- fill the starting rolling list so that the tail is behind the head straight
	local temp = {Spring.GetUnitPiecePosDir(unitID, head)}
	local startDirection = -Spring.GetUnitHeading(unitID, true)
	local lenX, lenY = sin(startDirection) * length, cos(startDirection) * length
	for i = 1, 7 do
		rollingList[i] = {
			temp[1] + (lenX * i),
			temp[2],
			temp[3] - (lenY * i),
			0, 1, 0
		}
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

