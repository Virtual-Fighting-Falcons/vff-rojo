local function joinTbl(orig, to, from)
	for i, value in ipairs(orig) do									
		to[i] = value
	end
	for i, value in ipairs(from) do									
		table.insert(to, value)
	end
	return to
end

local midAdapterAddMass = -79.8
local midPylonAddMass = -82.5

local tips		= {		-- 1,9
	{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",	Cx_gain = 0.32},					-- AIM-9M
	{ CLSID = "{AIM-9L}",								Cx_gain = 0.32},					-- AIM-9L
	{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}",	Cx_gain = 0.32},					-- AIM-9X
	{ CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}",	Cx_gain = 0.33},					-- AIM-120B
	{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",	Cx_gain = 0.33},					-- AIM-120C
	{ CLSID = "CATM-9M",								Cx_gain = 0.32},					-- CATM-9M
	{ CLSID = "{AIS_ASQ_T50}", attach_point_position = {0.25,  0.0,  0.0}, Cx_gain = 0.32},	-- ACMI pod
}

local outer 	= {		-- 2,8
	{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",	Cx_gain = 0.4},						-- AIM-9M
	{ CLSID = "{AIM-9L}",								Cx_gain = 0.4},						-- AIM-9L
	{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}",	Cx_gain = 0.4},						-- AIM-9X
	{ CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}",	Cx_gain = 0.33},					-- AIM-120B
	{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",	Cx_gain = 0.33},					-- AIM-120C
	{ CLSID = "CATM-9M",								Cx_gain = 0.4},						-- CATM-9M
	{ CLSID = "{AIS_ASQ_T50}", attach_point_position = {0.25,  0.0,  0.0}, Cx_gain = 0.4},	-- ACMI pod
	{ CLSID = "<CLEAN>",								arg_value = 1, add_mass = -51.3},						-- Clean
}

local middle	= {		-- 3,7
	-- Adapter similar to 2,8 is needed
	{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",						Cx_gain = 0.4,	arg_value = 0.5, add_mass = midAdapterAddMass},	-- AIM-9M
	{ CLSID = "{AIM-9L}",													Cx_gain = 0.4,	arg_value = 0.5, add_mass = midAdapterAddMass},	-- AIM-9L
	{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}",						Cx_gain = 0.4,	arg_value = 0.5, add_mass = midAdapterAddMass},	-- AIM-9X
	{ CLSID = "{C8E06185-7CD6-4C90-959F-044679E90751}",						Cx_gain = 0.33,	arg_value = 0.5, add_mass = midAdapterAddMass},	-- AIM-120B
	{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}",						Cx_gain = 0.33,	arg_value = 0.5, add_mass = midAdapterAddMass},	-- AIM-120C
	{ CLSID = "CATM-9M",													Cx_gain = 0.4,	arg_value = 0.5, add_mass = midAdapterAddMass},	-- CATM-9M
	{ CLSID = "{AIS_ASQ_T50}", attach_point_position = {0.25,  0.0,  0.0},	Cx_gain = 0.4,	arg_value = 0.5, add_mass = midAdapterAddMass},	-- ACMI pod
	-- Normal wing pylon
	{ CLSID = "LAU3_WP156"},										-- 
	{ CLSID = "LAU3_WP1B"},											-- 
	{ CLSID = "LAU3_WP61"},											-- 
	{ CLSID = "LAU3_HE5"},											-- 
	{ CLSID = "LAU3_HE151"},										-- 

	{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", Cx_gain = 1.0		},			-- Mk-82
	{ CLSID	= "{Mk82SNAKEYE}",							Cx_gain = 1.4		},			-- Mk-82 SNAKEYE
	{ CLSID	= "{Mk82AIR}",								Cx_gain = 1.4		},			-- Mk-82 AIR
	{ CLSID = "{TER_9A_3*MK-82}",						Cx_gain_item = 1.8	},		-- TER-9A + 3*MK-82
	{ CLSID = "{TER_9A_3*MK-82_Snakeye}",				Cx_gain_item = 1.57	},		-- TER-9A + 3*MK-82 SNAKEYE
	{ CLSID = "{TER_9A_3*MK-82AIR}",					Cx_gain_item = 1.57	},		-- TER-9A + 3*MK-82 AIR
	{ CLSID	= "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}", Cx_gain = 0.8		},			-- Mk-84

	{ CLSID	= "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}", Cx_gain = 1.0		},			-- GBU-10
	{ CLSID	= "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", Cx_gain = 0.62		},			-- GBU-12

	{ CLSID = "{CBU-87}",								Cx_gain = 2.18		},			-- CBU-87
	{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}",	Cx_gain = 2.18		},			-- CBU-97

	{ CLSID = "{TER_9A_3*BDU-33}"										},			-- TER-9A + 3*BDU-33

	{ CLSID = "{444BA8AE-82A7-4345-842E-76154EFCCA46}",						  Cx_gain_item = 0.41	},		-- LAU-117 + AGM-65D
	{ CLSID = "LAU_117_AGM_65G",											  Cx_gain_item = 0.41	},		-- LAU-117 + AGM-65G
	{ CLSID = "LAU_117_AGM_65H",											  Cx_gain_item = 0.41	},		-- LAU-117 + AGM-65H
	{ CLSID = "{69DC8AE7-8F77-427B-B8AA-B19D3F478B66}",						  Cx_gain_item = 0.41	},		-- LAU-117 + AGM-65K
	{ CLSID = "LAU_88_AGM_65D_ONE",						Cx_gain_empty = 0.37, Cx_gain_item = 0.67	}, 		-- LAU-88 AGM-65D*1
	{ CLSID = "{DAC53A2F-79CA-42FF-A77A-F5649B601308}",	Cx_gain_empty = 0.37, Cx_gain_item = 0.67	},		-- LAU-88 AGM-65D*3
	{ CLSID = "LAU_88_AGM_65H",							Cx_gain_empty = 0.37, Cx_gain_item = 0.67	}, 		-- LAU-88 AGM-65H*1
	{ CLSID = "LAU_88_AGM_65H_3",						Cx_gain_empty = 0.37, Cx_gain_item = 0.67	}, 		-- LAU-88 AGM-65H*3
	
	{ CLSID = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C93}",						  Cx_gain_item = 0.4	},      -- LAU-118 + AGM-88

	{ CLSID = "MXU-648-TP"},																	--MXU-648 Travel Pod
	{ CLSID = "<CLEAN>",								arg_value = 1, add_mass = -131.1 },		-- Clean
}
local middleLeft = {}	-- 3 left
joinTbl(middle, middleLeft,{
	{ CLSID = "{TER_9A_2L*MK-82}",						Cx_gain_item = 1.8	},			-- TER-9A + 2*MK-82
	{ CLSID = "{TER_9A_2L*MK-82_Snakeye}", 				Cx_gain_item = 1.57	},			-- TER-9A + 2*MK-82 SNAKEYE
	{ CLSID = "{TER_9A_2L*MK-82AIR}",					Cx_gain_item = 1.57	},			-- TER-9A + 2*MK-82 AIR
	{ CLSID = "{TER_9A_2L*GBU-12}",						Cx_gain_item = 1.2	},			-- TER-9A + 2*GBU-12
	
	{ CLSID = "{TER_9A_2L*CBU-87}",						Cx_gain_item = 2.66	},			-- TER-9A + 2*CBU-87
	{ CLSID = "{TER_9A_2L*CBU-97}",						Cx_gain_item = 2.66	},			-- TER-9A + 2*CBU-97

	{ CLSID = "{E6A6262A-CA08-4B3D-B030-E1A993B98452}",	Cx_gain_empty = 0.37, Cx_gain_item = 0.67	},		-- LAU-88 AGM-65D*2
	{ CLSID = "LAU_88_AGM_65H_2_L",						Cx_gain_empty = 0.37, Cx_gain_item = 0.67	},		-- LAU-88 AGM-65H*2
	})
local middleRight = {}	-- 7 right
joinTbl(middle, middleRight,{
	{ CLSID = "{TER_9A_2R*MK-82}",						Cx_gain_item = 1.8	},			-- TER-9A + 2*MK-82
	{ CLSID = "{TER_9A_2R*MK-82_Snakeye}", 				Cx_gain_item = 1.57	},			-- TER-9A + 2*MK-82 SNAKEYE
	{ CLSID = "{TER_9A_2R*MK-82AIR}",					Cx_gain_item = 1.57	},			-- TER-9A + 2*MK-82 AIR
	{ CLSID = "{TER_9A_2R*GBU-12}",						Cx_gain_item = 1.2	},			-- TER-9A + 2*GBU-12
	
	{ CLSID = "{TER_9A_2R*CBU-87}",						Cx_gain_item = 2.66	},			-- TER-9A + 2*CBU-87
	{ CLSID = "{TER_9A_2R*CBU-97}",						Cx_gain_item = 2.66	},			-- TER-9A + 2*CBU-97
	
	{ CLSID = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}",	Cx_gain_empty = 0.37, Cx_gain_item = 0.67	},		-- LAU-88 AGM-65D*2
	{ CLSID = "LAU_88_AGM_65H_2_R",						Cx_gain_empty = 0.37, Cx_gain_item = 0.67	},		-- LAU-88 AGM-65H*2
})

local inner		= {		-- 4,6
	{ CLSID = "LAU3_WP156",														arg_value = 0.5, add_mass = midPylonAddMass},					-- 
	{ CLSID = "LAU3_WP1B",														arg_value = 0.5, add_mass = midPylonAddMass},					-- 
	{ CLSID = "LAU3_WP61",														arg_value = 0.5, add_mass = midPylonAddMass},					-- 
	{ CLSID = "LAU3_HE5",														arg_value = 0.5, add_mass = midPylonAddMass},					-- 
	{ CLSID = "LAU3_HE151",														arg_value = 0.5, add_mass = midPylonAddMass},					-- 

	{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", Cx_gain = 1.0,			arg_value = 0.5, add_mass = midPylonAddMass},		-- Mk-82
	{ CLSID	= "{Mk82SNAKEYE}",							Cx_gain = 1.4,			arg_value = 0.5, add_mass = midPylonAddMass},		-- Mk-82 SNAKEYE
	{ CLSID	= "{Mk82AIR}",								Cx_gain = 1.4, 			arg_value = 0.5, add_mass = midPylonAddMass},		-- Mk-82 AIR
	{ CLSID = "{TER_9A_3*MK-82}",						Cx_gain_item = 1.8,		arg_value = 0.5, add_mass = midPylonAddMass},		-- TER-9A + 3*MK-82
	{ CLSID = "{TER_9A_3*MK-82_Snakeye}", 				Cx_gain_item = 1.57,	arg_value = 0.5, add_mass = midPylonAddMass},		-- TER-9A + 3*MK-82 SNAKEYE
	{ CLSID = "{TER_9A_3*MK-82AIR}",					Cx_gain_item = 1.57,	arg_value = 0.5, add_mass = midPylonAddMass},		-- TER-9A + 3*MK-82 AIR
	{ CLSID	= "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}",	Cx_gain = 0.8,			arg_value = 0.5, add_mass = midPylonAddMass},		-- Mk-84
	{ CLSID	= "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}", Cx_gain = 1.0,			arg_value = 0.5, add_mass = midPylonAddMass},		-- GBU-10
	{ CLSID	= "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", Cx_gain = 0.62,			arg_value = 0.5, add_mass = midPylonAddMass},		-- GBU-12

	{ CLSID = "{CBU-87}",								Cx_gain = 2.18,			arg_value = 0.5, add_mass = midPylonAddMass},			-- CBU-87
	{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}",	Cx_gain = 2.18,			arg_value = 0.5, add_mass = midPylonAddMass},			-- CBU-97
	{ CLSID = "{TER_9A_3*CBU-87}",						Cx_gain_item = 2.66,	arg_value = 0.5, add_mass = midPylonAddMass},			-- TER-9A + 3*CBU-87
	{ CLSID = "{TER_9A_3*CBU-97}",						Cx_gain_item = 2.66,	arg_value = 0.5, add_mass = midPylonAddMass},			-- TER-9A + 3*CBU-97

	{ CLSID = "{TER_9A_3*BDU-33}",												arg_value = 0.5, add_mass = midPylonAddMass},			-- TER-9A + 3*BDU-33

	{ CLSID = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}" },			-- 370 gallon Fuel tank
	{ CLSID = "MXU-648-TP",														arg_value = 0.5, add_mass = midPylonAddMass},				--MXU-648 Travel Pod
	{ CLSID = "<CLEAN>",														arg_value = 1,	 add_mass = -133.8},					-- Clean
}
local innerLeft = {}	-- 4 left
joinTbl(inner, innerLeft,{
	{ CLSID = "{TER_9A_2L*MK-82}",						Cx_gain_item = 1.8,		arg_value = 0.5, add_mass = midPylonAddMass},		-- TER-9A + 2*MK-82
	{ CLSID = "{TER_9A_2L*MK-82_Snakeye}",				Cx_gain_item = 1.57,	arg_value = 0.5, add_mass = midPylonAddMass},		-- TER-9A + 2*MK-82 SNAKEYE
	{ CLSID = "{TER_9A_2L*MK-82AIR}",					Cx_gain_item = 1.57,	arg_value = 0.5, add_mass = midPylonAddMass},		-- TER-9A + 2*MK-82 AIR

	{ CLSID = "{TER_9A_2L*CBU-87}",						Cx_gain_item = 2.66,	arg_value = 0.5, add_mass = midPylonAddMass},			-- TER-9A + 2*CBU-87
	{ CLSID = "{TER_9A_2L*CBU-97}",						Cx_gain_item = 2.66,	arg_value = 0.5, add_mass = midPylonAddMass},			-- TER-9A + 2*CBU-97
	})
local innerRight = {}	-- 6 right
joinTbl(inner, innerRight,{
	{ CLSID = "{TER_9A_2R*MK-82}",						Cx_gain_item = 1.8,		arg_value = 0.5, add_mass = midPylonAddMass},		-- TER-9A + 2*MK-82
	{ CLSID = "{TER_9A_2R*MK-82_Snakeye}",				Cx_gain_item = 1.57,	arg_value = 0.5, add_mass = midPylonAddMass},		-- TER-9A + 2*MK-82 SNAKEYE
	{ CLSID = "{TER_9A_2R*MK-82AIR}",					Cx_gain_item = 1.57,	arg_value = 0.5, add_mass = midPylonAddMass},		-- TER-9A + 2*MK-82 AIR

	{ CLSID = "{TER_9A_2R*CBU-87}",						Cx_gain_item = 2.66,	arg_value = 0.5, add_mass = midPylonAddMass},			-- TER-9A + 2*CBU-87
	{ CLSID = "{TER_9A_2R*CBU-97}",						Cx_gain_item = 2.66,	arg_value = 0.5, add_mass = midPylonAddMass},			-- TER-9A + 2*CBU-97
})

local fuselageLeft	= {		-- 5L
}

local fuselageRight	= {		-- 5R
	{ CLSID = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}",		arg_value = 0.0},			--Litening
}

local centerline	= {		-- 5
	{ CLSID = "{8A0BE8AE-58D4-4572-9263-3144C0D06364}" },			-- 300 gallon Fuel tank
	{ CLSID = "MXU-648-TP" },										--MXU-648 Travel Pod
	{ CLSID = "<CLEAN>",								arg_value = 1, 				add_mass = -78.9},			-- Clean
}

local F_16C =  {
	Name 				=   'F-16C_50',

	shape_table_data	= 
	{
		{
			file		= "f-16c_bl50";
			username	= "F-16C_50";
			index		= WSTYPE_PLACEHOLDER;
			life		= 20;
			vis			= 3;
			desrt		= "F-16C_destr";
			fire		= { 300, 2};
			classname	= "lLandPlane";
			positioning	= "BYNORMAL";
		},
		{
			name	= "F-16C_destr";
			file	= "f-16c-oblomok";
			fire	= { 0, 1};
		}
	},

	country_of_origin = "USA",

	Picture = "F-16C.png",
	DisplayName			=	_("F-16CM bl.50"),
	mapclasskey			=	"P0091000024",
	WorldID				=	WSTYPE_PLACEHOLDER,
	attribute			=	{wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER, "Multirole fighters", "Refuelable", "Datalink", "Link16"},
	Categories			=	{"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	CanopyGeometry		=	makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_GOOD),
	Rate				=	50,

	-- Countermeasures, 
	passivCounterm = {
		CMDS_Edit = true,
		SingleChargeTotal = 120,
		chaff = {default = 60, increment = 30, chargeSz = 1},
		flare = {default = 60, increment = 30, chargeSz = 1}
	},
	Sensors = {
		RADAR = "AN/APG-68",
		RWR = "Abstract RWR"
	},
	EPLRS = true,

	HumanRadio = {
		frequency		= 305.0,
		editable		= true,
		minFrequency	=  30.000,
		maxFrequency	= 399.975,
		rangeFrequency = {
			{min =  30.0, max =  87.975, modulation	= MODULATION_FM},
			{min = 116.0, max = 155.975, modulation	= MODULATION_AM},
			{min = 225.0, max = 399.975, modulation	= MODULATION_AM}
		},
		modulation	= MODULATION_AM,
	},
	panelRadio	= {
		[1] = {  
			name = _("COMM 1 (UHF) AN/ARC-164"),
			range = {
				{min = 225.0, max = 399.975, modulation	= MODULATION_AM}
			},
			channels = {
				[1] = { name = _("Channel 1"),		default = 305.0, connect = true}, -- default
				[2] = { name = _("Channel 2"),		default = 264.0},	-- min. water : 135.0, 264.0
				[3] = { name = _("Channel 3"),		default = 265.0},	-- nalchik : 136.0, 265.0
				[4] = { name = _("Channel 4"),		default = 256.0},	-- sochi : 127.0, 256.0
				[5] = { name = _("Channel 5"),		default = 254.0},	-- maykop : 125.0, 254.0
				[6] = { name = _("Channel 6"),		default = 250.0},	-- anapa : 121.0, 250.0
				[7] = { name = _("Channel 7"),		default = 270.0},	-- beslan : 141.0, 270.0
				[8] = { name = _("Channel 8"),		default = 257.0},	-- krasnodar-pashk. : 128.0, 257.0
				[9] = { name = _("Channel 9"),		default = 255.0},	-- gelenjik : 126.0, 255.0
				[10] = { name = _("Channel 10"),	default = 262.0},	-- kabuleti : 133.0, 262.0
				[11] = { name = _("Channel 11"),	default = 259.0},	-- gudauta : 130.0, 259.0
				[12] = { name = _("Channel 12"),	default = 268.0},	-- soginlug : 139.0, 268.0
				[13] = { name = _("Channel 13"),	default = 269.0},	-- vaziani : 140.0, 269.0
				[14] = { name = _("Channel 14"),	default = 260.0},	-- batumi : 131.0, 260.0
				[15] = { name = _("Channel 15"),	default = 263.0},	-- kutaisi : 134.0, 263.0
				[16] = { name = _("Channel 16"),	default = 261.0},	-- senaki : 132.0, 261.0
				[17] = { name = _("Channel 17"),	default = 267.0},	-- lochini : 138.0, 267.0
				[18] = { name = _("Channel 18"),	default = 251.0},	-- krasnodar-center : 122.0, 251.0
				[19] = { name = _("Channel 19"),	default = 253.0},	-- krymsk : 124.0, 253.0
				[20] = { name = _("Channel 20"),	default = 266.0},	-- mozdok : 137.0, 266.0
			}
		},
		[2] = {
			name = _("COMM 2 (VHF) AN/ARC-222"),
			range = {
				{min =  30.0, max =  87.975, modulation	= MODULATION_FM},	-- FM
				{min = 116.0, max = 155.975, modulation	= MODULATION_AM}	-- AM
			},
			channels = {
				[1] = { name = _("Channel 1"),		default = 127.0, connect = true},	-- default
				[2] = { name = _("Channel 2"),		default = 135.0},	-- min. water : 135.0, 264.0
				[3] = { name = _("Channel 3"),		default = 136.0},	-- nalchik : 136.0, 265.0
				[4] = { name = _("Channel 4"),		default = 127.0},	-- sochi : 127.0, 256.0
				[5] = { name = _("Channel 5"),		default = 125.0},	-- maykop : 125.0, 254.0
				[6] = { name = _("Channel 6"),		default = 121.0},	-- anapa : 121.0, 250.0
				[7] = { name = _("Channel 7"),		default = 141.0},	-- beslan : 141.0, 270.0
				[8] = { name = _("Channel 8"),		default = 128.0},	-- krasnodar-pashk. : 128.0, 257.0
				[9] = { name = _("Channel 9"),		default = 126.0},	-- gelenjik : 126.0, 255.0
				[10] = { name = _("Channel 10"),	default = 133.0},	-- kabuleti : 133.0, 262.0
				[11] = { name = _("Channel 11"),	default = 130.0},	-- gudauta : 130.0, 259.0
				[12] = { name = _("Channel 12"),	default = 139.0},	-- soginlug : 139.0, 268.0
				[13] = { name = _("Channel 13"),	default = 140.0},	-- vaziani : 140.0, 269.0
				[14] = { name = _("Channel 14"),	default = 131.0},	-- batumi : 131.0, 260.0
				[15] = { name = _("Channel 15"),	default = 134.0},	-- kutaisi : 134.0, 263.0
				[16] = { name = _("Channel 16"),	default = 132.0},	-- senaki : 132.0, 261.0
				[17] = { name = _("Channel 17"),	default = 138.0},	-- lochini : 138.0, 267.0
				[18] = { name = _("Channel 18"),	default = 122.0},	-- krasnodar-center : 122.0, 251.0
				[19] = { name = _("Channel 19"),	default = 124.0},	-- krymsk : 124.0, 253.0
				[20] = { name = _("Channel 20"),	default = 137.0},	-- mozdok : 137.0, 266.0
			}
		},
	},
	TACAN_AA = true,

	Pylons = {
		pylon(1, 0, -2.2, 0.002, -4.739,
			{
				arg = 308,
				arg_value = 0,
				use_full_connector_position = true,
				connector = "Pylon1",
			},
			tips, 1
		),
		pylon(2, 0, -1.918, -0.454, -3.948000,
			{
				arg = 309,
				arg_value = 0,
				use_full_connector_position = true,
				connector = "Pylon2",
				mass = 51.3,
			},
			outer, 2
		),
		pylon(3, 0, -2.05, -0.505, -3.050000,
			{
				arg = 310,
				arg_value = 0,
				use_full_connector_position = true,
				connector = "Pylon3",
				mass = 131.1,
			},
			middleLeft, 3
		),
		pylon(4, 0, -1.053, -0.519, -1.813000,
			{
				arg = 311,
				arg_value = 0,
				use_full_connector_position = true,
				connector = "Pylon4",
				mass = 133.8,
			},
			innerLeft, 4
		),
		pylon(5, 0, -0.704, -1.173, 0.000000,
			{
				arg = 312,
				arg_value = 0,
				use_full_connector_position = true,
				connector = "Pylon5",
				DisplayName = _("5"),
				mass = 78.9,
			},
			centerline, 6
		),
		pylon(6, 0, -1.053, -0.519, 1.813000,
			{
				arg = 313,
				arg_value = 0,
				use_full_connector_position = true,
				connector = "Pylon6",
 				DisplayName = _("6"),
				mass = 133.8,
			},
			innerRight, 8
		),
		pylon(7, 0, -2.05, -0.505, 3.050000,
			{
				arg = 314,
				arg_value = 0,
				use_full_connector_position = true,
				connector = "Pylon7",
 				DisplayName = _("7"),
				mass = 131.1,
			},
			middleRight, 9
		),
		pylon(8, 0, -1.918, -0.454, 3.948000,
			{
				arg = 315,
				arg_value = 0,
				use_full_connector_position = true,
				connector = "Pylon8",
 				DisplayName = _("8"),
				mass = 51.3,
			},
			outer, 10
		),
		pylon(9, 0, -2.2, 0.002, 4.739,
			{
				arg = 316,
				arg_value = 0,
				use_full_connector_position = true,
				connector = "Pylon9",
				DisplayName = _("9"),
			},
			tips, 11
		),
		pylon(10, 0, 2.700000, -0.550000, 0.550000,
			{
				DisplayName = _("5L")
			},
			fuselageLeft, 5
		),
		pylon(11, 0, 2.700000, -0.550000, -0.550000,
			{
				arg = 318,
				arg_value = 1,
				use_full_connector_position = true,
				connector = "Pylon11",
				DisplayName = _("5R")
			},
			fuselageRight, 7
		),
		pylon(
			12,
			2,-- make it "hatch" station , it will be invisible until hatch is closed , it is always closed on Viper
			-6.053, 0.0, 0.0, -- Forward/Back, Up/Down, Right/Left. ---7.1, 0.1, -0.49,
			{
				connector = "disable",
				DisplayName = _("SMK")
			},
			{
				{ CLSID = "{INV-SMOKE-WHITE}" ,arg_increment = -0.1},
			}
		),
	},
	
	Guns = {
		gun_mount("M_61",
		{
			mixes = { 
				{1},		-- XM242 HEI-T
				{2},		-- M56 HEI
				{3},		-- M53 API
				{4,5},		-- M55 + M220 TP
				{6},		-- PGU-28/B SAPHEI
				{7,8},		-- PGU-27/B TP with tracers
			},
			count = 510
		},
		{
			supply_position			= {0.4, 0.55, 0.0},		-- approx
		})
	},
	ammo_type_default = 5, -- interface to set desired ammunition mix in ME (DCSCORE-1104)
	ammo_type ={
			_("HEI-T High Explosive Incendiary-Tracer"),
			_("HEI High Explosive Incendiary"),
			_("AP Armor Piercing"),
			_("TP Target Practice-Tracer"),
			_("SAPHEI High Explosive Armor Piercing PGU"),
			_("TP Target Practice-Tracer PGU"),
	},

	Tasks = {
		aircraft_task(CAP),
		aircraft_task(Escort),
		aircraft_task(FighterSweep),
		aircraft_task(Intercept),
		aircraft_task(PinpointStrike),
		aircraft_task(CAS),
		aircraft_task(GroundAttack),
		aircraft_task(RunwayAttack),
		aircraft_task(SEAD),
		aircraft_task(AFAC),
		aircraft_task(AntishipStrike),
		aircraft_task(Reconnaissance),
	},-- end of Tasks
	DefaultTask	=	aircraft_task(CAP),

	-------------------------
	M_empty						=	9026,--8853,
	M_nominal					=	11000,
	M_max						=	19187,
	M_fuel_max					=	3249,--3104,
	H_max						=	15240,
	CAS_min						=	60,
	V_opt						=	220,
	V_take_off					=	87,--65,			-- for 33k lbs
	V_land						=	72,--68,			-- for 25k lbs touchdown
	V_max_sea_level				=	408,
	V_max_h						=	588.9,
	Mach_max					=	2,
	Vy_max						=	250,
	Ny_min						=	-3,
	Ny_max						=	8,
	Ny_max_e					=	8,
	bank_angle_max				=	60,
	AOA_take_off				=	0.16,
	range						=	1500,
	average_fuel_consumption	=	0.245,
	thrust_sum_max				=	8054,
	thrust_sum_ab				=	13160,

	wing_area	=	28,
	wing_span	=	9.45,
	length		=	14.52,
	height		=	5.02,

	flaps_maneuver				=	1,
	stores_number				=	10,
	has_afteburner				=	true,
	has_speedbrake				=	true,
	brakeshute_name				=	0,
	radar_can_see_ground		=	true,
	RCS							=	4,
	detection_range_max			=	160,
	IR_emission_coeff			=	0.6,
	IR_emission_coeff_ab		=	3.0,
	air_refuel_receptacle_pos	=	{-0.051, 0.911, 0.0},
	tanker_type					=	1,

	wing_tip_pos				=	{-2.704, 0.307, 4.649},

	tand_gear_max								=	0.62487,
	nose_gear_pos								=	{2.268, -2.021, 0},	-- calc:{2.2,	-1.84,	0}	design:{2.268,	-2.025,	0}
	nose_gear_amortizer_direct_stroke			=	0.0,		-- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke			=	-0.244,		-- up
	nose_gear_amortizer_normal_weight_stroke	=	-0.146,		-- down from nose_gear_pos
	nose_gear_wheel_diameter					=	0.4572,

	main_gear_pos								=	{-1.803, -1.990, 1.094},	-- calc:{-1.79,	-1.89,	1.19}	design:{-1.803,	-1.971,	1.094}
	main_gear_amortizer_direct_stroke			=	0.0,		-- down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke			=	-0.240,		-- up
	main_gear_amortizer_normal_weight_stroke	=	-0.144,		-- down from main_gear_pos
	main_gear_wheel_diameter					=	0.70485,
	nose_gear_door_close_after_retract			=	false,
	main_gear_door_close_after_retract			=	false,

	engines_count	=	1,
	engines_nozzles	=
	{
			[1] =
			{
				pos					=	{-6.003,	0.261,	0},
				elevation			=	0,
				diameter			=	1.1,
				exhaust_length_ab	=	12,
				exhaust_length_ab_K	=	0.76,
				smokiness_level		=	0.05,
				afterburner_circles_count = 11,
				afterburner_circles_pos = {0.2, 0.8},
				afterburner_circles_scale = 1.0,
				afterburner_effect_texture = "afterburner_f-16c",
			}, -- end of [1]
	}, -- end of engines_nozzles

	crew_members =
	{
		[1] = 
		{
			ejection_seat_name	=	17,
			drop_canopy_name	=	23,
			canopy_pos			= {0,0,0},
			pos					=	{3.9,	1.4,	0},
		}, -- end of [1]
	}, -- end of crew_members

	mechanimations = "Default",

	-- add model draw args for network transmitting to this draw_args table (16 limit)
	net_animation = 
	{
		799,		-- canopy tint
	},

	fires_pos =
	{
		[1] =	{-0.707,	0.553,	-0.213},
		[2] =	{-0.037,	0.285,	1.391},
		[3] =	{-0.037,	0.285,	-1.391},
		[4] =	{-0.82,		0.265,	2.774},
		[5] =	{-0.82,		0.265,	-2.774},
		[6] =	{-0.82,		0.255,	4.274},
		[7] =	{-0.82,		0.255,	-4.274},
		[8] =	{-5.003,	0.261,	0},
		[9] =	{-5.003,	0.261,	0},
		[10] =	{-0.707,	0.453,	1.036},
		[11] =	{-0.707,	0.453,	-1.036},
	}, -- end of fires_pos

	effects_presets = {
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/F-16C_bl50_overwingVapor.lua"},
	},

	chaff_flare_dispenser = 
	{
		[1] = 
		{
			dir =	{0,	-1,	0},
			pos =	{-3.65, -0.5, -0.93},
		}, -- end of [1]
		[2] = 
		{
			dir =	{0,	-1,	0},
			pos =	{-3.91, -0.5, -0.93},
		}, -- end of [2]
		[3] = 
		{
			dir =	{0,	-1,	0},
			pos =	{-4.73, -0.5, -0.93},
		}, -- end of [3]
		[4] = 
		{
			dir =	{0,	-1,	0},
			pos =	{-4.73, -0.5,	0.93},
		}, -- end of [4]
	}, -- end of chaff_flare_dispenser
	
	Damage = verbose_to_dmg_properties({
		["NOSE_CENTER"]				= {args = {146},	critical_damage = 7},
		["COCKPIT"]					= {args = {65},		critical_damage = 1},
		["FUSELAGE_CENTER"]			= {args = {153},	critical_damage = 9},
		
		["WING_L_OUT"]				= {args = {225},	critical_damage = 10, deps_cells = {"AILERON_L", "WING_L_PART_IN"}},
		["AILERON_L"]				= {args = {226},	critical_damage = 3},
		["WING_L_PART_IN"]			= {args = {230},	critical_damage = 2},
		
		["WING_R_OUT"]				= {args = {215},	critical_damage = 10, deps_cells = {"AILERON_R", "WING_R_PART_IN"}},
		["AILERON_R"]				= {args = {216},	critical_damage = 3},
		["WING_R_PART_IN"]			= {args = {220},	critical_damage = 2},
		
		["ELEVATOR_L"]				= {args = {240},	critical_damage = 2},
		["ELEVATOR_R"]				= {args = {238},	critical_damage = 2},
		
		["FIN_L_BOTTOM"]			= {args = {242},	critical_damage = 4},
		["FIN_L_TOP"]				= {args = {241},	critical_damage = 7, deps_cells = {"RUDDER"}},
		["RUDDER"]					= {args = {247},	critical_damage = 1},
	}),-- end of Damage

	DamageParts	=
	{
		[1] = "F-16C_oblomok_wing_R",
		[2] = "F-16C_oblomok_wing_L",
	},
	
	SFM_Data = {
		aerodynamics = 
		{
			Cy0	=	0,
			Mzalfa	=	4.355,
			Mzalfadt	=	0.8,
			kjx	=	2.75,
			kjz	=	0.00125,
			Czbe	=	-0.016,
			cx_gear	=	0.0268,
			cx_flap	=	0.05,
			cy_flap	=	0.52,
			cx_brk	=	0.06,
			table_data = 
			{
				[1] =	{0,	0.0165,	0.07,	0.132,	0.032,	0.5,	30,	1.2},
				[2] =	{0.2,	0.0165,	0.07,	0.132,	0.032,	1.5,	30,	1.2},
				[3] =	{0.4,	0.0165,	0.07,	0.133,	0.032,	2.5,	30,	1.2},
				[4] =	{0.6,	0.0165,	0.073,	0.133,	0.043,	3.5,	30,	1.2},
				[5] =	{0.7,	0.017,	0.076,	0.134,	0.045,	3.5,	28.666666666667,	1.18},
				[6] =	{0.8,	0.024,	0.079,	0.137,	0.052,	3.5,	27.333333333333,	1.16},
				[7] =	{0.9,	0.041,	0.083,	0.143,	0.058,	3.5,	26,	1.14},
				[8] =	{1,	0.062,	0.085,	0.18,	0.1,	3.5,	24.666666666667,	1.12},
				[9] =	{1.05,	0.061,	0.0855,	0.1975,	0.095,	3.5,	24,	1.11},
				[10] =	{1.1,	0.06,	0.086,	0.215,	0.09,	3.15,	18,	1.1},
				[11] =	{1.2,	0.051,	0.083,	0.228,	0.12,	2.45,	17,	1.05},
				[12] =	{1.3,	0.046,	0.077,	0.237,	0.17,	1.75,	16,	1},
				[13] =	{1.49,	0.044,	0.062,	0.251,	0.2,	1.5125,	13.15,	0.905},
				[14] =	{1.5,	0.043903225806452,	0.061483870967742,	0.25064516129032,	0.2058064516129,	1.5,	13,	0.9},
				[15] =	{1.7,	0.041967741935484,	0.051161290322581,	0.24354838709677,	0.32193548387097,	0.9,	12,	0.7},
				[16] =	{1.8,	0.041,	0.046,	0.24,	0.38,	0.86,	11.4,	0.64},
				[17] =	{2,	0.042,	0.039,	0.222,	2.5,	0.78,	10.2,	0.52},
				[18] =	{2.2,	0.041,	0.034,	0.227,	3.2,	0.7,	9,	0.4},
				[19] =	{2.5,	0.039,	0.033,	0.25,	4.5,	0.7,	9,	0.4},
				[20] =	{3.9,	0.035,	0.033,	0.35,	6,	0.7,	9,	0.4},
			}, -- end of table_data
		}, -- end of aerodynamics
		engine =
		{
			Nmg		=	67.5,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			type	=	"TurboJet",
			hMaxEng	=	19,
			dcx_eng	=	0.0144,
			cemax	=	1.24,
			cefor	=	2.56,
			dpdh_m	=	6200,
			dpdh_f	=	9500,
			table_data =
			{
				[1] =	{0,	77000,	108313.6},
				[2] =	{0.2,	74000,	109850},
				[3] =	{0.4,	74000,	115227.3},
				[4] =	{0.6,	85000,	126750},
				[5] =	{0.7,	85000,	145000},
				[6] =	{0.8,	90000,	157000},
				[7] =	{0.9,	94000,	166000},
				[8] =	{1,	100000,	170000},
				[9] =	{1.096,	96000,	171000},
				[10] =	{1.2,	86000,	171000},
				[11] =	{1.3,	68000,	173000},
				[12] =	{1.4,	55000,	176000},
				[13] =	{1.6,	56000,	176000},
				[14] =	{1.8,	56000,	184000},
				[15] =	{2.2,	52000,	173000},
				[16] =	{2.35,	43000,	157000},
				[17] =	{3.9,	25000,	120636.4},
			}, -- end of table_data
		}, -- end of engine
	},

	lights_data = {
		typename = "collection",
		lights = {
			-- STROBES
			[WOLALIGHT_STROBES] = {
				typename = "collection",
				lights = {
					{ typename = "argnatostrobelight", argument = 193,
						controller = "VariablePatternStrobe", mode = "1 Flash", period = 0.500, },
					{ typename = "Spot", position = {-6.8, 3.25, 0}, direction = {azimuth = math.rad(-90.0)}, argument = 193,
						proto = lamp_prototypes.MPS_1, range = 64, angle_max = math.rad(110.0), angle_min = math.rad(80.0),
						controller = "VariablePatternStrobe", mode = "1 Flash", period = 0.500, },
					{ typename = "Spot", position = {-6.8, 3.25, 0}, direction = {azimuth = math.rad(90.0)}, argument = 193,
						proto = lamp_prototypes.MPS_1, range = 64, angle_max = math.rad(110.0), angle_min = math.rad(80.0),
						controller = "VariablePatternStrobe", mode = "1 Flash", period = 0.500, },
				},
			},
			-- SPOTS
			[WOLALIGHT_LANDING_LIGHTS] = {
				typename = "collection",
				lights = {
					-- 0 -- landing
					{ typename = "argumentlight", argument = 208, exposure = {{117, 0.9, 1.0}}, movable = true, },
					-- 1 -- taxi
					{ typename = "argumentlight", argument = 209, exposure = {{117, 0.9, 1.0}}, movable = true, },
					-- 2 -- aux light
					{ typename = "argumentlight", argument = 210, exposure = {{117, 0.9, 1.0}}, movable = true, },
				},
			},
			[WOLALIGHT_TAXI_LIGHTS] = {
				typename = "collection",
				lights = {
					-- 0 -- taxi
					{ typename = "argumentlight", argument = 209, exposure = {{117, 0.9, 1.0}}, movable = true, },
					-- 1 -- aux light
					{ typename = "argumentlight", argument = 210, exposure = {{117, 0.9, 1.0}}, movable = true, },
				},
			},
			-- NAVLIGHTS
			[WOLALIGHT_NAVLIGHTS] = {
				typename = "collection",
				lights = {
					-- 0 -- wing tips
					{ typename = "argumentlight", argument = 190,
						controller = "Strobe", period = 0.73, reduced_flash_time = 0.5, power_up_t = 0.25, cool_down_t = 0.5, mode = 0, },
					-- 1 -- intake & tail
					{ typename = "argumentlight", argument = 191,
						controller = "Strobe", period = 0.73, reduced_flash_time = 0.5, power_up_t = 0.25, cool_down_t = 0.5, mode = 0, },
				},
			},
			-- FORMATION
			[WOLALIGHT_FORMATION_LIGHTS] = {
				typename = "collection",
				lights = {
					-- 0 -- fuselage upper formation
					{ typename = "argumentlight", argument = 200, },
					-- 1 -- fuselage lower formation
					{ typename = "argumentlight", argument = 201, },
					-- 2 -- fuselage formation/position
					{ typename = "argumentlight", argument = 202, },
				},
			},
			-- REFUEL
			[WOLALIGHT_REFUEL_LIGHTS] = {
				typename = "collection",
				lights = {
					-- 0 -- AR light, tail-mounted flood
					{ typename = "argumentlight", argument = 207, },
				},
			},
			-- STROBE / ANTI-COLLISION
			[WOLALIGHT_BEACONS] = {
				typename = "collection",
				lights = {
					-- 0 -- Anti-collision strobe
					{ typename = "argnatostrobelight", argument = 192, period = 0.4, flash_time = 0.1, },
				},
			},
		}, -- end of lights
	},-- end of lights_data

	-- Aircraft Additional Properties
	AddPropAircraft = {
		{ id = "LAU3ROF",			control = 'comboList', label = _('LAU-3 Rate of Fire'),
			values = {
				{id =  0, dispName = _("Single")},
				{id =  1, dispName = _("Ripple")},
			},
			defValue = 0,
			wCtrl	 = 150,
			playerOnly = true
		},
		{ id = "LaserCode100",		control = 'spinbox',  label = _('Laser code for GBUs, 1x11'), defValue = 6, min = 5, max = 7, dimension = ' ', playerOnly = true},
		{ id = "LaserCode10",		control = 'spinbox',  label = _('Laser code for GBUs, 11x1'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
		{ id = "LaserCode1",		control = 'spinbox',  label = _('Laser code for GBUs, 111x'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
		{ id = "HelmetMountedDevice",			control = 'comboList', label = _('Helmet Mounted Device'),
			values = {
				{id = 0, dispName = _("Not installed")},
				{id = 1, dispName = _("JHMCS")},
				{id = 2, dispName = _("NVG")},
			},
			defValue	= 1,
			wCtrl		= 150,
			playerOnly = true
		},
	},

}

add_aircraft(F_16C)

