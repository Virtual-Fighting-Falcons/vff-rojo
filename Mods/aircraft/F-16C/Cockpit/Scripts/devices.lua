local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}
-- do not changed following sequence for sim
devices["FM_PROXY"]					= counter()--
devices["CONTROL_INTERFACE"]		= counter()--
devices["ELEC_INTERFACE"]			= counter()--
devices["FUEL_INTERFACE"]			= counter()--
devices["HYDRO_INTERFACE"]			= counter()--
devices["ENGINE_INTERFACE"]			= counter()--
devices["GEAR_INTERFACE"]			= counter()--
devices["OXYGEN_INTERFACE"]			= counter()--
devices["HEARING_SENS"]				= counter()--
devices["CPT_MECH"]					= counter()--
devices["EXTLIGHTS_SYSTEM"]			= counter()--
devices["CPTLIGHTS_SYSTEM"]			= counter()--
devices["ECS_INTERFACE"]			= counter()--
devices["INS"]						= counter()--
devices["RALT"]						= counter()--
-- HOTAS Interface
devices["HOTAS"]					= counter()--
--
devices["UFC"]						= counter()--		-- Upfront Controls (UFC) with Integrated Control Panel (ICP)
-- Computers ----------------------------
devices["MUX"]						= counter()--		-- Multiplex manager, holds channels and manages remote terminals addition/remove
devices["MMC"]						= counter()--		-- Modular Mission Computer (MMC) / Fire Control Computer (FCC)
devices["CADC"]						= counter()--		-- Central Air Data Computer
devices["FLCC"]						= counter()--		-- Flight Control Computer
devices["SMS"]						= counter()--		-- Stores Management Subsystem
-- Displays -----------------------------
devices["HUD"]						= counter()--
devices["MFD_LEFT"]					= counter()--		-- Multifunction Display
devices["MFD_RIGHT"]				= counter()--		-- Multifunction Display
devices["DED"]						= counter()--		-- Data Entry Display (DED)
devices["PFLD"]						= counter()--		-- Pilot Fault List Display (PFLD)
devices["EHSI"]						= counter()--		-- Electronic Horizontal Situation Indicator (EHSI)
-- Helmet
devices["HELMET"]					= counter()--
devices["HMCS"]						= counter()--		-- HMCS Interface
-- Sensors ------------------------------
devices["FCR"]						= counter()--		-- AN/APG-68
-- EWS ----------------------------------
devices["CMDS"]						= counter()--		-- Counter Measures Dispensing System
devices["RWR"]						= counter()--		-- Radar Warning Receiver (RWR)
-- Radio --------------------------------
devices["IFF"]						= counter()--		-- AN/APX-113
devices["IFF_CONTROL_PANEL"]		= counter()--
devices["UHF_RADIO"]				= counter()--		-- AN/ARC-164
devices["UHF_CONTROL_PANEL"]		= counter()--
devices["VHF_RADIO"]				= counter()--		-- AN/ARC-222
devices["INTERCOM"]					= counter()--
devices["MIDS_RT"]					= counter()--
devices["MIDS"]						= counter()--
devices["KY58"]						= counter()--		-- KY-58 Secure Speech System
devices["ILS"]						= counter()--
-- Instruments --------------------------
devices["AOA_INDICATOR"]			= counter()--
devices["AAU34"]     				= counter()--		-- Altimeter AAU-34/A
devices["AMI"]						= counter()--		-- Airspeed/Mach Indicator
devices["SAI"]						= counter()--
devices["VVI"]						= counter()--		-- Vertical Velocity Indicator
devices["STANDBY_COMPASS"]			= counter()--
devices["ADI"]    					= counter()--		-- Attitude Director Indicator
devices["CLOCK"]					= counter()--
--
devices["MACROS"]					= counter()--
devices["AIHelper"]					= counter()--
devices["KNEEBOARD"] 				= counter()--
devices["ARCADE"]					= counter()--
--
devices["TACAN_CTRL_PANEL"]			= counter()--
-- Armament
devices["SIDEWINDER_INTERFACE"]		= counter()--
devices["TGP_INTERFACE"]			= counter()--
--
devices["GPS"]						= counter()--
devices["IDM"]						= counter()--
devices["MAP"]						= counter()--
-- Armament
devices["MAV_INTERFACE"]			= counter()--
devices["HARM_INTERFACE"]			= counter()--
devices["HTS_INTERFACE"]			= counter()--

-- Canaan's Mod
devices["ROJO_SMOKE_SYSTEM"]		= counter()--		-- Rojo Smoke System as Seen in Patriots Jet Demo