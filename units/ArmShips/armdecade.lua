return {
	armdecade = {
		buildangle = 16384,
		buildpic = "ARMDECADE.DDS",
		buildtime = 2450,
		canmove = true,
		collisionvolumeoffsets = "0 -7 -1",
		collisionvolumescales = "21 25 62",
		collisionvolumetype = "CylZ",
		corpse = "DEAD",
		energycost = 1500,
		explodeas = "mediumexplosiongeneric",
		floater = true,
		footprintx = 3,
		footprintz = 3,
		health = 970,
		idleautoheal = 5,
		idletime = 1800,
		maxacc = 0.1004,
		maxdec = 0.1004,
		metalcost = 175,
		minwaterdepth = 12,
		movementclass = "BOAT3",
		nochasecategory = "UNDERWATER VTOL",
		objectname = "Units/ARMDECADE.s3o",
		script = "Units/ARMDECADE.cob",
		seismicsignature = 0,
		selfdestructas = "mediumexplosiongenericSelfd",
		sightdistance = 375,
		speed = 104.7,
		turninplace = true,
		turninplaceanglelimit = 90,
		turnrate = 450,
		waterline = 0,
		customparams = {
			model_author = "FireStorm",
			normaltex = "unittextures/Arm_normal.dds",
			subfolder = "ArmShips",
			unitgroup = "weapon",
		},
		featuredefs = {
			dead = {
				blocking = false,
				category = "corpses",
				collisionvolumeoffsets = "-4.64749145508 -7.42665378418 -1.15311431885",
				collisionvolumescales = "32.7630615234 17.5484924316 65.1112213135",
				collisionvolumetype = "Box",
				damage = 300,
				featuredead = "HEAP",
				footprintx = 3,
				footprintz = 3,
				height = 20,
				metal = 82.5,
				object = "Units/armdecade_dead.s3o",
				reclaimable = true,
			},
			heap = {
				blocking = false,
				category = "heaps",
				collisionvolumescales = "85.0 14.0 6.0",
				collisionvolumetype = "cylY",
				damage = 500,
				footprintx = 2,
				footprintz = 2,
				height = 4,
				metal = 41.25,
				object = "Units/arm4X4B.s3o",
				reclaimable = true,
				resurrectable = 0,
			},
		},
		sfxtypes = {
			explosiongenerators = {
				[1] = "custom:barrelshot-tiny",
				[2] = "custom:waterwake-small-long",
			},
			pieceexplosiongenerators = {
				[1] = "deathceg2",
				[2] = "deathceg3",
				[3] = "deathceg4",
			},
		},
		sounds = {
			canceldestruct = "cancel2",
			underattack = "warning1",
			cant = {
				[1] = "cantdo4",
			},
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			ok = {
				[1] = "sharmmov",
			},
			select = {
				[1] = "sharmsel",
			},
		},
		weapondefs = {
			emg = {
				areaofeffect = 8,
				avoidfeature = false,
				burst = 3,
				burstrate = 0.1,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:laserhit-small-yellow",
				impulsefactor = 0.123,
				intensity = 0.7,
				name = "Rapid-fire close-quarters plasma turret",
				noselfdamage = true,
				range = 280,
				reloadtime = 0.4,
				rgbcolor = "1 0.95 0.4",
				size = 1.75,
				soundhitwet = "splshbig",
				soundstart = "flashemg",
				sprayangle = 900,
				tolerance = 5000,
				turret = true,
				weapontimer = 0.1,
				weapontype = "Cannon",
				weaponvelocity = 500,
				customparams = {
					noattackrangearc = 1,
				},
				damage = {
					default = 9,
					vtol = 2,
				},
			},
		},
		weapons = {
			[1] = {
				def = "EMG",
				maindir = "0 0 1",
				maxangledif = 285,
				onlytargetcategory = "NOTSUB",
			},
			[2] = {
				def = "EMG",
				maindir = "0 0 -1",
				maxangledif = 285,
				onlytargetcategory = "NOTSUB",
			},
		},
	},
}
