local base, body, f1, f2, f3, f4, f5, growth, armature = piece("empty_root_piece", "base","flare1","flare2","flare3","flare4","flare5","growth", "armature")
local lastPrint, upgrading, point = f1, 0, f1

function replace()
	Spring.DestroyUnit(unitID, false, true)
end

function _shrink()
	Sleep(5800)
	Spring.DestroyUnit(unitID, false, true)
end

function shrink()
	Move(body,2,-100,12)
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, false)
	StartThread(_shrink)
end

function script.Create()
	Turn(f1,2,-1.570796,nil)
	Turn(f2,2,2.827433,nil)
	Turn(f3,2,4.08407,nil)
	Turn(f4,2,5.340708,nil)
	Turn(f5,2,0.314159,nil)
	Move(f1,2,-12,nil)
	Move(f2,2,-12,nil)
	Move(f3,2,-12,nil)
	Move(f4,2,-12,nil)
	Move(f5,2,-12,nil)

	local mx, _, mz = Spring.GetUnitPosition(unitID)
	local gx, _, gz = Spring.GetGroundNormal(mx, mz)
	local facing = Spring.GetUnitBuildFacing(unitID)
	if facing == 0 then
		gx, gz = gz, -gx
	elseif facing == 1 then
	elseif facing == 2 then
		gx, gz = -gz, gx
	elseif facing == 3 then
		gx, gz = -gx, -gz
	end
	Turn(armature,1,gx,nil)
	Turn(armature,3,gz,nil)

	Sleep(2400)

	local spawn = Spring.CreateUnit
	local x,y,z = Spring.GetUnitPosition(unitID)
	local teamID = Spring.GetUnitTeam(unitID)
	local cusPar = UnitDefs[UnitDefNames.prap_nexus.id].customParams
	spawn(cusPar.entourage1, x-70, y, z, 3, teamID) -- left mid
	spawn(cusPar.entourage2, x-20, y, z-69, 2, teamID) -- up left
	spawn(cusPar.entourage3, x+65, y, z+40, 1, teamID) -- top right
	spawn(cusPar.entourage4, x+65, y, z-40, 1, teamID) -- bottom right
	spawn(cusPar.entourage5, x-20, y, z+69, 0, teamID) -- bottom left
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
end

local function _growOut()
end

function growOut()
	StartThread(_growOut)
end

function prepGrow()
end

function upgradeState()
	upgrading = 1
end

function placingMex(x, y, z)
	upgrading = 2
	Move(growth,1,x,nil)
	Move(growth,2,y,nil)
	Move(growth,3,z,nil)
end

function script.StartBuilding()
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
	Spring.SetUnitNanoPieces(unitID, {body})
	if upgrading == 1 then --temp.customParams.upgradable then
		point = base
	elseif upgrading == 2 then
		point = growth
	else
		lastPrint = (lastPrint + 1) % 5
		point = lastPrint + f1
	end
	upgrading = 0
	return true
end

function script.StopBuilding()
	point = 0
end

function script.QueryBuildInfo()
	return point
end

function script.QueryNanopiece()
	return body
end