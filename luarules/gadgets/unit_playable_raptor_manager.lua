local modoptions = Spring.GetModOptions()
if modoptions.playablerapotrs ~= true and modoptions.forceallunits ~= true then
	return false
end

function gadget:GetInfo()
	return {
		name = "Playable Raptor Manager",
		desc = "Manages gameplay mechanics/behaviors unique to Playable Raptors",
		author = "robert the pie",
		date = "9th of March, 2024",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true,
	}
end

local hiveDefIDs		= {}
local hiveUpgradables	= {}
local hivePlateDefIDs	= {}
local hiveEcoDefIDs		= {}
for unitDefID, unitDef in pairs(UnitDefs) do
	if unitDef.customParams.hive then
		hiveDefIDs[unitDefID] = true
		hiveUpgradables[unitDefID] = true
	elseif unitDef.customParams.hivepad then
		hivePlateDefIDs[unitDefID] = true
		hiveUpgradables[unitDefID] = true
	end
end

if gadgetHandler:IsSyncedCode() then
-- Synced Space
local hivePadPos5arms = {
	{100, 0},
	{30.9, 95.1,},
	{-80.9, 58.8,},
	{-80.9, -58.8,},
	{30.9, -95.1,},
}
local hivePadPos3arms = {
	{100, 0},
	{ -50, 86.6},
	{ -50, -86.6},
}

local activeHives = {}
local padToOwner = {}
local activeBuilds = {}

--[[
	Notes:
		Hives spawn fully built at low health
]]--

-- adds build pads for arms to a new hive
local function handleNewHive(unitID, unitTeam)
	-- for positioning build pads and sub-hives
	local create = Spring.CreateUnit
	local x, y, z = Spring.GetUnitPosition(unitID)
	local face = Spring.GetUnitBuildFacing(unitID)
	local pad, ang

	-- Create Hive subhive pads
	if face == 0 then
		for i = 1, 3 do
			pad = create("prap_pad", x + hivePadPos3arms[i][1], y,  z + hivePadPos3arms[i][2], face, unitTeam)
			if not pad then return false end
			ang = math.rad(i * 120 - 120 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID
		end
	elseif face == 1 then
		for i = 1, 3 do
			pad = create("prap_pad", x - hivePadPos3arms[i][2], y, z - hivePadPos3arms[i][1], face, unitTeam)
			if not pad then return false end
			ang = -math.rad(i * 120 - 120 + 180)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID
		end
	elseif face == 2 then
		for i = 1, 3 do
			pad = create("prap_pad", x - hivePadPos3arms[i][1], y,  z - hivePadPos3arms[i][2], face, unitTeam)
			if not pad then return false end
			ang = math.rad(i * 120 - 120 + 180 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID
		end
	else
		for i = 1, 3 do
			pad = create("prap_pad", x + hivePadPos3arms[i][2], y, z + hivePadPos3arms[i][1], face, unitTeam)
			if not pad then return false end
			ang = -math.rad(i * 120 - 120)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID
		end
	end
end

local function updateRotation(builderID)
	if hivePlateDefIDs[Spring.GetUnitDefID(builderID)] then
		local env = Spring.UnitScript.GetScriptEnv(builderID)
		if env then
			local _, y, _ = Spring.GetUnitRotation(builderID)
			Spring.UnitScript.CallAsUnit(builderID, env.setAngle, y)
		end
	end
end


-- converts the arms of a preexisting hive to it's new tier and adds more
local function handleHiveInheritance(unitID, unitTeam)
	-- for positioning build pads and sub-hives
	local create = Spring.CreateUnit
	local x, y, z = Spring.GetUnitPosition(unitID)
	local face = Spring.GetUnitBuildFacing(unitID)
	local pad, ang

	-- migrate old subhives/pads to new positions
	if face == 0 then
		for i = 1, 3 do
			pad = activeHives[unitID][i]
			Spring.SetUnitPosition(pad, x + hivePadPos5arms[((i-1)*2+1)][1], y,  z + hivePadPos5arms[((i-1)*2+1)][2])
			ang = math.rad(((i-1)*2+1) * 72 - 72 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			padToOwner[pad] = unitID
			updateRotation(pad)
		end
	elseif face == 1 then
		for i = 1, 3 do
			pad = activeHives[unitID][i]
			Spring.SetUnitPosition(pad, x - hivePadPos5arms[((i-1)*2+1)][2], y, z - hivePadPos5arms[((i-1)*2+1)][1])
			ang = -math.rad(((i-1)*2+1) * 72 - 72 + 180)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			padToOwner[pad] = unitID
			updateRotation(pad)
		end
	elseif face == 2 then
		for i = 1, 3 do
			pad = activeHives[unitID][i]
			Spring.SetUnitPosition(pad, x - hivePadPos5arms[((i-1)*2+1)][1], y,  z - hivePadPos5arms[((i-1)*2+1)][2])
			ang = math.rad(((i-1)*2+1) * 72 - 72 + 180 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			padToOwner[pad] = unitID
			updateRotation(pad)
		end
	else
		for i = 1, 3 do
			pad = activeHives[unitID][i]
			Spring.SetUnitPosition(pad, x + hivePadPos5arms[((i-1)*2+1)][2], y, z + hivePadPos5arms[((i-1)*2+1)][1])
			ang = -math.rad(((i-1)*2+1) * 72 - 72)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			padToOwner[pad] = unitID
			updateRotation(pad)
		end
	end

	-- Create Hive subhive pads
	if face == 0 then
		for i = 2, 4, 2 do
			pad = create("prap_pad", x + hivePadPos5arms[i][1], y,  z + hivePadPos5arms[i][2], face, unitTeam)
			if not pad then return false end
			ang = math.rad(i * 72 - 72 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i/2+3] = pad
			padToOwner[pad] = unitID
		end
	elseif face == 1 then
		for i = 2, 4, 2 do
			pad = create("prap_pad", x - hivePadPos5arms[i][2], y, z - hivePadPos5arms[i][1], face, unitTeam)
			if not pad then return false end
			ang = -math.rad(i * 72 - 72 + 180)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i/2+3] = pad
			padToOwner[pad] = unitID
		end
	elseif face == 2 then
		for i = 2, 4, 2 do
			pad = create("prap_pad", x - hivePadPos5arms[i][1], y,  z - hivePadPos5arms[i][2], face, unitTeam)
			if not pad then return false end
			ang = math.rad(i * 72 - 72 + 180 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i/2+3] = pad
			padToOwner[pad] = unitID
		end
	else
		for i = 2, 4, 2 do
			pad = create("prap_pad", x + hivePadPos5arms[i][2], y, z + hivePadPos5arms[i][1], face, unitTeam)
			if not pad then return false end
			ang = -math.rad(i * 72 - 72)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i/2+3] = pad
			padToOwner[pad] = unitID
		end
	end
end

function gadget:UnitCreated(unitID, unitDefID, teamID, builderID)
	local builderDefID = builderID and Spring.GetUnitDefID(builderID)
	if builderDefID and hiveUpgradables[builderDefID] then
		activeBuilds[unitID] = builderID
	end
end

function gadget:AllowUnitCreation(unitDefID, builderID)
	if not builderID then
		return true
	end

	local builderDefID = Spring.GetUnitDefID(builderID)
	if hivePlateDefIDs[builderDefID] then
		local env = Spring.UnitScript.GetScriptEnv(builderID)
		if env then
			local _, y, _ = Spring.GetUnitRotation(builderID)
			Spring.UnitScript.CallAsUnit(builderID, env.setAngle, y)
		end
	end

	return true
end

function gadget:UnitFinished(unitID, unitDefID, teamID)
	if hiveDefIDs[unitDefID] then
		-- we have arms to inherit
		if activeBuilds[unitID] then
			local builderID = activeBuilds[unitID]
			local builderDefID = builderID and Spring.GetUnitDefID(builderID) or false
			if builderDefID and hiveDefIDs[builderDefID] then
				activeHives[unitID] = activeHives[builderID]
				handleHiveInheritance(unitID, teamID)
				activeHives[builderID] = nil
				Spring.DestroyUnit(builderID, false, true)
			end
			activeBuilds[unitID] = nil

		-- new born
		else
			activeHives[unitID] = {}
			handleNewHive(unitID, teamID)
		end

	elseif activeBuilds[unitID] then
		local pad = activeBuilds[unitID]
		local parent = activeHives[padToOwner[pad]]
		for i = 1, 5 do
			if parent[i] == pad then
				parent[i] = unitID
				break
			end
		end
		padToOwner[unitID] = padToOwner[pad]
		padToOwner[pad] = nil
		Spring.DestroyUnit(activeBuilds[unitID], false, true)
		activeBuilds[unitID] = nil
	elseif hivePlateDefIDs[unitDefID] then
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID)
	if activeBuilds[unitID] then
		activeBuilds[unitID] = nil
	elseif activeHives[unitID] then
		-- if we lost a hive make sure its arms don't try turn to pads
		local tempChild
		for i = 1, #activeHives[unitID] do
			tempChild = activeHives[unitID][i]
			padToOwner[tempChild] = nil
			Spring.DestroyUnit(tempChild, false, false, attackerID)
		end
		activeHives[unitID] = nil
	elseif padToOwner[unitID] then
		-- create pad if we lost an arm
		local x, y, z = Spring.GetUnitPosition(unitID)
		local face = Spring.GetUnitBuildFacing(unitID)

		local pad = Spring.CreateUnit("prap_pad", x, y, z, face, teamID)
		if not pad then return --[[ we may have a big problem]] end

		local x, y, z = Spring.GetUnitRotation(unitID)
		Spring.SetUnitRotation(pad, 0, y, 0)

		local parent = activeHives[padToOwner[unitID]]

		if not parent then
			return
		end

		for i = 1, 5 do
			if parent[i] == unitID then
				parent[i] = pad
				break
			end
		end
		padToOwner[pad] = padToOwner[unitID]
		padToOwner[unitID] = nil
	end
end

else
-- Unsynced Space

end