local torso, pelvis, head, thing, aimx1, aimy1,
		rRoll, rleg, rfoot, rthigh, rtoes, -- right leg
		lRoll, lleg, lfoot, lthigh, ltoes, -- left  leg
		lturret, lbarrel1, lbarrel2, lflare1, lflare2, lexhaust1, lexhaust2,-- left  weapon
		rturret, rbarrel1, rbarrel2, rflare1, rflare2, rexhaust1, rexhaust2 -- right weapon
= piece("torso", "pelvis", "head", "thing", "aimx1", "aimy1",
		"rRoll", "rleg", "rfoot", "rthigh", "rtoes", -- right leg
		"lRoll", "lleg", "lfoot", "lthigh", "ltoes", -- left  leg
		"lturret", "lbarrel1", "lbarrel2", "lflare1", "lflare2", "lexhaust1", "lexhaust2", -- left  weapon
		"rturret", "rbarrel1", "rbarrel2", "rflare1", "rflare2", "rexhaust1", "rexhaust2") -- right weapon

--local DIST0, legIn, legOut = 123, 47, 89
local DIST2GROUND, legDistUpper, legDistLower, legDistFoot = 86, 47.04, 89.7, 20
local DISTFROMPELVIS = 45
-- local ANG1, ANG2, ANG3 = 60, 88, -28
local legSqrdUpper, legSqrdLower = legDistUpper * legDistUpper, legDistLower * legDistLower
local legTotSqrd, legTot    = legSqrdUpper + legSqrdLower, 2 * legDistUpper * legDistLower

local _x, _y, _z		= 0, 0, 0
local _dx, _dy, _dz	= 0, 0, 0
local _vx, _vy, _vz = 0,0,0

-- to local unit space
local function toLocalSpace2d(x, y, z)
	local vx = x - _x
	local vz = z - _z

	local ovx = vx * _dz + vz * -_dx
	local ovz = vx * _dx + vz * _dz

	local ovy = y - _y

	return ovx, ovy, ovz
end

local function updateLeg(legRoll, leg1, leg2, foot, target_x, target_y, target_z, legoffset_x, legoffset_y, legoffset_z)
	-- convert our target to local space
	local px, py, pz = toLocalSpace2d(target_x, target_y, target_z)
	--local px, py, pz = target_x, target_y, target_z
	--px, py, pz = toLocalSpace3d(px, py, pz)

	-- compensate for leg position
	px = px - legoffset_x
	py = py - legoffset_y
	-- HOTFIX: TODO: figure out where i'm actually going wrong?
	pz = -pz + legoffset_z

	-- maths
	local px2, py2, pz2 = px * px, py * py, pz * pz
	local dist = math.sqrt(px2 + py2)
	local dist3dSQRD = px2 + pz2 + py2
	local dist3d = math.sqrt(dist3dSQRD)

	-- finding the angles of the armpit and elbow, so that the armature ends at destination
	local anglePelvis	= math.acos(math.min(math.max((legSqrdUpper + dist3dSQRD - legSqrdLower) / (2 * legDistUpper * dist3d), -1), 1))
	local angleKnee		= math.acos(math.min(math.max((legTotSqrd - dist3dSQRD) / legTot, -1), 1))
	--local anglePelvisAdjusted = -math.atan2(py, dist) - anglePelvis ???

	-- roll the leg in and out
	local angle = math.atan2(py, px)
	Turn(legRoll, 3, angle + 1.5707963)

	local angle2 = -math.atan2(pz, dist) - anglePelvis

	-- bend the armature to reach the destination
	Turn(leg1, 1, - angle2)
	--Turn(leg1, 1, anglePelvis)
	Turn(leg2, 1, angleKnee + 3.1415926)
	Turn(foot, 1, - angleKnee - 3.1415926 - anglePelvis)
	Turn(foot, 1, - angleKnee - 3.1415926 + angle2 )
	Turn(foot, 3, -angle - 1.5707963)

	return nil
end

local function slowUpdate()
	local a, b, c, d
	while true do
		a, _, b = toGlobal2D_X(50)
		c, _, d = toLocalSpace2d(a, _y, b)
		Spring.Echo(a-_x, c, b-_z, d)
		Sleep(3600)
	end
end

local function calcFoorGoal(offset)

end

local function update()
	local leftRot, rightRot	= {}, {}
	local lt, rt = {0,0,0}, {0,0,0}
	local tx, ty, tz = 0,0,0

	while true do
		Sleep(1) -- sleep at the start so that i don't forget it

		-- current state
		 _x,  _y,  _z = Spring.GetUnitPosition(unitID)
		_dx, _dy, _dz = Spring.GetUnitDirection(unitID)
		_vx, _vy, _vz = Spring.GetUnitVelocity(unitID)

		tx = _x
		tz = _z

		tx = tx + _dz * 50
		tz = tz - _dx * 50

		tx = tx + _vx * 50
		tz = tz + _vz * 50

		ty = Spring.GetGroundHeight(tx, tz) + legDistFoot

		leftRot = {updateLeg(
			--thigh	lower	foot
			lRoll,	lthigh,	lleg,	lfoot,
			--target x, y, z
			tx, ty, tz,
			--thigh offset from the model centre
			DISTFROMPELVIS, DIST2GROUND, 0
		)}

		tx = _x
		tz = _z

		tz = tz - _dx * -50
		tx = tx + _dz * -50

		tx = tx + _vx * 50
		tz = tz + _vz * 50


		ty = Spring.GetGroundHeight(tx, tz) + legDistFoot

		rightRot= {updateLeg(
			--thigh		lower		foot
			rRoll,	rthigh, rleg, rfoot,
			--target x, y, z
			tx, ty, tz,
			--thigh offset from the model centre
			-DISTFROMPELVIS, DIST2GROUND, 0
		)}
	end
end

function script.Create()
	StartThread(update)
	--StartThread(slowUpdate)
end

function script.StartMoving()

end

function script.StopMoving()

end

function script.AimFromWeapon(weapon)

end

function script.AimWeapon(weapon, heading, pitch)

end

function script.FireWeapon(weapon)

end

function script.QueryWeapon(weapon)

end

function script.Killed()

end
