local view_width = 1084
local view_height = 1541

local assets = require("a32nx/assets")

--------------------------------------------------------------------------------------
-- register events
--------------------------------------------------------------------------------------
local events = {
    master1_up = mapper.register_event("ENGINE:MASTER1:flick_up"),
    master1_down = mapper.register_event("ENGINE:MASTER1:flick_up"),
    master1_change = mapper.register_event("ENGINE:MASTER1:change"),
    master2_up = mapper.register_event("ENGINE:MASTER2:flick_up"),
    master2_down = mapper.register_event("ENGINE:MASTER2:flick_up"),
    master2_change = mapper.register_event("ENGINE:MASTER2:change"),
    eng1u_change = mapper.register_event("ENGINE:1UPPER:change"),
    eng1l_change = mapper.register_event("ENGINE:1LOWER:change"),
    eng2u_change = mapper.register_event("ENGINE:2UPPER:change"),
    eng2l_change = mapper.register_event("ENGINE:2LOWER:change"),
    mode_left = mapper.register_event("ENGINE:MODE:flick_left"),
    mode_right = mapper.register_event("ENGINE:MODE:flick_right"),
    mode_change = mapper.register_event("ENGINE:MODE:change"),
    apumaster_push = mapper.register_event("APU:MASTER:push"),
    apumasteru_change = mapper.register_event("APU:MASTER_UPPER:change"),
    apumasterl_change = mapper.register_event("APU:MASTER_LOWER:change"),
    apustart_push = mapper.register_event("APU:START:push"),
    apustartu_change = mapper.register_event("APU:START_UPPER:change"),
    apustartl_change = mapper.register_event("APU:START_LOWER:change"),
    apubleed_push = mapper.register_event("APU:BLEED:push"),
    apubleedu_change = mapper.register_event("APU:BLEED_UPPER:change"),
    apubleedl_change = mapper.register_event("APU:BLEED_LOWER:change"),
    bat1_push = mapper.register_event("ELEC:BAT1:push"),
    bat1u_change = mapper.register_event("ELEC:BAT1_UPPER:change"),
    bat1l_change = mapper.register_event("ELEC:BAT1_LOWER:change"),
    bat2_push = mapper.register_event("ELEC:BAT2:push"),
    bat2u_change = mapper.register_event("ELEC:BAT2_UPPER:change"),
    bat2l_change = mapper.register_event("ELEC:BAT2_LOWER:change"),
    extpwr_push = mapper.register_event("ELEC:EXT_POWER:push"),
    extpwru_change = mapper.register_event("ELEC:EXT_POWER_UPPER:change"),
    extpwrl_change = mapper.register_event("ELEC:EXT_POWER_LOWER:change"),
    bat1v_change = mapper.register_event("ELEC:BAT1 Potential:change"),
    bat2v_change = mapper.register_event("ELEC:BAT2 Potential:change"),
}

--------------------------------------------------------------------------------------
-- observed data definitions
--------------------------------------------------------------------------------------
local observed_data = {
    {rpn="(L:S_ENG_MASTER_1)", event=events.master1_change},
    {rpn="(L:S_ENG_MASTER_2)", event=events.master2_change},
    {rpn="(L:I_ENG_FAULT_1)", event=events.eng1l_change},
    {rpn="(L:I_ENG_FIRE_1)", event=events.eng1u_change},
    {rpn="(L:I_ENG_FAULT_2)", event=events.eng2l_change},
    {rpn="(L:I_ENG_FIRE_2)", event=events.eng2u_change},
    {rpn="(L:S_ENG_MODE)", event=events.mode_change},
    {rpn="(L:I_OH_ELEC_APU_MASTER_L)", event=events.apumasterl_change},
    {rpn="(L:I_OH_ELEC_APU_MASTER_U)", event=events.apumasteru_change},
    {rpn="(L:I_OH_ELEC_APU_START_L)", event=events.apustartl_change},
    {rpn="(L:I_OH_ELEC_APU_START_U)", event=events.apustartu_change},
    {rpn="(L:I_OH_PNEUMATIC_APU_BLEED_L)", event=events.apubleedl_change},
    {rpn="(L:I_OH_PNEUMATIC_APU_BLEED_U)", event=events.apubleedu_change},
    {rpn="(L:I_OH_ELEC_BAT1_L)", event=events.bat1l_change},
    {rpn="(L:I_OH_ELEC_BAT1_U)", event=events.bat1u_change},
    {rpn="(L:I_OH_ELEC_BAT2_L)", event=events.bat2l_change},
    {rpn="(L:I_OH_ELEC_BAT2_U)", event=events.bat2u_change},
    {rpn="(L:I_OH_ELEC_EXT_PWR_L)", event=events.extpwrl_change},
    {rpn="(L:I_OH_ELEC_EXT_PWR_U)", event=events.extpwru_change},
    -- {rpn="(A:ELECTRICAL BATTERY VOLTAGE:1, Volts)", event=events.bat1v_change, epsilon=0.05},
    -- {rpn="(A:ELECTRICAL BATTERY VOLTAGE:2, Volts)", event=events.bat2v_change, epsilon=0.05},
}

--------------------------------------------------------------------------------------
-- event-action mappings
--------------------------------------------------------------------------------------
local view_mappings = {
    {event=events.master1_up, action=fs2020.mfwasm.rpn_executer("1 (>L:S_ENG_MASTER_1)")},
    {event=events.master1_down, action=fs2020.mfwasm.rpn_executer("0 (>L:S_ENG_MASTER_1)")},
    {event=events.master2_up, action=fs2020.mfwasm.rpn_executer("1 (>L:S_ENG_MASTER_2)")},
    {event=events.master2_down, action=fs2020.mfwasm.rpn_executer("0 (>L:S_ENG_MASTER_2)")},
    {event=events.mode_left, action=fs2020.mfwasm.rpn_executer("(L:S_ENG_MODE) -- 0 max (>L:S_ENG_MODE)")},
    {event=events.mode_right, action=fs2020.mfwasm.rpn_executer("(L:S_ENG_MODE) ++ 2 min (>L:S_ENG_MODE)")},
    {event=events.apumaster_push, action=fs2020.mfwasm.rpn_executer("(L:S_OH_ELEC_APU_MASTER) ! (>L:S_OH_ELEC_APU_MASTER)")},
    {event=events.apustart_push, action=filter.duplicator(
        fs2020.mfwasm.rpn_executer("1 (>L:S_OH_ELEC_APU_START)"),
        filter.delay(100, fs2020.mfwasm.rpn_executer("0 (>L:S_OH_ELEC_APU_START)"))
    )},
    {event=events.apubleed_push, action=fs2020.mfwasm.rpn_executer("(L:S_OH_PNEUMATIC_APU_BLEED) ! (>L:S_OH_PNEUMATIC_APU_BLEED)")},
    {event=events.bat1_push, action=fs2020.mfwasm.rpn_executer("(L:S_OH_ELEC_BAT1) ! (>L:S_OH_ELEC_BAT1)")},
    {event=events.bat2_push, action=fs2020.mfwasm.rpn_executer("(L:S_OH_ELEC_BAT2) ! (>L:S_OH_ELEC_BAT2)")},
    {event=events.extpwr_push, action=filter.duplicator(
        fs2020.mfwasm.rpn_executer("(L:S_OH_ELEC_EXT_PWR) ! (>L:S_OH_ELEC_EXT_PWR)"),
        filter.delay(100, fs2020.mfwasm.rpn_executer("(L:S_OH_ELEC_EXT_PWR) ! (>L:S_OH_ELEC_EXT_PWR)"))
    )},
}

local global_mappings = {
}

--------------------------------------------------------------------------------------
-- create view element definitions for Engine master switch
--------------------------------------------------------------------------------------
local view_elements = {}

local eswitch_size = {width=assets.engsw.width, height=assets.engsw.height, rratio=0.1}
local function create_eswitch_bitmap(ix)
    return assets.buttons:create_partial_bitmap(
        assets.engsw.x + eswitch_size.width * ix,
        assets.engsw.y,
        eswitch_size.width,
        eswitch_size.height)
end
local eswitches = {
    master1 = {x=68, y=20, size=eswitch_size, off=create_eswitch_bitmap(0), on=create_eswitch_bitmap(1)},
    master2 = {x=316, y=20, size=eswitch_size, off=create_eswitch_bitmap(2), on=create_eswitch_bitmap(3)},
}

for key, def in pairs(eswitches) do
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.operable_area{
            round_ratio = def.size.rratio,
            event_flick_up = events[key .. "_up"],
            event_flick_down = events[key .. "_down"],
        },
        x = def.x, y = def.y,
        width = def.size.width, height = def.size.height,
    }
    local canvas = mapper.view_elements.canvas{
        logical_width = def.size.width,
        logical_height = def.size.height,
        value = 0,
        renderer = function (ctx, value)
            if value > 0 then
                ctx:draw_bitmap(def.on)
            else
                ctx:draw_bitmap(def.off)
            end
        end,
    }
    view_elements[#view_elements + 1] = {
        object =canvas,
        x = def.x, y = def.y,
        width = def.size.width, height = def.size.height,
    }
    global_mappings[#global_mappings + 1] = {
        event = events[key .. "_change"],
        action = canvas:value_setter()
    }
end

--------------------------------------------------------------------------------------
-- create view element definitions for Engine Mode Knob
--------------------------------------------------------------------------------------
local knob_size = {width=assets.knob.width, height=assets.knob.height, rratio=0.5}
local function create_knob_image(ix)
    local y_gap = 2
    local bitmap = assets.buttons:create_partial_bitmap(
        knob_size.width * ix + assets.knob.x,
        assets.knob.y + y_gap,
        knob_size.width, 
        knob_size.height - y_gap)
    bitmap:set_origin{x=0, y=-y_gap}
    return bitmap
end
local emode_knob = {pos=1, x=194, y=283}
local emodes ={
    {image=create_knob_image(1)},
    {image=create_knob_image(2)},
    {image=create_knob_image(3)},
}

view_elements[#view_elements + 1] = {
    object = mapper.view_elements.operable_area{
        round_ratio = knob_size.rratio,
        event_flick_left = events.mode_left,
        event_flick_right = events.mode_right,
    },
    x = emode_knob.x, y = emode_knob.y,
    width = knob_size.width, height = knob_size.height,
}

local mknob_canvas = mapper.view_elements.canvas{
    logical_width = knob_size.width,
    logical_height = knob_size.height,
    value = emode_knob.pos,
    renderer = function (ctx, value)
        local mode = emodes[value + 1]
        if mode then
            ctx:draw_bitmap(mode.image)
        end
    end
}

view_elements[#view_elements + 1] = {
    object = mknob_canvas,
    x = emode_knob.x, y = emode_knob.y,
    width = knob_size.width, height = knob_size.width,
}

global_mappings[#global_mappings + 1] = {event=events.mode_change, action=mknob_canvas:value_setter()}

--------------------------------------------------------------------------------------
-- create view element definitions for 2 zone indicator buttons
--------------------------------------------------------------------------------------
local dibutton_size = {
    width=assets.sbutton_indicator.width,
    height=assets.sbutton_indicator.height * 2,
    rratio=0.05}
local function create_indicator_image(x, y)
    return assets.buttons:create_partial_bitmap(
        dibutton_size.width * x + assets.sbutton_indicator.x,
        dibutton_size.height / 2 * y + assets.sbutton_indicator.y,
        dibutton_size.width, dibutton_size.height / 2
    )
end
local indicators={
    on_gray = create_indicator_image(1, 0),
    on_skyblue = create_indicator_image(2, 0),
    off_gray = create_indicator_image(5, 0),
    off_white = create_indicator_image(6, 0),
    avail = create_indicator_image(0, 1),
    fault = create_indicator_image(1, 1),
    fault_lower = create_indicator_image(2, 1),
    fire = create_indicator_image(3, 1),
}

local dibuttons = {
    eng1 = {x=43, y=302, size=dibutton_size, l_on=indicators.fault_lower, u_on=indicators.fire},
    eng2 = {x=383, y=302, size=dibutton_size, l_on=indicators.fault_lower, u_on=indicators.fire},
    apubleed = {x=587, y=32, size=dibutton_size, l_off=indicators.on_gray, l_on=indicators.on_skyblue, u_on=indicators.fault},
    apumaster = {x=587, y=218, size=dibutton_size, l_off=indicators.on_gray, l_on=indicators.on_skyblue, u_on=indicators.fault},
    apustart = {x=587, y=348, size=dibutton_size, l_off=indicators.on_gray, l_on=indicators.on_skyblue, u_on=indicators.avail},
    bat1 = {x=806, y=196, size=dibutton_size, l_off=indicators.off_gray, l_on=indicators.off_white, u_on=indicators.fault},
    bat2 = {x=916, y=196, size=dibutton_size, l_off=indicators.off_gray, l_on=indicators.off_white, u_on=indicators.fault},
    extpwr = {x=861, y=346, size=dibutton_size, l_off=indicators.on_gray, l_on=indicators.on_skyblue, u_on=indicators.avail},
}

for key, def in pairs(dibuttons) do
    if events[key .. "_push"] then
        view_elements[#view_elements + 1] = {
            object = mapper.view_elements.operable_area{
                round_ratio = def.size.rratio,
                event_tap = events[key .. "_push"]
            },
            x = def.x, y = def.y,
            width = def.size.width, height = def.size.height
        }
    end
    local lcanvas = mapper.view_elements.canvas{
        logical_width = def.size.width,
        logical_height = def.size.height / 2,
        value = 0,
        renderer = function (ctx, value)
            if value > 0 then
                if def.l_on then ctx:draw_bitmap(def.l_on) end
            else
                if def.l_off then ctx:draw_bitmap(def.l_off) end
            end
        end
    }
    local ucanvas = mapper.view_elements.canvas{
        logical_width = def.size.width,
        logical_height = def.size.height / 2,
        value = 0,
        renderer = function (ctx, value)
            if value > 0 then
                if def.u_on then ctx:draw_bitmap(def.u_on) end
            else
                if def.u_off then ctx:draw_bitmap(def.u_off) end
            end
        end
    }
    view_elements[#view_elements + 1] = {
        object = lcanvas,
        x = def.x, y = def.y + def.size.height / 2,
        width = def.size.width, height = def.size.height / 2
    }
    view_elements[#view_elements + 1] = {
        object = ucanvas,
        x = def.x, y = def.y,
        width = def.size.width, height = def.size.height / 2
    }
    global_mappings[#global_mappings + 1] = {event=events[key .. "l_change"], action=lcanvas:value_setter()}
    global_mappings[#global_mappings + 1] = {event=events[key .. "u_change"], action=ucanvas:value_setter()}
end

--------------------------------------------------------------------------------------
-- create view element definitions for battery voltage meter
--------------------------------------------------------------------------------------
local vmeter_size = {width=90, height=39.474}
local vmeters ={
    bat1v = {x=783, y=97, size=vmeter_size},
    bat2v = {x=941, y=97, size=vmeter_size},
}

for key, def in pairs(vmeters) do
    local canvas = mapper.view_elements.canvas{
        logical_width = assets.sseg.width * 3,
        logical_height = assets.sseg.height,
        value = 0,
        renderer = function (ctx, value)
            ctx:set_font(assets.sseg_font)
            ctx:draw_number{
                value = value,
                precision = 3,
                fraction_precision = 1,
                leading_zero = false,
            }
        end
    }
    view_elements[#view_elements + 1] = {
        object = canvas,
        x = def.x, y = def.y,
        width = def.size.width, height = def.size.height,
    }
    global_mappings[#global_mappings + 1] = {event=events[key .. "_change"], action=canvas:value_setter()}
end

--------------------------------------------------------------------------------------
-- view definition generator
--------------------------------------------------------------------------------------
local function create_view_def(name, window)
    local elements = {}
    for i, element in ipairs(view_elements) do
        elements[#elements + 1] = element
    end
    elements[#elements + 1] = {
        object=window, x= 0, y=view_height - view_width, width=view_width, height=view_width + 2
    }

    return {
        name = name,
        logical_width = view_width, logical_height = view_height,
        background = assets.engine,
        elements = elements,
        mappings = view_mappings,
    }
end

return {viewdef=create_view_def, observed_data=observed_data, mappings=global_mappings}
