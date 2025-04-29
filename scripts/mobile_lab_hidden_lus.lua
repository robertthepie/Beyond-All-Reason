local base, pad, head1, head2, nano1, nano2, cagelight, cagelight_emit = piece("base", "pad", "head1", "head2", "nano1", "nano2", "cagelight", "cagelight_emit")
local public_mock

local function Update()
	local x,y,z
	local ry
	local mx,my,mz = Spring.GetUnitPosition(unitID)
	do
		local my_team = Spring.GetUnitTeam(unitID)
		public_mock = Spring.CreateUnit("mobile_lab_public", mx, my, mz, "s", my_team)
	end
	while true do
		x,y,z = Spring.GetUnitPosition(public_mock)
		_, ry, _ = Spring.GetUnitRotation(public_mock)
		Move(nano1, 1, x-mx)
		Move(nano1, 2, y-my)
		Move(nano1, 3, z-mz)
		Turn(nano1, 2, ry)
		Sleep(1)
	end
end

function script.Create()
	Hide(base)
	Hide(pad)
	Hide(head1)
	Hide(head2)
	--Hide(nano1)
	Hide(nano2)
	Hide(cagelight)
	Hide(cagelight_emit)

	Spring.UnitScript.SetUnitValue(COB.INBUILDSTANCE, true)

	StartThread(Update)
end
function script.StartMoving()
end
function script.StopMoving()
end
function script.AimFromWeapon(weapon)
end
function script.AimWeapon(weapon, heading, pitch)
end
function script.FireWeapon(weapon)
end
function script.QueryWeapon(weapon)
end
function script.StartBuilding(heading, pitch)
end
function script.StopBuilding()
end
function script.QueryNanoPiece()
	return nano1
end
function script.QueryBuildInfo()
	return nano1
end
function script.Killed()
	return 0
end