local armorDefs = {
	commanders = {
		"armcom",
		"armcomlvl2",
		"armcomlvl3",
		"armcomlvl4",
		"armcomlvl5",
		"armcomlvl6",
		"armcomlvl7",
		"armcomlvl8",
		"armcomlvl9",
		"armcomlvl10",
		"armdecom",
		"armdecomlvl3",
		"armdecomlvl6",
		"armdecomlvl10",
		"armcomcon",
		"comeffigylvl1",
		"comeffigylvl2",
		"comeffigylvl3",
		"comeffigylvl4",
		"comeffigylvl5",
		"corcom",
		"corcomlvl2",
		"corcomlvl3",
		"corcomlvl4",
		"corcomlvl5",
		"corcomlvl6",
		"corcomlvl7",
		"corcomlvl8",
		"corcomlvl9",
		"corcomlvl10",
		"cordecom",
		"cordecomlvl3",
		"cordecomlvl6",
		"cordecomlvl10",
		"corcomcon",
		"legdecom",
		"legdecomlvl3",
		"legdecomlvl6",
		"legdecomlvl10",
		"legcom",
		"legcomlvl2",
		"legcomlvl3",
		"legcomlvl4",
		"legcomlvl5",
		"legcomlvl6",
		"legcomlvl7",
		"legcomlvl8",
		"legcomlvl9",
		"legcomlvl10",
	},
	scavboss = {
		"armcomboss",
		"corcomboss",
		"scavengerbossv4_veryeasy",
		"scavengerbossv4_easy",
		"scavengerbossv4_normal",
		"scavengerbossv4_hard",
		"scavengerbossv4_veryhard",
		"scavengerbossv4_epic",
	},
	indestructable = {
		"xmasball1_1",
		"xmasball1_2",
		"xmasball1_3",
		"xmasball1_4",
		"xmasball1_5",
		"xmasball1_6",
		"xmasball2_1",
		"xmasball2_2",
		"xmasball2_3",
		"xmasball2_4",
		"xmasball2_5",
		"xmasball2_6",
		"armstone",
		"corstone",
		"legstone",
		"dice",
		"chip",
		"legmohoconin",
	},
	crawlingbombs = {
		"armvader",
		"corroach",
		"legsnapper",
		"corsktl",
	},
	standard = {
		"armjuno",
		"armageo",
		"armaak",
		"armack",
		"armacv",
		"armadvsol",
		"armah",
		"armamex",
		"armamph",
		"armanac",
		"armap",
		"armasp",
		"armfasp",
		"armbrtha",
		"armch",
		"armck",
		"armclaw",
		"armcv",
		"armdf",
		"armdrag",
		"armemp",
		"armestor",
		"armfark",
		"armfast",
		"armfatf",
		"armfav",
		"armfdrag",
		"armfgate",
		"armfhlt",
		"armfhp",
		"armfido",
		"armflash",
		"armflea",
		"armfmkr",
		"armfort",
		"armfrt",
		"armgate",
		"armgeo",
		"armgmm",
		"armgremlin",
		"armham",
		"armhlt",
		"armhp",
		"armjanus",
		"armjeth",
		"armlab",
		"armlatnk",
		"armllt",
		"armlwall",
		"armmakr",
		"armmanni",
		"armmart",
		"armmav",
		"armmerl",
		"armmex",
		"armmh",
		"armmmkr",
		"armmoho",
		"armmstor",
		"armpb",
		"armplat",
		"armpw",
		"armrectr",
		"armrl",
		"armrock",
		"armsam",
		"armscab",
		"armsd",
		"armsh",
		"armshockwave",
		"armsnipe",
		"armsolar",
		"armspid",
		"armsptk",
		"armstump",
		"armsy",
		"armtarg",
		"armthovr",
		"armtide",
		"armuwes",
		"armuwfus",
		"armuwmme",
		"armuwmmm",
		"armuwms",
		"armvp",
		"armvulc",
		"armwin",
		"armzeus",
		"armamsub",
		"corjuno",
		"legjuno",
		"corageo",
		"legageo",
		"armconsul",
		"legafcv",
		"coraak",
		"legadvaabot",
		"corack",
		"coracv",
		"coradvsol",
		"corah",
		"corak",
		"corap",
		"corasp",
		"corfasp",
		"corbhmth",
		"legrampart",
		"corbuzz",
		"corcan",
		"corch",
		"corck",
		"corcrash",
		"legaabot",
		"corcv",
		"cordrag",
		"corestor",
		"corfast",
		"corfatf",
		"corfav",
		"corfdrag",
		"corfgate",
		"corfhlt",
		"legfmg",
		"corfhp",
		"corfmkr",
		"legfeconv",
		"corforge",
		"corfort",
		"corfrt",
		"legfrl",
		"corftiger",
		"corgate",
		"corgator",
		"corgeo",
		"corhlt",
		"corhp",
		"corhrk",
		"corint",
		"corlab",
		"corllt",
		"cormabm",
		"cormakr",
		"cormart",
		"cormaw",
		"cormex",
		"cormh",
		"cormist",
		"cormmkr",
		"cormoho",
		"cormort",
		"cormstor",
		"cormwall",
		"legrwall",
		"cornecro",
		"legrezbot",
		"corplat",
		"corphantom",
		"corprinter",
		"corvac",
		"corvacct",
		"corraid",
		"correap",
		"corrl",
		"corsd",
		"corsh",
		"corsnap",
		"corsolar",
		"corstorm",
		"corsy",
		"cortarg",
		"cortermite",
		"corthovr",
		"cortorch",
		"corthud",
		"cortide",
		"legtide",
		"cortron",
		"coruwes",
		"coruwfus",
		"coruwmme",
		"coruwmmm",
		"coruwms",
		"leguwestore",
		"leguwmstore",
		"corvipe",
		"corvp",
		"corvroc",
		"corwin",
		"corwolv",
		"coramsub",
		"corhllt",
		"armmercury",
		"corhal",
		"corscreamer",
		"armbeamer",
		"armart",
		"corban",
    	"armbeaver",
		"armcroc",
		"armpincer",
		"coramph",
		"corgarp",
		"cormuskrat",
		"corparrow",
		"corseal",
		"corsala",
		"corintr",
		"armmar",
		"corshiva",
        "cormadsam",
		"armferret",
        "armwar",
		"corexp",
		"corlevlr",
		"cormexp",
        "armspy",
		"cormando",
		"corspy",
		"legaspy",
        "armdl",
		"cordl",
		"legctl",
        "armfflak",
		"armflak",
		"armyork",
		"corenaa",
		"corflak",
		"corsent",
        "armmlv",
		"cormlv",
		"legmlv",
		"corpyro",
        "armarad",
		"armaser",
		"armason",
		"armeyes",
		"armfrad",
		"armjam",
		"armjamt",
		"armmark",
		"armrad",
		"armseer",
		"armsonar",
		"armveil",
		"corarad",
		"corason",
		"coreter",
		"coreyes",
		"corfrad",
		"legfrad",
		"corjamt",
		"corrad",
		"corshroud",
		"corsonar",
		"corspec",
		"corvoyr",
		"corvrad",
		"armafus",
		"armaap",
		"armalab",
		"armamd",
		"armasy",
		"armavp",
		"armbull",
		"armckfus",
		"armfboy",
		"armfus",
		"armshltx",
		"armsilo",
		"corafus",
		"coraap",
		"coralab",
		"corasy",
		"coravp",
		"corfmd",
		"corfus",
		"corgant",
		"corgol",
		"corsilo",
		"corsumo",
		"cortrem",
		"armbanth",
		"corcat",
		"armraz",
		"armvang",
		"corkarg",
		"armamb",
		"armguard",
		"corpun",
		"cortoast",
		"armanni",
		"cordoom",
		"corkorg",
		"corjugg",
		"armtl",
		"cortl",
		"legtl",
		"armatl",
		"coratl",
		"armcir",
		"armuwadves",
		"armuwadvms",
		"corerad",
		"coruwadves",
		"coruwadvms",
		"corgatreap",

		"armpwt4",
		"armrattet4",
		"armvadert4",
		"corkarganetht4",
		"armassimilator",
		"armlunchbox",
		"armmeatball",
		"armsptkt4",
		"cordemon",
		"corgolt4",

		"scavmist",
		"scavmistxl",
		"scavmistxxl",

		"armapt3",
		"corapt3",
		"legapt3",
		"legjam",
		"legrad",
		"leglht",
		"leglupara",
		"legdtr",
		"legcluster",
		"legbastion",
		"legbombard",
		"legapopupdef",
		"legperdition",
		"legstarfall",
		"legflak",
		"legsolar",
		"legadvsol",
		"legrl",
		"legrhapsis",
		"legsilo",
		"legfus",

		"coruwgeo",
		"leguwgeo",
		"coruwageo",
		"armuwgeo",
		"armuwageo",
		"legamphlab",

		"legcv",
		"legck",
		"legotter",
		"legacv",
		"legack",
		"legavrad",
		"legavjam",

		"legah",
		"legmh",
		"legner",
		"legsh",
		"leghp",
		"legfhp",
		"legch",
		"legeyes",
		"legjav",
		"legbunk",
		"legerailtank",
		"legeheatraymech",
		"legelrpcmech",
		"legeshotgunmech",
		"legdrag",
		"scavdrag",
		"scavfort",
		"legmohocon",
		"legmohoconct",
		"leghrk",
		"legfdrag"
	},
	mines = {
		"armfmine3",
		"armmine1",
		"armmine2",
		"armmine3",
		"corfmine3",
		"cormine1",
		"cormine2",
		"cormine3",
		"cormine4",
		"legmine1",
		"legmine2",
		"legmine3",
	},
	nanos = {
		"armnanotc",
		"cornanotc",
		"armnanotcplat",
		"cornanotcplat",
		"legnanotc",
		"legnanotcplat",
	},
	vtol = {
		"armhvytrans",
		"corhvytrans",
		"raptors3",
		"armaca",
		"armca",
		"armcsa",
		"armdfly",
		"armpeep",
		"armseap",
		"corseah",
		"coraca",
		"corca",
		"corcsa",
		"corfink",
		"corseap",
        "armawac",
		"armsehak",
		"corawac",
		"corhunt",
        "armatlas",
		"corvalk",
        "armbrawl",
		"armkam",
		"armkam2",
		"armsaber",
        "armblade",
		"corbw",
		"corape",
		"corcrw",
		"corcrwh",
		"corcut",
		"corcrwt4",
		"armfepocht4",
		"corfblackhyt4",
		"cordronecarryair",
		"armthundt4",
		"armassistdrone",
		"corassistdrone",
		"legassistdrone",
		"legmos",
		"legmost3",
		"legfort",
		"legfortt4",
		"legca",
		"legaca",
		"armdrone",
		"armtdrone",
		"cordrone",
		"cortdrone",
		"armdroneold",
		"cordroneold",
		"legdrone",
		"legheavydrone",
		"legheavydronesmall",
		"raptor_air_bomber_basic_t1_v1",
		"raptor_air_bomber_basic_t2_v1",
		"raptor_air_bomber_basic_t2_v2",
		"raptor_air_bomber_basic_t4_v1",
		"raptor_air_bomber_basic_t4_v2",
		"raptor_air_bomber_emp_t2_v1",
		"raptor_air_bomber_acid_t2_v1",
		"armthund",
		"corshad",
		"armliche",
		"armlichet4",
		"armlance",
		"armpnix",
		"armsb",
		"armstil",
		"corhurc",
		"corsb",
		"cortitan",
		"cords",
		"legnap",
		"legkam",
		"legcib",
		"legatrans",
		"leglts",
		"legmineb",
		"raptor_air_kamikaze_basic_t2_v1",
		"raptor_air_bomber_brood_t4_v2",
		"raptor_air_bomber_brood_t4_v3",
		"raptor_air_bomber_brood_t4_v4",
		"raptor_air_fighter_basic_t1_v1",
		"raptor_air_fighter_basic_t2_v1",
		"raptor_air_fighter_basic_t2_v2",
		"raptor_air_fighter_basic_t2_v3",
		"raptor_air_fighter_basic_t2_v4",
		"raptor_air_fighter_basic_t4_v1",
		"raptor_air_scout_basic_t2_v1",
		"raptor_air_scout_basic_t3_v1",
		"raptor_air_scout_basic_t4_v1",
		"armfig",
		"corveng",
		"armhawk",
		"armsfig",
		"armsfig2",
		"corsfig",
		"corsfig2",
		"corvamp",
		"legfig",
		"legionnaire",
		"legafigdef",
		"legvenator",
		"legphoenix",
		"legstronghold",
		"legwhisper",
		"legatorpbomber",
		"critter_gull",
		"armfify",
	},
	shields = {
		-- Intentionally left blank. To be used in shield weapondefs only!
	},
	lboats = {
		"corpt",
		"armpt",
		"armpship",
		"corpship",
		"armcs",
		"armmls",
		"armsjam",
		"corcs",
		"coresupp",
		"cormls",
		"armdecade",
		"corsjam",
		"legcs",
		"legvelite",
		"leghastatus",
		"leghastatusalt",
		"legoptio",
		"legpontus",
	},

	hvyboats = {
		"armroy",
		"corroy",
		"legtriarius",
		"legtriariusheatray",
		"legtriariusdrone",
		"legportent",
		"corarch",
		"armaas",
		"armcrus",
		"armmship",
		"corcrus",
		"cormship",
		"armcarry",
		"corcarry",
		"armtship",
		"cortship",
		"armbats",
		"corbats",
		"armepoch",
		"corprince",
		"corblackhy",
	},

	subs = {
		"armsub",
		"corsub",
		"legstingray",
        "armsubk",
		"corshark",
        "corssub",
		"armserp",
		"armacsub",
        "coracsub",
		"armrecl",
		"correcl",
		"coronager",
		"cordesolator",
		"armexcalibur",
		"armseadragon",
	},

	raptor =
	{
		"raptor_land_swarmer_basic_t2_v1",
		"raptor_land_swarmer_basic_t2_v2",
		"raptor_land_swarmer_basic_t2_v3",
		"raptor_land_swarmer_basic_t2_v4",
		"raptor_land_swarmer_basic_t3_v1",
		"raptor_land_swarmer_basic_t3_v2",
		"raptor_land_swarmer_basic_t3_v3",
		"raptor_land_swarmer_basic_t4_v1",
		"raptor_land_swarmer_basic_t4_v2",
		"raptor_land_kamikaze_basic_t2_v1",
		"raptor_land_kamikaze_basic_t4_v1",
		"raptor_land_assault_basic_t2_v1",
		"raptor_land_assault_basic_t2_v2",
		"raptor_land_assault_basic_t2_v3",
		"raptor_land_assault_basic_t4_v1",
		"raptor_land_assault_basic_t4_v2",
		"raptorc2",
		"raptor_allterrain_swarmer_basic_t2_v1",
		"raptor_allterrain_swarmer_basic_t3_v1",
		"raptor_allterrain_swarmer_basic_t4_v1",
		"raptor_turret_basic_t2_v1",
		"raptor_turret_basic_t3_v1",
		"raptor_allterrain_arty_basic_t2_v1",
		"raptor_allterrain_arty_basic_t4_v1",
		"raptor_land_swarmer_brood_t4_v1",
		"raptor_land_swarmer_brood_t3_v1",
		"raptor_land_swarmer_brood_t2_v1",
		"raptorh5",
		"raptorr3",
		"raptor_land_spiker_basic_t2_v1",
		"raptor_land_spiker_basic_t4_v1",
		"raptor_land_swarmer_fire_t2_v1",
		"raptor_land_swarmer_fire_t4_v1",
		"raptor_allterrain_swarmer_fire_t2_v1",
		"raptor_land_swarmer_heal_t1_v1",
		"raptor_land_swarmer_heal_t2_v1",
		"raptor_land_swarmer_heal_t3_v1",
		"raptor_land_swarmer_heal_t4_v1",
		"raptorh1b",
		"raptor_allterrain_swarmer_acid_t2_v1",
		"raptor_allterrain_arty_acid_t2_v1",
		"raptor_allterrain_assault_acid_t2_v1",
		"raptor_land_swarmer_acids_t2_v1",
		"raptor_land_swarmer_emp_t2_v1",
		"raptor_land_assault_emp_t2_v1",
		"raptor_allterrain_arty_emp_t2_v1",
		"raptor_allterrain_swarmer_emp_t2_v1",
		"raptor_hive",
		"raptor_antinuke",
	},
	raptorqueen =
	{
		"raptor_queen_veryeasy",
		"raptor_queen_easy",
		"raptor_queen_normal",
		"raptor_queen_hard",
		"raptor_queen_veryhard",
		"raptor_queen_epic",
	},
}

-- add scavenger variants
local scavArmorDefs = {}
for category, names in pairs(armorDefs) do
	local nameCount = #names
	for _, name in pairs(names) do
		if scavArmorDefs[category] == nil then
			scavArmorDefs[category] = {}
		end

		nameCount = nameCount + 1
		scavArmorDefs[category][nameCount] = name .. '_scav'
	end
end

table.mergeInPlace(armorDefs, scavArmorDefs)

return armorDefs
