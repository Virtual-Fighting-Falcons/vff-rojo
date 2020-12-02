-- Get Sim and Own Aircraft Data
SIM = GetSelf()
AIRCRAFT = get_base_data()

-- Set the Update Rate / Sec
update_rate = 0.05
make_default_activity(update_rate)

-- Joystick and Keyboard Button Variables
local ROJO_ON = 6001
local ROJO_OFF = 6002
local SMOKE_ON = 6003
local SMOKE_OFF = 6004
local SMOKE_TOGGLE = 6005

local SMOKE_STATION = 11

local TIME_ADD = 0
local TIME_TOTAL = 0

local SMOKE_STATE = false
local ROJO_STATE = false
local ROJO_SWAP = 1
local ROJO_SMOKE = false

local ROJO_TIMER = 0

SIM:listen_command(ROJO_ON)
SIM:listen_command(ROJO_OFF)
SIM:listen_command(SMOKE_ON)
SIM:listen_command(SMOKE_OFF)
SIM:listen_command(SMOKE_TOGGLE)

function post_initialize()
end


function update()

    -- Calls Rojo Functions
    if ROJO_STATE == true then
        addTime()
        timeIsTwo()
        rojoLaunch()
    end

end

-- Function that adds time to 2 seconds
function addTime()
    TIME_ADD = TIME_ADD + update_rate
end

-- If Time is Two it Changes the Smoke State Logic when addTime reaches 2 Seconds
function timeIsTwo()
    if TIME_ADD >= 2 and TIME_TOTAL == 0 then
        TIME_TOTAL = 1
        TIME_ADD = 0
    elseif TIME_ADD >= 2 and TIME_TOTAL == 1 then
        TIME_TOTAL = 0
        TIME_ADD = 0
    end 
end

function rojoLaunch() 
    if SMOKE_STATE == false then
    end
    if TIME_TOTAL == 0 and SMOKE_STATE == true and ROJO_SMOKE == true then
        SIM:launch_station(SMOKE_STATION)
        ROJO_SMOKE = false
    elseif TIME_TOTAL == 1 and SMOKE_STATE == true and ROJO_SMOKE == false then
        SIM:launch_station(SMOKE_STATION)
        ROJO_SMOKE = true
    end
end

function SetCommand(Command, Value)
    
    -- Logic for Smoke On Key
    if Command == SMOKE_ON and SMOKE_STATE == false then
        SIM:launch_station(SMOKE_STATION)
        SMOKE_STATE = true
        ROJO_SMOKE = true
    end

    -- Logic for Smoke Off Key
    if Command == SMOKE_OFF and SMOKE_STATE == true and ROJO_SMOKE == true then 
        SIM:launch_station(SMOKE_STATION)
        SMOKE_STATE = false
        ROJO_SMOKE = false
    elseif Command == SMOKE_OFF and SMOKE_STATE == true then
        SMOKE_STATE = false
        ROJO_SMOKE = false
    end

    -- Logic for Smoke Toggle Key
    if Command == SMOKE_TOGGLE then
        SIM:launch_station(SMOKE_STATION)
        if SMOKE_STATE == false then
            SMOKE_STATE = true
        else 
            SMOKE_STATE = false
        end
    end

    -- Logic for Turning Rojo On
    if Command == ROJO_ON and ROJO_STATE == false then
        ROJO_STATE = true
    end

    -- Logic for Turning Rojo Off
    if Command == ROJO_OFF and ROJO_STATE == true then
        ROJO_STATE = false
        TIME_TOTAL = 0
        TIME_ADD = 0

        if SMOKE_STATE == true then
            SetCommand(SMOKE_OFF)
        end
    end
    
end