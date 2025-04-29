-- Do NOT use Spring.GetSideData() to display the faction names defined here on the UI,
-- as these names do not support I18N translations. Use the appropriate I18N entry instead.


local modoptions = Spring.GetModOptions()


----------------------
--- Base Game Factions
local outputSidedata = {
	{
		name = "Armada",
		startunit = 'armcom',
	},
	{
		name = "Cortex",
		startunit = 'corcom',
	},
	{
		name = "Random",
		startunit = 'dummycom',
	},
}

------------------------
--- Base Game Modoptions
if modoptions.experimentallegionfaction then
	table.insert(outputSidedata, {
		name = "Legion",
		startunit = 'legcom',
	})
end

--------------------
--- Sidedata modding
local extraSidedata = VFS.DirList('gamedata/modgamedata/', '*sidedata.lua', nil, true)
for _, filename in pairs(extraSidedata) do
	if filename then
		local success, sidedata = pcall(VFS.Include, filename)
		if not success then
			Spring.Log("customContent", LOG.ERROR, "Error parsing "..filename..": "..tostring(sidedata))

		elseif type(sidedata) == "string" then
			table.insert(outputSidedata,{
				name = "CustomContent",
				startunit = sidedata,
			})

		elseif type(sidedata) ~= "table" then
			Spring.Log("customContent", LOG.ERROR, "Bad return table from: " .. filename)

		else
			if type(sidedata.name) == "string" and type(sidedata.startunit) == "string" then
				table.insert(outputSidedata, sidedata)
			else
				for _, sidedataEntry in pairs(sidedata) do
					if type(sidedataEntry.name) == "string" and type(sidedataEntry.startunit) == "string" then
						table.insert(outputSidedata, sidedataEntry)
					end
				end
			end
		end
	end
end

----------------------
--- For Tweakdef Users
if modoptions.customcommanders then
	local commanders = string.split(modoptions.customcommanders, ",")
	for i = 1, #commanders do
		table.insert(outputSidedata,{
			name = "CustomContent",
			startunit = commanders[i],
		})
	end
end

return outputSidedata