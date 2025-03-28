return {
	cordroneold = {
		blocking = false,
		buildpic = "CORBW.DDS",
		buildtime = 1040,
		canfly = true,
		canmove = true,
		cantbetransported = false,
		collide = true,
		cruisealtitude = 78,
		energycost = 650,
		explodeas = "tinyExplosionGeneric",
		footprintx = 1,
		footprintz = 1,
		health = 166,
		hoverattack = true,
		idleautoheal = 0,
		idletime = 1800,
		maxacc = 0.25,
		maxdec = 0.55,
		maxslope = 10,
		maxwaterdepth = 0,
		metalcost = 29,
		nochasecategory = "COMMANDER VTOL",
		objectname = "Units/CORDRONEOLD.s3o",
		script = "Units/CORBW.cob",
		seismicsignature = 0,
		selfdestructas = "tinyExplosionGenericSelfd",
		sightdistance = 500,
		speed = 280.5,
		turninplaceanglelimit = 360,
		turnrate = 1100,
		upright = true,
		usesmoothmesh = 0,
		customparams = {
			drone = 1,
			model_author = "Mr Bob",
			normaltex = "unittextures/cor_normal.dds",
			subfolder = "CorAircraft",
			unitgroup = "emp",
		},
		sfxtypes = {
			pieceexplosiongenerators = {
				[1] = "airdeathceg2",
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
				[1] = "vtolcrmv",
			},
			select = {
				[1] = "vtolcrac",
			},
		},
		weapondefs = {
			heat_ray = {
				areaofeffect = 8,
				avoidfeature = false,
				beamtime = 0.25,
				corethickness = 0.15,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:laserhit-small-yellow",
				firestarter = 30,
				impactonly = 1,
				impulsefactor = 0,
				laserflaresize = 5,
				name = "HeatRay",
				noselfdamage = true,
				range = 360,
				reloadtime = 4.8,
				rgbcolor = "1 0.8 0",
				rgbcolor2 = "0.8 0 0",
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundstart = "lasrfir3",
				soundtrigger = 1,
				targetmoveerror = 0.2,
				thickness = 1.5,
				tolerance = 10000,
				turret = true,
				weapontype = "BeamLaser",
				weaponvelocity = 950,
				damage = {
					default = 80,
					vtol = 25,
				},
			},
			semiauto = {
				accuracy = 7,
				areaofeffect = 16,
				avoidfeature = false,
				burnblow = false,
				burst = 2,
				burstrate = 0.1,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				duration = 0.03,
				edgeeffectiveness = 0.85,
				explosiongenerator = "custom:plasmahit-sparkonly",
				falloffrate = 0.2,
				firestarter = 0,
				intensity = 0.8,
				name = "Rapid-fire a2g machine guns",
				noselfdamage = true,
				ownerexpaccweight = 4,
				proximitypriority = 1,
				range = 300,
				reloadtime = 1.5,
				rgbcolor = "1 0.95 0.4",
				soundhit = "bimpact3",
				soundhitwet = "splshbig",
				soundstart = "minigun3",
				soundstartvolume = 3,
				sprayangle = 1000,
				thickness = 0.6,
				tolerance = 6000,
				turret = true,
				weapontype = "LaserCannon",
				weaponvelocity = 950,
				damage = {
					default = 16,
					vtol = 5,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "VTOL",
				def = "HEAT_RAY",
				maindir = "0 0 1",
				maxangledif = 90,
				onlytargetcategory = "NOTSUB",
			},
		},
	},
}
