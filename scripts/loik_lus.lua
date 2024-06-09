local empty_root_piece, base, a1, a2, a3, a4, l1, l2, r1, r2, lb1, lb2, rb1, rb2 = piece("empty_root_piece", "Base", "LF1", "LF2", "LF3", "LF4", "L1", "L2", "R1", "R2", "LB1", "LB2", "RB1", "RB2")

local x, y, z = 1,1,1
-- 2d rotation matrix info
local dx, dz = 1,1
-- to local unit space
local function toLocalSpace(in_x, in_y, in_z)
	local vx, vy, vz = 0,0,0
	local ovx, ovy, ovz = 0,0,0
	vx = in_x - x
	ovy = in_y - y
	vz = in_z - z

	ovx = vx * dz	+	vz * -dx
	ovz = vx * dx	+	vz * dz
	return ovx, ovy, ovz
end

local m3d00, m3d01, m3d02 = 1, 0, 0
local m3d10, m3d11, m3d12 = 0, 1, 0
local m3d20, m3d21, m3d22 = 0, 0, 1
local baseOffset = 25
-- to local base plate space
local function toLocalSpace3d(in_x, in_y, in_z)
	local ox, oy, oz = 0,0,0
	local tmp_in_y = in_y - baseOffset
	ox = m3d00 * in_x + m3d01 * tmp_in_y + m3d02 * in_z
	oy = m3d10 * in_x + m3d11 * tmp_in_y + m3d12 * in_z
	oz = m3d20 * in_x + m3d21 * tmp_in_y + m3d22 * in_z
	return ox, oy, oz
end

-- some constants for leg length and leg length needed maths
local legIn, legOut = 115, 200
local legInSqrd, legOutSqrd = legIn*legIn, legOut*legOut
local legTotSqrd, legTot  = legInSqrd + legOutSqrd, 2 * legIn * legOut

-- updates the armeture p1, p2 to point twoards the target x/y/z with the passed in offset being where the armeture starts on the model
local function updateLeg(leg1, leg2, target_x, target_y, target_z, legoffset_x, legoffset_y, legoffset_z, marker)
	-- convert our target to local pos
	local px, py, pz = toLocalSpace(target_x, target_y, target_z)

	-- Move(marker, 1, px)
	-- Move(marker, 2, py)
	-- Move(marker, 3, pz)

	px, py, pz = toLocalSpace3d(px, py, pz)

	-- compensate for leg position
	px = px - legoffset_x
	py = py - legoffset_y
	pz = pz - legoffset_z

	-- maths
	local px2, py2, pz2 = px*px, py*py, pz*pz
	local angle = math.atan2(px, pz)
	local dist = math.sqrt(px2 + pz2)
	local dist3dSQRD = px2 + pz2 + py2
	local angle2 = math.atan2(dist, py)
	local dist3d = math.sqrt(dist3dSQRD)

	-- finding the angles of the armpit and elbow, so that the armeture ends at destination
	-- if the arm pieces end up the same length
	--		| the elbow caculation can be 180 - pit - pit as the triangle would be an iscoceles
	-- 		| alternatively the math can be simplified to `cos angle = segment len / dist / 2` so `acos(2len / dist)`?
	local legCosAngPit = math.acos( math.min( (legInSqrd + dist3dSQRD - legOutSqrd) / (2 * legIn * dist3d) ,1 ))
	local legCosAngElb = math.acos( math.max( (legTotSqrd - dist3dSQRD) / legTot , -1 ))

	-- bend the armeture to reach the destination
	Turn(leg1, 1, angle2-1.5707963-legCosAngPit)
	Turn(leg1, 2, angle)
	Turn(leg2, 1, 3.1415926-legCosAngElb)
	-- Turn(leg2, 3, angle) -- unturn the leg

	return dist3d, angle
end

local OFFSET_X, OFFSET_Y = 150, 40
local deb1, deb2, deb3 = 0,0,0

local function update()
	-- local marker = Spring.CreateUnit("armflea", x, y, z, "n", Spring.GetUnitTeam(unitID))
	local postions_x = {}
	local postions_y = {}
	local postions_z = {}
	local leg1s = {l1, r1, lb1, rb1}
	local leg2s = {l2, r2, lb2, rb2}
	local offsetxs = {50, -50, 50, -50}
	local offsetzs = {60, 60, -60, -60}
	local start_offsetxs = {OFFSET_X, -OFFSET_X, OFFSET_X, -OFFSET_X}
	local start_offsetzs = {OFFSET_Y, OFFSET_Y, -OFFSET_Y, -OFFSET_Y}
	local markers = {a1, a2, a3, a4}
	--local limitMax = {1.5707963, 0, 3.1415926, -1.5707963}
	--local limitMin = {0, -1.5707963, 1.5707963, -3.1415926}
	local limitMax = {1.5707963+0.5,	0,				3.1415926,		-1.5707963+0.5}
	local limitMin = {0,				-1.5707963-0.5,	1.5707963-0.5,	-3.1415926}
	do
		postions_x[1] = x + OFFSET_X
		postions_z[1] = z + OFFSET_Y + 50
		postions_y[1] = Spring.GetGroundHeight(x + OFFSET_X, z + OFFSET_Y)

		postions_x[2] = x - OFFSET_X
		postions_z[2] = z + OFFSET_Y + 50
		postions_y[2] = Spring.GetGroundHeight(x - OFFSET_X, z + OFFSET_Y)

		postions_x[3] = x + OFFSET_X
		postions_z[3] = z - OFFSET_Y - 50
		postions_y[3] = Spring.GetGroundHeight(x + OFFSET_X, z - OFFSET_Y)

		postions_x[4] = x - OFFSET_X
		postions_z[4] = z - OFFSET_Y - 50
		postions_y[4] = Spring.GetGroundHeight(x - OFFSET_X, z - OFFSET_Y)
	end
	local dd1 = {0,0,0,0}
	local da1 = {0,0,0,0}
	local legPosUpd = 1
	local updBase = false
	while true do
		Sleep(1)
		x,y,z = Spring.GetUnitPosition(unitID)
		dx, _, dz = Spring.GetUnitDirection(unitID)

		-- move legs to current frame's matrix
		for i = 1, 4 do
			dd1[i], da1[i] = updateLeg(leg1s[i], leg2s[i], postions_x[i], postions_y[i], postions_z[i], offsetxs[i], 0, offsetzs[i], markers[i])
		end

		-- do we need to lift a leg (we check 1 per frame, later to check only when another isn't lifted)
		if dd1[legPosUpd] > 220
		or dd1[legPosUpd] < 140
		or da1[legPosUpd] > limitMax[legPosUpd]
		or da1[legPosUpd] < limitMin[legPosUpd] then
			if legPosUpd == 1 or legPosUpd == 2 then
				postions_x[legPosUpd] =  dz * start_offsetxs[legPosUpd] + dx * ( start_offsetzs[legPosUpd] + 170 ) + x
				postions_z[legPosUpd] = -dx * start_offsetxs[legPosUpd] + dz * ( start_offsetzs[legPosUpd] + 170 ) + z
				postions_y[legPosUpd] = Spring.GetGroundHeight(postions_x[legPosUpd], postions_z[legPosUpd])
			else
				postions_x[legPosUpd] =  dz * start_offsetxs[legPosUpd] + dx * ( start_offsetzs[legPosUpd] - 40 ) + x
				postions_z[legPosUpd] = -dx * start_offsetxs[legPosUpd] + dz * ( start_offsetzs[legPosUpd] - 40 ) + z
				postions_y[legPosUpd] = Spring.GetGroundHeight(postions_x[legPosUpd], postions_z[legPosUpd])
			end
			updBase = true
		end

		-- update the plane of the base based on the 4 leg target positions if one of them has moved
		if updBase then
			local tmp_sum_1 = postions_y[4] + postions_y[3]
			local tmp_sum_2 = postions_y[2] + postions_y[1]

			local moveDist = math.max((tmp_sum_1 + tmp_sum_2 + y) * 0.25 + 100 - y, 100)

			-- pitch
			local angle = math.atan2( (tmp_sum_1 - tmp_sum_2) * 0.5, 160)
				--80 is the distance between feet that we are aiming for, since i can't do maths ¯\_(ツ)_/¯
				--(postions_z[4] + postions_z[3] - postions_z[2] - postions_z[1]) * 0.5
			deb1 = angle
			Turn(base, 1, angle)

			Move(base, 2, moveDist - 100)
			Move(base, 3, angle * moveDist)
			deb3 = moveDist

			-- roll
			local angle = math.atan2( (postions_y[3] + postions_y[1] - postions_y[4] - postions_y[2]) * 0.5, 300)
			--(postions_z[4] + postions_z[3] - postions_z[2] - postions_z[1]) * 0.5
			Turn(base, 3, angle)
			Move(base, 1, -angle * moveDist)

			deb2 = angle
			updBase = false
		end

		-- rotaion matrix my beloved, and y offset
		m3d00,	m3d01,	m3d02,	_,
		m3d10,	m3d11,	m3d12,	_,
		m3d20,	m3d21,	m3d22,	_,
		_,		baseOffset	= Spring.GetUnitPieceMatrix(unitID, base)
		--  0.97899908,	0.13875398,	-0.1493592,	 0,
		-- -0.2038648,	0.6663242,	-0.7172526,	 0,
		--  0,			0.73263866,	 0.68061781, 0,
		--	0,			35.1347351,	 0,			 1

		-- move to check the next leg on the next frame
		legPosUpd = legPosUpd % 4 + 1
	end
end

local function slowUpdate()
	while true do
		Sleep(6600)
		Spring.Echo(deb1, deb2, deb3)
	end
end

function script.Create()
	x,y,z = Spring.GetUnitPosition(unitID)
	dx, _, dz = Spring.GetUnitDirection(unitID)
	Move(base, 2, 0)

	StartThread(update)
	StartThread(slowUpdate)
end