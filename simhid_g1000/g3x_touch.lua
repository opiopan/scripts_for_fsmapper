local context = {
    g3x_touch_view = require("lib/g3x_touch_view")
}

local aircraft_defs = {}
aircraft_defs["Asobo NXCub"] = {views={"G3X Touch PFD"}, aptype=1}
aircraft_defs["Asobo XCub"] = {views={"G3X Touch PFD"}, aptype=1}
aircraft_defs["Asobo XCub Floats"] = {views={"G3X Touch PFD"}, aptype=1}
aircraft_defs["Asobo XCub Skis"] = {views={"G3X Touch PFD"}, aptype=1}
aircraft_defs["Beechcraft King Air 350i Asobo"] = {views={"G3X Touch PFD","G3X Touch MFD"}, aptype=2}
aircraft_defs["VL3 Asobo"] = {views={"G3X Touch PFD","G3X Touch MFD"}}
aircraft_fallback = {views={"G3X Touch PFD"}}

function context.start(config, aircraft)
    local display = config.simhid_g1000_display
    local scale = 1.0
    if config.debug then
        display = 1
        scale = 0.5
    end

    local viewport = mapper.viewport{
        name = "G3X Touch",
        displayno = display,
        x = 0, y = 0, width = scale, height = scale,
        aspect_raio = 2 / 3,
    }

    context.device = mapper.device{
        name = "SimHID G1000",
        type = "simhid",
        identifier = config.simhid_g1000_identifier,
        modifiers = {
            {class = "binary", modtype = "button"},
            {class = "relative", modtype = "incdec"},
        },
    }
    local g1000 = context.device.events
    context.g3x_touch_view.init(context.device)

    local aircraft_def = aircraft_defs[aircraft]
    if not aircraft_def then
        aircraft_def = aircraft_fallback
    end

    context.views = {}
    for i, name in ipairs(aircraft_def.views) do
        context.views[i] = viewport:register_view(context.g3x_touch_view.create_view(name, i))
    end

    context.current_view = 1
    local function change_view(d)
        context.current_view = context.current_view + 1
        if context.current_view > #context.views then
            context.current_view = 1
        elseif context.current_view < 1 then
            context.current_view = #context.views
        end
        viewport:change_view(context.views[context.current_view])
    end

    viewport:set_mappings{
        {event=g1000.AUX1D.down, action=function () change_view(1) end},
        {event=g1000.AUX1U.down, action=function () change_view(-1) end},
        {event=g1000.AUX2D.down, action=function () change_view(1) end},
        {event=g1000.AUX2U.down, action=function () change_view(-1) end},
    }

    if aircraft_def.aptype == 1 then
        viewport:add_mappings{
            {event=g1000.SW2.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_MASTER)")},
            {event=g1000.SW3.down, action=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT MASTER, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) }")},
            {event=g1000.SW4.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_PANEL_HEADING_HOLD)")},
            {event=g1000.SW5.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_ALT_HOLD)")},
            {event=g1000.SW6.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_NAV1_HOLD)")},
            {event=g1000.SW7.down, action=fs2020.mfwasm.rpn_executer("(L:XMLVAR_VNAVButtonValue) ! (>L:XMLVAR_VNAVButtonValue)")},
            {event=g1000.SW8.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_APR_HOLD)")},
            {event=g1000.SW10.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_PANEL_VS_HOLD) 1 0 (>K:2:AP_VS_VAR_SET_ENGLISH)")},
            {event=g1000.SW12.down, action=fs2020.mfwasm.rpn_executer("(>K:FLIGHT_LEVEL_CHANGE) (A:AUTOPILOT FLIGHT LEVEL CHANGE, bool) if { (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET) }")},
            {event=g1000.SW11.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_SPD_VAR_DEC) (>K:AP_VS_VAR_INC)")},
            {event=g1000.SW13.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_SPD_VAR_INC) (>K:AP_VS_VAR_DEC)")},
            {event=g1000.EC3.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
            {event=g1000.EC3.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
            {event=g1000.EC2X.increment, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC2X.decrement, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC2Y.increment, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC2Y.decrement, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
        }
    elseif aircraft_def.aptype == 2 then
        viewport:add_mappings{
            {event=g1000.SW2.down, action=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) if{ (A:AUTOPILOT FLIGHT DIRECTOR ACTIVE, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) } } (L:XMLVAR_APTrim) 0 == if{ (A:AUTOPILOT YAW DAMPER, Bool) ! (A:AUTOPILOT MASTER, bool) and if{ (K:YAW_DAMPER_TOGGLE) } } (A:AUTOPILOT MASTER, Bool) ! if{ (H:Generic_Autopilot_Manual_Off) } }")},
            {event=g1000.SW3.down, action=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT MASTER, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) }")},
            {event=g1000.SW4.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_PANEL_HEADING_HOLD)")},
            {event=g1000.SW5.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_ALT_HOLD)")},
            {event=g1000.SW6.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_NAV1_HOLD)")},
            {event=g1000.SW7.down, action=fs2020.mfwasm.rpn_executer("(L:XMLVAR_VNAVButtonValue) ! (>L:XMLVAR_VNAVButtonValue)")},
            {event=g1000.SW8.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_APR_HOLD)")},
            {event=g1000.SW10.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_PANEL_VS_HOLD) 1 0 (>K:2:AP_VS_VAR_SET_ENGLISH)")},
            {event=g1000.SW12.down, action=fs2020.mfwasm.rpn_executer("(>K:FLIGHT_LEVEL_CHANGE) (A:AUTOPILOT FLIGHT LEVEL CHANGE, bool) if { (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET) }")},
            {event=g1000.SW11.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_SPD_VAR_DEC) (>K:AP_VS_VAR_INC)")},
            {event=g1000.SW13.down, action=fs2020.mfwasm.rpn_executer("(>K:AP_SPD_VAR_INC) (>K:AP_VS_VAR_DEC)")},
            {event=g1000.EC3.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
            {event=g1000.EC3.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
            {event=g1000.EC2X.increment, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC2X.decrement, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC2Y.increment, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC2Y.decrement, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC2P.down, action=fs2020.mfwasm.rpn_executer("(A:INDICATED ALTITUDE, feet) (>K:AP_ALT_VAR_SET_ENGLISH) (>H:AP_KNOB)")},
            {event=g1000.EC7X.increment, action=fs2020.mfwasm.rpn_executer("(>K:VOR1_OBI_INC)")},
            {event=g1000.EC7X.decrement, action=fs2020.mfwasm.rpn_executer("(>K:VOR1_OBI_DEC)")},
            {event=g1000.EC7P.down, action=fs2020.mfwasm.rpn_executer("(A:HEADING INDICATOR,degrees) (>K:VOR1_SET)")},
        }
end

    return {
        move_next_view = function () change_view(1) end,
        move_previous_view = function () change_view(-1) end,
        global_mappings = {},
        need_to_start_viewports = true,
    }
end

function context.stop()
    context.views = nil
    context.g3x_touch_view.term()
    context.device:close()
    context.device = nil
    fs2020.mfwasm.clear_observed_data()
end

return context