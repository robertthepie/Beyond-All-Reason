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
local hiveMexDefIDs		= {}
local foundling			= {}
for unitDefID, unitDef in pairs(UnitDefs) do
	if unitDef.customParams.hive then
		hiveDefIDs[unitDefID]		= unitDef.customParams.hive
		hiveUpgradables[unitDefID]	= true
	elseif unitDef.customParams.hive_t2 then
		hivePlateDefIDs[unitDefID]	= unitDef.customParams.hive_t2
		hiveUpgradables[unitDefID]	= true
	elseif unitDef.extractsMetal and unitDef.extractsMetal > 0 then
		hiveMexDefIDs[unitDefID]	= true
	elseif false then
		hiveEcoDefIDs[unitDefID]	= true
	end
end

hiveEcoDefIDs[UnitDefNames["armsolar"].id]	= true
hiveEcoDefIDs[UnitDefNames["armwin"].id]	= true
foundling[UnitDefNames["prap_foundling"].id]= true

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

local SPRAWL_OUT_POSITIONS = {
-- inner ring
	{-120,	 0		},	-- [1]
	{-37.1,	 114.1	},	-- [2]
	{ 97.1,	 70.5	},	-- [3]
	{ 97.1,	-70.5	},	-- [4]
	{-37.1,	-114.1	},	-- [5]
-- outer ring
	{-240,	 0		},	-- [6]
	{ -74.2, 228.2	},	-- [7]
	{ 194.2, 141	},	-- [8]
	{ 194.2,-141	},	-- [9]
	{ -74.2,-228.2	},	-- [10]
-- two roots from 1-6-11/12
	{-240 - 97.1,	   0 + 70.5		},	-- [11]
	{-240 - 97.1,	   0 - 70.5		},	-- [12]
-- two roots from 2-7-13/14
	{ -74.2 + 37.1,	 228.2 + 114.1	},	-- [13]
	{ -74.2 - 97.1,	 228.2 + 70.5	},	-- [14]
-- two roots from 3-8-15/16
	{ 194.2	+ 120,	 141 + 0		},	-- [15]
	{ 194.2	+ 37.1,	 141.5 + 114.1	},	-- [16]
-- two roots from 4-9-17/18
	{ 194.2	+ 120,	-141 + 0		},	-- [17]
	{ 194.2	+ 37.1,	-141.5 - 114.1	},	-- [18]
-- two roots from 5-10-19/20
	{ -74.2 - 97.1,	-228.2 - 70.5	},	-- [19]
	{ -74.2 + 37.1,	-228.2 - 114.1	},	-- [20]
}
for i = 1, 5 do
	SPRAWL_OUT_POSITIONS[i][1] = 2 * SPRAWL_OUT_POSITIONS[i][1]
	SPRAWL_OUT_POSITIONS[i][2] = 2 * SPRAWL_OUT_POSITIONS[i][2]
	SPRAWL_OUT_POSITIONS[i+5][1] = 1.5 * SPRAWL_OUT_POSITIONS[i+5][1]
	SPRAWL_OUT_POSITIONS[i+5][2] = 1.5 * SPRAWL_OUT_POSITIONS[i+5][2]
end

local activeHives = {}
local padToOwner = {}
local activeBuilds = {}

local metalSpots = {}
local hiveMexSpots = {}
local hiveEcoSpots = {}
-- points to the same table as hiveEcoSpots except it's keyed by each wind turbine pointing to the hive eco spot that it belongs to
local EcoEcoSpots = {}

-- get all mexes in range, sorted
local function findChildMexes(a,b, range)
	local mexes = {}
	if metalSpots then
		local sqrdRange = range*range
		for i = 1, #metalSpots do
			local spot = metalSpots[i]
			local x = math.abs(spot.x - a)
			if x < range then
				local z = math.abs(spot.z - b)
				if z < range then
					if x*x + z*z < sqrdRange then
						mexes[#mexes+1] = spot
					end
				end
			end
		end
		table.sort(mexes, function(ms1, ms2)
			return math.distance2dSquared(ms1.x, ms1.z, a, b) < math.distance2dSquared(ms2.x, ms2.z, a, b)
		end)
	end
	return mexes
end

-- adds build pads for arms to a new hive
local function handleNewHive(unitID, unitDefID, unitTeam)
	-- for positioning build pads and sub-hives
	local create = Spring.CreateUnit
	local x, y, z = Spring.GetUnitPosition(unitID)
	local face = Spring.GetUnitBuildFacing(unitID)
	local pad, ang

	-- Create Hive subhive pads
	if face == 0 then
		for i = 1, 3 do
			pad = create(hiveDefIDs[unitDefID], x + hivePadPos3arms[i][1], y,  z + hivePadPos3arms[i][2], face, unitTeam)
			if not pad then return false end
			ang = math.rad(i * 120 - 120 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID
		end
	elseif face == 1 then
		for i = 1, 3 do
			pad = create(hiveDefIDs[unitDefID], x - hivePadPos3arms[i][2], y, z - hivePadPos3arms[i][1], face, unitTeam)
			if not pad then return false end
			ang = -math.rad(i * 120 - 120 + 180)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID
		end
	elseif face == 2 then
		for i = 1, 3 do
			pad = create(hiveDefIDs[unitDefID], x - hivePadPos3arms[i][1], y,  z - hivePadPos3arms[i][2], face, unitTeam)
			if not pad then return false end
			ang = math.rad(i * 120 - 120 + 180 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID
		end
	else
		for i = 1, 3 do
			pad = create(hiveDefIDs[unitDefID], x + hivePadPos3arms[i][2], y, z + hivePadPos3arms[i][1], face, unitTeam)
			if not pad then return false end
			ang = -math.rad(i * 120 - 120)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID
		end
	end
end

local function updateRotation(builderID)
	if hivePlateDefIDs[Spring.GetUnitDefID(builderID)] == "prap_pad_t2" then --TODO: temp pad test
		local env = Spring.UnitScript.GetScriptEnv(builderID)
		if env then
			local _, y, _ = Spring.GetUnitRotation(builderID)
			Spring.UnitScript.CallAsUnit(builderID, env.setAngle, y)
		end
	end
end


-- converts the arms of a preexisting hive to it's new tier and adds more
local function handleHiveInheritance(unitID, unitDefID, unitTeam)
	-- for positioning build pads and sub-hives
	local create = Spring.CreateUnit
	local x, y, z = Spring.GetUnitPosition(unitID)
	local face = Spring.GetUnitBuildFacing(unitID)
	local oldPad, pad, padDef, ang

	-- migrate old subhives/pads to new positions
	if face == 0 then
		for i = 1, 3 do
			oldPad = activeHives[unitID][i]
			padDef = Spring.GetUnitDefID(oldPad)

			pad = create(hivePlateDefIDs[padDef] or hiveDefIDs[unitDefID], x + hivePadPos5arms[((i-1)*2+1)][1], y,  z + hivePadPos5arms[((i-1)*2+1)][2], face, unitTeam)
			if not pad then return false end
			padToOwner[oldPad] = nil
			Spring.DestroyUnit(oldPad, false, true)

			ang = math.rad(((i-1)*2+1) * 72 - 72 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID

			--Spring.SetUnitPosition(pad, x + hivePadPos5arms[((i-1)*2+1)][1], y,  z + hivePadPos5arms[((i-1)*2+1)][2])
			--ang = math.rad(((i-1)*2+1) * 72 - 72 - 90)
			--Spring.SetUnitRotation(pad, 0, ang, 0)
			--padToOwner[pad] = unitID
			--updateRotation(pad)
		end
	elseif face == 1 then
		for i = 1, 3 do
			oldPad = activeHives[unitID][i]
			padDef = Spring.GetUnitDefID(oldPad)

			pad = create(hivePlateDefIDs[padDef] or hiveDefIDs[unitDefID], x - hivePadPos5arms[((i-1)*2+1)][2], y, z - hivePadPos5arms[((i-1)*2+1)][1], face, unitTeam)
			if not pad then return false end
			padToOwner[oldPad] = nil
			Spring.DestroyUnit(oldPad, false, true)

			ang = -math.rad(((i-1)*2+1) * 72 - 72 + 180)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID

			--Spring.SetUnitPosition(pad, x - hivePadPos5arms[((i-1)*2+1)][2], y, z - hivePadPos5arms[((i-1)*2+1)][1])
			--ang = -math.rad(((i-1)*2+1) * 72 - 72 + 180)
			--Spring.SetUnitRotation(pad, 0, ang, 0)
			--padToOwner[pad] = unitID
			--updateRotation(pad)
		end
	elseif face == 2 then
		for i = 1, 3 do
			oldPad = activeHives[unitID][i]
			padDef = Spring.GetUnitDefID(oldPad)

			pad = create(hivePlateDefIDs[padDef] or hiveDefIDs[unitDefID], x - hivePadPos5arms[((i-1)*2+1)][1], y,  z - hivePadPos5arms[((i-1)*2+1)][2], face, unitTeam)
			if not pad then return false end
			padToOwner[oldPad] = nil
			Spring.DestroyUnit(oldPad, false, true)

			ang = math.rad(((i-1)*2+1) * 72 - 72 + 180 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID

			--Spring.SetUnitPosition(pad, x - hivePadPos5arms[((i-1)*2+1)][1], y,  z - hivePadPos5arms[((i-1)*2+1)][2])
			--ang = math.rad(((i-1)*2+1) * 72 - 72 + 180 - 90)
			--Spring.SetUnitRotation(pad, 0, ang, 0)
			--padToOwner[pad] = unitID
			--updateRotation(pad)
		end
	else
		for i = 1, 3 do
			oldPad = activeHives[unitID][i]
			padDef = Spring.GetUnitDefID(oldPad)

			pad = create(hivePlateDefIDs[padDef] or hiveDefIDs[unitDefID], x + hivePadPos5arms[((i-1)*2+1)][2], y, z + hivePadPos5arms[((i-1)*2+1)][1], face, unitTeam)
			if not pad then return false end
			padToOwner[oldPad] = nil
			Spring.DestroyUnit(oldPad, false, true)

			ang = -math.rad(((i-1)*2+1) * 72 - 72)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			activeHives[unitID][i] = pad
			padToOwner[pad] = unitID

			--Spring.SetUnitPosition(pad, x + hivePadPos5arms[((i-1)*2+1)][2], y, z + hivePadPos5arms[((i-1)*2+1)][1])
			--ang = -math.rad(((i-1)*2+1) * 72 - 72)
			--Spring.SetUnitRotation(pad, 0, ang, 0)
			--padToOwner[pad] = unitID
			--updateRotation(pad)
		end
	end

	-- Create Hive subhive pads
	if face == 0 then
		for i = 2, 4, 2 do
			pad = create(hiveDefIDs[unitDefID], x + hivePadPos5arms[i][1], y,  z + hivePadPos5arms[i][2], face, unitTeam)
			if not pad then return false end
			ang = math.rad(i * 72 - 72 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			-- turn 2, 4 into 4, 5
			activeHives[unitID][i/2+3] = pad
			padToOwner[pad] = unitID
		end
	elseif face == 1 then
		for i = 2, 4, 2 do
			pad = create(hiveDefIDs[unitDefID], x - hivePadPos5arms[i][2], y, z - hivePadPos5arms[i][1], face, unitTeam)
			if not pad then return false end
			ang = -math.rad(i * 72 - 72 + 180)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			-- turn 2, 4 into 4, 5
			activeHives[unitID][i/2+3] = pad
			padToOwner[pad] = unitID
		end
	elseif face == 2 then
		for i = 2, 4, 2 do
			pad = create(hiveDefIDs[unitDefID], x - hivePadPos5arms[i][1], y,  z - hivePadPos5arms[i][2], face, unitTeam)
			if not pad then return false end
			ang = math.rad(i * 72 - 72 + 180 - 90)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			-- turn 2, 4 into 4, 5
			activeHives[unitID][i/2+3] = pad
			padToOwner[pad] = unitID
		end
	else
		for i = 2, 4, 2 do
			pad = create(hiveDefIDs[unitDefID], x + hivePadPos5arms[i][2], y, z + hivePadPos5arms[i][1], face, unitTeam)
			if not pad then return false end
			ang = -math.rad(i * 72 - 72)
			Spring.SetUnitRotation(pad, 0, ang, 0)
			-- turn 2, 4 into 4, 5
			activeHives[unitID][i/2+3] = pad
			padToOwner[pad] = unitID
		end
	end
end

function gadget:UnitCreated(unitID, unitDefID, teamID, builderID)

	if not builderID then
		return
	end

	if hiveMexDefIDs[unitDefID] then
		return
	end

	if foundling[unitDefID] then
		return
	end

	if hiveEcoDefIDs[unitDefID] then
		local spots = hiveEcoSpots[builderID]
		if spots then
			for i = 1, 20 do
				if spots[i] == false then
					spots[i] = unitID
					EcoEcoSpots[unitID] = hiveEcoSpots[builderID]
				end
			end
		end

	else
		local builderDefID = builderID and Spring.GetUnitDefID(builderID)
		if foundling[builderDefID] then
			Spring.SetUnitHealth(unitID, {health=2,build=1})
			Spring.DestroyUnit(builderID, false, true)
		elseif hiveUpgradables[unitDefID] and hiveUpgradables[builderDefID] then
			activeBuilds[unitID] = builderID
		end
	end
end

local function copiedAllowUnitCreation(unitDefID, builderID)
	-- are we building a mex via a lab
	if hiveMexDefIDs[unitDefID] and builderID then
		local builderDefID = Spring.GetUnitDefID(builderID)
		if hiveDefIDs[builderDefID] then

			-- animate the lab to be building at a free mex position, or cancel the order
			local env = Spring.UnitScript.GetScriptEnv(builderID)
			if env and hiveMexSpots[builderID] then

				-- find nearest free mex spot
				local blocking, featureID
				local facing = Spring.GetUnitBuildFacing(builderID)
				for i = 1, #hiveMexSpots[builderID] do
					local spot = hiveMexSpots[builderID][i]
					-- @TODO: convert if not blocked to read the returned list for a mex to upgrade
					blocking, featureID = Spring.TestBuildOrder(unitDefID, spot.x, spot.y, spot.z, facing)
					if blocking == 2 and featureID == nil then

						-- put the position into local space
						local x,y,z = Spring.GetUnitPosition(builderID)
						x = spot.x - x
						y = spot.y - y
						z = spot.z - z

						-- rotate the local cordiante to allaign with the building
						if facing == 1 then
							x, z = -z, x
						elseif facing == 2 then
							x, z = -x, -z
						elseif facing == 3 then
							x, z = z, -x
						end

						Spring.UnitScript.CallAsUnit(builderID, env.setBuildPoint, x, y, z)
						return true
					end
				end
				return false
			end
		end
	elseif hiveEcoDefIDs[unitDefID] and builderID then
		local builderDefID = Spring.GetUnitDefID(builderID)
		if hiveDefIDs[builderDefID] then
			local env = Spring.UnitScript.GetScriptEnv(builderID)
			if env and hiveEcoSpots[builderID] then
				local spots = hiveEcoSpots[builderID]
				local bx,by,bz = Spring.GetUnitPosition(builderID)
				local bfacing = Spring.GetUnitBuildFacing(builderID)
				local px, pz
				local blocked, featureID
				if bfacing == 0 then
					for i = 1, 20 do
						px = bx + SPRAWL_OUT_POSITIONS[i][1]
						pz = bz + SPRAWL_OUT_POSITIONS[i][2]
						if not spots[i] then
							local height = Spring.GetGroundHeight(px,pz) - by
							blocked, featureID = Spring.TestBuildOrder(unitDefID, px, height, pz, bfacing)
							if blocked == 2 and featureID == nil then
								spots[i] = false
								Spring.UnitScript.CallAsUnit(builderID, env.setBuildPoint, SPRAWL_OUT_POSITIONS[i][1], height, SPRAWL_OUT_POSITIONS[i][2])
								return true
							end
						end
					end
					return false
				elseif bfacing == 1 then
					for i = 1, 20 do
						px = bx + SPRAWL_OUT_POSITIONS[i][2]
						pz = bz - SPRAWL_OUT_POSITIONS[i][1]
						if not spots[i] then
							local height = Spring.GetGroundHeight(px,pz) - by
							blocked, featureID = Spring.TestBuildOrder(unitDefID, px, height, pz, bfacing)
							if blocked == 2 and featureID == nil then
								spots[i] = false
								Spring.UnitScript.CallAsUnit(builderID, env.setBuildPoint, SPRAWL_OUT_POSITIONS[i][1], height, SPRAWL_OUT_POSITIONS[i][2])
								return true
							end
						end
					end
					return false
				elseif bfacing == 2 then
					for i = 1, 20 do
						px = bx - SPRAWL_OUT_POSITIONS[i][1]
						pz = bz - SPRAWL_OUT_POSITIONS[i][2]
						if not spots[i] then
							local height = Spring.GetGroundHeight(px,pz) - by
							blocked, featureID = Spring.TestBuildOrder(unitDefID, px, height, pz, bfacing)
							if blocked == 2 and featureID == nil then
								spots[i] = false
								Spring.UnitScript.CallAsUnit(builderID, env.setBuildPoint, SPRAWL_OUT_POSITIONS[i][1], height, SPRAWL_OUT_POSITIONS[i][2])
								return true
							end
						end
					end
					return false
				elseif bfacing == 3 then
					for i = 1, 20 do
						px = bx - SPRAWL_OUT_POSITIONS[i][2]
						pz = bz + SPRAWL_OUT_POSITIONS[i][1]
						if not spots[i] then
							local height = Spring.GetGroundHeight(px,pz) - by
							blocked, featureID = Spring.TestBuildOrder(unitDefID, px, height, pz, bfacing)
							if blocked == 2 and featureID == nil then
								spots[i] = false
								Spring.UnitScript.CallAsUnit(builderID, env.setBuildPoint, SPRAWL_OUT_POSITIONS[i][1], height, SPRAWL_OUT_POSITIONS[i][2])
								return true
							end
						end
					end
					return false
				end
			end
		end
	end
	return true
end

function gadget:AllowUnitCreation(unitDefID, builderID)
	if not builderID then
		return true
	end

	-- got lazy:
	if hiveEcoDefIDs[unitDefID] or hiveMexDefIDs[unitDefID] then
		return copiedAllowUnitCreation(unitDefID, builderID)
	end

	local builderDefID = Spring.GetUnitDefID(builderID)
	if hivePlateDefIDs[builderDefID] == "prap_pad_t2" then --TODO: temp pad test
		local env = Spring.UnitScript.GetScriptEnv(builderID)
		if env then
			local _, y, _ = Spring.GetUnitRotation(builderID)
			Spring.UnitScript.CallAsUnit(builderID, env.setAngle, y)
		end
	elseif hiveDefIDs[builderDefID] then
		local env = Spring.UnitScript.GetScriptEnv(builderID)
		if env then
			local _, y, _ = Spring.GetUnitRotation(builderID)
			Spring.UnitScript.CallAsUnit(builderID, env.setBuildPoint, 0, 0, 0)
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
				handleHiveInheritance(unitID, unitDefID, teamID)
				activeHives[builderID] = nil

				hiveMexSpots[unitID] = hiveMexSpots[builderID]
				hiveEcoSpots[unitID] = hiveEcoSpots[builderID]
				hiveEcoSpots[builderID] = nil

				Spring.DestroyUnit(builderID, false, true)
			end
			activeBuilds[unitID] = nil

		-- new born
		else
			activeHives[unitID] = {}
			handleNewHive(unitID, unitDefID, teamID)

			local x,y,z = Spring.GetUnitPosition(unitID)
			hiveMexSpots[unitID] = findChildMexes(x,z, UnitDefs[unitDefID].buildDistance + 30)
			hiveEcoSpots[unitID] = {[0]=0}

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
	elseif hivePlateDefIDs[unitDefID] == "prap_pad_t2" then --TODO: temp pad test
		-- ?? i forgor
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

		-- clean up our ownerships
		hiveMexSpots[unitID] = nil

		-- if we still have an eco table it means we got killed, not upgraded over
		if hiveEcoSpots[unitID] then
			local child
			for i = 1, 20 do
				child = hiveEcoSpots[unitID][i]
				if child then
					hiveEcoSpots[unitID][i] = nil
					Spring.DestroyUnit(child, false, false, attackerID)
				end
			end
			hiveEcoSpots[unitID] = nil
		end

	elseif padToOwner[unitID] then
		-- create pad if we lost an arm
		local x, y, z = Spring.GetUnitPosition(unitID)
		local face = Spring.GetUnitBuildFacing(unitID)

		local parentDefID = Spring.GetUnitDefID(padToOwner[unitID])
		local pad = Spring.CreateUnit(hiveDefIDs[parentDefID], x, y, z, face, teamID)
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

	-- hive economy structures
	elseif hiveEcoDefIDs[unitDefID] then
		if EcoEcoSpots[unitID] then
			for i = 1, 20 do
				if EcoEcoSpots[unitID][i] == unitID then
					EcoEcoSpots[unitID][i] = nil
					local child
					if i < 6 then	
						child = EcoEcoSpots[unitID][i+5]
						if child then
							Spring.DestroyUnit(child, false, false, attackerID)
						end
					elseif i < 11 then
						child = EcoEcoSpots[unitID][i+i-1]
						if child then
							Spring.DestroyUnit(child, false, false, attackerID)
						end
						child = EcoEcoSpots[unitID][i+i]
						if child then
							Spring.DestroyUnit(child, false, false, attackerID)
						end
					end
					break
				end
			end
			EcoEcoSpots[unitID] = nil
		end
	end
end

function gadget:Initialize()
	metalSpots = GG["resource_spot_finder"] and GG["resource_spot_finder"].metalSpotsList or nil
end

else
-- Unsynced Space

end