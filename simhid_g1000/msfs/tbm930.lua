local context = {
    afcs_view = require("tbm930/afcs"),
    g3000_view = require("tbm930/g3000"),
    tsc_view = require("tbm930/tsc"),
}

local common = require('lib/common')

function context.start(config, aircraft)
    local display = config.simhid_g1000_display
    local scale = config.simhid_g1000_display_scale

    context.device = common.open_simhid_g1000{
        config = config,
        modifiers = {
            {class = "binary", modtype = "button"},
            {class = "relative", modtype = "incdec"},
            {name = "EC6P", modtype = "button", modparam={longpress = 2000}},
            {name = "SW11", modtype = "button", modparam={repeat_interval = 150, repeat_delay = 500}},
            {name = "SW13", modtype = "button", modparam={repeat_interval = 150, repeat_delay = 500}},
        },
    }
    local g1000 = context.device.events

    local global_mappings = {}
    msfs.mfwasm.add_observed_data(context.afcs_view.observed_data)
    global_mappings[#global_mappings + 1] = context.afcs_view.mappings
    context.afcs_view.init(context.device)
    msfs.mfwasm.add_observed_data(context.g3000_view.observed_data)
    global_mappings[#global_mappings + 1] = context.g3000_view.mappings
    context.g3000_view.init(context.device)
    msfs.mfwasm.add_observed_data(context.tsc_view.observed_data)
    global_mappings[#global_mappings + 1] = context.tsc_view.mappings
    context.tsc_view.init(context.device)
    
    local viewport_afcs = mapper.viewport{
        name = "TBM 930 AFCS Viewport",
        displayno = display,
        x = 0, y = 0,
        width = scale, height = 2 / 12 * scale,
        aspect_ratio = 16 / 2,
        horizontal_alignment = "center",
        vertical_alignment = "bottom",
    }
    viewport_afcs:register_view(context.afcs_view.create_view("TBM930 AFCS"))

    local viewport_main = mapper.viewport{
        name = "TBM 930 Main Viewport",
        displayno = display,
        x = 0, y = 2/ 12 * scale,
        width = scale, height = 10 / 12 * scale,
        aspect_ratio = 16 / 10,
        horizontal_alignment = "center",
        vertical_alignment = "top",
    }
    context.views = {
        viewport_main:register_view(context.g3000_view.create_view("G3000 PFD", "PFD_1")),
        viewport_main:register_view(context.g3000_view.create_view("G3000 MFD", "MFD")),
        viewport_main:register_view(context.tsc_view.create_view("G3000 TSC")),
    }

    context.current_view = 1
    local function change_view(d)
        context.current_view = context.current_view + d
        if context.current_view > #context.views then
            context.current_view = 1
        elseif context.current_view < 1 then
            context.current_view = #context.views
        end
        viewport_main:change_view(context.views[context.current_view])
    end

    viewport_main:set_mappings{
        {event=g1000.AUX1D.down, action=function () change_view(1) end},
        {event=g1000.AUX1U.down, action=function () change_view(-1) end},
        {event=g1000.AUX2D.down, action=function () change_view(1) end},
        {event=g1000.AUX2U.down, action=function () change_view(-1) end},

        {event=g1000.SW2.down, action=msfs.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } els{ (A:AUTOPILOT YAW DAMPER, Bool) ! if{ (>K:YAW_DAMPER_TOGGLE) } } }")},
        {event=g1000.SW3.down, action=msfs.mfwasm.rpn_executer("1 (>K:TOGGLE_FLIGHT_DIRECTOR)")},
        {event=g1000.SW4.down, action=msfs.mfwasm.rpn_executer("(>K:AP_PANEL_HEADING_HOLD)")},
        {event=g1000.SW5.down, action=msfs.mfwasm.rpn_executer("(>K:AP_ALT_HOLD)")},
        {event=g1000.SW6.down, action=msfs.mfwasm.rpn_executer("(>K:AP_NAV1_HOLD)")},
        {event=g1000.SW7.down, action=msfs.mfwasm.rpn_executer("(L:XMLVAR_VNAVButtonValue) ! (>L:XMLVAR_VNAVButtonValue)")},
        {event=g1000.SW8.down, action=msfs.mfwasm.rpn_executer("(>K:AP_APR_HOLD)")},
        {event=g1000.SW9.down, action=msfs.mfwasm.rpn_executer("(>K:AP_BC_HOLD)")},
        {event=g1000.SW10.down, action=msfs.mfwasm.rpn_executer("(>K:AP_PANEL_VS_HOLD) 1 0 (>K:2:AP_VS_VAR_SET_ENGLISH)")},
        {event=g1000.SW12.down, action=msfs.mfwasm.rpn_executer("(>K:FLIGHT_LEVEL_CHANGE) (A:AUTOPILOT FLIGHT LEVEL CHANGE, bool) if { (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET) }")},
        {event=g1000.SW11.down, action=msfs.mfwasm.rpn_executer("(>K:AP_SPD_VAR_DEC) (>K:AP_VS_VAR_INC)")},
        {event=g1000.SW13.down, action=msfs.mfwasm.rpn_executer("(>K:AP_SPD_VAR_INC) (>K:AP_VS_VAR_DEC)")},
        {event=g1000.SW28.down, action=msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Menu_Push)")},
        {event=g1000.EC3.increment, action=msfs.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
        {event=g1000.EC3.decrement, action=msfs.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
        {event=g1000.EC3P.down, action=msfs.mfwasm.rpn_executer("(A:HEADING INDICATOR,degrees) (>K:HEADING_BUG_SET)")},
        {event=g1000.EC4X.increment, action=msfs.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
        {event=g1000.EC4X.decrement, action=msfs.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
        {event=g1000.EC4Y.increment, action=msfs.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
        {event=g1000.EC4Y.decrement, action=msfs.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
        {event=g1000.EC4P.down, action=msfs.mfwasm.rpn_executer("(A:INDICATED ALTITUDE, feet) (>K:AP_ALT_VAR_SET_ENGLISH) (>H:AP_KNOB)")},
        {event=g1000.EC7X.increment, action=msfs.mfwasm.rpn_executer("(>H:AS3000_PFD_1_CRS_INC)")},
        {event=g1000.EC7X.decrement, action=msfs.mfwasm.rpn_executer("(>H:AS3000_PFD_1_CRS_DEC)")},
        {event=g1000.EC7P.down, action=msfs.mfwasm.rpn_executer("(>H:AS3000_PFD_1_CRS_PUSH)")},
        {event=g1000.EC7Y.increment, action=msfs.mfwasm.rpn_executer("1 (>K:KOHLSMAN_INC) (>H:AP_BARO_Up)")},
        {event=g1000.EC7Y.decrement, action=msfs.mfwasm.rpn_executer("1 (>K:KOHLSMAN_DEC) (>H:AP_BARO_Down)")},

        {event=g1000.EC6Y.increment, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_TopKnob_Large_INC)")},
        {event=g1000.EC6Y.decrement, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_TopKnob_Large_DEC)")},
        {event=g1000.EC6X.increment, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_TopKnob_Small_INC)")},
        {event=g1000.EC6X.decrement, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_TopKnob_Small_DEC)")},
        {event=g1000.EC6P.up, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_TopKnob_Push)")},
        {event=g1000.EC6P.longpressed, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_TopKnob_Push_Long)")},
        {event=g1000.EC9Y.increment, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_BottomKnob_Small_INC)")},
        {event=g1000.EC9Y.decrement, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_BottomKnob_Small_DEC)")},
        {event=g1000.EC9X.increment, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_BottomKnob_Small_INC)")},
        {event=g1000.EC9X.decrement, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_BottomKnob_Small_DEC)")},
        {event=g1000.EC9P.down, action=msfs.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_BottomKnob_Push)")},
    }

    return {
        move_next_view = function () change_view(1) end,
        move_previous_view = function () change_view(-1) end,
        global_mappings = global_mappings,
        need_to_start_viewports = true,
    }
end

function context.stop()
    context.views = nil
    context.afcs_view.term()
    context.g3000_view.term()
    context.tsc_view.term()
    context.device:close()
    context.device = nil
    msfs.mfwasm.clear_observed_data()
end

return context