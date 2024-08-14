local module = {
    width = 2224,
    height = 278,
    type = {
        general = 1,
    },
}

local module_defs = {
    prefix = "Longitude FCU",
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
    ap = msfs.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } els{ (A:AUTOPILOT FLIGHT DIRECTOR ACTIVE, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) } } }"),
    fd = msfs.mfwasm.rpn_executer("(A:AUTOPILOT MASTER, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) }"),
    hdg = msfs.mfwasm.rpn_executer("(>K:AP_PANEL_HEADING_HOLD)"),
    alt = msfs.mfwasm.rpn_executer("(>K:AP_ALT_HOLD)"),
    nav = msfs.mfwasm.rpn_executer("(>K:AP_NAV1_HOLD)"),
    vnav = msfs.mfwasm.rpn_executer("(L:XMLVAR_VNAVButtonValue) ! (>L:XMLVAR_VNAVButtonValue)"),
    apr = msfs.mfwasm.rpn_executer("(>K:AP_APR_HOLD)"),
    bc = msfs.mfwasm.rpn_executer("(>K:AP_BC_HOLD)"),
    vs = msfs.mfwasm.rpn_executer("(>K:AP_PANEL_VS_HOLD) 1 0 (>K:2:AP_VS_VAR_SET_ENGLISH)"),
    flc = msfs.mfwasm.rpn_executer("(>K:FLIGHT_LEVEL_CHANGE) (A:AUTOPILOT FLIGHT LEVEL CHANGE, bool) if { (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET) }"),
    up = msfs.mfwasm.rpn_executer("(>K:AP_SPD_VAR_DEC) (>K:AP_VS_VAR_INC)"),
    dn = msfs.mfwasm.rpn_executer("(>K:AP_SPD_VAR_INC) (>K:AP_VS_VAR_DEC)"),
    bank = msfs.mfwasm.rpn_executer("(>K:AP_MAX_BANK_INC)"),
    -- caution = msfs.mfwasm.rpn_executer("1 (>H:Generic_Master_Caution_Push, Number)"),
    caution = msfs.mfwasm.rpn_executer("(>K:MASTER_CAUTION_ACKNOWLEDGE)"),
    warning = msfs.mfwasm.rpn_executer("(>K:MASTER_WARNING_ACKNOWLEDGE)"),
    std = msfs.mfwasm.rpn_executer("(L:XMLVAR_Baro1_ForcedToSTD) ! (>L:XMLVAR_Baro1_ForcedToSTD)"),
    at = msfs.mfwasm.rpn_executer("(>K:AUTO_THROTTLE_ARM)"),
    spd_ref = msfs.mfwasm.rpn_executer("(L:XMLVAR_SpeedIsManuallySet) ! (>L:XMLVAR_SpeedIsManuallySet)"),
    spd_mach = msfs.mfwasm.rpn_executer("(>K:AP_MANAGED_SPEED_IN_MACH_TOGGLE) (A:AUTOPILOT MANAGED SPEED IN MACH, Bool) (>L:XMLVAR_AirSpeedIsInMach)"),
}

--------------------------------------------------------------------------------------
-- operable area definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=100, height=71.335, rratio=0.05}
local attr_circle = {width=68, height=68, rratio=0.5}
local attr_toggle = {width=141, height=76, rratio=0.5}
local attr_caution = {width=162.328, height=125.744, rratio=0.05}
module_defs.operables = {}
module_defs.operables[module.type.general] = {
    fd = {x=782.441, y=38.864, attr=attr_normal},
    vs = {x=1000.276, y=38.864, attr=attr_normal},
    alt = {x=2076.755, y=38.864, attr=attr_normal},
    vnav = {x=1154.059, y=38.864, attr=attr_normal},
    flc = {x=1307.841, y=38.864, attr=attr_normal},
    ap = {x=1461.624, y=38.864, attr=attr_normal},
    at = {x=1461.624, y=167.801, attr=attr_normal},
    nav = {x=1615.407, y=38.864, attr=attr_normal},
    hdg = {x=1769.189, y=38.864, attr=attr_normal},
    apr = {x=1922.972, y=38.864, attr=attr_normal},
    bank = {x=1615.407, y=167.801, attr=attr_normal},
    bc = {x=1922.972, y=167.801, attr=attr_normal},
    std = {x=588.378, y=105, attr=attr_circle},
    spd_mach = {x=868.868, y=187.803, attr=attr_circle},
    spd_ref = {x=1114.098, y=184.254, attr=attr_toggle},
    warning = {x=280.005, y=76.128, attr=attr_caution},
    caution = {x=61.14, y=76.128, attr=attr_caution},
}

--------------------------------------------------------------------------------------
-- indicator definitions
--------------------------------------------------------------------------------------
local buttons_img = graphics.bitmap("assets/longitude_buttons.png")
local attr_caution_indicator = {width=142.61, height=104.973}
local attr_toggle_indicator = {width=139, height=74}
local caution_img = buttons_img:create_partial_bitmap(144, 0, attr_caution_indicator.width, attr_caution_indicator.height)
local warning_img = buttons_img:create_partial_bitmap(0, 0, attr_caution_indicator.width, attr_caution_indicator.height)
local toggle_1_img = buttons_img:create_partial_bitmap(291, 11, attr_toggle_indicator.width, attr_toggle_indicator.height)
local toggle_2_img = buttons_img:create_partial_bitmap(433, 11, attr_toggle_indicator.width, attr_toggle_indicator.height)

local attr_engaged_indicator = {width=8.417, height=61.593}
local engaged_off_img = graphics.bitmap(math.floor(attr_engaged_indicator.width + 0.5), math.floor(attr_engaged_indicator.height + 0.5))
local engaged_on_img = graphics.bitmap(math.floor(attr_engaged_indicator.width + 0.5), math.floor(attr_engaged_indicator.height + 0.5))
local rctx = graphics.rendering_context(engaged_off_img)
rctx:set_brush(graphics.color(48, 48, 48))
rctx:fill_rectangle(0, 0, attr_engaged_indicator.width, attr_engaged_indicator.height)
rctx:finish_rendering()
rctx = graphics.rendering_context(engaged_on_img)
rctx:set_brush(graphics.color(64, 255, 64))
rctx:fill_rectangle(0, 0, attr_engaged_indicator.width, attr_engaged_indicator.height)
rctx:finish_rendering()

module_defs.indicators ={}
module_defs.indicators[module.type.general] = {}
module_defs.indicators[module.type.general][1]= {
    caution_indicator = {x=71.636, y=87.17, attr=attr_caution_indicator, bitmaps={nil, caution_img}, rpn="(A:MASTER CAUTION ACTIVE, Boolean) (A:MASTER CAUTION ACKNOWLEDGED, Boolean) ! and (O:XMLVAR_CAUTION_1) or"},
    warning_indicator = {x=290.501, y=87.17, attr=attr_caution_indicator, bitmaps={nil, warning_img}, rpn="(A:MASTER WARNING ACTIVE, Boolean) (A:MASTER WARNING ACKNOWLEDGED, Boolean) ! and (O:XMLVAR_WARNING_1) or"},
    spd_ref_indicator = {x=1117.098, y=187.254, attr=attr_toggle_indicator, bitmaps={toggle_1_img, toggle_2_img}, rpn="(L:XMLVAR_SpeedIsManuallySet)"},
    ap_indicator = {x=1569.499, y=43.734, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT MASTER, Bool) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    at_indicator = {x=1569.499, y=172.671, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(L:WT_Longitude_Autothrottle_Status) 0 !="},
    fd_indicator = {x=890.316, y=43.734, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1, Bool) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    vs_indicator = {x=1108.151, y=43.734, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT VERTICAL HOLD, Bool) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    vnav_indicator = {x=1261.933, y=43.734, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(L:XMLVAR_VNAVButtonValue) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    flc_indicator = {x=1415.716, y=43.734, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    nav_indicator = {x=1723.281, y=43.734, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT NAV1 LOCK, Bool) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    hdg_indicator = {x=1877.064, y=43.734, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT HEADING LOCK, Bool) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    apr_indicator = {x=2030.847, y=43.734, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT APPROACH HOLD, Bool) (A:AUTOPILOT GLIDESLOPE HOLD, Bool) and (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    alt_indicator = {x=2184.629, y=43.734, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT ALTITUDE LOCK, Bool) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    bank_indicator = {x=1723.281, y=172.671, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT MAX BANK ID, number) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
    bc_indicator = {x=2030.847, y=172.671, attr=attr_engaged_indicator, bitmaps={engaged_off_img, engaged_on_img}, rpn="(A:AUTOPILOT BACKCOURSE HOLD, Bool) (L*XMLVAR_LTS_Test) max (A:CIRCUIT GENERAL PANEL ON, Bool) *"},
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
    local background = graphics.bitmap("assets/longitude_fcu.png")
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
            {event=g1000.SW7.down, action=module.actions[id].vnav},
            {event=g1000.SW8.down, action=module.actions[id].apr},
            {event=g1000.SW10.down, action=module.actions[id].vs},
            {event=g1000.SW12.down, action=module.actions[id].flc},
            {event=g1000.SW11.down, action=module.actions[id].up},
            {event=g1000.SW13.down, action=module.actions[id].dn},
        }
    end

    return component
end

return module
