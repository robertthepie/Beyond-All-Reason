local gadget = gadget ---@type Gadget

function gadget:GetInfo()
	return {
		name	= "Community: Mobile Labs",
		desc	= "Creates Mobile Labs via attatching a lab to an underlying unit, and passing on its orders",
		author	= "Robert the Pie",
		date	= "April Not Fools 2025",
		license	= "GNU GPL, v2 or later",
		layer	= 0,
		enabled	= true
	}
end

--- Mobile Lab Custom Params:
--- String	lab_carried_by:				unit name of what unit is to carry this
--- Int		[lab_carried_on]:			Optional, default 0.	piece number to attatch to, otherwise 0
--- TODO: UNIMPLEMENTEDBool	[lab_carried_autostore]:	Optional, default false	should this lab's units get orders to get transported by this unit. Don't build when full should be handled by animation.
local mobileLabs = {}
local mobileLabCarryOn = {}
--local mobileLabsAutobag = {}
for unitDefID, unitDef in pairs(UnitDefs) do
	if unitDef.customparam.lab_carried_by then
		if UnitDefNames[unitDef.customparam.lab_carried_by] then
			mobileLabs[unitDefID] = UnitDefNames[unitDef.customparam.lab_carried_by].id
			if unitDef.customparam.lab_carried_on then
				mobileLabCarryOn[unitDefID] = tonumber(unitDef.customparam.lab_carried_on)
			end
			--if unitDef.customparam.lab_carried_autostore then
			--	mobileLabsAutobag[unitDefID] = true
			--end
		end
	end
end

------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then--SYNCED--
------------------------------------------------

function gadget:UnitFinished(unitID, unitDefID, unitTeam)
	if mobileLabs[unitDefID] then
		local x,y,z = Spring.GetUnitPosition(unitID)
		if x then
			local facing = Spring.GetUnitBuildFacing(unitID)
			local carrier = Spring.CreateUnit(mobileLabs[unitDefID], x, y, z, facing or "s", unitTeam)
			if carrier then
				Spring.SetUnitNoSelect(carrier, true)
				Spring.UnitAttach(carrier, unitID, mobileLabCarryOn[unitDefID] or 0)
				SendToUnsynced()
			else
				Spring.Log(gadget:GetInfo().name, "warning", "Failed to create a carrier for a mobile lab")
			end
		end
	end
end

----------------
else--UNSYNCED--
----------------

local trackedMobileLabs = {}

local function LinkMobileLabToCarrier(_, mobileLabID, carrierID)
	trackedMobileLabs[mobileLabID] = carrierID
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
	if trackedMobileLabs[unitID] then
		trackedMobileLabs[unitID] = nil
	end
end

function gadget:Initialize()
	gadgetHandler:AddSyncAction("LinkMobileLabToCarrier", LinkMobileLabToCarrier)
end

function gadget:Shutdown()
	gadgetHandler:RemoveSyncAction("LinkMobileLabToCarrier")
end

----------
end--EOF--
----------