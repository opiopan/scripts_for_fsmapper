local module = {
    width = 797,
    height = 741,
    actions = {},
    events = {},
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    left = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_push_left)"),
    right = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_push_right)"),
    knob_inc = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_knob_Inc)"),
    knob_dec = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_knob_Dec)"),
    knob_push = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_knob_Push)"),
}
--------------------------------------------------------------------------------------
-- operable are definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=80.088, height=76.472, rratio=0.07}
local buttons = {
    left = {x=208.152, y=633.555, attr=attr_normal},
    right = {x=500.115, y=633.555, attr=attr_normal},
}

for i = 1,#module.actions do
    module.events[i] = {}
    for name, button in pairs(buttons) do
        module.events[i][name] = mapper.register_event("Vigilus:" .. name .. "_tapped")
    end
    module.events[i].all = mapper.register_event("Vigilus: background_tapped")
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
    local background = graphics.bitmap("assets/vigilus.png")
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
        x = x + 346.5 * scale, y = y + 625.29 * scale,
        width = 95 * scale, height = 95 * scale
    }
    function component.activate(state)
        canvas1:set_value(state)
    end

    -- captured window
    component.view_elements[#component.view_elements + 1] = {
        object = captured_window,
        x = x + 52 * scale, y = y + 56 * scale,
        width = 688 * scale, height = 523 * scale,
    }

    -- Event-Action mappings which are enabled when the component is activated
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.component_mappings = {
            {event=g1000.EC9Y.increment, action=module.actions[id].knob_inc},
            {event=g1000.EC9Y.decrement, action=module.actions[id].knob_dec},
            {event=g1000.EC9X.increment, action=module.actions[id].knob_inc},
            {event=g1000.EC9X.decrement, action=module.actions[id].knob_dec},
            {event=g1000.EC9P.down, action=module.actions[id].knob_push},
        }
    end

    return component
end

return module
