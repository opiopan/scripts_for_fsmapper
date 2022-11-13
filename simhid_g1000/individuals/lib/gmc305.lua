local module = {
    width = 1112,
    height = 328,
    type = {
        general = 1,
    },
}

local module_defs = {
    prefix = "GMC305",
    activatable = false,
    options = {{}},
    option_defaults = {
        type = module.type.general,
    },
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions = {}
module.actions[1] = {
    ap=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } els{ (A:AUTOPILOT FLIGHT DIRECTOR ACTIVE, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) } } }"),
    lvl=fs2020.mfwasm.rpn_executer("(>K:AP_WING_LEVELER) (A:AUTOPILOT WING LEVELER, Bool) if{ (A:AUTOPILOT MASTER, Bool) (>O:APStateWhenLevelerEnabled) (A:AUTOPILOT MASTER, Bool) ! if{ (>K:AUTOPILOT_ON) } (>K:AP_PITCH_LEVELER_ON) } els{ (>K:AP_PITCH_LEVELER_OFF) (O:APStateWhenLevelerEnabled) if{ (>K:AUTOPILOT_ON) } els{ (>K:AUTOPILOT_OFF) } }"),
    fd=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT MASTER, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) }"),
    hdg=fs2020.mfwasm.rpn_executer("(>K:AP_PANEL_HEADING_HOLD)"),
    alt=fs2020.mfwasm.rpn_executer("(>K:AP_ALT_HOLD)"),
    nav=fs2020.mfwasm.rpn_executer("(>K:AP_NAV1_HOLD)"),
    vnv=fs2020.mfwasm.rpn_executer("(L:XMLVAR_VNAVButtonValue) ! (>L:XMLVAR_VNAVButtonValue)"),
    apr=fs2020.mfwasm.rpn_executer("(>K:AP_APR_HOLD)"),
    vs=fs2020.mfwasm.rpn_executer("(>K:AP_PANEL_VS_HOLD) 1 0 (>K:2:AP_VS_VAR_SET_ENGLISH)"),
    ias=fs2020.mfwasm.rpn_executer("(>K:FLIGHT_LEVEL_CHANGE) (A:AUTOPILOT FLIGHT LEVEL CHANGE, bool) if { (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET) }"),
    up=fs2020.mfwasm.rpn_executer("(>K:AP_SPD_VAR_DEC) (>K:AP_VS_VAR_INC)"),
    dn=fs2020.mfwasm.rpn_executer("(>K:AP_SPD_VAR_INC) (>K:AP_VS_VAR_DEC)"),
}

--------------------------------------------------------------------------------------
-- operable area definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=74.989, height=53.318, rratio=0.1}
local attr_alt = {width=48.473, height=83.977, rratio=0.05}
local attr_normal = {width=69.674, height=39.247, rratio=0.05}
module_defs.operables = {}
module_defs.operables[module.type.general] = {
    hdg = {x=102.18, y=75.849, attr=attr_normal},
    nav = {x=229.789, y=75.849, attr=attr_normal},
    apr = {x=229.789, y=202.973, attr=attr_normal},
    ap = {x=370.795, y=75.849, attr=attr_normal},
    lvl = {x=496.404, y=75.849, attr=attr_normal},
    fd = {x=370.795, y=202.973, attr=attr_normal},
    ias = {x=815.46, y=75.849, attr=attr_normal},
    alt = {x=940.444, y=75.849, attr=attr_normal},
    vs = {x=815.46, y=202.973, attr=attr_normal},
    vnv = {x=940.444, y=202.973, attr=attr_normal},
    dn = {x=696.996, y=60.447, attr=attr_alt},
    up = {x=696.996, y=187.643, attr=attr_alt},
}

--------------------------------------------------------------------------------------
-- indicator definitions
--------------------------------------------------------------------------------------
local img_indicator = graphics.bitmap(20, 18)
local path_indicator = graphics.path()
path_indicator:add_figure{
    fill_mode = "winding",
    from = {0, 0},
    segments = {
        {to = {20, 0}},
        {to = {10, 17.321}},
        {to = {0, 0}},
    }
}
local rctx = graphics.rendering_context(img_indicator)
rctx:set_brush(graphics.color("white"))
rctx:fill_geometry{geometry = path_indicator, x=0, y=0}
rctx:finish_rendering()

local attr_indicator = {width=20, height=17.321}
module_defs.indicators ={}
module_defs.indicators[module.type.general] = {}
module_defs.indicators[module.type.general][1]= {
    hdg_indicator = {x=129.674, y=51.276, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(A:AUTOPILOT HEADING LOCK, Bool)"},
    nav_indicator = {x=257.284, y=51.276, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(A:AUTOPILOT NAV1 LOCK, Bool)"},
    apr_indicator = {x=257.284, y=178.867, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(A:AUTOPILOT APPROACH HOLD, Bool) (A:AUTOPILOT GLIDESLOPE HOLD, Bool) and"},
    ap_indicator = {x=398.289, y=51.276, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(A:AUTOPILOT MASTER, Bool)"},
    lvl_indicator = {x=523.899, y=51.276, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(A:AUTOPILOT WING LEVELER, Bool)"},
    fd_indicator = {x=398.289, y=178.867, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1, Bool)"},
    ias_indicator = {x=842.955, y=51.276, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool)"},
    alt_indicator = {x=967.939, y=51.276, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(A:AUTOPILOT ALTITUDE LOCK, Bool)"},
    vs_indicator = {x=842.955, y=178.867, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(A:AUTOPILOT VERTICAL HOLD, Bool)"},
    vnv_indicator = {x=967.939, y=178.867, attr=attr_indicator, bitmaps={nil, img_indicator}, rpn="(L:XMLVAR_VNAVButtonValue)"},
}

--------------------------------------------------------------------------------------
-- prepare module scope environment
--------------------------------------------------------------------------------------
common.component_module_init(module, module_defs, true)

--------------------------------------------------------------------------------------
-- instance generator
--------------------------------------------------------------------------------------
function module.create_component(component_name, id, captured_window, x, y, scale, rctx, simhid_g1000)
    local component = common.component_module_create_instance(module, module_defs,{
        name = component_name,
        id = id,
        captured_window = captured_window,
        x = x, y = y, scale = scale,
        simhid_g1000 = simhid_g1000
    })

    -- update view background bitmap
    local background = graphics.bitmap("assets/gmc305.png")
    rctx:draw_bitmap{bitmap=background, x=x, y=y, scale=scale}

    -- view scope mappings
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.viewport_mappings = {
            {event=g1000.SW2.down, action=module.actions[id].ap},
            {event=g1000.SW3.down, action=module.actions[id].fd},
            {event=g1000.SW4.down, action=module.actions[id].hdg},
            {event=g1000.SW5.down, action=module.actions[id].alt},
            {event=g1000.SW6.down, action=module.actions[id].nav},
            {event=g1000.SW7.down, action=module.actions[id].vnv},
            {event=g1000.SW8.down, action=module.actions[id].apr},
            {event=g1000.SW10.down, action=module.actions[id].vs},
            {event=g1000.SW12.down, action=module.actions[id].ias},
            {event=g1000.SW11.down, action=module.actions[id].up},
            {event=g1000.SW13.down, action=module.actions[id].dn},
        }
    end

    return component
end

return module
