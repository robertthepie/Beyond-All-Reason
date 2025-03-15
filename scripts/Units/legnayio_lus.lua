local base, head, tail, t1, t2, t3, t4, t5, t6 =piece("base",
	"head", "tail", -- goals
	"base1", "base2", "base3", "base4", "base5", "base6" -- body pieces
	)

local _x, _y, _z = 0,0,0
local _rx, _ry, _rz = 0,0,0

--local TAILGAP = 36--*6 -- i really don't know, tail length * tail num maybe?
local TAILGAP = 28--??????? -- i really don't know, tail length * tail num maybe?
local TAILGAPSQRD = TAILGAP*TAILGAP
local tails = { t1, t2, t3, t4, t5, t6, }
local history = {
	{x=0,y=0,z=0, gnx=0, gny=0, gnz=0},
	{x=0,y=0,z=0, gnx=0, gny=0, gnz=0},
	{x=0,y=0,z=0, gnx=0, gny=0, gnz=0},
	{x=0,y=0,z=0, gnx=0, gny=0, gnz=0},
	{x=0,y=0,z=0, gnx=0, gny=0, gnz=0},
	{x=0,y=0,z=0, gnx=0, gny=0, gnz=0},
	{x=0,y=0,z=0, gnx=0, gny=0, gnz=0},
}

local function toLocalSpace2d(x, y, z)
	local vx, vy, vz = 0, 0, 0
	local ovx, ovy, ovz = 0, 0, 0
	vx = x - _x
	ovy = y - _y
	vz = z - _z

	ovx = vx * _rz + vz * -_rx
	ovz = vx * _rx + vz * _rz
	return ovx, ovy, ovz
end

local function toLocalRotation(x, y, z)
	return x * _rz + z * -_rx, y, x * _rx + z * _rz
end

local function update()
	local progress, float_progress = 0, 0

	local hx, hy, hz = Spring.GetUnitPiecePosDir(unitID, head)
	local phx, phy, phz = hx, hy ,hz
	local dx, dy, dz = 0,0,0
	_rx, _ry, _rz = Spring.GetUnitDirection(unitID)
	local sh, sh2
	local gnx, gny, gnz = Spring.GetGroundNormal(hx, hz)

	local lx, ly, lz, plx, ply, plz = 0,0,0,0,0,0
	local dlx, dly, dlz
	local currentTail = 0

	while true do
		Sleep(1)

		_x, _y, _z = Spring.GetUnitPosition(unitID)
		_rx, _ry, _rz = Spring.GetUnitDirection(unitID)

		hx, _, hz = Spring.GetUnitPiecePosDir(unitID, head)
		hy = Spring.GetGroundHeight(hx, hz)
		dx, dy, dz =
			phx - hx,
			phy - hy,
			phz - hz

		progress = math.sqrt(
			  dx*dx
			+ (dy*dy*2) -- abstact value that felt right due to noticable stretching when moving vertically
			+ dz*dz)

		if progress >= TAILGAP then
			progress = progress - TAILGAP
			phx, phy, phz = hx, hy ,hz
			for i = 7, 1, -1 do
				history[i+1] = history[i]
			end

			gnx, gny, gnz = Spring.GetGroundNormal(hx, hz, true)
			history[1] = {x=hx, y=hy, z=hz, gnx=gnx, gny=gny, gnz=gnz}

		end
		float_progress = progress/TAILGAP
		plx, plz = 0, 96 -- 96 is distance to head
		sh = history[1]
		for i = 1, 6 do
			currentTail = tails[i]
			sh2 = sh
			sh = history[i+1]
			lx, ly, lz = toLocalSpace2d(
				math.mix(sh.x, sh2.x, float_progress),
				math.mix(sh.y, sh2.y, float_progress),
				math.mix(sh.z, sh2.z, float_progress)
			)
			Move(currentTail, 1, lx)
			Move(currentTail, 2, ly+16)
			Move(currentTail, 3, lz)
			dlx, dlz = plx-lx, plz-lz
			Turn(
				currentTail,
				2,
				math.atan2(dlx, dlz)
			)
			gnx, gny, gnz = toLocalRotation(
				math.mix(sh.gnx, sh2.gnx, float_progress),
				math.mix(sh.gny, sh2.gny, float_progress),
				math.mix(sh.gnz, sh2.gnz, float_progress)
			)
			Turn(
				currentTail,
				1,
				gnz
			)
			Turn(
				currentTail,
				3,
				-gnx
			)
			plx, plz = lx, lz
		end

	end
end

function script.Create()
	_x, _y, _z, _rx, _ry, _rz = Spring.GetUnitPiecePosDir(unitID, head)
	for i, past in pairs(history) do
		-- i wish i bloody knew
		past["x"] = _x - i * _rx * TAILGAP--36*0.75
		past["y"] = _y
		past["z"] = _z - i * _rz * TAILGAP--36*0.75
	end
	for i = 1, 6 do
		Move(tails[i], 1, 0)
		Move(tails[i], 2, -50)
		Move(tails[i], 3, 0)
	end
	StartThread(update)
end














function script.StartMoving()

end

function script.StopMoving()

end

function script.AimFromWeapon(weapon)
	return head
end

function script.AimWeapon(weapon, heading, pitch)
	return base
end

function script.FireWeapon(weapon)
	return false
end

function script.QueryWeapon(weapon)
	return base
end

function script.Killed()

end
