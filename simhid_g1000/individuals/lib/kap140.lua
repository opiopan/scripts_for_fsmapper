local module = {
    width = 1112,
    height = 296,
    actions = {},
    events = {},
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    ap=fs2020.mfwasm.rpn_executer("(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) ! if{ (>H:Generic_Autopilot_Manual_Off) } }"),
    hdg=fs2020.mfwasm.rpn_executer("(>H:KAP140_Push_HDG)"),
    nav=fs2020.mfwasm.rpn_executer("(>H:KAP140_Push_NAV)"),
    apr=fs2020.mfwasm.rpn_executer("(>H:KAP140_Push_APR)"),
    rev=fs2020.mfwasm.rpn_executer("(>H:KAP140_Push_REV)"),
    alt=fs2020.mfwasm.rpn_executer("(>H:KAP140_Push_ALT)"),
    up=fs2020.mfwasm.rpn_executer("(>H:KAP140_Push_UP)"),
    dn=fs2020.mfwasm.rpn_executer("(>H:KAP140_Push_DN)"),
    arm=fs2020.mfwasm.rpn_executer("(>H:KAP140_Push_ARM)"),
    baro=fs2020.mfwasm.rpn_executer("(>H:KAP140_Push_BARO)"),
    baro_long=fs2020.mfwasm.rpn_executer("(>H:KAP140_Long_Push_BARO)"),
    knob_inner_inc=fs2020.mfwasm.rpn_executer("(>H:KAP140_Knob_Inner_inc)"),
    knob_inner_dec=fs2020.mfwasm.rpn_executer("(>H:KAP140_Knob_Inner_dec)"),
    knob_outer_inc=fs2020.mfwasm.rpn_executer("(>H:KAP140_Knob_Outer_inc)"),
    knob_outer_dec=fs2020.mfwasm.rpn_executer("(>H:KAP140_Knob_Outer_dec)"),
}
--------------------------------------------------------------------------------------
-- operable are definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=69.674, height=39.247, rratio=0.05}
local buttons = {
    ap = {x=46.497, y=215.701, attr=attr_normal},
    hdg = {x=270.684, y=215.701, attr=attr_normal},
    nav = {x=376.357, y=215.701, attr=attr_normal},
    apr = {x=485.876, y=215.701, attr=attr_normal},
    rev = {x=590.718, y=215.701, attr=attr_normal},
    alt = {x=700.237, y=215.701, attr=attr_normal},
    up = {x=827.779, y=132.204, attr=attr_normal},
    dn = {x=827.779, y=215.701, attr=attr_normal},
    arm = {x=887.8, y=35.546, attr=attr_normal},
    baro = {x=994.98, y=35.546, attr=attr_normal},
}

for i = 1,#module.actions do
    module.events[i] = {}
    for name, button in pairs(buttons) do
        module.events[i][name] = mapper.register_event("KAP-140:" .. name .. "_tapped")
    end
    module.events[i].all = mapper.register_event("KAP-140: background_tapped")
end

--------------------------------------------------------------------------------------
-- module destructor (GC handler)
--------------------------------------------------------------------------------------
setmetatable(module, {
    __gc = function (obj)
        for i = 1,#module.actions do
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
        view_mappings = {},
        component_mappings = {},
        callback = nil,
    }

    -- update view background bitmap
    local background = graphics.bitmap("assets/kap140.png")
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
    local canvas1 = mapper.view_elements.canvas{
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
        object = canvas1,
        x = x + 935.997 * scale, y = y + 122.99 * scale,
        width = 130 * scale, height = 130 * scale
    }
    function component.activate(state)
        canvas1:set_value(state)
    end

    -- captured window
    component.view_elements[#component.view_elements + 1] = {
        object = captured_window,
        x = x + 141 * scale, y = y + 22 * scale,
        width = 658 * scale, height = 142 * scale,
    }

    -- Event-Action mappings which are enabled when the component is activated
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.component_mappings = {
            {event=g1000.EC4Y.increment, action=module.actions[id].knob_outer_inc},
            {event=g1000.EC4Y.decrement, action=module.actions[id].knob_outer_dec},
            {event=g1000.EC4X.increment, action=module.actions[id].knob_inner_inc},
            {event=g1000.EC4X.decrement, action=module.actions[id].knob_inner_dec},
        }
        component.viewport_mappings = {
            {event=g1000.SW2.down, action=module.actions[id].ap},
            {event=g1000.SW4.down, action=module.actions[id].hdg},
            {event=g1000.SW5.down, action=module.actions[id].alt},
            {event=g1000.SW6.down, action=module.actions[id].nav},
            {event=g1000.SW8.down, action=module.actions[id].apr},
            {event=g1000.SW9.down, action=module.actions[id].rev},
            {event=g1000.SW11.down, action=module.actions[id].up},
            {event=g1000.SW13.down, action=module.actions[id].dn},
        }
    end
    
    return component
end

return module
