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
local baseOffsetX, baseOffsetY, baseOffsetZ = 0, 100, 0
-- to local base plate space
local function toLocalSpace3d(in_x, in_y, in_z)
	local ox, oy, oz = 0,0,0
	local tmp_in_x, tmp_in_y, tmp_in_z = in_x - baseOffsetX, in_y - baseOffsetY, in_z - baseOffsetZ
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

local OFFSET_X, OFFSET_Y = 170, 180
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
	local legPosUpd, legFree = 1, 0
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
		if legFree < 1 and (dd1[legPosUpd] > 250 or dd1[legPosUpd] < 110
		or da1[legPosUpd] > limitMax[legPosUpd]	or da1[legPosUpd] < limitMin[legPosUpd]) then
			-- move legs in relation to where we heading, with vertial velocity colapsing them inward
			local mdx, mdy, mdz = Spring.GetUnitVelocity(unitID)
			mdx = mdx * 30 * ( 1 - math.abs(mdy) )
			mdz = mdz * 30 * ( 1 - mdy )
			local height, itteration = 0,1
			repeat
				-- @TODO: make this primarly affect mode direction offset
				postions_x[legPosUpd] = (  dz * (start_offsetxs[legPosUpd]) + dx * ( start_offsetzs[legPosUpd]) + mdx ) * itteration + x
				postions_z[legPosUpd] = ( -dx * (start_offsetxs[legPosUpd]) + dz * ( start_offsetzs[legPosUpd]) + mdz ) * itteration + z
				height = Spring.GetGroundHeight(postions_x[legPosUpd], postions_z[legPosUpd])
				itteration = itteration * 0.75
			until math.abs(height - y) - 100 < 50 or itteration < 0.4
			postions_y[legPosUpd] = height
			updBase = true
			legFree = 10
			-- @TODO: compare retrived ground against current, if
		end

		-- update the plane of the base based on the 4 leg target positions if one of them has moved
		if updBase then
			local tmp_sum_1 = postions_y[4] + postions_y[3]
			local tmp_sum_2 = postions_y[2] + postions_y[1]

			-- prevent sitting in troughs
			local moveDist = math.max((tmp_sum_1 + tmp_sum_2 + y) * 0.25 + 50 - y, 50)

			-- pitch	
			local angle = math.atan2( (tmp_sum_1 - tmp_sum_2) * 0.5, 160) --@TODO: 160 is a bad estimate of distance between front and back
			Turn(base, 1, angle)

			Move(base, 2, moveDist - 50)
			Move(base, 3, angle * moveDist)

			-- roll
			local angle = math.atan2( (postions_y[3] + postions_y[1] - postions_y[4] - postions_y[2]) * 0.5, 300) --@TODO: 300 is a questionable estimate of distsance between left and right
			Turn(base, 3, angle)
			Move(base, 1, -angle * moveDist)

			updBase = false

		end

		-- rotaion matrix my beloved, and y offset
		m3d00,	m3d01,	m3d02,	_,
		m3d10,	m3d11,	m3d12,	_,
		m3d20,	m3d21,	m3d22,	_,
		baseOffsetX, baseOffsetY, baseOffsetZ	= Spring.GetUnitPieceMatrix(unitID, base)

		-- move to check the next leg on the next frame
		legPosUpd = legPosUpd % 4 + 1
		if legFree > 0 then legFree = legFree - 1 end
	end
end

function script.Create()
	x,y,z = Spring.GetUnitPosition(unitID)
	dx, _, dz = Spring.GetUnitDirection(unitID)

	StartThread(update)
end