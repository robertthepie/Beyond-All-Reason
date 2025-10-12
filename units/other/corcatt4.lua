epic_catapult = {
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
		collisionvolumescales	= "114 100 114",
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
local nodeTemplate = {
	health		= epic_catapult.corcatt4.health,
	energycost	= epic_catapult.corcatt4.energycost,
	metalcost	= epic_catapult.corcatt4.metalcost,
	script		= "corcatt4_node_common_lus.lua",
	objectname	= "blank.s3o",
	customparams		= {
		model_author	= "__TMP",
		normaltex		= "unittextures/cor_normal.dds",
	},
	sfxtypes = {},
	sounds = {},
	footprintx = 1,
	footprintz = 1,
	collisionvolumeoffsets	= "0 0 0",
	collisionvolumescales	= "0 0 0",
	collisionvolumetype		= "sphere",
	selectionvolumeoffsets	= "0 0 0",
	selectionvolumescales	= "0 0 0",
	selectionvolumetype		= "sphere",
}
local _node
local function newNode(name)
	_node = table.copy(nodeTemplate)
	epic_catapult[name] = _node
end
local function setNodeSize(x, y, z, px, py, pz)
	if not x and _node then return end
	if y and z then
		local offset = px and py and pz and (px.." "..py.." "..pz) or "0 0 0"
		local size = x and y and z and (x.." "..y.." "..z) or "0 0 0"
		_node.collisionvolumeoffsets	= offset
		_node.collisionvolumescales	= size
		_node.collisionvolumetype	= "box"
		_node.selectionvolumeoffsets	= offset
		_node.selectionvolumescales	= size
		_node.selectionvolumetype	= "box"
	else
		local offset = px and py and pz and (px.." "..py.." "..pz) or "0 0 0"
		local size = x and (x.." "..x.." "..x) or "0 0 0"
		_node.collisionvolumeoffsets	= offset
		_node.collisionvolumescales	= size
		_node.collisionvolumetype	= "sphere"
		_node.selectionvolumeoffsets	= offset
		_node.selectionvolumescales	= size
		_node.selectionvolumetype	= "sphere"
	end
	local aproxSize = x*0.1
	_node.footprintx = aproxSize
	_node.footprintz = aproxSize
end
newNode("corcatt4_leftpod")
setNodeSize(65)

return epic_catapult