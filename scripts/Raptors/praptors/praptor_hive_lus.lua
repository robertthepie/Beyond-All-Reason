local body, hand = piece("base", "armbase")

function script.Create()
	Spring.Echo("EPIEhive spawned")
end

function script.StartBuilding()
	Spring.Echo("EPIEstart build called")
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
	Spring.SetUnitNanoPieces(unitID, {hand})
	return true
end

function script.QueryBuildInfo()
	Spring.Echo("EPIEquery called")
	return hand
end

function script.QueryNanopiece()
	Spring.Echo("EPIEnanopiece called")
	return hand
end