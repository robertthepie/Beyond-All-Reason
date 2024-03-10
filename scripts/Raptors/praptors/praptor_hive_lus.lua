local body = piece("base")

function script.Create()
	--Spring.Echo("EPIEhive spawned")
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
end

function script.StartBuilding()
	--Spring.Echo("EPIEstart build called")
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
	Spring.SetUnitNanoPieces(unitID, {body})
	return true
end

function script.QueryBuildInfo()
	return body
end

function script.QueryNanopiece()
	--Spring.Echo("EPIEnanopiece called")
	return body
end