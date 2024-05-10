local module = {}

local common = require("lib/common")
local libs = {
    fcu = require("lib/longitude_fcu"),
    cw = require("lib/captured_window"),
}
local lib_options = {}

local captured_window_defs ={
    {key="pfd", name="G5000 PFD", window_title="WTG3000_PFD_1"},
    {key="mfd", name="G5000 MFD", window_title="WTG3000_MFD"},
    {key="gtc_pfd", name="GTC for PFD", window_title="WTG3000_GTC_1"},
    {key="gtc_mfdl", name="GTC for MFD (Left)", window_title="WTG3000_GTC_2"},
    {key="gtc_mfdr", name="GTC for MFD (Right)", window_title="WTG3000_GTC_3"},
}

local views_fcu = {
    {
        -----------------------------------------------------------------------------------
        name = "FCU View",
        width = libs.fcu.width, height = libs.fcu.height,
        components = {
            {name="FCU", module=libs.fcu, cw=nil, type_id=1, x=0, y=0, scale=1},
        },
    },
}

local main_view_height = 1668 - libs.fcu.height
local gtc_height = 1264
local gtc_width = 948
local views_main = {
    {
        -----------------------------------------------------------------------------------
        name = "PFD View",
        width = libs.fcu.width, height = main_view_height,
        components = {
            {name="PFD", module=libs.cw, cw="pfd", type_id=1, x=0, y=0, options={width=libs.fcu.width, height=main_view_height}},
        },
    },
    {
        -----------------------------------------------------------------------------------
        name = "PFD + GTC View",
        width = libs.fcu.width, height = main_view_height,
        components = {
            {name="PFD", module=libs.cw, cw="pfd", type_id=1, x=0, y=0, options={width=libs.fcu.width - gtc_width, height=main_view_height}},
            {name="GTC", module=libs.cw, cw="gtc_pfd", type_id=1, x=libs.fcu.width - gtc_width, y=0, options={width=gtc_width, height=main_view_height}},
        },
    },
    {
        -----------------------------------------------------------------------------------
        name = "MFD View",
        width = libs.fcu.width, height = main_view_height,
        components = {
            {name="MFD", module=libs.cw, cw="mfd", type_id=1, x=0, y=0, options={width=libs.fcu.width, height=main_view_height}},
        },
    },
    {
        -----------------------------------------------------------------------------------
        name = "MFD + Left GTC View",
        width = libs.fcu.width, height = main_view_height,
        components = {
            {name="MFD", module=libs.cw, cw="mfd", type_id=1, x=0, y=0, options={width=libs.fcu.width - gtc_width, height=main_view_height}},
            {name="GTC left", module=libs.cw, cw="gtc_mfdl", type_id=1, x=libs.fcu.width - gtc_width, y=0, options={
                width=gtc_width, height=main_view_height, y_offset=126,
                tap_area = {x=403.5, y=25.451, width=141, height=76, rratio=0.5},
            }},
        },
    },
    {
        -----------------------------------------------------------------------------------
        name = "MFD + Right GTC View",
        width = libs.fcu.width, height = main_view_height,
        components = {
            {name="MFD", module=libs.cw, cw="mfd", type_id=1, x=0, y=0, options={width=libs.fcu.width - gtc_width, height=main_view_height}},
            {name="GTC right", module=libs.cw, cw="gtc_mfdr", type_id=1, x=libs.fcu.width - gtc_width, y=0, options={
                width=gtc_width, height=main_view_height, y_offset=126,
                tap_area = {x=403.5, y=25.451, width=141, height=76, rratio=0.5},
            }},
        },
    },
}

function module.start(config, aircraft)
    local display = config.simhid_g1000_display
    local scale = config.simhid_g1000_display_scale

    local gtc_selector_width = 948
    local gtc_selector_height = 126
    local gtc_selector_image = graphics.bitmap("assets/longitude_gtc_selector.png")
    views_main[4].components[2].options.bg_image = gtc_selector_image:create_partial_bitmap(0, 0, gtc_selector_width, gtc_selector_height)
    views_main[5].components[2].options.bg_image = gtc_selector_image:create_partial_bitmap(0, 127, gtc_selector_width, gtc_selector_height)

    module.device = common.open_simhid_g1000{
        config = config,
        modifiers = {
            {class = "binary", modtype = "button"},
            {class = "relative", modtype = "incdec"},
            {name = "EC6P", modtype = "button", modparam={longpress = 2000}},
            {name = "EC8U", modtype = "button", modparam={repeat_interval = 150, repeat_delay = 500}},
            {name = "EC8D", modtype = "button", modparam={repeat_interval = 150, repeat_delay = 500}},
            {name = "EC8L", modtype = "button", modparam={repeat_interval = 150, repeat_delay = 500}},
            {name = "EC8R", modtype = "button", modparam={repeat_interval = 150, repeat_delay = 500}},
            {name = "SW11", modtype = "button", modparam={repeat_interval = 150, repeat_delay = 500}},
            {name = "SW13", modtype = "button", modparam={repeat_interval = 150, repeat_delay = 500}},
        },
    }
    local g1000 = module.device.events

    local switchable_views = {
        {current=1, gtc_offset=0, views = {views_main[1], views_main[2]}},
        {current=1, gtc_offset=0, views = {views_main[3], views_main[4], views_main[5]}},
    }

    local pfd_mappings = {
        {event=g1000.EC5.increment, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_MiddleKnob_INC)")},
        {event=g1000.EC5.decrement, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_MiddleKnob_DEC)")},
        {event=g1000.EC5P.up, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_MiddleKnob_Push)")},
        {event=g1000.EC8.increment, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_Joystick_INC)")},
        {event=g1000.EC8.decrement, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_Joystick_DEC)")},
        {event=g1000.EC8P.up, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_Joystick_Push)")},
        {event=g1000.EC8U.down, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_Joystick_Up)")},
        {event=g1000.EC8D.down, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_Joystick_Down)")},
        {event=g1000.EC8L.down, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_Joystick_Left)")},
        {event=g1000.EC8R.down, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_Joystick_Right)")},
        {event=g1000.EC6Y.increment, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_RightKnob_Large_INC)")},
        {event=g1000.EC6Y.decrement, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_RightKnob_Large_DEC)")},
        {event=g1000.EC6X.increment, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_RightKnob_Small_INC)")},
        {event=g1000.EC6X.decrement, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_RightKnob_Small_DEC)")},
        {event=g1000.EC6P.up, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_RightKnob_Push)")},
        {event=g1000.EC6P.longpressed, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Vertical_1_RightKnob_Push_Long)")},
    }
    local mfd_gtc_is_left = true
    local execute_gtc_rpn = function (suffix)
        fs2020.mfwasm.execute_rpn("(>H:AS3000_TSC_Vertical_" .. (mfd_gtc_is_left and "2" or "3") .. suffix)
    end
    local mfd_mappings = {
        {event=g1000.EC5.increment, action=function () execute_gtc_rpn("(_MiddleKnob_INC)") end},
        {event=g1000.EC5.decrement, action=function () execute_gtc_rpn("(_MiddleKnob_DEC)") end},
        {event=g1000.EC5P.up, action=function () execute_gtc_rpn("_MiddleKnob_Push)") end},
        {event=g1000.EC8.increment, action=function () execute_gtc_rpn("_Joystick_INC)") end},
        {event=g1000.EC8.decrement, action=function () execute_gtc_rpn("_Joystick_DEC)") end},
        {event=g1000.EC8P.up, action=function () execute_gtc_rpn("_Joystick_Push)") end},
        {event=g1000.EC8U.down, action=function () execute_gtc_rpn("_Joystick_Up)") end},
        {event=g1000.EC8D.down, action=function () execute_gtc_rpn("_Joystick_Down)") end},
        {event=g1000.EC8L.down, action=function () execute_gtc_rpn("_Joystick_Left)") end},
        {event=g1000.EC8R.down, action=function () execute_gtc_rpn("_Joystick_Right)") end},
        {event=g1000.EC6Y.increment, action=function () execute_gtc_rpn("_RightKnob_Large_INC)") end},
        {event=g1000.EC6Y.decrement, action=function () execute_gtc_rpn("_RightKnob_Large_DEC)") end},
        {event=g1000.EC6X.increment, action=function () execute_gtc_rpn("_RightKnob_Small_INC)") end},
        {event=g1000.EC6X.decrement, action=function () execute_gtc_rpn("_RightKnob_Small_DEC)") end},
        {event=g1000.EC6P.up, action=function () execute_gtc_rpn("_RightKnob_Push)") end},
        {event=g1000.EC6P.longpressed, action=function () execute_gtc_rpn("_RightKnob_Push_Long)") end},
    }
    views_main[1].mappings = pfd_mappings
    views_main[2].mappings = pfd_mappings
    views_main[3].mappings = mfd_mappings
    views_main[4].mappings = mfd_mappings
    views_main[5].mappings = mfd_mappings

    common.init_component_modules(libs, lib_options)

    local viewport_fcu = mapper.viewport{
        name = "Cessna Longitude FCU Viewport",
        displayno = display,
        x = 0, y = 0,
        width = scale, height = 2 / 12 * scale,
        aspect_ratio = 16 / 2,
        horizontal_alignment = "center",
        vertical_alignment = "bottom",
    }
    local viewport_fcu_mappings = {}
    common.arrange_views(viewport_fcu, viewport_fcu_mappings, {}, views_fcu, module.device)
    viewport_fcu:set_mappings(viewport_fcu_mappings)

    local viewport_main = mapper.viewport{
        name = "Cessna Longitude Main Viewport",
        displayno = display,
        x = 0, y = 2/ 12 * scale,
        width = scale, height = 10 / 12 * scale,
        aspect_ratio = 16 / 10,
        horizontal_alignment = "center",
        vertical_alignment = "top",
    }
    local viewport_main_mappings = {}
    local current_view_group = 1
        local function change_view_group(delta)
        current_view_group = current_view_group + delta
        if current_view_group > #switchable_views then
            current_view_group = 1
        elseif current_view_group < 1 then
            current_view_group = #switchable_views
        end
        local vg = switchable_views[current_view_group]
        local view = vg.views[vg.current]
        viewport_main:change_view(view.viewid)
        common.change_viewport_mappings(viewport_main, viewport_main_mappings, view)
    end
    local function change_sub_view()
        local vg = switchable_views[current_view_group]
        vg.current = vg.current == 1 and 2 + vg.gtc_offset or 1
        local view = vg.views[vg.current]
        viewport_main:change_view(view.viewid)
        common.change_viewport_mappings(viewport_main, viewport_main_mappings, view)
    end
    local function change_mfd_gtc()
        local vg = switchable_views[current_view_group]
        mfd_gtc_is_left = not mfd_gtc_is_left
        vg.gtc_offset = mfd_gtc_is_left and 0 or 1
        vg.current = vg.current == 1 and 1 or 2 + vg.gtc_offset
        mapper.print(string.format("vg:%d current:%d offset:%d", current_view_group, vg.current, vg.gtc_offset))
        local view = vg.views[vg.current]
        viewport_main:change_view(view.viewid)
        common.change_viewport_mappings(viewport_main, viewport_main_mappings, view)
    end
    views_main[1].components[1].options.on_tap = change_sub_view
    views_main[2].components[1].options.on_tap = change_sub_view
    views_main[3].components[1].options.on_tap = change_sub_view
    views_main[4].components[1].options.on_tap = change_sub_view
    views_main[5].components[1].options.on_tap = change_sub_view
    views_main[4].components[2].options.on_tap = change_mfd_gtc
    views_main[5].components[2].options.on_tap = change_mfd_gtc
    common.arrange_views(viewport_main, viewport_main_mappings, captured_window_defs, views_main, module.device)
    viewport_main:set_mappings(viewport_main_mappings)

    local global_mappings = {
        {
            {event=g1000.AUX1D.down, action=function () change_view_group(1) end},
            {event=g1000.AUX1U.down, action=function () change_view_group(-1) end},
            {event=g1000.AUX1P.down, action=change_sub_view},
            {event=g1000.AUX2D.down, action=function () change_view_group(1) end},
            {event=g1000.AUX2U.down, action=function () change_view_group(-1) end},
            {event=g1000.AUX2P.down, action=change_sub_view},
    
            {event=g1000.EC3.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
            {event=g1000.EC3.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
            {event=g1000.EC3P.down, action=fs2020.mfwasm.rpn_executer("(A:HEADING INDICATOR,degrees) (>K:HEADING_BUG_SET)")},
            {event=g1000.EC4X.increment, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC4X.decrement, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC4Y.increment, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC4Y.decrement, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC4P.down, action=fs2020.mfwasm.rpn_executer("(A:INDICATED ALTITUDE, feet) (>K:AP_ALT_VAR_SET_ENGLISH) (>H:AP_KNOB)")},
            {event=g1000.EC7X.increment, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_PFD_1_CRS_INC)")},
            {event=g1000.EC7X.decrement, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_PFD_1_CRS_DEC)")},
            {event=g1000.EC7P.down, action=fs2020.mfwasm.rpn_executer("(>H:AS3000_PFD_1_CRS_PUSH)")},
            {event=g1000.EC7Y.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:KOHLSMAN_INC) (>H:AP_BARO_Up)")},
            {event=g1000.EC7Y.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:KOHLSMAN_DEC) (>H:AP_BARO_Down)")},
        }
    }
    common.set_global_mappings(global_mappings, libs)

    return {
        move_next_view = function () change_view_group(1) end,
        move_previous_view = function () change_view_group(-1) end,
        global_mappings = global_mappings,
        need_to_start_viewports = true,
    }
end

function module.stop()
    common.clear_component_instance(views_main)
    common.clear_component_instance(views_fcu)
    module.device:close()
    module.device = nil
end

return module
