local base, rail = piece("body", "rail")

-- Called when a passenger should be loaded into the transport. This should eventually call AttachUnit to actually attach the unit. Assuming the transport is in range of the next passenger, this will be called again for the next passenger 16 frames later, unless the script enters the BUSY state: then Spring will not move on to the next passenger until the script leaves the BUSY state.
function script.TransportPickup(passengerID) --> nil
	if moving then return end
	Move(rail, 1, 0)
	Move(rail, 2, 0)
	Move(rail, 3, 0)
	Spring.UnitAttach( unitID, passengerID, rail)
end



-- Called when a passenger should be unloaded. This should eventually call DetachUnit to actually detach the unit, unless the used unload method is UnloadLandFlood, in which case Spring will actually detach the unit after the call.
function script.TransportDrop ( passengerID, x, y, z ) --> nil
	Spring.UnitDetach(passengerID)
end



-- Only called in UnloadLandFlood behavior, after the last unit has been unloaded. 
function script.EndTransport ( ) --> nil

end

local moving = false
local _x,_y,_z
local function dropLoad()
	local dist = 
	_x * _x +
	_y * _y +
	_z * _z
	dist = math.sqrt(dist)
	Move(rail, 1, _x, 5000 * (_x / dist))
	Move(rail, 2, _y, 5000 * (_y / dist))
	Move(rail, 3, _z, 5000 * (_z / dist))

	WaitForMove(rail,1)
	WaitForMove(rail,3)

	local load = Spring.GetUnitIsTransporting(unitID)
	for _, passengerID in pairs(load) do
		Spring.UnitDetachFromAir(passengerID)
	end
	moving = false
end

function unloadat(x, y, z)
	if moving then return end
	moving = true

	_x,_y,_z = x,y,z
	StartThread(dropLoad)
end



function script.Create()
	Spring.Echo("created")
end


function script.StartMoving() end


function script.StopMoving() end


function script.AimFromWeapon(weapon) end


function script.AimWeapon(weapon, heading, pitch) end


function script.FireWeapon(weapon) end


function script.QueryWeapon(weapon) end


function script.StartBuilding(heading, pitch) end


function script.StopBuilding() end


function script.QueryNanoPiece() end


function script.Killed()
	return 1
end

