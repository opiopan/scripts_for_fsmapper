local background = graphics.bitmap("assets/tbm930_afcs.png")
local view_width = background.width
local view_height = background.height

local context = {}
context.mappings = {}
context.observed_data = {}
context.view_elements = {}
context.view_mappings = {}

--------------------------------------------------------------------------------------
-- button and indicator definitions
--------------------------------------------------------------------------------------
local assets = require("tbm930/assets")

local attr_safety_button = {width=assets.safety_button_size.width, height=assets.safety_button_size.height, rratio=0}
local attr_std_button = {width=104.112, height=104.112, rratio=0.5}
local attr_ap_button = {width=128.332, height=82.007, rratio=0.1}
local attr_lvl_button = {width=185.126, height=118.332, rratio=0.05}
local buttons = {
    warning = {x=70.012, y=49.563, attr=attr_safety_button, action=fs2020.mfwasm.rpn_executer("1 (>H:Generic_Master_Warning_Push, Number)")},
    caution = {x=394.863, y=49.563, attr=attr_safety_button, action=fs2020.mfwasm.rpn_executer("1 (>H:Generic_Master_Caution_Push, Number)")},
    std = {x=839.326, y=88.781, attr=attr_std_button, action=fs2020.mfwasm.rpn_executer("1 (>K:BAROMETRIC)")},
    fd = {x= 1136.527, y=26.934, attr=attr_ap_button, action=fs2020.mfwasm.rpn_executer("1 (>K:TOGGLE_FLIGHT_DIRECTOR)")},
    bank = {x= 1136.527, y=161.713, attr=attr_ap_button, action=fs2020.mfwasm.rpn_executer("(>K:AP_MAX_BANK_INC)")},
    xfr = {x=1545.024, y=26.934, attr=attr_ap_button, action=fs2020.mfwasm.rpn_executer("(L:XMLVAR_PushXFR) ! (>L:XMLVAR_PushXFR)")},
    ap = {x=1435.434, y=161.713, attr=attr_ap_button, action=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } els{ (A:AUTOPILOT YAW DAMPER, Bool) ! if{ (>K:YAW_DAMPER_TOGGLE) } } }")},
    yd = {x=1645.566, y=161.713, attr=attr_ap_button, action=fs2020.mfwasm.rpn_executer("(>K:YAW_DAMPER_TOGGLE)")},
    lvl = {x=1953.606, y=81.671, attr=attr_lvl_button, action=fs2020.mfwasm.rpn_executer("(>K:AP_WING_LEVELER) (A:AUTOPILOT WING LEVELER, Bool) if{ (A:AUTOPILOT MASTER, Bool) (>O:APStateWhenLevelerEnabled) (A:AUTOPILOT MASTER, Bool) ! if{ (>K:AUTOPILOT_ON) } (>K:AP_PITCH_LEVELER_ON) } els{ (>K:AP_PITCH_LEVELER_OFF) (O:APStateWhenLevelerEnabled) if{ (>K:AUTOPILOT_ON) } els{ (>K:AUTOPILOT_OFF) } }")},
}

local attr_safety_indicator = {width=assets.warning.width, height=assets.warning.height}
local attr_ap_indicator = {width=assets.button_indicator_dark.width, height=assets.button_indicator_dark.height}
local attr_xfr_indicator = {width=assets.xfr_left.width, height=assets.xfr_left.height}
local attr_lvl_indicator = {width=assets.lvl.width, height=assets.lvl.height}
local indicators = {
    warning = {x=70.012, y=49.563, attr=attr_safety_indicator, bitmaps={nil, assets.warning}, rpn="(A:MASTER WARNING ACTIVE, Boolean) (A:MASTER WARNING ACKNOWLEDGED, Boolean) ! and (O:XMLVAR_WARNING_1) or"},
    caution = {x=394.863, y=49.563, attr=attr_safety_indicator, bitmaps={nil, assets.caution}, rpn="(A:MASTER CAUTION ACTIVE, Boolean) (A:MASTER CAUTION ACKNOWLEDGED, Boolean) ! and (O:XMLVAR_CAUTION_1) or"},
    fd = {x=1274.351, y=34.029, attr=attr_ap_indicator, bitmaps={assets.button_indicator_dark, assets.button_indicator_light}, rpn="(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1, Bool)"},
    bank = {x=1274.351, y=168.808, attr=attr_ap_indicator, bitmaps={assets.button_indicator_dark, assets.button_indicator_light}, rpn="(A:AUTOPILOT MAX BANK ID, number)"},
    ap = {x=1573.259, y=168.808, attr=attr_ap_indicator, bitmaps={assets.button_indicator_dark, assets.button_indicator_light}, rpn="(A:AUTOPILOT MASTER, Bool)"},
    yd = {x=1783.39, y=168.808, attr=attr_ap_indicator, bitmaps={assets.button_indicator_dark, assets.button_indicator_light}, rpn="(A:AUTOPILOT YAW DAMPER, Bool)"},
    xfr = {x=1499.739, y=48.671, attr=attr_xfr_indicator, bitmaps={assets.xfr_left, assets.xfr_right}, rpn="(L:XMLVAR_PushXFR)"},
    lvl = {x=1977.024, y=114.493, attr=attr_lvl_indicator, bitmaps={nil, assets.lvl}, rpn="(A:AUTOPILOT WING LEVELER, Bool)"},
}

for name, button in pairs(buttons) do
    button.evid = mapper.register_event("AP_PANEL:" .. name .. "_tapped")
    context.view_elements[#context.view_elements + 1] = {
        object = mapper.view_elements.operable_area{
            round_ratio = button.attr.rratio,
            event_tap = button.evid
        },
        x = button.x, y = button.y,
        width = button.attr.width, height = button.attr.height
    }
    context.view_mappings[#context.view_mappings + 1] = {event=button.evid, action=button.action}
end
for name, indicator in pairs(indicators) do
    indicator.evid = mapper.register_event("INDICATOR:" .. name)
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
    context.view_elements[#context.view_elements + 1] = {
        object = canvas,
        x = indicator.x, y = indicator.y,
        width = indicator.attr.width, height = indicator.attr.height
    }
    context.observed_data[#context.observed_data + 1] = {rpn=indicator.rpn, event=indicator.evid}
    context.mappings[#context.mappings + 1] = {event=indicator.evid, action=canvas:value_setter()}
end

--------------------------------------------------------------------------------------
-- initialize module
--------------------------------------------------------------------------------------
function context.init(g1000)
    context.g1000 = g1000.events
end

--------------------------------------------------------------------------------------
-- celan up module
--------------------------------------------------------------------------------------
function context.term()
    context.g1000 = nil
end

--------------------------------------------------------------------------------------
-- view definition generator
--------------------------------------------------------------------------------------
function context.create_view(name)
    local view_definition = {
        name = name,
        elements = context.view_elements,
        logical_width = view_width,
        logical_height = view_height,
        mappings = context.view_mappings,
        background = background,
    }

    return view_definition
end

--------------------------------------------------------------------------------------
-- return module context
--------------------------------------------------------------------------------------
return context
