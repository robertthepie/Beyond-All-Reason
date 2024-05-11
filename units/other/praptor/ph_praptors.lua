if false and Spring.GetModOptions().playableraptors == true then
	local returnTable = {}
	local titles =
	--[[name =]]{	"health", "metalcost", "energycost", "buildtime", "sightdistance", "autoheal", "idleautoheal", "workertime", "buildDistance", "_TMP_1", "footprintx", "footprintz", "maxslope", "metalstorage", "energystorage"}
	local buildingTable = {
		--name			health	m_cost	e_cost	bp_cost	slight	autoheal	idleautoheal	bp		bdist	model	size_x, size_y	slope	estor	mstor
		hive		= {	2050,	450,	0,		6500,	510,	1.8,		10,				100,	800,	"hive",	12,		12,		25,		0,		500,	},
	}
	local unitTable = {
	}


	for unit, stats in pairs(buildingTable) do
		returnTable["prap_"..unit] = {
			activatewhenbuilt	= true,
			autoheal		= stats[5],
			builder			= (stats[6] > 0),
			buildpic		= "raptors/raptor_hive.DDS",
			buildtime		= stats[4],
			buildDistance	= stats[7],
			capturable		= false,
			canmove			= false,
			category		= "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost		= stats[3],
			energystorage	= stats[13],
			explodeas		= "ROOST_DEATH",
			footprintx		= stats[10],
			footprintz		= stats[11],
			health			= stats[1],

			idleautoheal = 10,
			idletime = 90,
			levelground = false,
			maxacc = 0,
			maxdec = 0,
			metalcost = 450,
			metalstorage = 500,
			maxslope = 25,
			objectname = "Raptors/praptors/praptor_hive.s3o",
			--objectname = "Raptors/raptor_hive.s3o",
			reclaimable = false,
			script = "Raptors/praptors/praptor_hive_lus.lua",
			--script = "Units/ARMLAB.cob",
			seismicsignature = 0,
			selfdestructas = "ROOST_DEATH",
			sightdistance = 510,
			smoothanim = true,
			waterline = 0,
			workertime = 100,
			yardmap = "yyyyyyyyyyyy yyyyyyooyyyy yyyoyyooyyyy yyooooooyyyy yoooooooyyyy yyyooooooooy yyyooooooooy yoooooooyyyy yyooooooyyyy yyyoyyooyyyy yyyyyyooyyyy yyyyyyyyyyyy",
		}
	end
else
	return {}
end

if false and Spring.GetModOptions().playableraptors == true then
	local returnTable = {}
	local headers = {
		-- health
	"health",

	"autoheal",
	"idleautoheal",
		-- make costs
	"energycost",
	"metalcost",
	"buildtime",
		-- other stats
	"sightdistance",
	"energystorage",
	"metalstorage",
		-- stats as builder
	"builder",
	"workertime",
	"buildDistance",
		-- placement
	"maxslope",
	"footprintx",
	"footprintz",

	-- SPEICALS that get post proccessed
	"_TEMP_1", -- model/anim pre_name
	"_TEMP_2", -- yardmap ref
	}
	local buildingTable = {
	--			health, autoheal, 	idleautoheal,	energycost, metalcost,	buildtime,	sight,	e_storage, 	m_storage,	builder,	bp,		buildDistance,	slope,	sizeX,	sizeY,	model	yardref
hive		= { 2050,	1.8,		10,				0,			450,		6500,		510,	0,			500,		true,		100,	800,			25,		12,		12,		"hive",	"hive"},
nexus		= { 2050,	1.8,		10,				0,			450,		6500,		510,	0,			500,		true,		100,	800,			25,		12,		12,		"hive",	"hive"},
	}
	local buildingBuildTableTable = {
		hive = {"prap_mex_t1",	"prap_sol_t1"}
	}
	local yardmaps = {
		hive = "yyyyyyyyyyyy yyyyyyooyyyy yyyoyyooyyyy yyooooooyyyy yoooooooyyyy yyyooooooooy yyyooooooooy yoooooooyyyy yyooooooyyyy yyyoyyooyyyy yyyyyyooyyyy yyyyyyyyyyyy",
	}
	local builderDefaults = {
		-- string/float
		category		=	"BOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
		seismicsignature=	0,
		explodeas		=	"BUG_DEATH",
		selfdestructas	=	"BUG_DEATH",
		idletime		=	90,
		waterline		=	0,
		maxacc			=	0,
		maxdec			=	0,
		-- bool
		activatewhenbuilt=	true,
		canmove			=	true,
		capturable		=	false,
		levelground		=	false,
		reclaimable		=	false,
		smoothanim		=	true,
		-- temp
		buildpic = "raptors/raptor_hive.DDS",
	}
	-- convert the tables into valid unit defs
	for name, stats in pairs(buildingTable) do
		local newTable = {}

		for i, heading in pairs(headers) do
			newTable[heading] = buildingTable[i]
		end
		for heading, value in pairs(builderDefaults) do
			newTable[heading] = value
		end

		-- swap shorthands for actual
		local temp
		temp = newTable["_TEMP_1"] or ""
		newTable["objectname"]	= "Raptors/praptors/praptor_"..temp..".s3o"
		newTable["script"]		= "Raptors/praptors/praptor_"..temp.."_lus.lua"
		newTable["_TEMP_1"]		= nil
		newTable["yardmap"] = yardmaps[newTable["_TEMP_2"]] or ""
		newTable["_TEMP_2"]		= nil

		newTable["customparams"] = {
			model_author = "FireStorm, Beherith",
			normalmaps = "yes",
			normaltex = "unittextures/chicken_l_normals.png",
			upgradable = "replace",
		}
		newTable["featuredefs"] = {}
		newTable["sfxtypes"] = {
			explosiongenerators = {
				[1] = "custom:blood_spray",
				[2] = "custom:blood_explode",
				[3] = "custom:dirt",
			},
			pieceexplosiongenerators = {
				[1] = "blood_spray",
				[2] = "blood_spray",
				[3] = "blood_spray",
			},
		}

		returnTable["prap_"..name] = newTable
	end

	return returnTable



--[[buildoptions = {
	[1] = "prap_nest",
	[2] = "prap_den",
	[3] = "prap_foundling",
	[4] = "prap_swarmer",
	--[5] = "prap_spiker",
	[6] = "prap_mex_t1",
	[7] = "prap_sol_t1",
},]]
else
	return {}
end