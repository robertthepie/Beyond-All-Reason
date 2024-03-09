if not gadgetHandler:IsSyncedCode() then
	return
end
function gadget:GetInfo()
	return {
		name		= "Playable Raptors Extra Behaviour Handler",
		desc		= "Handles additional behaviour such us recyling when a factory upgrades itself",
		author		= "robert the pie", -- it is not robert the epie
		date		= "March 2024",
		license		= "GNU GPL, v2 or later",
		layer		= 0,
		enabled		= true,
	}
end

local reclaimable = {}
-- weird way to make sure these units exist individually
for unit, hide in pairs({
	praptor_nest=-1,
	praptor_hive=0,
}) do
	local temp = UnitDefNames[unit].id
	if temp then
		reclaimable[temp]={hide,UnitDefs.id.metalcost}
	end
end
-- @TODO add a custom param support, maybe mirgate entierly?

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	local builderDefID = Spring.GetUnitDefID(builderID)
	if reclaimable[builderDefID] then
		
	end
end