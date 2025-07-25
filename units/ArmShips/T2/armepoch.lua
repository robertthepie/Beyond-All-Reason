return {
	armepoch = {
		activatewhenbuilt = true,
		buildangle = 16384,
		buildpic = "ARMEPOCH.DDS",
		buildtime = 200000,
		canattackground = true,
		canmove = true,
		collisionvolumeoffsets = "0 -6 3",
		collisionvolumescales = "71 71 180",
		collisionvolumetype = "CylZ",
		corpse = "DEAD",
		energycost = 190000,
		explodeas = "flagshipExplosion",
		floater = true,
		footprintx = 8,
		footprintz = 8,
		health = 50000,
		idleautoheal = 25,
		idletime = 1800,
		mass = 9999999,
		maxacc = 0.01104,
		maxdec = 0.01104,
		metalcost = 20000,
		minwaterdepth = 15,
		movementclass = "BOAT8",
		movestate = 0,
		objectname = "Units/ARMEPOCH.s3o",
		radardistance = 1530,
		radaremitheight = 52,
		script = "Units/ARMEPOCH.cob",
		seismicsignature = 0,
		selfdestructas = "flagshipExplosionSelfd",
		sightdistance = 689,
		sightemitheight = 52,
		speed = 53.85,
		turninplace = true,
		turninplaceanglelimit = 90,
		turnrate = 135,
		waterline = 0,
		customparams = {
			model_author = "FireStorm",
			normaltex = "unittextures/Arm_normal.dds",
			paralyzemultiplier = 0,
			subfolder = "ArmShips/T2",
			techlevel = 2,
			unitgroup = "weapon",
		},
		featuredefs = {
			dead = {
				blocking = false,
				category = "corpses",
				collisionvolumeoffsets = "0.439918518066 -4.07348632798e-05 0.367340087891",
				collisionvolumescales = "75.0081939697 51.5621185303 178.425750732",
				collisionvolumetype = "Box",
				damage = 85500,
				featuredead = "HEAP",
				footprintx = 6,
				footprintz = 18,
				height = 4,
				metal = 8500,
				object = "Units/armepoch_dead.s3o",
				reclaimable = true,
			},
			heap = {
				blocking = false,
				category = "heaps",
				damage = 40032,
				footprintx = 2,
				footprintz = 2,
				height = 4,
				metal = 4250,
				object = "Units/arm6X6A.s3o",
				reclaimable = true,
				resurrectable = 0,
			},
		},
		sfxtypes = {
			explosiongenerators = {
				[1] = "custom:barrelshot-large",
				[2] = "custom:barrelshot-larger",
				[3] = "custom:barrelshot-medium-aa",
				[4] = "custom:waterwake-huge",
				[5] = "custom:bowsplash-huge",
				[6] = "custom:enginespurt-huge",
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
			ferret_missile = {
				areaofeffect = 16,
				avoidfeature = false,
				burnblow = true,
				burst = 2,
				burstrate = 0.2,
				canattackground = false,
				castshadow = false,
				cegtag = "missiletrailaa",
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				energypershot = 0,
				explosiongenerator = "custom:genericshellexplosion-tiny-aa",
				firestarter = 72,
				flighttime = 2.5,
				impulsefactor = 0.123,
				metalpershot = 0,
				model = "cormissile.s3o",
				name = "Pop-up rapid-fire g2a missile launcher",
				noselfdamage = true,
				range = 840,
				reloadtime = 1.7,
				smokecolor = 0.95,
				smokeperiod = 6,
				smokesize = 4.6,
				smoketime = 12,
				smoketrail = true,
				smoketrailcastshadow = false,
				soundhit = "packohit",
				soundhitwet = "splshbig",
				soundstart = "packolau",
				soundtrigger = true,
				startvelocity = 1,
				texture1 = "null",
				texture2 = "smoketrailaa3",
				tolerance = 9950,
				tracks = true,
				turnrate = 68000,
				turret = true,
				weaponacceleration = 1200,
				weapontimer = 2,
				weapontype = "MissileLauncher",
				weaponvelocity = 1000,
				customparams = {
					noattackrangearc = 1,
				},
				damage = {
					commanders = 1,
					vtol = 150,
				},
			},
			flak = {
				accuracy = 1000,
				areaofeffect = 128,
				avoidfeature = false,
				burnblow = true,
				canattackground = false,
				cegtag = "flaktrailaa",
				craterboost = 0,
				cratermult = 0,
				cylindertargeting = 1,
				edgeeffectiveness = 1,
				explosiongenerator = "custom:genericshellexplosion-large-air",
				gravityaffected = "true",
				impulsefactor = 0,
				name = "Heavy g2a flak cannon",
				noselfdamage = true,
				range = 775,
				reloadtime = 0.53333,
				size = 4.5,
				sizedecay = 0.08,
				soundhit = "flakhit",
				soundhitwet = "splsmed",
				soundstart = "flakfire",
				stages = 8,
				turret = true,
				weapontimer = 1,
				weapontype = "Cannon",
				weaponvelocity = 1550,
				customparams = {
					noattackrangearc = 1,
				},
				damage = {
					vtol = 250,
				},
				rgbcolor = {
					[1] = 1,
					[2] = 0.33,
					[3] = 0.7,
				},
			},
			heavyplasma = {
				accuracy = 600,
				areaofeffect = 160,
				avoidfeature = false,
				burst = 2,
				burstrate = 0.8,
				cegtag = "arty-heavy",
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:genericshellexplosion-large-aoe",
				gravityaffected = "true",
				impulsefactor = 1,
				name = "Primary rapid-fire heavy long-range plasma cannon",
				noselfdamage = true,
				range = 2450,
				reloadtime = 3.5,
				soundhit = "bertha6",
				soundhitwet = "splslrg",
				soundstart = "BERTHA1",
				sprayangle = 650,
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 600,
				customparams = {
					noattackrangearc = 1,
				},
				damage = {
					default = 500,
					vtol = 200,
				},
			},
			mediumplasma = {
				accuracy = 350,
				areaofeffect = 128,
				avoidfeature = false,
				cegtag = "arty-fast",
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:genericshellexplosion-medium",
				gravityaffected = "true",
				impulsefactor = 0.123,
				name = "Secondary rapid-fire heavy plasma cannon",
				noselfdamage = true,
				range = 830,
				reloadtime = 1.2,
				soundhit = "xplomed2",
				soundhitwet = "splsmed",
				soundstart = "cannhvy1",
				tolerance = 5000,
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 570,
				customparams = {
					noattackrangearc = 1,
				},
				damage = {
					default = 270,
					vtol = 65,
				},
			},
		},
		weapons = {
			[1] = {
				def = "HEAVYPLASMA",
				onlytargetcategory = "SURFACE",
			},
			[2] = {
				def = "MEDIUMPLASMA",
				maindir = "0 0 1",
				maxangledif = 320,
				onlytargetcategory = "SURFACE",
			},
			[3] = {
				def = "HEAVYPLASMA",
				maindir = "0 0 1",
				maxangledif = 240,
				onlytargetcategory = "SURFACE",
			},
			[4] = {
				def = "MEDIUMPLASMA",
				maindir = "-4 0 1",
				maxangledif = 180,
				onlytargetcategory = "SURFACE",
			},
			[5] = {
				def = "MEDIUMPLASMA",
				maindir = "4 0 1",
				maxangledif = 180,
				onlytargetcategory = "SURFACE",
			},
			[6] = {
				badtargetcategory = "NOTAIR GROUNDSCOUT",
				def = "FERRET_MISSILE",
				maindir = "0 -1 -2",
				maxangledif = 270,
				onlytargetcategory = "VTOL T4AIR",
			},
			[7] = {
				badtargetcategory = "NOTAIR GROUNDSCOUT",
				def = "FERRET_MISSILE",
				onlytargetcategory = "VTOL T4AIR",
			},
		},
	},
}
