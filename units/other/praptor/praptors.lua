--	Imports playable raptors from csv files cause i am evil
if Spring.GetModOptions().playableraptors == true then
	local returnTable = {}

	local function byNewLine(input)
		local output = {}
		for object in string.gmatch(input, "[^\n]+") do
			table.insert(output, object)
		end
		return output
	end
	local function commaSeperated(input)
		local output = {}
		for object in string.gmatch(input..",", "([^,]*),") do
			table.insert(output, object)
		end
		return output
	end

	local function addToTable(file, subheading, headless)
		-- load stats csv
		local CSV = VFS.LoadFile("units/other/praptor/"..file..".csv")
		CSV = byNewLine(CSV)
		if headless then
			for i = 2, #CSV do
				local output = {}
				local csv = commaSeperated(CSV[i])
				for j = 2, #csv do
					if csv[j] and csv[j] ~= "" then
						output[#output+1] = tonumber(csv[j]) or csv[j]
					end
				end
				if subheading then
					returnTable[csv[1]][subheading] = output
				else
					returnTable[csv[1]] = output
				end
			end
		else
			local header = commaSeperated(CSV[1])
			-- convert csv to output
			for i = 2, #CSV do
				local output = {}
				local csv = commaSeperated(CSV[i])
				for j = 2, #header do
					if csv[j] and csv[j] ~= "" then
						output[header[j]] = tonumber(csv[j]) or csv[j]
					end
				end
				if subheading then
					returnTable[csv[1]][subheading] = output
				else
					returnTable[csv[1]] = output
				end
			end
		end
	end

	addToTable("praptor_stats")
	addToTable("praptor_buildoptions", "buildoptions", true)
	addToTable("praptor_customparams", "customparams")

	return returnTable
end