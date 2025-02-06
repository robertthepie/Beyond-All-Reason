local modoptions = Spring.GetModOptions()
if modoptions.playablerapotrs ~= true and modoptions.forceallunits ~= true then return {}
else
	return {
prap_hive = {
	health		= 5000,
	autoheal	= 5,
	idletime	= 90,
	idleautoheal= 50,
	selfDestructCountdown= 0,

	-- builder builds these for free, dies in the porcess, it itself is the cost
	energycost	= 0,
	metalcost	= 450,
	buildtime	= 750,

	metalmake	= 4,
	energymake	= 25,
	energystorage= 500,

	builder		= true,
	workertime	= 200,
	buildDistance= 800,
	buildoptions = {
		"prap_hive_t2",
		"prap_mex",
		"prap_win",
		"prap_solar",
		"prap_foundling",
	},

	waterline	= 0,
	footprintx	= 6,
	footprintz	= 6,
	maxslope	= 33,
	sightdistance= 750,
	levelground	= false,
	objectname	= "praptors/hive.s3o",
	script		= "praptors/prap_hive_lus.lua",
	yardmap		= [[
	eeeeee
	eooooe
	eooooe
	eooooe
	eooooe
	eeeeee
	]],
	collisionvolumetype		= "s",
	collisionvolumeoffsets	= "0 -10 0",
	collisionvolumescales	= "96 96 96	",
	selectionVolumeType		= "s",
	selectionVolumeOffsets	= "0 -10 0",
	selectionVolumeScales	= "92 92 92	",

	capturable = false,
	category	= "RAPTOR",
	selfdestructas= "ROOST_DEATH",

	customparams= {
		iscommander = true,
		hive		= "prap_pad",
		isairbase	= true,
		model_author= "FireStorm, Beherith",
		normalmaps	= "yes",
		normaltex	= "unittextures/chicken_l_normals.png",
	},
	featuredefs	= {},
	sfxtypes	= {
		explosiongenerators = {
			[1]	= "custom:blood_spray",
			[2]	= "custom:blood_explode",
			[3]	= "custom:dirt",
		},
		pieceexplosiongenerators = {
			[1]	= "blood_spray",
			[2]	= "blood_spray",
			[3]	= "blood_spray",
		},
	},
},
prap_hive_t2 = {
	health		= 10000,
	autoheal	= 10,
	idletime	= 90,
	idleautoheal= 100,
	selfDestructCountdown= 0,

	energycost	= 16000,
	metalcost	= 2800,
	buildtime	= 10500,

	metalmake	= 4,
	energymake	= 25,
	energystorage= 2000,

	builder		= true,
	workertime	= 400,
	buildDistance= 800,
	buildoptions = {
		"prap_mex",
		"prap_win",
		"prap_solar",
		"prap_foundling",
	},

	waterline	= 0,
	footprintx	= 6,
	footprintz	= 6,
	maxslope	= 33,
	sightdistance= 750,
	levelground	= false,
	objectname	= "praptors/hive.s3o",
	script		= "praptors/prap_hive_lus.lua",
	yardmap		= [[
	eeeeee
	eooooe
	eooooe
	eooooe
	eooooe
	eeeeee
	]],
	collisionvolumetype		= "s",
	collisionvolumeoffsets	= "0 -10 0",
	collisionvolumescales	= "96 96 96	",
	selectionVolumeType		= "s",
	selectionVolumeOffsets	= "0 -10 0",
	selectionVolumeScales	= "92 92 92	",

	capturable = false,
	category	= "RAPTOR",
	selfdestructas= "ROOST_DEATH",

	customparams= {
		iscommander = true,
		hive		= "prap_pad_t2",
		isairbase	= true,
		model_author= "FireStorm, Beherith",
		normalmaps	= "yes",
		normaltex	= "unittextures/chicken_l_normals.png",
	},
	featuredefs	= {},
	sfxtypes	= {
		explosiongenerators = {
			[1]	= "custom:blood_spray",
			[2]	= "custom:blood_explode",
			[3]	= "custom:dirt",
		},
		pieceexplosiongenerators = {
			[1]	= "blood_spray",
			[2]	= "blood_spray",
			[3]	= "blood_spray",
		},
	},
},
prap_pad = {
	health		= 50000,
	autoheal	= 5,
	idletime	= 90,
	idleautoheal= 50,
	energycost	= 25000,
	metalcost	= 400,
	selfDestructCountdown= 0,

	workertime	= 250,
	metalmake	= 0,
	energymake	= 0,
	energystorage= 0,

	builder = true,
	buildtime = 10500,
	buildoptions = {
		"prap_siege",
		"prap_swarm",
		"prap_nest",
	},

	waterline	= 0,
	footprintx	= 6,
	footprintz	= 6,
	sightdistance= 750,
	levelground	= false,
	objectname	= "Units/CORSY.s3o",
	script		= "praptors/prap_pad_lus.lua",
	yardmap		= [[
	eeeeee
	eeeeee
	eeeeee
	eeeeee
	eeeeee
	eeeeee
	]],
	collisionvolumetype		= "s",
	collisionvolumeoffsets	= "0 -10 0",
	collisionvolumescales	= "92 92 92	",
	selectionVolumeType		= "s",
	selectionVolumeOffsets	= "0 -10 0",
	selectionVolumeScales	= "72 72 72	",

	capturable = false,
	category	= "RAPTOR",
	selfdestructas= "ROOST_DEATH",

	customparams= {
		hivepad		= true,
		hive_t2 = "prap_pad_t2",
		isairbase	= true,
		model_author = "Mr Bob",
		normalmaps	= "yes",
		normaltex = "unittextures/cor_normal.dds",
	},
	featuredefs	= {},
	sfxtypes	= {
		explosiongenerators = {
			[1]	= "custom:blood_spray",
			[2]	= "custom:blood_explode",
			[3]	= "custom:dirt",
		},
		pieceexplosiongenerators = {
			[1]	= "blood_spray",
			[2]	= "blood_spray",
			[3]	= "blood_spray",
		},
	},
},
prap_pad_t2 = {
	health		= 50000,
	autoheal	= 5,
	idletime	= 90,
	idleautoheal= 50,
	energycost	= 25000,
	metalcost	= 400,
	selfDestructCountdown= 0,

	workertime	= 250,
	metalmake	= 0,
	energymake	= 0,
	energystorage= 0,

	builder = true,
	buildtime = 10500,
	buildoptions = {
		"prap_siege_t2",
		"prap_swarm_t2",
		"prap_nest_t2",
	},

	waterline	= 0,
	footprintx	= 6,
	footprintz	= 6,
	sightdistance= 750,
	levelground	= false,
	objectname	= "Units/CORASY.s3o",
	script		= "praptors/prap_pad_t2_lus.lua",
	yardmap		= [[
	eeeeee
	eeeeee
	eeeeee
	eeeeee
	eeeeee
	eeeeee
	]],
	collisionvolumetype		= "s",
	collisionvolumeoffsets	= "0 -10 0",
	collisionvolumescales	= "92 92 92	",
	selectionVolumeType		= "s",
	selectionVolumeOffsets	= "0 -10 0",
	selectionVolumeScales	= "72 72 72	",

	capturable = false,
	category	= "RAPTOR",
	selfdestructas= "ROOST_DEATH",

	customparams= {
		isairbase	= true,
		hivepad		= true,
		hive_t2 = "prap_pad_t2",
		model_author = "Mr Bob",
		normalmaps	= "yes",
		normaltex = "unittextures/cor_normal.dds",
	},
	featuredefs	= {},
	sfxtypes	= {
		explosiongenerators = {
			[1]	= "custom:blood_spray",
			[2]	= "custom:blood_explode",
			[3]	= "custom:dirt",
		},
		pieceexplosiongenerators = {
			[1]	= "blood_spray",
			[2]	= "blood_spray",
			[3]	= "blood_spray",
		},
	},
},
} end