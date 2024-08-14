local g1000_context ={}

local common = require('lib/common')

local function start(config)
    g1000_context.device = common.open_simhid_g1000{
        config = config,
        modifiers = {
            {class = "binary", modtype = "button"},
            {name = "SW26", modtype = "button", modparam={longpress = 2000}},
            {name = "SW31", modtype = "button", modparam={longpress = 2000}},
            {name = "EC8U", modtype = "button", modparam={repeat_interval = 80}},
            {name = "EC8D", modtype = "button", modparam={repeat_interval = 80}},
            {name = "EC8R", modtype = "button", modparam={repeat_interval = 80}},
            {name = "EC8L", modtype = "button", modparam={repeat_interval = 80}},
        },
    }
    local g1000 = g1000_context.device.events

    local pfd_maps = {
        {event=g1000.EC1.change, action=msfs.input_event_executer("AS1000_PFD_1_NAV_Volume")},
        {event=g1000.EC2X.change, action=msfs.input_event_executer("AS1000_PFD_1_NAV_Khz")},
        {event=g1000.EC2Y.change, action=msfs.input_event_executer("AS1000_PFD_1_NAV_Mhz")},
        {event=g1000.EC2P.down, action=msfs.input_event_executer("AS1000_PFD_1_NAV_Khz_Button", 1)},
        {event=g1000.EC3.change, action=msfs.input_event_executer("AS1000_PFD_1_Heading")},
        {event=g1000.EC3P.down, action=msfs.input_event_executer("AS1000_PFD_1_Heading_Sync", 1)},
        {event=g1000.EC4X.change, action=msfs.input_event_executer("AS1000_PFD_1_Altitude_100")},
        {event=g1000.EC4Y.change, action=msfs.input_event_executer("AS1000_PFD_1_Altitude_1000")},
        {event=g1000.SW1.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_NAV_Switch)")},
        {event=g1000.SW2.down, action=msfs.mfwasm.rpn_executer("(>K:AP_MASTER)")},
        {event=g1000.SW3.down, action=msfs.mfwasm.rpn_executer("(>K:TOGGLE_FLIGHT_DIRECTOR)")},
        {event=g1000.SW4.down, action=msfs.mfwasm.rpn_executer("(>K:AP_HDG_HOLD)")},
        {event=g1000.SW5.down, action=msfs.mfwasm.rpn_executer("(>K:AP_ALT_HOLD)")},
        {event=g1000.SW6.down, action=msfs.mfwasm.rpn_executer("(>K:AP_NAV1_HOLD)")},
        {event=g1000.SW7.down, action=msfs.mfwasm.rpn_executer("(L:XMLVAR_VNAVButtonValue, Bool) ! (>L:XMLVAR_VNAVButtonValue)")},
        {event=g1000.SW8.down, action=msfs.mfwasm.rpn_executer("(>K:AP_APR_HOLD)")},
        {event=g1000.SW9.down, action=msfs.mfwasm.rpn_executer("(>K:AP_BC_HOLD)")},
        {event=g1000.SW10.down, action=msfs.mfwasm.rpn_executer("(>K:AP_PANEL_VS_HOLD)")},
        {event=g1000.SW11.down, action=msfs.mfwasm.rpn_executer("(A:AUTOPILOT VERTICAL HOLD, Bool) if{ (>K:AP_VS_VAR_INC) (>H:AP_DN) } (A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool) if{ (>K:AP_SPD_VAR_DEC) } (A:AUTOPILOT PITCH HOLD, Bool) if{ (>K:AP_PITCH_REF_INC_UP) }")},
        {event=g1000.SW12.down, action=msfs.mfwasm.rpn_executer("(>K:FLIGHT_LEVEL_CHANGE) (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET)")},
        {event=g1000.SW13.down, action=msfs.mfwasm.rpn_executer("(A:AUTOPILOT VERTICAL HOLD, Bool) if{ (>K:AP_VS_VAR_DEC) (>H:AP_UP) } (A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool) if{ (>K:AP_SPD_VAR_INC) } (A:AUTOPILOT PITCH HOLD, Bool) if{ (>K:AP_PITCH_REF_INC_DN) }")},

        {event=g1000.SW14.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_1)")},
        {event=g1000.SW15.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_2)")},
        {event=g1000.SW16.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_3)")},
        {event=g1000.SW17.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_4)")},
        {event=g1000.SW18.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_5)")},
        {event=g1000.SW19.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_6)")},
        {event=g1000.SW20.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_7)")},
        {event=g1000.SW21.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_8)")},
        {event=g1000.SW22.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_9)")},
        {event=g1000.SW23.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_10)")},
        {event=g1000.SW24.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_11)")},
        {event=g1000.SW25.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_SOFTKEYS_12)")},

        {event=g1000.EC5.change, action=msfs.input_event_executer("AS1000_PFD_1_COM_Volume")},
        {event=g1000.EC6X.change, action=msfs.input_event_executer("AS1000_PFD_1_COM_Khz")},
        {event=g1000.EC6Y.change, action=msfs.input_event_executer("AS1000_PFD_1_COM_Mhz")},
        {event=g1000.EC6P.down, action=msfs.input_event_executer("AS1000_PFD_1_COM_Khz_Button", 1)},
        {event=g1000.EC7X.change, action=msfs.input_event_executer("AS1000_PFD_1_Course")},
        {event=g1000.EC7Y.change, action=msfs.input_event_executer("AS1000_PFD_1_Baro")},
        {event=g1000.EC7P.down, action=msfs.input_event_executer("AS1000_PFD_1_Course_Button", 1)},
        {event=g1000.EC8.change, action=msfs.input_event_executer("AS1000_PFD_1_Range_Zoom")},
        {event=g1000.EC8P.down, action=msfs.input_event_executer("AS1000_PFD_1_Range_Cursor", 1)},
        {event=g1000.EC8U.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_JOYSTICK_UP)")},
        {event=g1000.EC8D.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_JOYSTICK_DOWN)")},
        {event=g1000.EC8R.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_JOYSTICK_RIGHT)")},
        {event=g1000.EC8L.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_JOYSTICK_LEFT)")},
        {event=g1000.EC9X.change, action=msfs.input_event_executer("AS1000_PFD_1_FMS_Inner")},
        {event=g1000.EC9Y.change, action=msfs.input_event_executer("AS1000_PFD_1_FMS_Outer")},
        {event=g1000.EC9P.down, action=msfs.input_event_executer("AS1000_PFD_1_FMS_Inner_Button", 1)},

        {event=g1000.SW26.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_COM_Switch)")},
        {event=g1000.SW26.longpressed, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_COM_Switch_Long)")},
        {event=g1000.SW27.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_DIRECTTO)")},
        {event=g1000.SW28.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_MENU_Push)")},
        {event=g1000.SW29.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_FPL_Push)")},
        {event=g1000.SW30.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_PROC_Push)")},
        {event=g1000.SW31.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_CLR)")},
        {event=g1000.SW31.longpressed, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_CLR_Long)")},
        {event=g1000.SW32.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_PFD_ENT_Push)")},
    }

    local mfd_maps = {
        {event=g1000.EC1.change, action=msfs.input_event_executer("AS1000_MFD_1_NAV_Volume")},
        {event=g1000.EC2X.change, action=msfs.input_event_executer("AS1000_MFD_1_NAV_Khz")},
        {event=g1000.EC2Y.change, action=msfs.input_event_executer("AS1000_MFD_1_NAV_Mhz")},
        {event=g1000.EC2P.down, action=msfs.input_event_executer("AS1000_MFD_1_NAV_Khz_Button", 1)},
        {event=g1000.EC3.change, action=msfs.input_event_executer("AS1000_MFD_1_Heading")},
        {event=g1000.EC3P.down, action=msfs.input_event_executer("AS1000_MFD_1_Heading_Sync", 1)},
        {event=g1000.EC4X.change, action=msfs.input_event_executer("AS1000_MFD_1_Altitude_100")},
        {event=g1000.EC4Y.change, action=msfs.input_event_executer("AS1000_MFD_1_Altitude_1000")},
        {event=g1000.SW1.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_NAV_Switch)")},
        {event=g1000.SW2.down, action=msfs.mfwasm.rpn_executer("(>K:AP_MASTER)")},
        {event=g1000.SW3.down, action=msfs.mfwasm.rpn_executer("(>K:TOGGLE_FLIGHT_DIRECTOR)")},
        {event=g1000.SW4.down, action=msfs.mfwasm.rpn_executer("(>K:AP_HDG_HOLD)")},
        {event=g1000.SW5.down, action=msfs.mfwasm.rpn_executer("(>K:AP_ALT_HOLD)")},
        {event=g1000.SW6.down, action=msfs.mfwasm.rpn_executer("(>K:AP_NAV1_HOLD)")},
        {event=g1000.SW7.down, action=msfs.mfwasm.rpn_executer("(L:XMLVAR_VNAVButtonValue, Bool) ! (>L:XMLVAR_VNAVButtonValue)")},
        {event=g1000.SW8.down, action=msfs.mfwasm.rpn_executer("(>K:AP_APR_HOLD)")},
        {event=g1000.SW9.down, action=msfs.mfwasm.rpn_executer("(>K:AP_BC_HOLD)")},
        {event=g1000.SW10.down, action=msfs.mfwasm.rpn_executer("(>K:AP_PANEL_VS_HOLD)")},
        {event=g1000.SW11.down, action=msfs.mfwasm.rpn_executer("(A:AUTOPILOT VERTICAL HOLD, Bool) if{ (>K:AP_VS_VAR_INC) (>H:AP_DN) } (A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool) if{ (>K:AP_SPD_VAR_DEC) } (A:AUTOPILOT PITCH HOLD, Bool) if{ (>K:AP_PITCH_REF_INC_UP) }")},
        {event=g1000.SW12.down, action=msfs.mfwasm.rpn_executer("(>K:FLIGHT_LEVEL_CHANGE) (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET)")},
        {event=g1000.SW13.down, action=msfs.mfwasm.rpn_executer("(A:AUTOPILOT VERTICAL HOLD, Bool) if{ (>K:AP_VS_VAR_DEC) (>H:AP_UP) } (A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool) if{ (>K:AP_SPD_VAR_INC) } (A:AUTOPILOT PITCH HOLD, Bool) if{ (>K:AP_PITCH_REF_INC_DN) }")},

        {event=g1000.SW14.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_1)")},
        {event=g1000.SW15.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_2)")},
        {event=g1000.SW16.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_3)")},
        {event=g1000.SW17.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_4)")},
        {event=g1000.SW18.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_5)")},
        {event=g1000.SW19.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_6)")},
        {event=g1000.SW20.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_7)")},
        {event=g1000.SW21.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_8)")},
        {event=g1000.SW22.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_9)")},
        {event=g1000.SW23.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_10)")},
        {event=g1000.SW24.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_11)")},
        {event=g1000.SW25.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_SOFTKEYS_12)")},

        {event=g1000.EC5.change, action=msfs.input_event_executer("AS1000_MFD_1_COM_Volume")},
        {event=g1000.EC6X.change, action=msfs.input_event_executer("AS1000_MFD_1_COM_Khz")},
        {event=g1000.EC6Y.change, action=msfs.input_event_executer("AS1000_MFD_1_COM_Mhz")},
        {event=g1000.EC6P.down, action=msfs.input_event_executer("AS1000_MFD_1_COM_Khz_Button", 1)},
        {event=g1000.EC7X.change, action=msfs.input_event_executer("AS1000_MFD_1_Course")},
        {event=g1000.EC7Y.change, action=msfs.input_event_executer("AS1000_MFD_1_Baro")},
        {event=g1000.EC7P.down, action=msfs.input_event_executer("AS1000_MFD_1_Course_Button", 1)},
        {event=g1000.EC8.change, action=msfs.input_event_executer("AS1000_MFD_1_Range_Zoom")},
        {event=g1000.EC8P.down, action=msfs.input_event_executer("AS1000_MFD_1_Range_Cursor", 1)},
        {event=g1000.EC8U.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_JOYSTICK_UP)")},
        {event=g1000.EC8D.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_JOYSTICK_DOWN)")},
        {event=g1000.EC8R.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_JOYSTICK_RIGHT)")},
        {event=g1000.EC8L.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_JOYSTICK_LEFT)")},
        {event=g1000.EC9X.change, action=msfs.input_event_executer("AS1000_MFD_1_FMS_Inner")},
        {event=g1000.EC9Y.change, action=msfs.input_event_executer("AS1000_MFD_1_FMS_Outer")},
        {event=g1000.EC9P.down, action=msfs.input_event_executer("AS1000_MFD_1_FMS_Inner_Button", 1)},

        {event=g1000.SW26.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_COM_Switch)")},
        {event=g1000.SW26.longpressed, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_COM_Switch_Long)")},
        {event=g1000.SW27.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_DIRECTTO)")},
        {event=g1000.SW28.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_MENU_Push)")},
        {event=g1000.SW29.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_FPL_Push)")},
        {event=g1000.SW30.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_PROC_Push)")},
        {event=g1000.SW31.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_CLR)")},
        {event=g1000.SW31.longpressed, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_CLR_Long)")},
        {event=g1000.SW32.down, action=msfs.mfwasm.rpn_executer("(>H:AS1000_MFD_ENT_Push)")},
    }

    local displayno = config.simhid_g1000_display
    local scale = config.simhid_g1000_display_scale
    
    local viewport = mapper.viewport({
        name = "G1000 Viewport",
        displayno = displayno,
        x = 0, y = 0,
        width = scale, height = scale,
        bgcolor = "Black",
        aspect_ratio = 4.0 / 3.0,
    })
    local pfd = viewport:register_view({
        name = "PFD",
        elements = {{object = mapper.captured_window({name = "G1000 PFD", window_title="AS1000_PFD"})}},
        mappings = pfd_maps,
    })
    local mfd = viewport:register_view({
        name = "MFD",
        elements = {{object = mapper.captured_window({name = "G1000 MFD", window_title="AS1000_MFD"})}},
        mappings = mfd_maps,
    })

    local function toggle_view()
        if viewport.current_view == pfd then
            viewport:change_view(mfd)
        else
            viewport:change_view(pfd)
        end
    end

    viewport:set_mappings({
        {event=g1000.AUX1D.down, action=toggle_view},
        {event=g1000.AUX1U.down, action=toggle_view},
        {event=g1000.AUX2D.down, action=toggle_view},
        {event=g1000.AUX2U.down, action=toggle_view},
    })

    return {
        move_next_view = toggle_view,
        move_previous_view = toggle_view,
        global_mappings = {},
        need_to_start_viewports = true,
    }
end

local function stop()
    g1000_context.device:close()
    g1000_context.device = nil
end

return {
    start = start,
    stop = stop,
}
