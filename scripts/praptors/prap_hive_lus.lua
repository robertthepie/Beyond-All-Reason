local base, flare1, flare2, flare3, flare4, flare5 =
	piece("base", "flare1", "flare2", "flare3", "flare4", "flare5")

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

function script.Killed()
	return 1
end