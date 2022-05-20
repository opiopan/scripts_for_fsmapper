g1000_dev = mapper.device({
    name = "SimHID G1000",
    type = "simhid",
    identifier = {path = "COM3"},
    modifiers = {
        {class = "binary", modtype = "button"},
        {class = "relative", modtype = "incdec"},
        {name = "SW26", modtype = "button", modparam={longpress = 2000}},
        {name = "SW31", modtype = "button", modparam={longpress = 2000}},
        {name = "EC8U", modtype = "button", modparam={repeat_interval = 80}},
        {name = "EC8D", modtype = "button", modparam={repeat_interval = 80}},
        {name = "EC8R", modtype = "button", modparam={repeat_interval = 80}},
        {name = "EC8L", modtype = "button", modparam={repeat_interval = 80}},
    },
})
local g1000 = g1000_dev.events

mapper.print("G1000 device opened")

local pfd_maps = {
    {event=g1000.EC1.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_VOL_1_INC")},
    {event=g1000.EC1.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_VOL_1_DEC")},
    {event=g1000.EC2X.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_NAV_Small_INC")},
    {event=g1000.EC2X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_NAV_Small_DEC")},
    {event=g1000.EC2Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_NAV_Large_INC")},
    {event=g1000.EC2Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_NAV_Large_DEC")},
    {event=g1000.EC2P.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_NAV_Push")},
    {event=g1000.EC3.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_HEADING_INC")},
    {event=g1000.EC3.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_HEADING_DEC")},
    {event=g1000.EC3P.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_HEADING_SYNC")},
    {event=g1000.EC4X.increment, action=fs2020.event_sender("Mobiflight.AS1000_AP_ALT_INC_100")},
    {event=g1000.EC4X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_AP_ALT_DEC_100")},
    {event=g1000.EC4Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_AP_ALT_INC_1000")},
    {event=g1000.EC4Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_AP_ALT_DEC_1000")},
    {event=g1000.SW1.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_NAV_Switch")},
    {event=g1000.SW2.down, action=fs2020.event_sender("Mobiflight.AP_MASTER")},
    {event=g1000.SW3.down, action=fs2020.event_sender("Mobiflight.TOGGLE_FLIGHT_DIRECTOR")},
    {event=g1000.SW4.down, action=fs2020.event_sender("Mobiflight.AP_HDG_HOLD")},
    {event=g1000.SW5.down, action=fs2020.event_sender("Mobiflight.AP_ALT_HOLD")},
    {event=g1000.SW6.down, action=fs2020.event_sender("Mobiflight.AP_NAV1_HOLD")},
    {event=g1000.SW7.down, action=fs2020.event_sender("Mobiflight.AS1000_AP_VNAV_Push")},
    {event=g1000.SW8.down, action=fs2020.event_sender("Mobiflight.AP_APR_HOLD")},
    {event=g1000.SW9.down, action=fs2020.event_sender("Mobiflight.AP_BC_HOLD")},
    {event=g1000.SW10.down, action=fs2020.event_sender("Mobiflight.AP_PANEL_VS_HOLD")},
    {event=g1000.SW11.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NOSE_UP")},
    {event=g1000.SW12.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_FLC_Push")},
    {event=g1000.SW13.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NOSE_DN")},

    {event=g1000.SW14.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_1")},
    {event=g1000.SW15.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_2")},
    {event=g1000.SW16.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_3")},
    {event=g1000.SW17.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_4")},
    {event=g1000.SW18.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_5")},
    {event=g1000.SW19.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_6")},
    {event=g1000.SW20.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_7")},
    {event=g1000.SW21.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_8")},
    {event=g1000.SW22.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_9")},
    {event=g1000.SW23.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_10")},
    {event=g1000.SW24.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_11")},
    {event=g1000.SW25.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_SOFTKEYS_12")},

    {event=g1000.EC5.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_VOL_2_INC")},
    {event=g1000.EC5.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_VOL_2_DEC")},
    {event=g1000.EC6X.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_COM_Small_INC")},
    {event=g1000.EC6X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_COM_Small_DEC")},
    {event=g1000.EC6Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_COM_Large_INC")},
    {event=g1000.EC6Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_COM_Large_DEC")},
    {event=g1000.EC6P.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_COM_Push")},
    {event=g1000.EC7X.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_CRS_INC")},
    {event=g1000.EC7X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_CRS_DEC")},
    {event=g1000.EC7Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_BARO_INC")},
    {event=g1000.EC7Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_BARO_DEC")},
    {event=g1000.EC7P.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_CRS_PUSH")},
    {event=g1000.EC8.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_RANGE_INC")},
    {event=g1000.EC8.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_RANGE_DEC")},
    {event=g1000.EC8P.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_JOYSTICK_PUSH")},
    {event=g1000.EC8U.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_JOYSTICK_UP")},
    {event=g1000.EC8D.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_JOYSTICK_DOWN")},
    {event=g1000.EC8R.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_JOYSTICK_RIGHT")},
    {event=g1000.EC8L.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_JOYSTICK_LEFT")},
    {event=g1000.EC9X.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_FMS_Upper_INC")},
    {event=g1000.EC9X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_FMS_Upper_DEC")},
    {event=g1000.EC9Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_PFD_FMS_Lower_INC")},
    {event=g1000.EC9Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_PFD_FMS_Lower_DEC")},
    {event=g1000.EC9P.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_FMS_Upper_PUSH")},

    {event=g1000.SW26.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_COM_Switch")},
    {event=g1000.SW26.longpressed, action=fs2020.event_sender("Mobiflight.AS1000_PFD_COM_Switch_Long")},
    {event=g1000.SW27.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_DIRECTTO")},
    {event=g1000.SW28.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_MENU_Push")},
    {event=g1000.SW29.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_FPL_Push")},
    {event=g1000.SW30.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_PROC_Push")},
    {event=g1000.SW31.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_CLR")},
    {event=g1000.SW31.longpressed, action=fs2020.event_sender("Mobiflight.AS1000_PFD_CLR_Long")},
    {event=g1000.SW32.down, action=fs2020.event_sender("Mobiflight.AS1000_PFD_ENT_Push")},
}

local mfd_maps = {
    {event=g1000.EC1.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_VOL_1_INC")},
    {event=g1000.EC1.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_VOL_1_DEC")},
    {event=g1000.EC2X.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NAV_Small_INC")},
    {event=g1000.EC2X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NAV_Small_DEC")},
    {event=g1000.EC2Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NAV_Large_INC")},
    {event=g1000.EC2Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NAV_Large_DEC")},
    {event=g1000.EC2P.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NAV_Push")},
    {event=g1000.EC3.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_HEADING_INC")},
    {event=g1000.EC3.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_HEADING_DEC")},
    {event=g1000.EC3P.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_HEADING_SYNC")},
    {event=g1000.EC4X.increment, action=fs2020.event_sender("Mobiflight.AS1000_AP_ALT_INC_100")},
    {event=g1000.EC4X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_AP_ALT_DEC_100")},
    {event=g1000.EC4Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_AP_ALT_INC_1000")},
    {event=g1000.EC4Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_AP_ALT_DEC_1000")},
    {event=g1000.SW1.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NAV_Switch")},
    {event=g1000.SW2.down, action=fs2020.event_sender("Mobiflight.AP_MASTER")},
    {event=g1000.SW3.down, action=fs2020.event_sender("Mobiflight.TOGGLE_FLIGHT_DIRECTOR")},
    {event=g1000.SW4.down, action=fs2020.event_sender("Mobiflight.AP_HDG_HOLD")},
    {event=g1000.SW5.down, action=fs2020.event_sender("Mobiflight.AP_ALT_HOLD")},
    {event=g1000.SW6.down, action=fs2020.event_sender("Mobiflight.AP_NAV1_HOLD")},
    {event=g1000.SW7.down, action=fs2020.event_sender("Mobiflight.AS1000_AP_VNAV_Push")},
    {event=g1000.SW8.down, action=fs2020.event_sender("Mobiflight.AP_APR_HOLD")},
    {event=g1000.SW9.down, action=fs2020.event_sender("Mobiflight.AP_BC_HOLD")},
    {event=g1000.SW10.down, action=fs2020.event_sender("Mobiflight.AP_PANEL_VS_HOLD")},
    {event=g1000.SW11.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NOSE_UP")},
    {event=g1000.SW12.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_FLC_Push")},
    {event=g1000.SW13.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_NOSE_DN")},

    {event=g1000.SW14.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_1")},
    {event=g1000.SW15.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_2")},
    {event=g1000.SW16.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_3")},
    {event=g1000.SW17.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_4")},
    {event=g1000.SW18.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_5")},
    {event=g1000.SW19.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_6")},
    {event=g1000.SW20.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_7")},
    {event=g1000.SW21.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_8")},
    {event=g1000.SW22.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_9")},
    {event=g1000.SW23.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_10")},
    {event=g1000.SW24.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_11")},
    {event=g1000.SW25.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_SOFTKEYS_12")},

    {event=g1000.EC5.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_VOL_2_INC")},
    {event=g1000.EC5.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_VOL_2_DEC")},
    {event=g1000.EC6X.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_COM_Small_INC")},
    {event=g1000.EC6X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_COM_Small_DEC")},
    {event=g1000.EC6Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_COM_Large_INC")},
    {event=g1000.EC6Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_COM_Large_DEC")},
    {event=g1000.EC6P.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_COM_Push")},
    {event=g1000.EC7X.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_CRS_INC")},
    {event=g1000.EC7X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_CRS_DEC")},
    {event=g1000.EC7Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_BARO_INC")},
    {event=g1000.EC7Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_BARO_DEC")},
    {event=g1000.EC7P.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_CRS_PUSH")},
    {event=g1000.EC8.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_RANGE_INC")},
    {event=g1000.EC8.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_RANGE_DEC")},
    {event=g1000.EC8P.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_JOYSTICK_PUSH")},
    {event=g1000.EC8U.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_JOYSTICK_UP")},
    {event=g1000.EC8D.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_JOYSTICK_DOWN")},
    {event=g1000.EC8R.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_JOYSTICK_RIGHT")},
    {event=g1000.EC8L.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_JOYSTICK_LEFT")},
    {event=g1000.EC9X.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_FMS_Upper_INC")},
    {event=g1000.EC9X.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_FMS_Upper_DEC")},
    {event=g1000.EC9Y.increment, action=fs2020.event_sender("Mobiflight.AS1000_MFD_FMS_Lower_INC")},
    {event=g1000.EC9Y.decrement, action=fs2020.event_sender("Mobiflight.AS1000_MFD_FMS_Lower_DEC")},
    {event=g1000.EC9P.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_FMS_Upper_PUSH")},

    {event=g1000.SW26.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_COM_Switch")},
    {event=g1000.SW26.longpressed, action=fs2020.event_sender("Mobiflight.AS1000_MFD_COM_Switch_Long")},
    {event=g1000.SW27.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_DIRECTTO")},
    {event=g1000.SW28.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_MENU_Push")},
    {event=g1000.SW29.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_FPL_Push")},
    {event=g1000.SW30.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_PROC_Push")},
    {event=g1000.SW31.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_CLR")},
    {event=g1000.SW31.longpressed, action=fs2020.event_sender("Mobiflight.AS1000_MFD_CLR_Long")},
    {event=g1000.SW32.down, action=fs2020.event_sender("Mobiflight.AS1000_MFD_ENT_Push")},
}

mapper.print("mapping table has been created")

local scale = (16.0 / 9.0) / (16.0 / 9.0)
local view_size = 0.5

local viewport = mapper.viewport({
    name = "G1000 Viewport",
    displayno = 1,
    x = 0.03, y = 0.05, 
    width = view_size * scale,
    height = view_size,
    -- displayno = 2,
    aspect_ratio = 4.0 / 3.0,
    horizontal_alignment = "center",
    vertical_alignment = "center",

    bgcolor = graphics.color(0, 0, 128),
})

local pfd = viewport:register_view({
    name = "PFD",
    background = graphics.color("Aqua", 0.1),
    elements = {{object = mapper.captured_window({name = "G1000 PFD", omit_system_region = true}),}},
    mappings = pfd_maps,
})

local macdu_1 = mapper.register_event("macdu-1")

local mfd = viewport:register_view({
    name = "MFD",
    logical_width = 581,
    logical_height = 911,
    horizontal_alignment = "right",
    vertical_alignment = "center",
    background = graphics.bitmap("assets/macdu2.png"),
    elements = {
        {
            object = mapper.view_objects.operable_area({
                reaction_color = graphics.color("yellow", 0.25),
                round_ratio = 0.1,
                event_tap = macdu_1,
            }),
            x = 239, y = 550,
            width = 42, height = 41,
        },
        {
            object = mapper.view_objects.captured_window({name = "G1000 MFD"}),
            x = 94, y = 78,
            width = 397, height = 334,
        },
    },
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
})
viewport:add_mappings({
    {event=g1000.AUX2D.down, action=toggle_view},
    {event=g1000.AUX2U.down, action=toggle_view},
})

mapper.start_viewports()
