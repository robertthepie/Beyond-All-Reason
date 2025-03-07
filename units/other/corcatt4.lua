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
		maxdec			= 0.5,
		speed			= 66,
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

		cruisealtitude	= 40,
		maxslope		= 10,

		turninplaceanglelimit = 360,
		footprintx		= 12,
		footprintz		= 12,
		maxwaterdepth	= 0,

		-- cosmetic
		buildpic		= "CORSEAH.DDS",
		objectname		= "Units/SCAVBOSS/CORCATT4.s3o",
		script			= "Units/SCAVBOSS/CORCATT4_lus.lua",
		explodeas		= "hugeExplosionGeneric",

		--other @TODO:
		collisionvolumeoffsets	= "0 -50 0",
		collisionvolumescales	= "114 114 114",
		collisionvolumetype		= "CylY",
		seismicsignature	= 0,
		selfdestructas		= "hugeExplosionGenericSelfd",
		customparams		= {
			model_author	= "__TMP",
			normaltex		= "unittextures/cor_normal.dds",
		},
		sfxtypes = {},
		sounds = {},
	},
}
