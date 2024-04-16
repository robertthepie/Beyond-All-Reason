local base, body, t1, t2, t3, t4, t5, nest, f1, f2, f3, growth, armature = piece("empty_root_piece","MainBody","NestStrut","NestStrut1","NestStrut2","NestStrut3","NestStrut4","Nest","flare1","flare2","flare3","growth", "armature")

local lastPrint, upgrading, point = 0, 0, 7

function replace()
	Spring.DestroyUnit(unitID, false, true)
end

function shrink()
	Spring.DestroyUnit(unitID, false, true)
end

local function _growOut()
	Show(body)
	Show(t1)
	Show(t2)
	Show(t3)
	Show(t4)
	Show(t5)
	Show(nest)

	Move(t1, 2, 0, 11.25)
	Move(t2, 2, 0, 11.25)
	Move(t3, 2, 0, 11.25)
	Move(t4, 2, 0, 11.25)
	Move(t5, 2, 0, 11.25)
	Turn(nest, 1, 0, 0.174532875)
	Turn(nest, 2, 0, 0.01418075)

	Spin(t1, 2, -0.78539816339744830961566084581988)
	Spin(t2, 2, -0.78539816339744830961566084581988)
	Spin(t3, 2, -0.78539816339744830961566084581988)
	Spin(t4, 2, -0.78539816339744830961566084581988)
	Spin(t5, 2, -0.78539816339744830961566084581988)

	Sleep(6000) -- sorta timed so that it is far enough into the spin that this finished the 360 spin
	Turn(t1, 2, 0, 0.78539816339744830961566084581988)
	Turn(t2, 2, 0, 0.78539816339744830961566084581988)
	Turn(t3, 2, 0, 0.78539816339744830961566084581988)
	Turn(t4, 2, 0, 0.78539816339744830961566084581988)
	Turn(t5, 2, 0, 0.78539816339744830961566084581988)
end

function growOut()
	StartThread(_growOut)
end

function prepGrow()
	Move(t1, 2, -90, nil)
	Move(t2, 2, -90, nil)
	Move(t3, 2, -90, nil)
	Move(t4, 2, -90, nil)
	Move(t5, 2, -90, nil)
	Turn(nest, 1, -1.396263, nil)
	Turn(nest, 2, 0.113446, nil)
	Hide(body)
	Hide(t1)
	Hide(t2)
	Hide(t3)
	Hide(t4)
	Hide(t5)
	Hide(nest)
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
	Turn(f2,2,2.094395,nil)
	Turn(f3,2,4.18879,nil)

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
	Spring.SetUnitNanoPieces(unitID, {body})
	if upgrading == 1 then --temp.customParams.upgradable then
		point = base
	elseif upgrading == 2 then
		point = growth
	else
		lastPrint = (lastPrint + 1) % 3
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
	return nest
end