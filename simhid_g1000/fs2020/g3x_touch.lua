local context = {
    g3x_touch_view = require("lib/g3x_touch_view")
}

local common = require('lib/common')
local assets = require("lib/g3x_touch_assets")

--------------------------------------------------------------------------------------
-- Definitions of auto pilot panel for each aircraft
--------------------------------------------------------------------------------------
local ap_panel_defs = {}
do -- Airecraft which installs GMC 307 control panel
    local panel_def = {buttons={}, indicators={}}

    local attr_button = {width=122, height=83.266, rratio=0.1}
    panel_def.buttons = {
        ap = {x=921.168, y=32.867, attr=attr_button, image=assets.ap, action=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } els{ (A:AUTOPILOT FLIGHT DIRECTOR ACTIVE, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) } } }")},
        lvl = {x=1180.832, y=32.867, attr=attr_button, image=assets.lvl, action=fs2020.mfwasm.rpn_executer("(>K:AP_WING_LEVELER) (A:AUTOPILOT WING LEVELER, Bool) if{ (A:AUTOPILOT MASTER, Bool) (>O:APStateWhenLevelerEnabled) (A:AUTOPILOT MASTER, Bool) ! if{ (>K:AUTOPILOT_ON) } (>K:AP_PITCH_LEVELER_ON) } els{ (>K:AP_PITCH_LEVELER_OFF) (O:APStateWhenLevelerEnabled) if{ (>K:AUTOPILOT_ON) } els{ (>K:AUTOPILOT_OFF) } }")},
    }

    local indicator_image = graphics.bitmap(80, 10)
    local rctx = graphics.rendering_context(indicator_image)
    rctx:set_brush(graphics.color(161, 161, 161))
    rctx:fill_rectangle(0, 0, indicator_image.width, indicator_image.height)
    rctx:finish_rendering()
    local attr_indicator = {width=indicator_image.width, height=indicator_image.height, scale=1}
    panel_def.indicators = {
        ap = {x=942.168, y=13.406, attr=attr_indicator, bitmaps={nil, indicator_image}, rpn="(A:AUTOPILOT MASTER, Bool)"},
        lvl = {x=1201.832, y=13.406, attr=attr_indicator, bitmaps={nil, indicator_image}, rpn="(A:AUTOPILOT WING LEVELER, Bool)"},
    }

    ap_panel_defs[#ap_panel_defs + 1] = panel_def
end

do -- King Air 350i
    local panel_def = {}
    panel_def.background = "assets/kingair350.png"

    local attr_caution = {width=210.343, height=180.513, rratio=0.1}
    local attr_button = {width=95.713, height=71.719, rratio=0.03}
    panel_def.buttons = {
        warning = {x=85.694, y=48.744, attr=attr_caution, action=fs2020.mfwasm.rpn_executer("1 (>H:Generic_Master_Warning_Push, Number)")},
        caution = {x=368.328, y=48.744, attr=attr_caution, action=fs2020.mfwasm.rpn_executer("1 (>H:Generic_Master_Caution_Push, Number)")},
        half_bank = {x=1483.569, y=103.14, attr=attr_button, action=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT MAX BANK, degrees) 16 < if{ (>K:AP_MAX_BANK_INC) } els{ (>K:AP_MAX_BANK_DEC) }")},
        yd = {x=1802.731, y=103.14, attr=attr_button, action=fs2020.mfwasm.rpn_executer("(>K:YAW_DAMPER_TOGGLE)")},
        ap = {x=1998.256, y=103.14, attr=attr_button, action=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } els{ (A:AUTOPILOT FLIGHT DIRECTOR ACTIVE, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) } } }")},
    }
    local attr_indicator = {width=151.098, height=108.647, scale=1}
    panel_def.indicators = {
        warning = {x=118.25, y=73.145, attr=attr_indicator, bitmaps={nil, assets.kingair_warn_fire}, rpn="(A:MASTER WARNING ACTIVE, Boolean) (A:MASTER WARNING ACKNOWLEDGED, Boolean) ! and (O:XMLVAR_WARNING_1) or"},
        caution = {x=400.884, y=73.145, attr=attr_indicator, bitmaps={nil, assets.kingair_master_caution}, rpn="(A:MASTER CAUTION ACTIVE, Boolean) (A:MASTER CAUTION ACKNOWLEDGED, Boolean) ! and (O:XMLVAR_CAUTION_1) or"},
    }

    ap_panel_defs[#ap_panel_defs + 1] = panel_def
end

do -- case of no auto pilot is enabled
    ap_panel_defs[#ap_panel_defs + 1] = {buttons={}, indicators={}}
end

for i, def in ipairs(ap_panel_defs) do
    for name, button in pairs(def.buttons) do
        button.evid = mapper.register_event("AP_PANEL:" .. name .. "_tapped")
    end
    for name, indicator in pairs(def.indicators) do
        indicator.evid = mapper.register_event("INDICATOR:" .. name)
    end
end

local aircraft_defs = {}
aircraft_defs["Asobo NXCub"] = {views={"G3X Touch PFD"}, aptype=1}
aircraft_defs["Asobo XCub"] = {views={"G3X Touch PFD"}, aptype=1}
aircraft_defs["Xcub"] = {views={"G3X Touch PFD"}, aptype=1}
aircraft_defs["Beechcraft King Air 350"] = {views={"G3X Touch PFD","G3X Touch MFD"}, aptype=2}
aircraft_defs["VL3"] = {views={"G3X Touch PFD","G3X Touch MFD"}, aptype=3}
aircraft_defs["Volocity Microsoft"] = {views={"G3X Touch PFD"}, aptype=3}
aircraft_fallback = {views={"G3X Touch PFD"}, aptype=3}

--------------------------------------------------------------------------------------
-- Initialize function
--------------------------------------------------------------------------------------
function context.start(config, aircraft)
    local display = config.simhid_g1000_display
    local scale = config.simhid_g1000_display_scale
    
    local viewport = mapper.viewport{
        name = "G3X Touch",
        displayno = display,
        x = 0, y = 0, width = scale, height = scale,
        aspect_ratio = 4 / 3,
    }

    context.device = common.open_simhid_g1000{
        config = config,
        modifiers = {
            {class = "binary", modtype = "button"},
            {class = "relative", modtype = "incdec"},
        },
    }
    local g1000 = context.device.events

    local aircraft_def = aircraft_defs[aircraft]
    if not aircraft_def then
        for name, def in pairs(aircraft_defs) do
            if string.find(aircraft, name) ~= nil then
                aircraft_def = def
                break
            end
        end
        if not aircraft_def then
            aircraft_def = aircraft_fallback
        end
    end

    context.g3x_touch_view.init(context.device, aircraft_def.aptype ~= 2)
    context.views = {}
    context.canvases = {}
    local global_mappings = {}
    local observed_data = {}
    local ap_panel_def = ap_panel_defs[aircraft_def.aptype]
    if ap_panel_def.background then
        context.background = graphics.bitmap(ap_panel_def.background)
    end

    for name, indicator in pairs(ap_panel_def.indicators) do
        context.canvases[name] = {}
        observed_data[#observed_data + 1] = {rpn=indicator.rpn, event=indicator.evid}
        global_mappings[#global_mappings + 1] = {event=indicator.evid, action=function(evid, value)
            for i, canvas in ipairs(context.canvases[name]) do
                canvas:set_value(value)
            end
        end}
    end
    fs2020.mfwasm.add_observed_data(observed_data)

    for i, name in ipairs(aircraft_def.views) do
        local view_def = context.g3x_touch_view.create_view(name, i)
        if context.background then
            view_def.background = context.background
        end
        for name, button in pairs(ap_panel_def.buttons) do
            view_def.elements[#view_def.elements + 1] = {
                object = mapper.view_elements.operable_area{round_ratio = button.attr.rratio, event_tap = button.evid},
                x = button.x, y = button.y,
                width = button.attr.width, height = button.attr.height
            }
            view_def.mappings[#view_def.mappings + 1] = {event = button.evid, action = button.action}
            if button.image then
                local rctx = graphics.rendering_context(view_def.background)
                rctx:draw_bitmap(button.image, button.x, button.y)
                rctx:finish_rendering()
            end
        end
        for name, indicator in pairs(ap_panel_def.indicators) do
            local canvas = mapper.view_elements.canvas{
                logical_width = indicator.attr.width,
                logical_height = indicator.attr.height,
                value = 0,
                renderer = function (ctx, value)
                    local image = indicator.bitmaps[value + 1]
                    if image then
                        ctx:draw_bitmap(image, 0, 0)
                    end
                end
            }
            view_def.elements[#view_def.elements + 1] = {
                object = canvas,
                x = indicator.x, y = indicator.y,
                width = indicator.attr.width, height = indicator.attr.height
            }
            context.canvases[name][#context.canvases[name] + 1] = canvas
        end
        context.views[i] = viewport:register_view(view_def)
    end

    if aircraft_def.aptype == 1 then
        -- Airecraft which install GMC 307 control panel
        viewport:set_mappings{
            {event=g1000.SW2.down, action=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } els{ (A:AUTOPILOT FLIGHT DIRECTOR ACTIVE, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) } } }")},
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
            {event=g1000.EC7Y.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:KOHLSMAN_INC) (>H:AP_BARO_Up)")},
            {event=g1000.EC7Y.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:KOHLSMAN_DEC) (>H:AP_BARO_Down)")},
        }
    elseif aircraft_def.aptype == 2 then
        viewport:set_mappings{
            {event=g1000.SW2.down, action=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } els{ (A:AUTOPILOT FLIGHT DIRECTOR ACTIVE, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) } } }")},
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
            {event=g1000.SW28.down, action=fs2020.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Menu_Push)")},
            {event=g1000.EC3.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
            {event=g1000.EC3.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
            {event=g1000.EC3P.down, action=fs2020.mfwasm.rpn_executer("(A:HEADING INDICATOR,degrees) (>K:HEADING_BUG_SET)")},
            {event=g1000.EC4X.increment, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC4X.decrement, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC4Y.increment, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC4Y.decrement, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC4P.down, action=fs2020.mfwasm.rpn_executer("(A:INDICATED ALTITUDE, feet) (>K:AP_ALT_VAR_SET_ENGLISH) (>H:AP_KNOB)")},
            {event=g1000.EC7X.increment, action=fs2020.mfwasm.rpn_executer("(>K:VOR1_OBI_INC)")},
            {event=g1000.EC7X.decrement, action=fs2020.mfwasm.rpn_executer("(>K:VOR1_OBI_DEC)")},
            {event=g1000.EC7P.down, action=fs2020.mfwasm.rpn_executer("(A:HEADING INDICATOR,degrees) (>K:VOR1_SET)")},
            {event=g1000.EC8.increment, action=fs2020.mfwasm.rpn_executer("(>K:VOR2_OBI_INC)")},
            {event=g1000.EC8.decrement, action=fs2020.mfwasm.rpn_executer("(>K:VOR2_OBI_DEC)")},
            {event=g1000.EC8P.down, action=fs2020.mfwasm.rpn_executer("(A:HEADING INDICATOR,degrees) (>K:VOR2_SET)")},
            {event=g1000.EC7Y.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:KOHLSMAN_INC) (>H:AP_BARO_Up)")},
            {event=g1000.EC7Y.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:KOHLSMAN_DEC) (>H:AP_BARO_Down)")},
        }
    else
        -- No auto pilot system is enabled
        viewport:set_mappings{
            {event=g1000.EC3.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
            {event=g1000.EC3.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
            {event=g1000.EC2X.increment, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC2X.decrement, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC2Y.increment, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC2Y.decrement, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC7Y.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:KOHLSMAN_INC) (>H:AP_BARO_Up)")},
            {event=g1000.EC7Y.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:KOHLSMAN_DEC) (>H:AP_BARO_Down)")},
        }
    end

    context.current_view = 1
    local function change_view(d)
        context.current_view = context.current_view + d
        if context.current_view > #context.views then
            context.current_view = 1
        elseif context.current_view < 1 then
            context.current_view = #context.views
        end
        viewport:change_view(context.views[context.current_view])
    end

    viewport:add_mappings{
        {event=g1000.AUX1D.down, action=function () change_view(1) end},
        {event=g1000.AUX1U.down, action=function () change_view(-1) end},
        {event=g1000.AUX2D.down, action=function () change_view(1) end},
        {event=g1000.AUX2U.down, action=function () change_view(-1) end},
    }

    return {
        move_next_view = function () change_view(1) end,
        move_previous_view = function () change_view(-1) end,
        global_mappings = {global_mappings},
        need_to_start_viewports = true,
    }
end


--------------------------------------------------------------------------------------
-- Terminate function
--------------------------------------------------------------------------------------
function context.stop()
    context.canvases = nil
    context.views = nil
    context.g3x_touch_view.term()
    context.device:close()
    context.device = nil
    context.background = nil
    fs2020.mfwasm.clear_observed_data()
end

return context