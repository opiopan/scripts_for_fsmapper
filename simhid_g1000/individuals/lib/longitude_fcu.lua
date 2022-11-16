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
    ap=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } els{ (A:AUTOPILOT FLIGHT DIRECTOR ACTIVE, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) } } }"),
    fd=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT MASTER, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) }"),
    hdg=fs2020.mfwasm.rpn_executer("(>K:AP_PANEL_HEADING_HOLD)"),
    alt=fs2020.mfwasm.rpn_executer("(>K:AP_ALT_HOLD)"),
    nav=fs2020.mfwasm.rpn_executer("(>K:AP_NAV1_HOLD)"),
    vnav=fs2020.mfwasm.rpn_executer("(L:XMLVAR_VNAVButtonValue) ! (>L:XMLVAR_VNAVButtonValue)"),
    apr=fs2020.mfwasm.rpn_executer("(>K:AP_APR_HOLD)"),
    bc=fs2020.mfwasm.rpn_executer("(>K:AP_BC_HOLD)"),
    vs=fs2020.mfwasm.rpn_executer("(>K:AP_PANEL_VS_HOLD) 1 0 (>K:2:AP_VS_VAR_SET_ENGLISH)"),
    flc=fs2020.mfwasm.rpn_executer("(>K:FLIGHT_LEVEL_CHANGE) (A:AUTOPILOT FLIGHT LEVEL CHANGE, bool) if { (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET) }"),
    up=fs2020.mfwasm.rpn_executer("(>K:AP_SPD_VAR_DEC) (>K:AP_VS_VAR_INC)"),
    dn=fs2020.mfwasm.rpn_executer("(>K:AP_SPD_VAR_INC) (>K:AP_VS_VAR_DEC)"),
    bank=fs2020.mfwasm.rpn_executer("(>K:AP_MAX_BANK_INC)"),
}

--------------------------------------------------------------------------------------
-- operable area definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=63.434, height=36.762, rratio=0.05}
module_defs.operables = {}
module_defs.operables[module.type.general] = {
     ap = {x=0, y=0, attr=attr_normal},
}

--------------------------------------------------------------------------------------
-- indicator definitions
--------------------------------------------------------------------------------------
module_defs.indicators ={}
module_defs.indicators[module.type.general] = {}
module_defs.indicators[module.type.general][1]= {
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
    local background = graphics.bitmap("assets/tbm930_afcs.png")
    rctx:draw_bitmap{bitmap=background, x=x, y=y, scale=scale}

    -- view scope mappings
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.view_mappings = {
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
