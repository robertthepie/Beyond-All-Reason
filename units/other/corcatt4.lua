return {
	corcatt4 = {
		-- stats
		health			= 1830,
		idletime		= 1800,
		idleautoheal	= 5,
		energycost		= 6400,
		metalcost		= 370,
		buildtime		= 15300,
		sightdistance	= 260,
		category		= "BOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE GROUNDSCOUT EMPABLE",

		-- movement
		maxacc			= 0.15,
		maxdec			= 0.15,
		speed			= 66,
		rspeed			= 66,
		turnrate		= 150,

		-- movement constraints
		bankingAllowed	= false,
		blocking		= false,
		canfly			= true,
		canmove			= true,
		collide			= false,
		hoverattack		= true,
		upright			= true,
		useSmoothMesh	= false,

		cruisealtitude	= 70,
		maxslope		= 10,

		turninplaceanglelimit = 360,
		footprintx		= 12,
		footprintz		= 12,
		maxwaterdepth	= 0,

		-- air post:
		factoryHeadingTakeoff = false,
		airHoverFactor = 0,

		-- cosmetic
		buildpic		= "CORSEAH.DDS",
		objectname		= "Units/SCAVBOSS/CORCATT4.s3o",
		script			= "Units/SCAVBOSS/CORCATT4_lus.lua",
		explodeas		= "hugeExplosionGeneric",

		--other @TODO:
		collisionvolumeoffsets	= "0 0 0",
		collisionvolumescales	= "114 50 114",
		collisionvolumetype		= "CylY",
		selectionvolumeoffsets	= "0 50 0",
		selectionvolumescales	= "50 50 150",
		selectionvolumetype		= "box",
		seismicsignature	= 0,
		selfdestructas		= "hugeExplosionGenericSelfd",
		selfDCountdown		= 0,
		customparams		= {
			model_author	= "__TMP",
			normaltex		= "unittextures/cor_normal.dds",
		},
		sfxtypes = {},
		sounds = {},

		weapondefs = {
			dummy_weapon = {
				areaofeffect = 4,
				avoidfeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "",
				gravityaffected = "true",
				hightrajectory = 1,
				impulsefactor = 0.123,
				name = "HeavyCannon",
				noselfdamage = true,
				metalpershot = 15,
				energypershot = 500,
				range = 1100,
				reloadtime = 2.5,
				size = 0,
				soundhit = "",
				soundhitwet = "",
				soundstart = "",
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 1000,
				damage = {
					default = 0,
				},
			}
		},
		weapons = {
			[1] = {
				def = "DUMMY_WEAPON",
				onlytargetcategory = "SURFACE",
			},
		},
	},
}
