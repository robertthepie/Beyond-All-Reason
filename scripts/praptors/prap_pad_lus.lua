local base, pad, head1 =
	piece("base", "pad", "head1")

function script.Create()
	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)
end

function setAngle(angle)
	Move(head1, 1, -40)
	Move(head1, 3, -40)
	local face = Spring.GetUnitBuildFacing(unitID)
	-- -0.1 is to fix a weird edge case
	Turn(head1, 2, angle + math.rad(face*90) - 0.01)
end

function script.StartBuilding(heading, pitch)
	return true
end

function script.StopBuilding()
	return true
end

function script.QueryNanoPiece()
	return head1
end

function script.QueryBuildInfo()
	return head1
end

function script.Killed()
	return 1
end