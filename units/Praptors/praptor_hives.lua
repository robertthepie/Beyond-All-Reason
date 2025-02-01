local modoptions = Spring.GetModOptions()
if modoptions.playablerapotrs ~= true and modoptions.forceallunits ~= true then return {}
else
	return {
prap_hive = {
	health		= 50000,
	autoheal	= 5,
	idletime	= 90,
	idleautoheal= 50,
	energycost	= 25000,
	metalcost	= 400,
	selfDestructCountdown= 0,

	workertime	= 300,
	metalmake	= 4,
	energymake	= 25,
	energystorage= 10000,

	builder = true,
	buildtime = 10500,
	buildoptions = {
		"prap_hive",
	},

	waterline	= 0,
	footprintx	= 6,
	footprintz	= 6,
	maxslope	= 33,
	sightdistance= 750,
	levelground	= false,
	objectname	= "Raptors/raptor_hive.s3o",
	script		= "praptors/prap_hive_lus.lua",
	yardmap		= "oooooo oooooo oooooo oooooo oooooo oooooo",
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
		hive		= true,
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

	workertime	= 300,
	metalmake	= 4,
	energymake	= 25,
	energystorage= 10000,

	builder = true,
	buildtime = 10500,
	buildoptions = {
		"corlab",
		"corap",
		"corvp",
		"corck",
	},

	waterline	= 0,
	footprintx	= 6,
	footprintz	= 6,
	sightdistance= 750,
	levelground	= false,
	objectname	= "Units/CORSY.s3o",
	script		= "praptors/prap_pad_lus.lua",
	yardmap		= "oooooo oooooo oooooo oooooo oooooo oooooo",
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
} end