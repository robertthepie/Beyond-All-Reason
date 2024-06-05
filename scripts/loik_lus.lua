local empty_root_piece, base, a1, a2, a3, a4, l1, l2, r1, r2, lb1, lb2, rb1, rb2 = piece("empty_root_piece", "Base", "LF1", "LF2", "LF3", "LF4", "L1", "L2", "R1", "R2", "LB1", "LB2", "RB1", "RB2")

local x, y, z = 1,1,1
local dx, dy, dz = 1,1,1
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

-- some constants for leg length and leg length needed maths
local legIn, legOut = 70, 70
local legInSqrd, legOutSqrd = legIn*legIn, legOut*legOut
local legTotSqrd, legTot  = legInSqrd + legOutSqrd, 2 * legIn * legOut

-- updates the armeture p1, p2 to point twoards the target x/y/z with the passed in offset being where the armeture starts on the model
local function updateLeg(leg1, leg2, target_x, target_y, target_z, legoffset_x, legoffset_y, legoffset_z, marker)
	-- convert our target to local pos
	local px, py, pz = toLocalSpace(target_x, target_y, target_z)

	Move(marker, 1, px)
	Move(marker, 2, py)
	Move(marker, 3, pz)

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

	return dist3d, angle
end

local OFFSET_X, OFFSET_Y = 75, 20

local function update()
	-- local marker = Spring.CreateUnit("armflea", x, y, z, "n", Spring.GetUnitTeam(unitID))
	local postions_x = {}
	local postions_y = {}
	local postions_z = {}
	local leg1s = {l1, r1, lb1, rb1}
	local leg2s = {l2, r2, lb2, rb2}
	local offsetxs = {25, -25, 25, -25}
	local offsetzs = {30, 30, -30, -30}
	local start_offsetxs = {OFFSET_X, -OFFSET_X, OFFSET_X, -OFFSET_X}
	local start_offsetzs = {OFFSET_Y, OFFSET_Y, -OFFSET_Y, -OFFSET_Y}
	local markers = {a1, a2, a3, a4}
	local limitMax = {2.3561944, 0, 0.7853981, 3.1415926}
	local limitMin = {0, -2.3561944, -3.1415926, -0.7853981}
	do
		postions_x[1] = x + OFFSET_X
		postions_z[1] = z + OFFSET_Y + 25
		postions_y[1] = Spring.GetGroundHeight(x + OFFSET_X, z + OFFSET_Y)

		postions_x[2] = x - OFFSET_X
		postions_z[2] = z + OFFSET_Y + 25
		postions_y[2] = Spring.GetGroundHeight(x - OFFSET_X, z + OFFSET_Y)

		postions_x[3] = x + OFFSET_X
		postions_z[3] = z - OFFSET_Y - 25
		postions_y[3] = Spring.GetGroundHeight(x + OFFSET_X, z - OFFSET_Y)

		postions_x[4] = x - OFFSET_X
		postions_z[4] = z - OFFSET_Y - 25
		postions_y[4] = Spring.GetGroundHeight(x - OFFSET_X, z - OFFSET_Y)
	end
	local dd1, da1 = 0,0
	while true do
		Sleep(1)
		x,y,z = Spring.GetUnitPosition(unitID)
		dx, dy, dz = Spring.GetUnitDirection(unitID)

		for i = 1, 4 do
			dd1, da1 = updateLeg(leg1s[i], leg2s[i], postions_x[i], postions_y[i], postions_z[i], offsetxs[i], 25, offsetzs[i], markers[i])
			if dd1 > 110 then
			-- or da1 > limitMax[i]
			-- or da1 < limitMin[i] then
				postions_x[i] =  dz * start_offsetxs[i] + dx * ( start_offsetzs[i] + 55 ) + x
				postions_z[i] = -dx * start_offsetxs[i] + dz * ( start_offsetzs[i] + 55 ) + z
				postions_y[i] = Spring.GetGroundHeight(postions_x[i], postions_z[i])
			end
		end
	end
end

function script.Create()
	x,y,z = Spring.GetUnitPosition(unitID)
	dx, dy, dz = Spring.GetUnitDirection(unitID)
	Move(base, 2, 25)

	StartThread(update)
end