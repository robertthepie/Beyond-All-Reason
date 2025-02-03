local base, body, flare, arms =
	piece("base", "body", "flare", "arms")

function script.Create()
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
end

function script.StartBuilding(heading, pitch)
	return true
end

function script.StopBuilding()
	return true
end

function script.QueryNanoPiece()
	return base
end

function script.QueryBuildInfo()
	return flare
end

function script.Killed()
	return 1
end

function setBuildPoint(x, y, z)
	Move(flare,1,x)
	Move(flare,2,y)
	Move(flare,3,z)
	Turn(flare,2,math.atan2(-x,z))
end
