local module = {
    width = 1112,
    height = 1534,
    type = {
        general = 1,
    },
}

local module_defs = {
    prefix = "G3X Portrate",
    activatable = true,
    options = {{}, {}},
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
    rng_zoom = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_RNG_Zoom)"),
    rng_dezoom = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_RNG_Dezoom)"),
    turn_inc = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_TURN_INC)"),
    turn_dec = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_TURN_DEC)"),
    joystick_left = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_JOYSTICK_LEFT)"),
    joystick_right = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_JOYSTICK_RIGHT)"),
    joystick_up = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_JOYSTICK_UP)"),
    joystick_down = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_JOYSTICK_DOWN)"),
    joystick_push = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_JOYSTICK_PUSH)"),
    ent = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_ENT_Push)"),
    clr = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_CLR_Push)"),
    menu = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_MENU_Push)"),
    fpl = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_FPL_Push)"),
    directto = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_DIRECTTO)"),
    nrst = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_NRST_Push)"),
    softkey1 = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_SOFTKEYS_1)"),
    softkey2 = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_SOFTKEYS_2)"),
    softkey3 = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_SOFTKEYS_3)"),
    softkey4 = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_SOFTKEYS_4)"),
    softkey5 = fs2020.mfwasm.rpn_executer("(>H:AS3X_1_SOFTKEYS_5)"),
}

module.actions[2] = {
    rng_zoom = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_RNG_Zoom)"),
    rng_dezoom = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_RNG_Dezoom)"),
    turn_inc = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_TURN_INC)"),
    turn_dec = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_TURN_DEC)"),
    joystick_left = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_JOYSTICK_LEFT)"),
    joystick_right = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_JOYSTICK_RIGHT)"),
    joystick_up = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_JOYSTICK_UP)"),
    joystick_down = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_JOYSTICK_DOWN)"),
    joystick_push = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_JOYSTICK_PUSH)"),
    ent = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_ENT_Push)"),
    clr = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_CLR_Push)"),
    menu = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_MENU_Push)"),
    fpl = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_FPL_Push)"),
    directto = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_DIRECTTO)"),
    nrst = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_NRST_Push)"),
    softkey1 = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_SOFTKEYS_1)"),
    softkey2 = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_SOFTKEYS_2)"),
    softkey3 = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_SOFTKEYS_3)"),
    softkey4 = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_SOFTKEYS_4)"),
    softkey5 = fs2020.mfwasm.rpn_executer("(>H:AS3X_2_SOFTKEYS_5)"),
}

--------------------------------------------------------------------------------------
-- operable are definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=110.264, height=73.366, rratio=0.1}
local attr_range = {width=91.57, height=76.903, rratio=0.1}
module_defs.operables = {}
module_defs.operables[module.type.general] = {
    rng_dezoom = {x=958.147, y=111.503, attr=attr_range},
    rng_zoom = {x=958.147, y=218.58, attr=attr_range},
    ent = {x=949.506, y=599.876, attr=attr_normal},
    clr = {x=949.506, y=726.387, attr=attr_normal},
    menu = {x=949.506, y=854.672, attr=attr_normal},
    fpl = {x=949.506, y=981.182, attr=attr_normal},
    directto = {x=949.506, y=1111.242, attr=attr_normal},
    nrst = {x=949.506, y=1241.302, attr=attr_normal},
    softkey1 = {x=110.295, y=1398.934, attr=attr_normal},
    softkey2 = {x=274.689, y=1398.934, attr=attr_normal},
    softkey3 = {x=436.287, y=1398.934, attr=attr_normal},
    softkey4 = {x=600.927, y=1398.934, attr=attr_normal},
    softkey5 = {x=758.94, y=1398.934, attr=attr_normal},
}

--------------------------------------------------------------------------------------
-- captured window placeholder definition
--------------------------------------------------------------------------------------
module_defs.captured_window = {}
module_defs.captured_window[module.type.general] = {x=100, y=82, width=775, height=1261}

--------------------------------------------------------------------------------------
-- active indicator difinitions
--------------------------------------------------------------------------------------
module_defs.active_indicators= {}
module_defs.active_indicators[module.type.general] = {
    {x=965.638, y=411.03, width=78, height=78},
}

--------------------------------------------------------------------------------------
-- prepare module scope environment
--------------------------------------------------------------------------------------
common.component_module_init(module, module_defs)

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
    local background = graphics.bitmap("assets/g3x_portrate.png")
    rctx:draw_bitmap{bitmap=background, x=x, y=y, scale=scale}

    -- Event-Action mappings which are enabled when the component is activated
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.component_mappings = {
            {event=g1000.EC8.increment, action=module.actions[id].turn_inc},
            {event=g1000.EC8.decrement, action=module.actions[id].turn_dec},
            {event=g1000.EC8L.down, action=module.actions[id].joystick_left},
            {event=g1000.EC8R.down, action=module.actions[id].joystick_right},
            {event=g1000.EC8U.down, action=module.actions[id].joystick_up},
            {event=g1000.EC8D.down, action=module.actions[id].joystick_down},
            {event=g1000.EC8P.down, action=module.actions[id].joystick_push},
            {event=g1000.SW32.down, action=module.actions[id].ent},
            {event=g1000.SW31.down, action=module.actions[id].clr},
            {event=g1000.SW28.down, action=module.actions[id].menu},
            {event=g1000.SW29.down, action=module.actions[id].fpl},
            {event=g1000.SW27.down, action=module.actions[id].directto},
        }
    end

    return component
end

return module
