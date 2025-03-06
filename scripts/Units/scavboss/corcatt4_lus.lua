local torso, pelvis, head, thing, aimx1, aimy1,
		rleg, rfoot, rthigh, rtoes, -- right leg
		lleg, lfoot, lthigh, ltoes, -- left  leg
		lturret, lbarrel1, lbarrel2, lflare1, lflare2, lexhaust1, lexhaust2,-- left  weapon
		rturret, rbarrel1, rbarrel2, rflare1, rflare2, rexhaust1, rexhaust2 -- right weapon
		=
		piece("torso", "pelvis", "head", "thing", "aimx1", "aimy1",
		"rleg", "rfoot", "rthigh", "rtoes",
		"lleg", "lfoot", "lthigh", "ltoes", 
		"lturret", "lbarrel1", "lbarrel2", "lflare1", "lflare2", "lexhaust1", "lexhaust2",
		"rturret", "rbarrel1", "rbarrel2", "rflare1", "rflare2", "rexhaust1", "rexhaust2")

--local DIST0, legIn, legOut = 123, 47, 89
local DIST0, legIn, legOut, footOffset = 78, 47, 89, 20
local DISTX = 45
-- local ANG1, ANG2, ANG3 = 60, 88, -28
local legInSqrd, legOutSqrd = legIn * legIn, legOut * legOut
local legTotSqrd, legTot    = legInSqrd + legOutSqrd, 2 * legIn * legOut

local _x, _y, _z		= 0, 0, 0
local _dx, _dy, _dz	= 0, 0, 0

-- to local unit space
local function toLocalSpace2d(x, y, z)
	local vx, vy, vz = 0, 0, 0
	local ovx, ovy, ovz = 0, 0, 0
	vx = x - _x
	ovy = y - _y
	vz = z - _z

	ovx = vx * _dz + vz * -_dx
	ovz = vx * _dx + vz * _dz
	return ovx, ovy, ovz
end

local function toGlobal2D_X(x)
	return x * _dx + _x, _y, x * _dz + _z
end

local function updateLeg(leg1, leg2, foot, target_x, target_y, target_z, legoffset_x, legoffset_y, legoffset_z)
	-- convert our target to local space
	local px, py, pz = target_x, target_y, target_z
	--local px, py, pz = toLocalSpace2d(target_x, target_y, target_z)
	--px, py, pz = toLocalSpace3d(px, py, pz)

	-- compensate for leg position
	px = px - legoffset_x
	py = py - legoffset_y
	pz = pz - legoffset_z

	-- maths
	local px2, py2, pz2 = px * px, py * py, pz * pz
	local dist = math.sqrt(px2 + pz2)
	local dist3dSQRD = px2 + pz2 + py2
	local dist3d = math.sqrt(dist3dSQRD)

	-- finding the angles of the armpit and elbow, so that the armature ends at destination
	-- if the arm pieces end up the same length
	--		| the elbow calculation can be 180 - pit - pit as the triangle would be an isosceles
	-- 		| alternatively the math can be simplified to `cos angle = segment len / dist / 2` so `acos(2len / dist)`?
	local legCosAngPit = math.acos(math.min(math.max((legInSqrd + dist3dSQRD - legOutSqrd) / (2 * legIn * dist3d), -1), 1))
	local legCosAngElb = math.acos(math.min(math.max((legTotSqrd - dist3dSQRD) / legTot, -1), 1))

	-- angle to face around y towards target
	local angle = 0--math.atan2(px, pz)
	-- angle flatten our triangle to our plane
	--local angle2 = math.atan2(dist, py)
	local angle2 = -math.atan2(py, dist) - legCosAngPit

	-- bend the armature to reach the destination
	--Turn(leg1, 1, angle2 - 1.5707963)
	Turn(leg1, 1, - angle2 + 1.5707963)
	Turn(leg1, 2, angle)
	Turn(leg2, 1, legCosAngElb + 3.1415926)
	Turn(foot, 1, - legCosAngElb - 3.1415926 + angle2 - 1.5707963)
	--Turn(leg2, 1, 3.1415926 - legCosAngElb)
	-- Turn(leg2, 3, angle) -- un-turn the leg

	return legCosAngElb, legTotSqrd, dist3dSQRD, legTot
end
local leftRot, rightRot = {},{}
local function update()
	 leftRot	= { 0, 0, 0 }
	 rightRot	= { 0, 0, 0 }
	local leftLeg	= { rleg, rfoot, rthigh, rtoes }
	local rightLeg	= { lleg, lfoot, lthigh, ltoes }
	local dd1, da1, db1 = {0,0},{0,0},{0,0}

	local temp = 1

	while true do
		Sleep(1) -- sleep at the start so that i don't forget it
		_x, _y, _z = Spring.GetUnitPosition(unitID)
		_dx, _dy, _dz = Spring.GetUnitDirection(unitID)

		temp = Spring.GetGroundHeight(_x, _z)

		leftRot = {updateLeg(leftLeg[3],  leftLeg[1], leftLeg[2], -DISTX, temp - _y + footOffset, 0, -DISTX, DIST0, 0)}
		updateLeg(rightLeg[3], rightLeg[1], rightLeg[2], DISTX, temp - _y + footOffset, 0, DISTX, DIST0, 0)
	end
end

local function slowUpdate()
	while true do
		Sleep(600)
		Spring.Echo(leftRot[1],leftRot[2],leftRot[3],leftRot[4])
	end
end

function script.Create()
	--Move(pelvis, 2, (-DIST0*0.5))
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
