function gadget:GetInfo()
	return {
		name		= "Playable Raptors Extra Behaviour Handler",
		desc		= "Handles additional behaviour such us recyling when a factory upgrades itself",
		author		= "robert the pie",
		date		= "March 2024",
		license		= "GNU GPL, v2 or later",
		layer		= 1,
		enabled		= true,
	}
end

if true or Spring.GetModOptions().playableraptors ~= true then return false end


--
--	Tables for identifying:
--		- mex buildings for metal spot placement
--		- eco buildings for root like placement
--		- foundlings, which get destroyed when they build a hive
--	done this way in case the unit turns out to not exist for whatever reason

local mex,eco,foundling = {},{},{}
-- mexes
for _, name in pairs({
	"prap_mex_t1",
}) do
	if UnitDefNames[name] then
		mex[UnitDefNames[name].id] = true
	end
end
-- ecos
for _, name in pairs({
	"prap_sol_t1",
}) do
	if UnitDefNames[name] then
		eco[UnitDefNames[name].id] = true
	end
end
-- foundlings
for _, name in pairs({
	"prap_foundling",
}) do
	if UnitDefNames[name] then
		foundling[UnitDefNames[name].id] = true
	end
end

--
--	Tables for identifying anything upgradeable,
-- 		how it's predecesor should react
-- 		and storing its metal cost

local upgradeAnimation = {}
local noUpgradeAnimation = {}
local upgradeMetalCost = {}

--------------------
--- SYNCED SPACE ---
--------------------
if gadgetHandler:IsSyncedCode() then

--------------------
-- UNSYNCED SPACE --
--------------------
else

end