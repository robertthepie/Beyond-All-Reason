return {
	coruwmmm = {
		activatewhenbuilt = true,
		buildangle = 8192,
		buildpic = "CORUWMMM.DDS",
		buildtime = 31300,
		canrepeat = false,
		collisionvolumeoffsets = "0 0 0",
		collisionvolumescales = "120 120 120",
		collisionvolumetype = "Ell",
		corpse = "DEAD",
		energycost = 21000,
		explodeas = "hugeBuildingExplosionGeneric",
		floater = true,
		footprintx = 5,
		footprintz = 5,
		health = 560,
		idleautoheal = 5,
		idletime = 1800,
		maxacc = 0,
		maxdec = 0,
		maxslope = 16,
		metalcost = 370,
		minwaterdepth = 15,
		objectname = "Units/CORUWMMM.s3o",
		script = "Units/coruwmmm.cob",
		seismicsignature = 0,
		selfdestructas = "hugeBuildingExplosionGenericSelfd",
		sightdistance = 143,
		waterline = 17,
		yardmap = "ooooooooooooooooooooooooo",
		customparams = {
			energyconv_capacity = 600,
			energyconv_efficiency = 0.01724,
			model_author = "Mr Bob",
			normaltex = "unittextures/cor_normal.dds",
			removestop = true,
			removewait = true,
			subfolder = "CorBuildings/SeaEconomy",
			techlevel = 2,
			unitgroup = "metal",
		},
		featuredefs = {
			dead = {
				blocking = true,
				category = "corpses",
				collisionvolumeoffsets = "0.0 -2.2497558593e-05 -0.0",
				collisionvolumescales = "60.0 29.4457550049 60.0",
				collisionvolumetype = "Box",
				damage = 300,
				featuredead = "HEAP",
				footprintx = 5,
				footprintz = 5,
				height = 20,
				metal = 242,
				object = "Units/coruwmmm_dead.s3o",
				reclaimable = true,
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 150,
				footprintx = 5,
				footprintz = 5,
				height = 4,
				metal = 97,
				object = "Units/cor5X5A.s3o",
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
			activate = "metlon2",
			canceldestruct = "cancel2",
			deactivate = "metloff2",
			underattack = "warning1",
			working = "metlrun2",
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			select = {
				[1] = "metlon2",
			},
		},
	},
}
