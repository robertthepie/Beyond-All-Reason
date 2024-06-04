local empty_root_piece, base, a1, a2, a3, l1, l2 = piece("empty_root_piece", "Base", "LF1", "LF2", "LF3", "L1", "L2")


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

local px, py, pz

local legIn, legOut = 50, 50
local legInSqrd, legOutSqrd = legIn*legIn, legOut*legOut
local legTotSqrd, legTot  = legInSqrd + legOutSqrd, 2 * legIn * legOut


local function update()
	local marker = Spring.CreateUnit("armflea", x, y, z, "n", Spring.GetUnitTeam(unitID))
	while true do
		Sleep(1)
		x,y,z = Spring.GetUnitPosition(unitID)
		dx, dy, dz = Spring.GetUnitDirection(unitID)
		px, py, pz = toLocalSpace(Spring.GetUnitPosition(marker))

		Move(a3, 1, px)
		Move(a3, 2, py+10)
		Move(a3, 3, pz)

		px = px - 25
		py = py - 25
		pz = pz - 25

		local px2, py2, pz2 = px*px, py*py, pz*pz
		local angle = math.atan2(px, pz)
		local dist = math.sqrt(px2 + pz2)
		local dist3dSQRD = px2 + pz2 + py2
		local angle2 = math.atan2(dist, py)

		-- cosine rule finding, asuuming leg len is 20
		local legCosAngPit = math.acos( math.min( (legInSqrd + dist3dSQRD - legOutSqrd) / (2 * legIn * math.sqrt(dist3dSQRD)) ,1 ))
		local legCosAngElb = math.acos( math.max( (legTotSqrd - dist3dSQRD) / legTot , -1 ))
		--Spring.Echo(legCosAngPit, legCosAngElb, legCosAngPit + legCosAngElb + legCosAngPit)
		--[[

			Turn(a2, 1, angle2-legCosAngPit)
			Turn(a2, 2, angle)
			Move(a2, 1, px / 2)
			Move(a2, 2, py / 2 + 25)
			Move(a2, 3, pz / 2)
			
			Turn(a1, 1, -angle2+legCosAngPit)
			Turn(a1, 2, angle)
			Move(a1, 2, 25)
			Move(a1, 1, 25)
			Move(a1, 3, 25)
			]]
			
		Turn(l1, 1, angle2-1.5707963-legCosAngPit)
		
		--Turn(l1, 1, -legCosAngPit)
		Turn(l1, 2, angle)
		Turn(l2, 1, 3.1415926-legCosAngElb)
		--Turn(l2, 1, 0)

	end
end

--[[
	c² = a² + b² - abcosC
	c² + abcosC = a² + b²
	abcosC = a² + b² - c²
	cos α = [b2 + c2 – a2]/2bc

	soh
	sin a = o / h

	1 / 2
	1 + 1 - 1
	1 / 2

	]]

function script.Create()
	-- local x,y,z = Spring.GetUnitPosition(unitID)
	-- local dirX, dirY, dirZ = Spring.GetUnitDirection(unitID)
	-- -- Spring.Echo(Spring.GetUnitPiecePosDir(unitID,base))
	-- -- Spring.Echo(Spring.GetUnitPiecePosDir(unitID,empty_root_piece))
	-- Spring.Echo(dirX, dirY, dirZ)
-- 
	-- local dx = math.atan2(dirY, dirX)
	-- local dz = math.atan2(dirY, dirZ)
-- 
	-- Move(a1, 2, 5)
	-- Turn(a1, 1, dx)
	-- Turn(a1, 3, dz)
	x,y,z = Spring.GetUnitPosition(unitID)
	dx, dy, dz = Spring.GetUnitDirection(unitID)
	Move(a1, 1, 0)
	Move(a1, 2, 0)
	Move(a1, 3, 0)
	Turn(a1, 1, 0)
	Turn(a1, 2, 0)
	Turn(a1, 3, 0)

	Move(a1, 1, 0)
	Move(a1, 2, 0)
	Move(a1, 3, 0)

	Move(a2, 1, 25)
	Move(a2, 2, 75)
	Move(a2, 3, 25)
	
	Move(l1, 1, 50)

	StartThread(update)
end