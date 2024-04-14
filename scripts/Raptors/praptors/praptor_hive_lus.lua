local body,f1,f2,f3,f4,f5 = piece("base","flare1","flare2","flare3","flare4","flare5")
local lastPrint, upgrading, point = 4, 0, 4

function replace()
	Spring.DestroyUnit(unitID, false, true)
end

function _shrink()
	Sleep(5800)
	Spring.DestroyUnit(unitID, false, true)
end

function shrink()
	Move(body,2,-90,11.25)
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, false)
	StartThread(_shrink)
end

function script.Create()
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
	--Turn(f1,2,4.712389,nil)
	Turn(f1,2,-1.570796,nil) -- ???
	Turn(f2,2,2.827433,nil)
	Turn(f3,2,4.08407,nil)
	Turn(f4,2,5.340708,nil)
	Turn(f5,2,0.314159,nil)
	Move(f1,2,-12,nil)
	Move(f2,2,-12,nil)
	Move(f3,2,-12,nil)
	Move(f4,2,-12,nil)
	Move(f5,2,-12,nil)
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

function script.StartBuilding()
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
	Spring.SetUnitNanoPieces(unitID, {body})
	if upgrading == 1 then --temp.customParams.upgradable then
		upgrading = 0
		point = 0
	else
		lastPrint = lastPrint % 5 + 1
		point = lastPrint + 1
	end
	return true
end

function script.QueryBuildInfo()
	return point
end

function script.QueryNanopiece()
	return body
end