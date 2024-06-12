return {
	loik = {
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
		turnrate		= 200,

		-- movement constraints
		bankingAllowed	= false,
		blocking		= false,
		canfly			= true,
		canmove			= true,
		collide			= false,
		hoverattack		= true,
		upright			= true,
		useSmoothMesh	= false,

		cruisealtitude	= 100,
		maxslope		= 10,

		turninplaceanglelimit = 360,
		footprintx		= 12,
		footprintz		= 12,
		maxwaterdepth	= 0,

		-- cosmetic
		buildpic		= "CORSEAH.DDS",
		objectname		= "corloik.s3o",
		script			= "loik_lus.lua",
		explodeas		= "hugeExplosionGeneric",

		--other @TODO:
		collisionvolumeoffsets	= "1 -3 0",
		collisionvolumescales	= "52 21 52",
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
