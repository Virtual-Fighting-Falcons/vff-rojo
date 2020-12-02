dofile(LockOn_Options.script_path.."VFF/Utilities/BitTestDefinitions.lua")

VFF_SMOKE = GetSelf()
VFF_SENSOR = get_base_data()

update_rate = 0.05
make_default_activity(update_rate)

local SMOKE_ON = 5000
local SMOKE_OFF = 5001
local SMOKE_TOGGLE = 5002
local SMOKE_POWER = 5003
local SMOKE_ARM = 5004

local SmokeStation = 11

VFF_SMOKE:listen_command(SMOKE_ON)
VFF_SMOKE:listen_command(SMOKE_OFF)
VFF_SMOKE:listen_command(SMOKE_TOGGLE)
VFF_SMOKE:listen_command(SMOKE_POWER)
VFF_SMOKE:listen_command(SMOKE_ARM)

function post_initialize()
    AllReset()

    -- KEY STATES
    POWER_KEY = false
    ARM_KEY = false
    SMOKE_KEY = false

    -- POWER
    pwrJetHasPower = false
    pwrControllerPoweredOn = false

    -- OIL
    oilBitComplete = false
    -- 0 OFF, 1 PERCENT, 2 CAPACITY, 3 TIME, 4 OFF, 5 ALL ON SET COMPLETE
    oilBitState = 0
    oilBitTimer = 0.0

    -- FAILURES
    filBitComplete = false
    -- 0 FAIL, 1 ALL, 2 PUMP, 3 PRESS, 4 EQUIP, 5 AVIONIC, 6 ALL, 7 FAIL, 8 ALL OF SET COMPLETE
    filBitState = 0
    filBitTimer = 0.0

    filAvionicTemperature = 70
    filEquipTemperature = 70

    filPumpFail = false
    filPressFail = false
    filEquipFail = false
    filAvionicFail = false

    filPumpFailRunTime = 0.0
    filPumpFailMaxRunTime = 5.0

    filOverpressureRunTime = 0.0
    filOverpressureMaxRunTime = 1.5

    -- ARMING
    armBitComplete = false
    -- 0 ALL ON, 1 ALL OFF SET COMPLETE
    armBitState = 0
    armBitTimer = 0.0

    armArmed = false
    armPressurized = false

    -- SMOKE SYSTEM
    smkBitComplete = false
    -- 0 ALL ON, 1 WAIT, 2 EMIT, 3 VAPOR, 4 ALL ON, 5 ALL OFF BIT COMPLETE
    smkBitState = 0
    smkBitTimer = 0.0

    smkOilRemain = 198.0 -- 198 ORIGINAL NUMBER
    smkOilPercent = 0
    smkOilTime = 0
    smkOilPerSecond = 0.22

    smkState = false
    smkStateShould = false
    smkGate = false

    SmokeIndicationParameters[Percent]:set("000")
    SmokeIndicationParameters[Capacity]:set("00:0")
    SmokeIndicationParameters[Time]:set("00:00")

end

function update()
    if pwrJetHasPower == true then
        filAvionicTemperature = filAvionicTemperature + 2
        filEquipTemperature = filEquipTemperature + 6.75

        if filAvionicTemperature > 750 then
            filAvionicTemperature = 750
        end

        if filEquipTemperature > 1800 then
            filEquipTemperature = 1800
        end
    end

    if pwrControllerPoweredOn == true then
        filAvionicTemperature = filAvionicTemperature - 2.5
        filEquipTemperature = filEquipTemperature - 8.25

        if filAvionicTemperature < 70 then
            filAvionicTemperature = 70
        end

        if filEquipTemperature < 70 then
            filEquipTemperature = 70
        end
    end


    UpdatePowerState()
    UpdateFailures()
    UpdateArmState()
    UpdateOilState()
    UpdateSmokeState()
end

function SetCommand(Command, Value)
    if Command == SMOKE_POWER then
        POWER_KEY = not POWER_KEY
    end

    if Command == SMOKE_ARM then
        ARM_KEY = not ARM_KEY
    end

    if Command == SMOKE_ON then
        SMOKE_KEY = true
    end

    if Command == SMOKE_OFF then
        SMOKE_KEY = false
    end

    if Command == SMOKE_TOGGLE then
        SMOKE_KEY = not SMOKE_KEY
    end
end

function AllReset()
    for i = 1, #SmokeIndicationParameters do
        SmokeIndicationParameters[i]:set(0)
    end
end

-- LOGIC

function UpdateFailures()
    if filBitComplete == false and pwrControllerPoweredOn == true then
        filBitTimer = filBitTimer + update_rate
    -- 0 FAIL, 1 ALL, 2 PUMP, 3 PRESS, 4 EQUIP, 5 AVIONIC, 6 ALL, 7 FAIL, 8 ALL OF SET COMPLETE
        if filBitState == 0 then
            SmokeIndicationParameters[Fail]:set(1)
            if filBitTimer > 1.5 then
                filBitState = filBitState + 1
            end
        elseif filBitState == 1 then
            SmokeIndicationParameters[Fail]:set(1)
            SmokeIndicationParameters[PumpFailure]:set(1)
            SmokeIndicationParameters[LineOverpressure]:set(1)
            SmokeIndicationParameters[EquipmentHot]:set(1)
            SmokeIndicationParameters[AvionicsHot]:set(1)
            if filBitTimer > 2.0 then
                SmokeIndicationParameters[LineOverpressure]:set(0)
                SmokeIndicationParameters[EquipmentHot]:set(0)
                SmokeIndicationParameters[AvionicsHot]:set(0)
                SmokeIndicationParameters[PumpFailure]:set(0)
                filBitState = filBitState + 1
            end
        elseif filBitState == 2 then
            SmokeIndicationParameters[PumpFailure]:set(1)
            if filBitTimer > 2.75 then
                filBitState = filBitState + 1
                SmokeIndicationParameters[PumpFailure]:set(0)
            end
        elseif filBitState == 3 then
            SmokeIndicationParameters[LineOverpressure]:set(1)
            if filBitTimer > 3.5 then
                filBitState = filBitState + 1
                SmokeIndicationParameters[LineOverpressure]:set(0)
            end
        elseif filBitState == 4 then
            SmokeIndicationParameters[EquipmentHot]:set(1)
            if filBitTimer > 4.25 then
                filBitState = filBitState + 1 
                SmokeIndicationParameters[EquipmentHot]:set(0)
            end
        elseif filBitState == 5 then
            SmokeIndicationParameters[AvionicsHot]:set(1)
            if filBitTimer > 5.0 then
                filBitState = filBitState + 1
                SmokeIndicationParameters[AvionicsHot]:set(0)
            end
        elseif filBitState == 6 then
            SmokeIndicationParameters[Fail]:set(1)
            SmokeIndicationParameters[PumpFailure]:set(1)
            SmokeIndicationParameters[LineOverpressure]:set(1)
            SmokeIndicationParameters[EquipmentHot]:set(1)
            SmokeIndicationParameters[AvionicsHot]:set(1)
            if filBitTimer > 7.0 then
                filBitState = filBitState + 1
            end
        elseif filBitState == 7 then
            SmokeIndicationParameters[PumpFailure]:set(0)
            SmokeIndicationParameters[LineOverpressure]:set(0)
            SmokeIndicationParameters[EquipmentHot]:set(0)
            SmokeIndicationParameters[AvionicsHot]:set(0)
            if filBitTimer > 8.0 then
                filBitState = filBitState + 1
            end
        elseif filBitState == 8 then
            if filBitTimer > 0.0 then
                filBitState = filBitState + 1
                filBitComplete = true
                SmokeIndicationParameters[Fail]:set(0)
            end
        end
    elseif filBitComplete == true and pwrControllerPoweredOn == true then
        if filAvionicTemperature > 90 then
            filAvionicFail = true
            SmokeIndicationParameters[AvionicsHot]:set(1)
        else
            filAvionicFail = false
            SmokeIndicationParameters[AvionicsHot]:set(0)
        end

        if filEquipTemperature > 350 then
            filEquipFail = true
            SmokeIndicationParameters[EquipmentHot]:set(1)
        else
            filEquipFail = false
            SmokeIndicationParameters[EquipmentHot]:set(0)
        end

        if filAvionicFail == true or filEquipFail == true or filPumpFail == true or filPressFail == true then
            SmokeIndicationParameters[Fail]:set(1)
        else
            SmokeIndicationParameters[Fail]:set(0)
        end

        if filPumpFail == true then
            SmokeIndicationParameters[PumpFailure]:set(1)
        else
            SmokeIndicationParameters[PumpFailure]:set(0)
        end

        if filPressFail == true then
            SmokeIndicationParameters[LineOverpressure]:set(1)
        else
            SmokeIndicationParameters[LineOverpressure]:set(0)
        end

        if smkOilPercent == 0.0 and ARM_KEY == true then
            filPumpFailRunTime = filPumpFailRunTime + update_rate
        end

        if filPumpFailRunTime >= filPumpFailMaxRunTime then
            filPumpFail = true
        end

        if ARM_KEY == true then
            if SmokeIndicationParameters[EquipmentHot]:get() == 1 or SmokeIndicationParameters[AvionicsHot]:get() == 1 then
                filOverpressureRunTime = filOverpressureRunTime + update_rate
            end
        end

        if filOverpressureRunTime >= filOverpressureMaxRunTime then
            filPressFail = true
        end

    elseif pwrControllerPoweredOn == false then
        filBitComplete = false
        filBitState = 0
        filBitTimer = 0.0
    end
end

function UpdatePowerState()
    if get_cockpit_draw_argument_value(15) > -1.0 then
        pwrJetHasPower = true
        SmokeIndicationParameters[PowerAvailable]:set(1)
    else
        pwrJetHasPower = false
        SmokeIndicationParameters[PowerAvailable]:set(0)
        AllReset()
    end

    if pwrJetHasPower == true and POWER_KEY == true then
        pwrControllerPoweredOn = true
        SmokeIndicationParameters[PowerOn]:set(1)
        SmokeIndicationParameters[PowerButton]:set(1)
    elseif pwrControllerPoweredOn == true and POWER_KEY == false then
        AllReset()
        pwrControllerPoweredOn = false
    else
        pwrControllerPoweredOn = false
        SmokeIndicationParameters[PowerOn]:set(0)
        SmokeIndicationParameters[PowerButton]:set(0)
    end
end

function UpdateArmState()
    if armBitComplete == false and pwrControllerPoweredOn == true then
        armBitTimer = armBitTimer + update_rate

        if armBitState == 0 then
            SmokeIndicationParameters[ArmButton]:set(1)
            SmokeIndicationParameters[Armed]:set(1)
            SmokeIndicationParameters[Pressurized]:set(1)
            if armBitTimer > 3.0 then
                armBitState = armBitState + 1
            end
        elseif armBitState == 1 and smkBitComplete == true and oilBitComplete == true and filBitComplete == true then
            SmokeIndicationParameters[ArmButton]:set(0)
            SmokeIndicationParameters[Armed]:set(0)
            SmokeIndicationParameters[Pressurized]:set(0)
            armBitComplete = true
        end
    elseif armBitComplete == true and pwrControllerPoweredOn == true then
        -- If the power is on and the key is pressed, arm
        -- if the power is off dearm
        -- if the key is off dearm

        if pwrControllerPoweredOn == true and ARM_KEY == true then
            SmokeIndicationParameters[Armed]:set(1)
            SmokeIndicationParameters[ArmButton]:set(1)
            armArmed = true
            if filAvionicFail == false and filEquipFail == false and filPressFail == false and filPumpFail == false and smkOilPercent > 0.0 then
                SmokeIndicationParameters[Pressurized]:set(1)
                armPressurized = true
            else
                SmokeIndicationParameters[Pressurized]:set(0)
                armPressurized = false
            end
        else
            SmokeIndicationParameters[Armed]:set(0)
            SmokeIndicationParameters[ArmButton]:set(0)
            SmokeIndicationParameters[Pressurized]:set(0)
            armArmed = false
            armPressurized = false
        end
    elseif pwrControllerPoweredOn == false then
        armBitComplete = false
        armBitState = 0
        armBitTimer = 0.0
    end
end

function UpdateOilState()
    if oilBitComplete == false and pwrControllerPoweredOn == true then
        -- STARTUP
        SmokeIndicationParameters[Percent]:set("555:")
        SmokeIndicationParameters[Capacity]:set("555:5")
        SmokeIndicationParameters[Time]:set("55:55")

        -- PERCENT ON, PERCENT OFF / CAPACITY ON, CAPACITY OFF / TIME ON, TIME OFF, WAIT, ALL ON
        oilBitTimer = oilBitTimer + update_rate
        if oilBitState == 0 then
            SmokeIndicationParameters[QuantityLow]:set(1)
            SmokeIndicationParameters[QuanityEmpty]:set(1)
            if oilBitTimer > 1.0 then
                oilBitState = oilBitState + 1
            end
        elseif oilBitState == 1 then
            SmokeIndicationParameters[PercentVisible]:set(1)
            if oilBitTimer > 2.0 then
                oilBitState = oilBitState + 1
                SmokeIndicationParameters[PercentVisible]:set(0)
            end
        elseif oilBitState == 2 then
            SmokeIndicationParameters[CapacityVisible]:set(1)
            if oilBitTimer > 3.0 then
                oilBitState = oilBitState + 1
                SmokeIndicationParameters[CapacityVisible]:set(0)
            end
        elseif oilBitState == 3 then
            SmokeIndicationParameters[TimeVisible]:set(1)
            if oilBitTimer > 4.0 then
                oilBitState = oilBitState + 1
                SmokeIndicationParameters[TimeVisible]:set(0)
                SmokeIndicationParameters[QuantityLow]:set(0)
                SmokeIndicationParameters[QuanityEmpty]:set(0)
            end
        elseif oilBitState == 4 then
            if oilBitTimer > 6.0 then
                oilBitState = oilBitState + 1
            end
        elseif oilBitState == 5 then
            SmokeIndicationParameters[PercentVisible]:set(1)
            SmokeIndicationParameters[CapacityVisible]:set(1)
            SmokeIndicationParameters[TimeVisible]:set(1)
            oilBitComplete = true
        end
    elseif oilBitComplete == true and pwrControllerPoweredOn == true then
        -- RUN

        local remain = smkOilRemain
        local remainRound = math.floor(remain)
        local remainDecimal = remain - remainRound
        remainDecimal = round(remainDecimal, 1)
        local remainDecimalFormatted = string.sub(remainDecimal, 3)
        local built = remainRound..":"..remainDecimalFormatted

        SmokeIndicationParameters[Capacity]:set(built)

        local percent = smkOilRemain
        percent = percent / 198
        percent = percent * 100

        smkOilPercent = percent

        percent = math.floor(percent)
        local perbuilt = percent..":"
        SmokeIndicationParameters[Percent]:set(perbuilt)
        -- print_message_to_user(built)

        local time = smkOilRemain / smkOilPerSecond
        local timeSeconds = time % 60
        local timeSeconds = math.floor(timeSeconds)
        local timeMinutes = math.floor(time / 60)
        local timeString = timeMinutes..":"..timeSeconds

        SmokeIndicationParameters[Time]:set(timeString)

        if smkOilPercent < 15.0 and smkOilPercent > 0.0 then
            SmokeIndicationParameters[QuantityLow]:set(1)
        else
            SmokeIndicationParameters[QuantityLow]:set(0)
        end

        if smkOilPercent == 0.0 then
            SmokeIndicationParameters[QuanityEmpty]:set(1)
        else
            SmokeIndicationParameters[QuanityEmpty]:set(0)
        end
        
    elseif pwrControllerPoweredOn == false then
        oilBitComplete = false
        oilBitState = 0
        oilBitTimer = 0.0
    end
end

function UpdateSmokeState()
    if smkBitComplete == false and pwrControllerPoweredOn == true then
        smkBitTimer = smkBitTimer + update_rate

        if smkBitState == 0 then
            SmokeIndicationParameters[Emitting]:set(1)
            SmokeIndicationParameters[Vaporizing]:set(1)
            if smkBitTimer > 2.0 then
                smkBitState = smkBitState + 1
                SmokeIndicationParameters[Vaporizing]:set(0)
            end
        elseif smkBitState == 1 then
            if smkBitTimer > 4.0 then
                smkBitState = smkBitState + 1
                SmokeIndicationParameters[Emitting]:set(0)
            end
        elseif smkBitState == 2 then
            SmokeIndicationParameters[Vaporizing]:set(1)
            if smkBitTimer > 6.0 then
                smkBitState = smkBitState + 1
            end
        elseif smkBitState == 3 then
            SmokeIndicationParameters[Emitting]:set(1)
            if smkBitTimer > 8.0 then
                smkBitState = smkBitState + 1
            end
        elseif smkBitState == 4 and filBitComplete == true then
            SmokeIndicationParameters[Vaporizing]:set(0)
            SmokeIndicationParameters[Emitting]:set(0)
            smkBitComplete = true
        end 
    elseif smkBitComplete == true and pwrControllerPoweredOn == true then
        if filAvionicFail == false and filPumpFail == false and filEquipFail == false and filPressFail == false and armArmed == true and armPressurized == true and smkOilPercent > 0.0 then
            if get_aircraft_draw_argument_value(90) > 0.10 and get_cockpit_draw_argument_value(755) > 0.72 then
                smkGate = true
            else
                smkGate = false
            end

            if SMOKE_KEY then
                if smkGate == false then
                    smkStateShould = true
                    SmokeIndicationParameters[Vaporizing]:set(0)
                else
                    smkStateShould = false
                    SmokeIndicationParameters[Vaporizing]:set(1)
                end
            else
                smkStateShould = false
                SmokeIndicationParameters[Emitting]:set(0)
                SmokeIndicationParameters[Vaporizing]:set(0)
            end

            if smkState == false and smkStateShould == true then
                smkState = true
                SmokeIndicationParameters[Emitting]:set(1)
                VFF_SMOKE:launch_station(SmokeStation)
            elseif smkState == true and smkStateShould == false then
                smkState = false
                SmokeIndicationParameters[Emitting]:set(0)
                VFF_SMOKE:launch_station(SmokeStation)
            end

            if SMOKE_KEY == true then
                smkOilRemain = smkOilRemain - (smkOilPerSecond / (1 / update_rate))
                if smkOilRemain < 0.0 then
                    smkOilRemain = 0.0
                end
            end
        else
            if smkState == true then
                smkState = false
                VFF_SMOKE:launch_station(SmokeStation)
            end
            SmokeIndicationParameters[Emitting]:set(0)
            SmokeIndicationParameters[Vaporizing]:set(0)
        end
    elseif pwrControllerPoweredOn == false then
        smkBitComplete = false
        smkBitState = 0
        smkBitTimer = 0.0

        if smkState == true then
            smkState = false
            VFF_SMOKE:launch_station(SmokeStation)
            SmokeIndicationParameters[Emitting]:set(0)
            SmokeIndicationParameters[Vaporizing]:set(0)
        end
    end
end

function round(what, precision)
    return math.floor(what*math.pow(10,precision)+0.5) / math.pow(10,precision)
 end

--  remain = remain - 0.011
--  smkOilRemain = remain
-- smkOilRemain = smkOilRemain - (smkOilPerSecond / (1 / update_rate))