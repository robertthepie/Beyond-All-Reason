if Spring.GetModOptions().playableraptors == true then
	return {
		-- nexus (commander)
		prap_nexus = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 6500,
			buildDistance = 800,
			buildangle = 3,640,
			capturable = false,
			canmove = true,
			category = "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost = 0,
			energymake = 0,
			energystorage = 500,
			metalmake = 2,
			metalstorage = 500,
			explodeas = "ROOST_DEATH",
			footprintx = 12,
			footprintz = 12,
			health = 8050,
			idleautoheal = 10,
			idletime = 90,
			levelground = false,
			maxacc = 0,
			maxdec = 0,
			metalcost = 650,
			maxslope = 25,
			objectname = "Raptors/praptors/praptor_nexus.s3o",
			--objectname = "Raptors/raptor_hive.s3o",
			reclaimable = false,
			script = "Raptors/praptors/praptor_nexus_lus.lua",
			--script = "Units/ARMLAB.cob",
			seismicsignature = 0,
			selfdestructas = "ROOST_DEATH",
			sightdistance = 510,
			smoothanim = true,
			waterline = 0,
			workertime = 100,
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
				-- [1] = "prap_nest",
				-- [2] = "prap_den",
				[3] = "prap_foundling",
				[4] = "prap_swarmer",
				-- [5] = "prap_spiker",
				[6] = "prap_mex_t1",
			},
			customparams = {
				subfolder = "other/raptor",
				model_author = "FireStorm, Beherith",
				normalmaps = "yes",
				normaltex = "unittextures/chicken_l_normals.png",
				upgradable = "replace",
				iscommander = true,
				entourage1 = "prap_swarmer", -- "prap_healer",
				entourage2 = "prap_swarmer",
				entourage3 = "prap_swarmer", -- "prap_healer",
				entourage4 = "prap_swarmer",
				entourage5 = "prap_swarmer", -- "prap_spiker",
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

		-- hives (swarm spawners, structural start)
		prap_hive = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 6500,
			buildDistance = 800,
			buildangle = 3,640,
			capturable = false,
			canmove = true,
			category = "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost = 0,
			energystorage = 0,
			explodeas = "ROOST_DEATH",
			footprintx = 12,
			footprintz = 12,
			health = 2050,
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
				[3] = "prap_foundling",
				[4] = "prap_swarmer",
				--[5] = "prap_spiker",
				[6] = "prap_mex_t1",
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

		-- nests (air lab)
		prap_nest = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 7250,
			buildDistance = 800,
			buildangle = 3,640,
			capturable = false,
			canmove = true,
			category = "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost = 0,
			energystorage = 0,
			explodeas = "ROOST_DEATH",
			footprintx = 12,
			footprintz = 12,
			health = 4050,
			idleautoheal = 10,
			idletime = 90,
			levelground = false,
			maxacc = 0,
			maxdec = 0,
			metalcost = 860,
			metalstorage = 500,
			maxslope = 25,
			objectname = "Raptors/praptors/praptor_nest.s3o",
			reclaimable = false,
			script = "Raptors/praptors/praptor_nest_lus.lua",
			seismicsignature = 0,
			selfdestructas = "ROOST_DEATH",
			sightdistance = 510,
			smoothanim = true,
			waterline = 0,
			workertime = 125,
			yardmap = "yyyyyyyyyyyy yyyyooooyyyy yyyooooooyyy yyooooooooyy yooooooooooy yooooooooooy yooooooooooy yooooooooooy yyooooooooyy yyyooooooyyy yyyyooooyyyy yyyyyyyyyyyy",
			buildoptions = {
				[2] = "prap_fighter",
				--[3] = "prap_bomber",
				--[4] = "prap_air_kamikaze",
				[6] = "prap_mex_t1",
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

		-- dens (specilise)
		prap_den = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 7250,
			buildDistance = 800,
			buildangle = 3,640,
			capturable = false,
			canmove = true,
			category = "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost = 0,
			energystorage = 0,
			explodeas = "ROOST_DEATH",
			footprintx = 12,
			footprintz = 12,
			health = 4050,
			idleautoheal = 10,
			idletime = 90,
			levelground = false,
			maxacc = 0,
			maxdec = 0,
			metalcost = 860,
			metalstorage = 750,
			maxslope = 25,
			objectname = "Raptors/praptors/praptor_den.s3o",
			reclaimable = false,
			script = "Raptors/praptors/praptor_den_lus.lua",
			seismicsignature = 0,
			selfdestructas = "ROOST_DEATH",
			sightdistance = 510,
			smoothanim = true,
			waterline = 0,
			workertime = 150,
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
				[2] = "prap_arty",
				[3] = "prap_mex_t1",
				[4] = "prap_spiker",
				[5] = "prap_den_acid"
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
		prap_den_acid = {
			activatewhenbuilt = true,
			autoheal = 1.8,
			builder = true,
			buildpic = "raptors/raptor_hive.DDS",
			buildtime = 10250,
			buildDistance = 800,
			buildangle = 3,640,
			capturable = false,
			canmove = true,
			category = "ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE RAPTOR EMPABLE",
			energycost = 0,
			energystorage = 0,
			explodeas = "ROOST_DEATH",
			footprintx = 12,
			footprintz = 12,
			health = 6050,
			idleautoheal = 10,
			idletime = 90,
			levelground = false,
			maxacc = 0,
			maxdec = 0,
			metalcost = 1600,
			metalstorage = 1000,
			maxslope = 25,
			objectname = "Raptors/praptors/praptor_den_acid.s3o",
			reclaimable = false,
			script = "Raptors/praptors/praptor_den_lus.lua",
			seismicsignature = 0,
			selfdestructas = "ROOST_DEATH",
			sightdistance = 510,
			smoothanim = true,
			waterline = 0,
			workertime = 150,
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
				[2] = "prap_arty_acid",
				[3] = "prap_mex_t1",
				[4] = "prap_spiker",
			},
			customparams = {
				subfolder = "other/raptor",
				model_author = "FireStorm, Beherith",
				normalmaps = "yes",
				normaltex = "unittextures/chicken_l_normals.png",
				upgradable = "replace",
				skipgrowth = "skipgrowth",
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

		-- eco
		prap_mex_t1 = {
			maxacc = 0,
			activatewhenbuilt = true,
			maxdec = 0,
			energycost = 0,
			metalcost = 50,
			buildingmask = 0,
			buildpic = "ARMMEX.DDS",
			buildtime = 1800,
			canrepeat = false,
			category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR NOTHOVER SURFACE EMPABLE CANBEUW UNDERWATER",
			collisionvolumeoffsets = "0 -2 0",
			collisionvolumescales = "48 33 48",
			collisionvolumetype = "CylY",
			corpse = "DEAD",
			energyupkeep = 0,
			explodeas = "smallBuildingExplosionGeneric",
			extractsmetal = 0.001,
			footprintx = 4,
			footprintz = 4,
			idleautoheal = 5,
			idletime = 1800,
			health = 189,
			maxslope = 30,
			metalstorage = 50,
			objectname = "Units/ARMMEX.s3o",
			--objectname = "raptors/praptors/praptor_mex.s3o",
			onoffable = true,
			script = "Units/ARMMEX.cob",
			--script = "",
			seismicsignature = 0,
			selfdestructas = "smallMex",
			selfdestructcountdown = 1,
			sightdistance = 273,
			yardmap = "h cbbbbbbc bsossbsb bbsbbsob bsbbbbsb bsbbbbsb bosbbsbb bsbssosb cbbbbbbc",
			customparams = {
				subfolder = "other/raptor",
				normalmaps = "yes",
				normaltex = "unittextures/chicken_l_normals.png",
				unitgroup = 'metal',
				cvbuildable = true,
				metal_extractor = 1,
				removestop = true,
				removewait = true,
			},
			featuredefs = {
				dead = {
					blocking = true,
					category = "corpses",
					collisionvolumeoffsets = "0.510162353516 -0.044793737793 0.21223449707",
					collisionvolumescales = "52.280090332 25.2522125244 52.9224243164",
					collisionvolumetype = "Box",
					damage = 102,
					featuredead = "HEAP",
					footprintx = 3,
					footprintz = 3,
					height = 20,
					metal = 33,
					object = "Units/armmex_dead.s3o",
					reclaimable = true,
				},
				heap = {
					blocking = false,
					category = "heaps",
					collisionvolumescales = "55.0 4.0 6.0",
					collisionvolumetype = "cylY",
					damage = 51,
					footprintx = 3,
					footprintz = 3,
					height = 4,
					metal = 13,
					object = "Units/arm3X3B.s3o",
					reclaimable = true,
					resurrectable = 0,
				},
			},
			sfxtypes = {
				pieceexplosiongenerators = {
					[1] = "deathceg2",
					[2] = "deathceg3",
				},
			},
			sounds = {
				activate = "mexon",
				canceldestruct = "cancel2",
				deactivate = "mexoff",
				underattack = "warning1",
				working = "mexworking",
				count = {
					[1] = "count6",
					[2] = "count5",
					[3] = "count4",
					[4] = "count3",
					[5] = "count2",
					[6] = "count1",
				},
				select = {
					[1] = "mexselect",
				},
			},
		}
	}
end