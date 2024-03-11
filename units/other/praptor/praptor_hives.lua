if Spring.GetModOptions().praptors == true or true then
	return {
		prap_nest = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 725,
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
				[3] = "prap_bomber",
				[4] = "prap_air_kamikaze",
				[5] = "legmos",
			},
			customparams = {
				subfolder = "other/raptor",
				model_author = "FireStorm, Beherith",
				normalmaps = "yes",
				normaltex = "unittextures/chicken_l_normals.png",
				upgradable = "praptor",
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
			buildtime = 650,
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
			yardmap = "yyyyyyyyyyyy yyyyyyooyyyy yyyoyyooyyyy yyooooooyyyy yooooooooooy yyyooooooooy yyyooooooooy yooooooooooy yyooooooyyyy yyyoyyooyyyy yyyyyyooyyyy yyyyyyyyyyyy",
			--[[ shaped around the positions of the entrances
			new	yyyyyyyyyyyy	old	yyyyyyyyyyyy
				yyyyyyooyyyy		yyyyooooyyyy
				yyyoyyooyyyy		yyyooooooyyy
				yyooooooyyyy		yyooooooooyy
				yooooooooooy		yooooooooooy
				yyyooooooooy		yooooooooooy
				yyyooooooooy		yooooooooooy
				yooooooooooy		yooooooooooy
				yyooooooyyyy		yyooooooooyy
				yyyoyyooyyyy		yyyooooooyyy
				yyyyyyooyyyy		yyyyooooyyyy
				yyyyyyyyyyyy		yyyyyyyyyyyy
			]]
			buildoptions = {
				[1] = "prap_nest",
				[2] = "prap_healer",
				[3] = "prap_swarmer",
				[4] = "prap_spiker",
			},
			customparams = {
				subfolder = "other/raptor",
				model_author = "FireStorm, Beherith",
				normalmaps = "yes",
				normaltex = "unittextures/chicken_l_normals.png",
				upgradable = "praptor",
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
	}	
end