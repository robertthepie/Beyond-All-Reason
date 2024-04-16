local base, body, t1, t2, t3, t4, t5, growth, armature = piece("empty_root_piece", "BaseDen","ArmBackLeft","ArmBackRight","ArmCentreLeft","ArmForwardRight","ArmFrontRight","growth", "armature")

local lastPrint, upgrading, point = base, 0, base

function replace()
	Spring.DestroyUnit(unitID, false, true)
end

function shrink()
	Move(body,2,-90,11.25)
	Sleep(5800)
	Spring.DestroyUnit(unitID, false, true)
end

local function _growOut()
	Show(body)
	Move(body, 2, 0, 11.25)
	Sleep(5800)
	Show(t1)
	Show(t2)
	Show(t3)
	Show(t4)
	Show(t5)
end

function growOut()
	StartThread(_growOut)
end

function prepGrow()
	Move(body, 2, -90, nil)
	Hide(body)
	Hide(t1)
	Hide(t2)
	Hide(t3)
	Hide(t4)
	Hide(t5)
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

function script.Create()
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)

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
end

function script.StartBuilding()
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
	Spring.SetUnitNanoPieces(unitID, {base})
	point = base
	if upgrading == 2 then
		point = growth
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
	return point
end