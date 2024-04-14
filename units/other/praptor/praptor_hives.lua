if Spring.GetModOptions().praptors == true or true then
	return {
		prap_nest = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 7250,
			capturable = false,
			canmove = true,
			category = "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost = 1350,
			energystorage = 1000,
			explodeas = "ROOST_DEATH",
			footprintx = 12,
			footprintz = 12,
			health = 2050,
			idleautoheal = 10,
			idletime = 90,
			levelground = false,
			maxacc = 0,
			maxdec = 0,
			metalcost = 860,
			maxslope = 15,
			objectname = "Raptors/praptors/praptor_nest.s3o",
			script = "Raptors/praptors/praptor_nest_lus.lua",
			seismicsignature = 0,
			selfdestructas = "ROOST_DEATH",
			sightdistance = 510,
			smoothanim = true,
			waterline = 0,
			workertime = 300,
			yardmap = "yyyyyyyyyyyy yyyyooooyyyy yyyooooooyyy yyooooooooyy yooooooooooy yooooooooooy yooooooooooy yooooooooooy yyooooooooyy yyyooooooyyy yyyyooooyyyy yyyyyyyyyyyy",
			buildoptions = {
				[1] = "prap_healer",
				[2] = "prap_fighter",
				--[3] = "prap_bomber",
				--[4] = "prap_air_kamikaze",
				[5] = "legmos",
			},
			customparams = {
				subfolder = "other/raptor",
				model_author = "FireStorm, Beherith",
				normalmaps = "yes",
				normaltex = "unittextures/chicken_l_normals.png",
				upgradable = "replace",
				--treeshader = "yes",
			},
			featuredefs = {},
			sfxtypes = {
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
			},
		},
		prap_den = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 7250,
			capturable = false,
			canmove = true,
			category = "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost = 1350,
			energystorage = 1000,
			explodeas = "ROOST_DEATH",
			footprintx = 12,
			footprintz = 12,
			health = 2050,
			idleautoheal = 10,
			idletime = 90,
			levelground = false,
			maxacc = 0,
			maxdec = 0,
			metalcost = 860,
			maxslope = 15,
			objectname = "Raptors/praptors/praptor_den.s3o",
			script = "Raptors/praptors/praptor_den_lus.lua",
			seismicsignature = 0,
			selfdestructas = "ROOST_DEATH",
			sightdistance = 510,
			smoothanim = true,
			waterline = 0,
			workertime = 300,
			yardmap = "yyyyyyyyyyyy yyyyyyyoyyyy yyoyyyyooyyy yyoyyyyyooyy yooyyyyyoooy yooyyyyyoooy yooyyyyyoooy yooyyyyyoooy yyoyyyyyooyy yyoyyyyooyyy yyyyyyyoyyyy yyyyyyyyyyyy",
			--[[ fancy drawing of a tunel where a unit may walk through the den
				yyyyyyyyyyyy	yyyyyyyyyyyy
				yyyyyyyoyyyy	yyyyooooyyyy
				yyoyyyyooyyy	yyyooooooyyy
				yyoyyyyyooyy	yyooooooooyy
				yooyyyyyoooy	yooooooooooy
				yooyyyyyoooy	yooooooooooy
				yooyyyyyoooy	yooooooooooy
				yooyyyyyoooy	yooooooooooy
				yyoyyyyyooyy	yyooooooooyy
				yyoyyyyooyyy	yyyooooooyyy
				yyyyyyyoyyyy	yyyyooooyyyy
				yyyyyyyyyyyy	yyyyyyyyyyyy
			]]
			buildoptions = {
				[1] = "prap_healer",
				[2] = "prap_arty",
			},
			customparams = {
				subfolder = "other/raptor",
				model_author = "FireStorm, Beherith",
				normalmaps = "yes",
				normaltex = "unittextures/chicken_l_normals.png",
				upgradable = "shrink",
				--treeshader = "yes",
			},
			featuredefs = {},
			sfxtypes = {
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
			},
		},
		prap_hive = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 6500,
			capturable = false,
			canmove = true,
			category = "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost = 1200,
			energystorage = 1000,
			explodeas = "ROOST_DEATH",
			footprintx = 12,
			footprintz = 12,
			health = 2050,
			idleautoheal = 10,
			idletime = 90,
			levelground = false,
			maxacc = 0,
			maxdec = 0,
			metalcost = 650,
			maxslope = 15,
			objectname = "Raptors/praptors/praptor_hive.s3o",
			--objectname = "Raptors/raptor_hive.s3o",
			script = "Raptors/praptors/praptor_hive_lus.lua",
			--script = "Units/ARMLAB.cob",
			seismicsignature = 0,
			selfdestructas = "ROOST_DEATH",
			sightdistance = 510,
			smoothanim = true,
			waterline = 0,
			workertime = 300,
			yardmap = "yyyyyyyyyyyy yyyyyyooyyyy yyyoyyooyyyy yyooooooyyyy yoooooooyyyy yyyooooooooy yyyooooooooy yoooooooyyyy yyooooooyyyy yyyoyyooyyyy yyyyyyooyyyy yyyyyyyyyyyy",
			--[[ shaped around the positions of the entrances
			new	yyyyyyyyyyyy	old	yyyyyyyyyyyy
				yyyyyyooyyyy		yyyyooooyyyy
				yyyoyyooyyyy		yyyooooooyyy
				yyooooooyyyy		yyooooooooyy
				yoooooooyyyy		yooooooooooy
				yyyooooooooy		yooooooooooy
				yyyooooooooy		yooooooooooy
				yoooooooyyyy		yooooooooooy
				yyooooooyyyy		yyooooooooyy
				yyyoyyooyyyy		yyyooooooyyy
				yyyyyyooyyyy		yyyyooooyyyy
				yyyyyyyyyyyy		yyyyyyyyyyyy
			]]
			buildoptions = {
				[1] = "prap_nest",
				[2] = "prap_den",
				[3] = "prap_healer",
				[4] = "prap_swarmer",
				--[5] = "prap_spiker",
			},
			customparams = {
				subfolder = "other/raptor",
				model_author = "FireStorm, Beherith",
				normalmaps = "yes",
				normaltex = "unittextures/chicken_l_normals.png",
				upgradable = "replace",
			},
			featuredefs = {},
			sfxtypes = {
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
			},
		},
		prap_nexus = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 6500,
			capturable = false,
			canmove = true,
			category = "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost = 1200,
			energystorage = 1000,
			explodeas = "ROOST_DEATH",
			footprintx = 12,
			footprintz = 12,
			health = 2050,
			idleautoheal = 10,
			idletime = 90,
			levelground = false,
			maxacc = 0,
			maxdec = 0,
			metalcost = 650,
			maxslope = 15,
			objectname = "Raptors/praptors/praptor_hive.s3o",
			--objectname = "Raptors/raptor_hive.s3o",
			script = "Raptors/praptors/praptor_nexus_lus.lua",
			--script = "Units/ARMLAB.cob",
			seismicsignature = 0,
			selfdestructas = "ROOST_DEATH",
			sightdistance = 510,
			smoothanim = true,
			waterline = 0,
			workertime = 300,
			yardmap = "yyyyyyyyyyyy yyyyyyooyyyy yyyoyyooyyyy yyooooooyyyy yoooooooyyyy yyyooooooooy yyyooooooooy yoooooooyyyy yyooooooyyyy yyyoyyooyyyy yyyyyyooyyyy yyyyyyyyyyyy",
			--[[ shaped around the positions of the entrances
			new	yyyyyyyyyyyy	old	yyyyyyyyyyyy
				yyyyyyooyyyy		yyyyooooyyyy
				yyyoyyooyyyy		yyyooooooyyy
				yyooooooyyyy		yyooooooooyy
				yoooooooyyyy		yooooooooooy
				yyyooooooooy		yooooooooooy
				yyyooooooooy		yooooooooooy
				yoooooooyyyy		yooooooooooy
				yyooooooyyyy		yyooooooooyy
				yyyoyyooyyyy		yyyooooooyyy
				yyyyyyooyyyy		yyyyooooyyyy
				yyyyyyyyyyyy		yyyyyyyyyyyy
			]]
			buildoptions = {
				[1] = "prap_nest",
				[2] = "prap_den",
				[3] = "prap_healer",
				[4] = "prap_swarmer",
				--[5] = "prap_spiker",
			},
			customparams = {
				subfolder = "other/raptor",
				model_author = "FireStorm, Beherith",
				normalmaps = "yes",
				normaltex = "unittextures/chicken_l_normals.png",
				upgradable = "replace",
				iscommander = true,
				entourage1 = "prap_healer",
				entourage2 = "prap_swarmer",
				entourage3 = "prap_healer",
				entourage4 = "prap_swarmer",
				entourage5 = "prap_spiker",
			},
			featuredefs = {},
			sfxtypes = {
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
			},
		},
	}	
end