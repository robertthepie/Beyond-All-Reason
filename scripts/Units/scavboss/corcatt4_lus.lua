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


local DIST2GROUND, legDistUpper, legDistLower, legDistFoot = 50, 47.04, 89.7, 20
local DISTFROMPELVIS = 45

local SPEEDDISTMULT = 55
local EXERTANGLE = 137

local legSqrdUpper, legSqrdLower = legDistUpper * legDistUpper, legDistLower * legDistLower
local legTotSqrd, legTot    = legSqrdUpper + legSqrdLower, 2 * legDistUpper * legDistLower

local _x, _y, _z	= 0, 0, 0
local _dx, _dy, _dz	= 0, 0, 0
local _dvx, _dvz = 0,0
local _vx, _vy, _vz, _vt = 0,0,0, 0

-- to local unit space
local function toLocalSpace2d(x, y, z)
	local vx = x - _x
	local vz = z - _z

	local ovx = vx * _dz + vz * -_dx
	local ovz = vx * _dx + vz * _dz

	local ovy = y - _y

	return ovx, ovy, ovz
end
local function toLocalRotation(x, y, z)
	return x * _dz + z * -_dx, y, x * _dx + z * _dz
end

local function updateLeg(legRoll, leg1, leg2, foot, target_x, target_y, target_z, legoffset_x, legoffset_y, legoffset_z, ground_norm_x, ground_norm_y, ground_norm_z, toe, toeAngle)
	-- convert our target to local space
	local px, py, pz = toLocalSpace2d(target_x, target_y, target_z)
	--local px, py, pz = target_x, target_y, target_z
	--px, py, pz = toLocalSpace3d(px, py, pz)

	local extra_x, _, _ = Spring.UnitScript.GetPieceTranslation(pelvis)

	-- compensate for leg position
	px = px - legoffset_x - extra_x
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
	Turn(leg2, 1, angleKnee + 3.1415926)

	local gnx, gny, gnz = toLocalRotation(ground_norm_x, ground_norm_y, ground_norm_z)
	Turn(foot, 1, - angleKnee - 3.1415926 + angle2 + gnz)
	Turn(foot, 3, -angle - 1.5707963 - gnx)

	Turn(toe, 1, toeAngle-gnz)

	return dist3d, angle
end


local function calcFootGoal(legXOffset, moveOffset)
	local x, y, z = _x, 0, _z

	--local tx, tz =
	--	_dvx * _dx + _dvz * _dz,
	--	_dvx * _dz + _dvz * _dx

	x = x
	-- leg offset from centre
	+ _dz * legXOffset
	-- movement direction
	+ _vx * moveOffset
	-- movement rotation

	z = z
	-- leg offset from centre
	- _dx * legXOffset
	-- movement direction
	+ _vz * moveOffset
	-- movement rotation

	y = Spring.GetGroundHeight(x, z)
	local gx, gy, gz = Spring.GetGroundNormal(x, z, true)
	x = x + legDistFoot * gx
	y = y + legDistFoot * gy
	z = z + legDistFoot * gz

	local toe_y = Spring.GetGroundHeight(x + (25 * _dx), z + (25 * _dz))-y+legDistFoot
	toe_y = -math.atan2(toe_y, 25)

	return x,y,z, gx, gy, gz, toe_y
end

local leftRot, rightRot	= {}, {}
local function update()

	_x,  _y,  _z = Spring.GetUnitPosition(unitID)
	_dx, _dy, _dz = Spring.GetUnitDirection(unitID)
	local _odx, _odz = _dx, _dz
	_vx, _vy, _vz = Spring.GetUnitVelocity(unitID)

	local tx1, ty1, tz1, tgn1x, tgn1y, tgn1z, toe1 = calcFootGoal(DISTFROMPELVIS	-10, 0)
	local tx1b, ty1b, tz1b = tx1, ty1, tz1
	local tx1c, ty1c, tz1c = tx1, ty1, tz1
	local tx2, ty2, tz2, tgn2x, tgn2y, tgn2z, toe2 = calcFootGoal(-DISTFROMPELVIS	+10, 0)
	local tx2b, ty2b, tz2b = tx2, ty2, tz2
	local tx2c, ty2c, tz2c = tx2, ty2, tz2

	local ac, aci = 0, 1
	local leftLeg, lifted = true, true

	while true do
		Sleep(1) -- sleep at the start so that i don't forget it

		-- current state
		 _x,  _y,  _z = Spring.GetUnitPosition(unitID)
		_dx, _dy, _dz = Spring.GetUnitDirection(unitID)
		_vx, _vy, _vz, _vt = Spring.GetUnitVelocity(unitID)
		_vt = _vt * 5

		ac = ac + 0.04 -- 0.04
		if ac > 2 then
			ac = 0
			leftLeg = not leftLeg
			if leftLeg then
				tx1b, ty1b, tz1b = tx1c, ty1c, tz1c
				tx1c, ty1c, tz1c, tgn1x, tgn1y, tgn1z, toe1 = calcFootGoal(DISTFROMPELVIS - _vt, _vt*5)
			else
				tx2b, ty2b, tz2b = tx2c, ty2c, tz2c
				tx2c, ty2c, tz2c, tgn2x, tgn2y, tgn2z, toe2 = calcFootGoal(-DISTFROMPELVIS + _vt, _vt*5)
			end
			lifted = true
		end
		if lifted and ac > 1 then
			lifted = false
			if leftLeg then
				Move(pelvis, 1, _vt, 25)
			else
				Move(pelvis, 1, -_vt, 25)
			end
		end
		aci = math.min(ac, 1)
		if leftLeg then
			tx1, ty1, tz1 =
				math.mix(tx1b, tx1c, aci),
				math.mix(ty1b, ty1c, aci),
				math.mix(tz1b, tz1c, aci)
			local temp = (math.abs(aci+aci-1))
			temp = temp * temp
			ty1 = ty1 + (25 * (1-temp))
		else
			tx2, ty2, tz2 =
				math.mix(tx2b, tx2c, aci),
				math.mix(ty2b, ty2c, aci),
				math.mix(tz2b, tz2c, aci)
			local temp = (math.abs(aci+aci-1))
			temp = temp * temp
			ty2 = ty2 + (25 * (1-temp))
		end

		leftRot = {updateLeg(
			--thigh	lower	foot
			lRoll,	lthigh,	lleg,	lfoot,
			--target x, y, z
			tx1, ty1, tz1,
			--thigh offset from the model centre
			DISTFROMPELVIS, DIST2GROUND, 0,
			tgn1x, tgn1y, tgn1z, ltoes, toe1
		)}

		rightRot= {updateLeg(
			--thigh		lower		foot
			rRoll,	rthigh, rleg, rfoot,
			--target x, y, z
			tx2, ty2, tz2,
			--thigh offset from the model centre
			-DISTFROMPELVIS, DIST2GROUND, 0,
			tgn2x, tgn2y, tgn2z, rtoes, toe2
		)}
		
		-- if overextending a leg, speed up so that we can lift it up sooner
		if leftLeg then
			if rightRot[1] > 120 then
				ac = ac + 0.04
			end
		else
			if leftRot[1] > 120 then
				ac = ac + 0.04
			end
		end
	end
end
local tempGlobal = 0
local function updateNotTimer()
	
	_x,  _y,  _z = Spring.GetUnitPosition(unitID)
	_dx, _dy, _dz = Spring.GetUnitDirection(unitID)
	local _odx, _odz = _dx, _dz
	_vx, _vy, _vz = Spring.GetUnitVelocity(unitID)

	local tx1, ty1, tz1, tgn1x, tgn1y, tgn1z, toe1 = calcFootGoal(DISTFROMPELVIS	-10, 0)
	local tx1b, ty1b, tz1b = tx1, ty1, tz1
	local tx1c, ty1c, tz1c = tx1, ty1, tz1
	local tx2, ty2, tz2, tgn2x, tgn2y, tgn2z, toe2 = calcFootGoal(-DISTFROMPELVIS	+10, 0)
	local tx2b, ty2b, tz2b = tx2, ty2, tz2
	local tx2c, ty2c, tz2c = tx2, ty2, tz2

	local ac, aci = 0, 1
	local leftLeg, lifted = true, true
	local alternate = true
	local needToLift = false

	while true do
		Sleep(1) -- sleep at the start so that i don't forget it

		-- current state
		 _x,  _y,  _z = Spring.GetUnitPosition(unitID)
		_dx, _dy, _dz = Spring.GetUnitDirection(unitID)
		_vx, _vy, _vz, _vt = Spring.GetUnitVelocity(unitID)
		_vt = _vt * 5

		ac = ac + 0.04 -- 0.04

		aci = math.min(ac, 1)
		if leftLeg then
			tx1, ty1, tz1 =
				math.mix(tx1b, tx1c, aci),
				math.mix(ty1b, ty1c, aci),
				math.mix(tz1b, tz1c, aci)
			local temp = (math.abs(aci+aci-1))
			temp = temp * temp
			ty1 = ty1 + (25 * (1-temp))
		else
			tx2, ty2, tz2 =
				math.mix(tx2b, tx2c, aci),
				math.mix(ty2b, ty2c, aci),
				math.mix(tz2b, tz2c, aci)
			local temp = (math.abs(aci+aci-1))
			temp = temp * temp
			ty2 = ty2 + (25 * (1-temp))
		end

		if ac > 1 then
			alternate = not alternate

			local temp1, temp2, temp3 = tx1c + tx2c, ty1c + ty2c, tz1c + tz2c
			temp1, temp2, temp3 = temp1 * 0.5, temp2 * 0.5, temp3 * 0.5
			tempGlobal = math.distance2d(temp1,temp3, _x, _z)
			
			if tempGlobal > (20 + _vt + _vt) then needToLift = true end
			if alternate then
				if needToLift or leftRot[1] > EXERTANGLE then
					leftLeg = true
					tx1b, ty1b, tz1b = tx1c, ty1c, tz1c
					tx1c, ty1c, tz1c, tgn1x, tgn1y, tgn1z, toe1 = calcFootGoal(DISTFROMPELVIS - _vt, _vt*5)
					ac = 0
					lifted = true
					--Spring.Echo("Lifted Left Leg", leftRot[1], leftRot[2])
					needToLift = false
				end
			elseif needToLift or rightRot[1] > EXERTANGLE then
				leftLeg = false
				tx2b, ty2b, tz2b = tx2c, ty2c, tz2c
				tx2c, ty2c, tz2c, tgn2x, tgn2y, tgn2z, toe2 = calcFootGoal(-DISTFROMPELVIS + _vt, _vt*5)
				ac = 0
				lifted = true
				--Spring.Echo("Lifted Right Leg", rightRot[1], rightRot[2])
				needToLift = false
			end
		end
		if lifted and ac > 1 then
			lifted = false
			if leftLeg then
				Move(pelvis, 1, _vt, 25)
			else
				Move(pelvis, 1, -_vt, 25)
			end
		end

		leftRot = {updateLeg(
			--thigh	lower	foot
			lRoll,	lthigh,	lleg,	lfoot,
			--target x, y, z
			tx1, ty1, tz1,
			--thigh offset from the model centre
			DISTFROMPELVIS, DIST2GROUND, 0,
			tgn1x, tgn1y, tgn1z, ltoes, toe1
		)}

		rightRot= {updateLeg(
			--thigh		lower		foot
			rRoll,	rthigh, rleg, rfoot,
			--target x, y, z
			tx2, ty2, tz2,
			--thigh offset from the model centre
			-DISTFROMPELVIS, DIST2GROUND, 0,
			tgn2x, tgn2y, tgn2z, rtoes, toe2
		)}
		
		-- if overextending a leg, speed up so that we can lift it up sooner
		if leftLeg then
			if rightRot[1] > EXERTANGLE then
				ac = ac + 0.04
			end
		else
			if leftRot[1] > EXERTANGLE then
				ac = ac + 0.04
			end
		end
	end
end

local function slowUpdate()
	while true do
		Sleep(300)
		--Spring.Echo(tempGlobal, (20 + _vt + _vt), tempGlobal > (20 + _vt + _vt))
	end
end

function script.Create()
	StartThread(updateNotTimer)
	StartThread(slowUpdate)
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
