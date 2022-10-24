local module = {
    width = 1112,
    height = 1534,
    actions = {},
    events = {},
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
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
local buttons = {
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

for i = 1,2 do
    module.events[i] = {}
    for name, button in pairs(buttons) do
        module.events[i][name] = mapper.register_event("G3X Portrate:" .. name .. "_tapped")
    end
    module.events[i].all = mapper.register_event("G3X Portrate: background_tapped")
end

--------------------------------------------------------------------------------------
-- module destructor (GC handler)
--------------------------------------------------------------------------------------
setmetatable(module, {
    __gc = function (obj)
        for i = 1, 2 do
            for key, evid in pairs(obj.events[i]) do
                mapper.unregister_message(evid)
            end
        end
    end
})

--------------------------------------------------------------------------------------
-- instance generator
--------------------------------------------------------------------------------------
function module.create_component(component_name, id, captured_window, x, y, scale, rctx, simhid_g1000)
    local component = {
        name = component_name,
        view_elements = {},
        global_mappings = {},
        view_mappings = {},
        component_mappings = {},
        callback = nil,
    }

    -- update view background bitmap
    local background = graphics.bitmap("assets/g3x_portrate.png")
    rctx:draw_bitmap{bitmap=background, x=x, y=y, scale=scale}

    -- operable area
    local function notify_tapped()
        if component.callback then
            component.callback(component_name)
        end
    end
    for name, button in pairs(buttons) do
        component.view_elements[#component.view_elements + 1] = {
            object = mapper.view_elements.operable_area{event_tap = module.events[id][name], round_ratio=button.attr.rratio},
            x = x + button.x * scale, y = y + button.y * scale,
            width = button.attr.width * scale, height = button.attr.height * scale
        }
        component.view_mappings[#component.view_mappings + 1] = {event=module.events[id][name], action=filter.duplicator(module.actions[id][name], notify_tapped)}
    end
    component.view_elements[#component.view_elements + 1] = {
        object = mapper.view_elements.operable_area{event_tap = module.events[id].all, reaction_color=graphics.color(0, 0, 0, 0)},
        x = x, y = y,
        width = module.width * scale, height = module.height * scale
    }
    component.view_mappings[#component.view_mappings + 1] = {event=module.events[id].all, action=notify_tapped}

    -- activation indicator
    local canvas = mapper.view_elements.canvas{
        logical_width = 1,
        logical_height = 1,
        value = 0,
        renderer = function (rctx, value)
            if value > 0 then
                rctx:set_brush(common.active_indicator_color)
                rctx:fill_geometry{geometry = common.circle, x = 0, y = 0}
            end
        end
    }
    component.view_elements[#component.view_elements + 1] = {
        object = canvas,
        x = x + 965.638 * scale, y = y + 411.03 * scale,
        width = 78 * scale, height = 78 * scale
    }
    function component.activate(state)
        canvas:set_value(state)
    end

    -- captured window
    component.view_elements[#component.view_elements + 1] = {
        object = captured_window,
        x = x + 100 * scale, y = y + 82 * scale,
        width = 775 * scale, height = 1261 * scale,
    }

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
