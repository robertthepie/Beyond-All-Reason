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

-- body
local	root, turnTable, head, tail,
		base1, base2, base3, base4, base5, base6
= piece("root", "turnTable", "head", "tail",
		"base1", "base2", "base3", "base4", "base5", "base6"
)

-- legs
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
local rep = 1

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

		local tempProgress = dist / length
		if rep == 1 then
			Spring.Echo(tempProgress, progress, tempProgress == progress, tempProgress - progress, progress - tempProgress)
		end
		rep = rep % 60 + 1
		if tempProgress == progress then
			local alt = true
			for _, left in pairs(leg1) do
				if alt then
					Turn(left[1], 3, 0.5)
					Turn(left[2], 3, -0.5)
					Turn(left[3], 3, -0.5)
					Turn(left[4], 3, 0.5)
				else
					Turn(left[1], 3, -0.5)
					Turn(left[2], 3, 0.5)
					Turn(left[3], 3, 0.5)
					Turn(left[4], 3, -0.5)
				end
				alt = not alt
			end
		else
			progress = tempProgress

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

			tempProgress=(totalProgress+progress)*3.1415
			local angle = math.max(math.min(math.sin(tempProgress), 0.5), -0.5)
			local angle2 = math.cos(tempProgress) * .5
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
			temp[2] + 16,
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

-- weapons
local w1xy, flare1,
	w2x, w2y, flare2,
	w3x, w3y, flare3a, flare3b, flare3c,
	w4x, w4y, flare4a, flare4b, flare4c,
	w5x, w5y, flare5,
	w6xy, flare6
	= piece (
	"sleeve1", "flare1",
	"aimy12", "sleeve2", "flare2",
	"aimy13", "turret3", "flare23", "flare33", "flare13",
	"aimy14", "turret4", "flare24", "flare34", "flare14",
	"aimy15", "sleeve5", "flare5",
	"sleeve6", "flare6"
)

function script.AimFromWeapon(weapon)
	if weapon > 3 then
		if weapon == 6 then
			return w6xy
		elseif weapon == 5 then
			return w5x
		else -- 4
			return w4x
		end
	elseif weapon == 3 then
		return w3x
	elseif weapon == 2 then
		return w2x
	else
		return w1xy
	end
end

function script.AimWeapon(weapon, heading, pitch)
	pitch = -pitch
	if weapon > 3 then
		if weapon == 6 then
			Turn(w6xy, 2, heading)
			Turn(w6xy, 1, pitch)
		elseif weapon == 5 then
			Turn(w5x, 2, heading)
			Turn(w5y, 1, pitch)
		else -- 4
			Turn(w4x, 2, heading)
			Turn(w4y, 1, pitch)
		end
	elseif weapon == 3 then
		Turn(w3x, 2, heading)
		Turn(w3y, 1, pitch)
	elseif weapon == 2 then
		Turn(w2x, 2, heading)
		Turn(w2y, 1, pitch)
	else
		Turn(w1xy, 2, heading)
		Turn(w1xy, 1, pitch)
	end
	return true
end

function script.FireWeapon(weapon)
	return true
end

function script.QueryWeapon(weapon)
	if weapon > 3 then
		if weapon == 6 then
			return flare6
		elseif weapon == 5 then
			return flare5
		else -- 4
			return flare4a
		end
	elseif weapon == 3 then
		return flare3a
	elseif weapon == 2 then
		return flare2
	else
		return flare1
	end
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

