
local gadget = gadget ---@type Gadget

function gadget:GetInfo()
	return {
		name    = "Permissions",
		desc	= 'provides a list of user permissions to other gadgets',
		author	= 'Floris',
		date	= 'February 2021',
		license	= 'GNU GPL, v2 or later',
		layer	= -999000,
		enabled	= true
	}
end


local powerusers = include("LuaRules/configs/powerusers.lua")
local singleplayerPermissions = powerusers[-1]

local numPlayers = Spring.Utilities.GetPlayerCount()

-- give permissions when in singleplayer
if numPlayers <= 1 then
	for _,playerID in ipairs(Spring.GetPlayerList()) do

		local accountID = false
		local _, _, spec, _, _, _, _, _, _, _, accountInfo = Spring.GetPlayerInfo(playerID)
		if accountInfo and accountInfo.accountid then
			accountID = tonumber(accountInfo.accountid)
		end

		-- dont give permissions to the spectators when there is a player is playing
		if not spec or numPlayers == 0 then
			powerusers[accountID] = singleplayerPermissions
		end
	end
else
	powerusers[-1] = nil
end

-- order by permission instead of playername
local permissions = {}
for permission, _ in pairs(singleplayerPermissions) do
	permissions[permission] = {}
end
for user, perms in pairs(powerusers) do
	for permission, value in pairs(perms) do
		permissions[permission][user] = value
	end
end

_G.powerusers = powerusers
_G.permissions = permissions











--[[ Brainstorming table, do not lean against, fragile
	LEVEL:	|admin	|cheat	| mod	| cheat	| cosmetic		examples
			|		|sp		| 		| boss	|
Allowed:----+-------+-------+-------+-------+-------+
01cosmetic	| 1		| 1		| 1		| post	| post	|		nightmode, terraform, waterlevel
02cheat		| 1		| post	| 0		| post	| 0		|		give
04mod		| 1		| 0		| 1		| 0		| 0		|		
08unsafe	| 1		| post	| 1		| 0		| 0		|		desync / dev helpers?
16admin		| 1		| 0		| 0		| 0		| 0		|		

32?	undo?	| 1		| 1		| 1		| 1		| 0		|		perchance? mayhaps?
32?	undo?	| 1		| 1		| 1		| post	| 0		|		perchance? mayhaps?

totalWPost	| 31	| 11	| 13	| 3		| 1
total		| 31	| 1		| 13	| 1		| 1
totalWUndo	| 63	| 33	| 45	| 1		| 1
]]

local powerusersBitmasked = {}
for user, perms in pairs(powerusers) do
	powerusersBitmasked[user] =
		perms["playerdata"] and 31 or
		perms["sysinfo"]	and 13 or 1
end
local cheatsModoption = Spring.GetModOption("bosscheats")
local levelToBitmask = {
	["cosmetic"]= 01,
	["cheats"]	= 02,
	["mod"]		= 04,
	["unsafe"]	= 08,
	["admin"]	= 16,
	["undo"]	= 32,
}
local cachedPermLevel = {}
---comment
---@param playerID number
---@param level "cosmetic"|"cheats"|"mod"|"unsafe"|"admin"|"undo"
---@return boolean authorised can the player use the command of this level
local function isAuthorised(playerID, level)
	local levelBitmask = levelToBitmask[level] or 2
	local playerPermLevel = cachedPermLevel[playerID]
	if not playerPermLevel then
		local playername,_,_,_,_,_,_,_,_,_,accountInfo = Spring.GetPlayerInfo(playerID)
		local accountID = (accountInfo and accountInfo.accountid) and tonumber(accountInfo.accountid) or -1
		if (powerusersBitmasked[playerID]) then
			playerPermLevel = powerusersBitmasked[accountID]
		else
			playerPermLevel = 0
			if cheatsModoption == "cosmetic" then
				if accountInfo and accountInfo.boss == "1" then
					playerPermLevel = 1
				end
			elseif cheatsModoption == "boss" then
				if accountInfo and accountInfo.boss == "1" then
					playerPermLevel = 3
				end
			end
			cachedPermLevel[playerID] = playerPermLevel
		end
	end
	if Spring.IsCheatingEnabled() then
		playerPermLevel = math.bit_or(playerPermLevel, 11)
	end
	return math.bit_and(levelBitmask, playerPermLevel) ~= 0
end

---Wrapper to put inside gadgetHandler:AddChatAction, so that luarules are blocked behind the right permissions
---@param func function(cmd, line, words, playerID)
---@param level "cosmetic"|"cheats"|"moderator"|"unsafe"|"admin"|"undo"
local function isAuthorisedChatWrapper(func, level)
	return function(cmd, line, words, playerID)
		if isAuthorised(playerID, level) then
			func(cmd, line, words, playerID)
		end
	end
end

function gadget:Initialize()
	GG.isAuthorised = isAuthorised
	GG.isAuthorisedChatWrapper = isAuthorisedChatWrapper
end

function gadget:Shutdown()
	GG.isAuthorised = nil
	GG.isAuthorisedChatWrapper = nil
end