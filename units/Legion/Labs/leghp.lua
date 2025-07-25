return {
	leghp = {
		maxacc = 0,
		maxdec = 0,
		energycost = 2750,
		metalcost = 750,
		builder = true,
		buildpic = "LEGHP.DDS",
		buildtime = 9500,
		canmove = true,
		collisionvolumeoffsets = "0 0 0",
		collisionvolumescales = "96 35 96",
		collisionvolumetype = "Box",
		corpse = "DEAD",
		energystorage = 200,
		explodeas = "largeBuildingExplosionGeneric",
		footprintx = 6,
		footprintz = 6,
		idleautoheal = 5,
		idletime = 1800,
		health = 3750,
		maxslope = 15,
		maxwaterdepth = 0,
		metalstorage = 200,
		objectname = "Units/LEGHP.s3o",
		script = "Units/LEGHP.cob",
		seismicsignature = 0,
		selfdestructas = "largeBuildingExplosionGenericSelfd",
		sightdistance = 312,
		terraformspeed = 1000,
		workertime = 150,
		yardmap = "oeeeeo oeeeeo oeeeeo oeeeeo oeeeeo oeeeeo",
		buildoptions = {
			[1] = "legch",
			[2] = "legsh",
			[3] = "legner",
			[4] = "legah",
			[5] = "legmh",
			[6] = "legcar",
		},
		customparams = {
			usebuildinggrounddecal = true,
			buildinggrounddecaltype = "decals/leghp_aoplane.dds",
			buildinggrounddecalsizey = 8,
			buildinggrounddecalsizex = 8,
			buildinggrounddecaldecayspeed = 30,
			unitgroup = 'builder',
			model_author = "Protar",
			normaltex = "unittextures/leg_normal.dds",
			subfolder = "Legion/Labs",
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "0 0 0",
				collisionvolumescales = "96 35 96",
				collisionvolumetype = "Box",
				damage = 2014,
				featuredead = "HEAP",
				footprintx = 6,
				footprintz = 6,
				height = 20,
				metal = 662,
				object = "Units/leghp_dead.s3o",
				reclaimable = true,
			},
			heap = {
				blocking = false,
				category = "heaps",
				collisionvolumeoffsets = "0 5 0",
				collisionvolumescales = "96 12 96",
				collisionvolumetype = "Box",
				damage = 1007,
				footprintx = 6,
				footprintz = 6,
				height = 4,
				metal = 265,
				object = "Units/cor7X7D.s3o",
				reclaimable = true,
				resurrectable = 0,
			},
		},
		sfxtypes = {
			pieceexplosiongenerators = {
				[1] = "deathceg2",
				[2] = "deathceg3",
				[3] = "deathceg4",
			},
		},
		sounds = {
			build = "hoverok2",
			canceldestruct = "cancel2",
			underattack = "warning1",
			unitcomplete = "untdone",
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			select = {
				[1] = "hoversl2",
			},
		},
	},
}
