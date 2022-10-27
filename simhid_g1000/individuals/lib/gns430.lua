local module = {
    width = 1112,
    height = 466,
    actions = {},
    events = {},
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    comswap = fs2020.mfwasm.rpn_executer("(>H:AS430_COMSWAP_Push)"),
    navswap = fs2020.mfwasm.rpn_executer("(>H:AS430_NAVSWAP_Push)"),
    rng_dezoom = fs2020.mfwasm.rpn_executer("(>H:AS430_RNG_Dezoom)"),
    rng_zoom = fs2020.mfwasm.rpn_executer("(>H:AS430_RNG_Zoom)"),
    directto = fs2020.mfwasm.rpn_executer("(>H:AS430_DirectTo_Push)"),
    menu = fs2020.mfwasm.rpn_executer("(>H:AS430_MENU_Push)"),
    clr = fs2020.mfwasm.rpn_executer("(>H:AS430_CLR_Push)"),
    clr_long = fs2020.mfwasm.rpn_executer("(>H:AS430_CLR_Push_Long)"),
    ent = fs2020.mfwasm.rpn_executer("(>H:AS430_ENT_Push)"),
    cdi = fs2020.mfwasm.rpn_executer("(>H:AS430_CDI_Push)"),
    obs = fs2020.mfwasm.rpn_executer("(>H:AS430_OBS_Push)"),
    msg = fs2020.mfwasm.rpn_executer("(>H:AS430_MSG_Push)"),
    fpl = fs2020.mfwasm.rpn_executer("(>H:AS430_FPL_Push)"),
    proc = fs2020.mfwasm.rpn_executer("(>H:AS430_PROC_Push)"),
    left_large_knob_inc = fs2020.mfwasm.rpn_executer("(>H:AS430_LeftLargeKnob_Right)"),
    left_large_knob_dec = fs2020.mfwasm.rpn_executer("(>H:AS430_LeftLargeKnob_Left)"),
    left_small_knob_inc = fs2020.mfwasm.rpn_executer("(>H:AS430_LeftSmallKnob_Right)"),
    left_small_knob_dec = fs2020.mfwasm.rpn_executer("(>H:AS430_LeftSmallKnob_Left)"),
    left_small_knob_push = fs2020.mfwasm.rpn_executer("(>H:AS430_LeftSmallKnob_Push)"),
    right_large_knob_inc = fs2020.mfwasm.rpn_executer("(>H:AS430_RightLargeKnob_Right)"),
    right_large_knob_dec = fs2020.mfwasm.rpn_executer("(>H:AS430_RightLargeKnob_Left)"),
    right_small_knob_inc = fs2020.mfwasm.rpn_executer("(>H:AS430_RightSmallKnob_Right)"),
    right_small_knob_dec = fs2020.mfwasm.rpn_executer("(>H:AS430_RightSmallKnob_Left)"),
    right_small_knob_push = fs2020.mfwasm.rpn_executer("(>H:AS430_RightSmallKnob_Push)"),
}
--------------------------------------------------------------------------------------
-- operable are definitions
--------------------------------------------------------------------------------------
local attr_swap = {width=49.127, height=74.004, rratio=0.1}
local attr_range = {width=67.501, height=52.437, rratio=0.1}
local attr_left = {width=77.068, height=47.371, rratio=0.1}
local attr_bottom = {width=69.189, height=50.003, rratio=0.1}
local buttons = {
    comswap = {x=183.481, y=71.039, attr=attr_swap},
    navswap = {x=183.481, y=180.925, attr=attr_swap},
    rng_zoom = {x=906.396, y=41.037, attr=attr_range},
    rng_dezoom = {x=1003.637, y=41.037, attr=attr_range},
    directto = {x=902.959, y=110.699, attr=attr_left},
    menu = {x=1002.637, y=110.699, attr=attr_left},
    clr = {x=902.959, y=178.925, attr=attr_left},
    ent = {x=1002.637, y=178.925, attr=attr_left},
    cdi = {x=282.645, y=398.823, attr=attr_bottom},
    obs = {x=409.329, y=398.823, attr=attr_bottom},
    msg = {x=534.746, y=398.823, attr=attr_bottom},
    fpl = {x=659.821, y=398.823, attr=attr_bottom},
    proc = {x=786.505, y=398.823, attr=attr_bottom},
}

for i = 1,2 do
    module.events[i] = {}
    for name, button in pairs(buttons) do
        module.events[i][name] = mapper.register_event("GNS430:" .. name .. "_tapped")
    end
    module.events[i].all = mapper.register_event("GNS430: background_tapped")
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
    local background = graphics.bitmap("assets/gns430.png")
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
    local canvas2 = mapper.view_elements.canvas{
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
        x = x + 36.853 * scale, y = y + 308.376 * scale,
        width = 102.201 * scale, height = 102.201 * scale
    }
    component.view_elements[#component.view_elements + 1] = {
        object = canvas2,
        x = x + 976.504 * scale, y = y + 308.376 * scale,
        width = 102.201 * scale, height = 102.201 * scale
    }
    function component.activate(state)
        canvas1:set_value(state)
        canvas2:set_value(state)
    end

    -- captured window
    component.view_elements[#component.view_elements + 1] = {
        object = captured_window,
        x = x + 266 * scale, y = y + 52 * scale,
        width = 609 * scale, height = 308 * scale,
    }

    -- Event-Action mappings which are enabled when the component is activated
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.component_mappings = {
            {event=g1000.SW26.down, action=module.actions[id].comswap},
            {event=g1000.SW1.down, action=module.actions[id].navswap},
            {event=g1000.EC8.increment, action=module.actions[id].rng_dezoom},
            {event=g1000.EC8.decrement, action=module.actions[id].rng_zoom},
            {event=g1000.SW27.down, action=module.actions[id].directto},
            {event=g1000.SW28.down, action=module.actions[id].menu},
            {event=g1000.SW31.down, action=module.actions[id].clr},
            {event=g1000.SW31.longpressed, action=module.actions[id].clr_long},
            {event=g1000.SW32.down, action=module.actions[id].ent},
            {event=g1000.SW29.down, action=module.actions[id].fpl},
            {event=g1000.SW30.down, action=module.actions[id].proc},
            {event=g1000.EC4Y.increment, action=module.actions[id].left_large_knob_inc},
            {event=g1000.EC4Y.decrement, action=module.actions[id].left_large_knob_dec},
            {event=g1000.EC4X.increment, action=module.actions[id].left_small_knob_inc},
            {event=g1000.EC4X.decrement, action=module.actions[id].left_small_knob_dec},
            {event=g1000.EC4P.down, action=module.actions[id].left_small_knob_push},
            {event=g1000.EC9Y.increment, action=module.actions[id].right_large_knob_inc},
            {event=g1000.EC9Y.decrement, action=module.actions[id].right_large_knob_dec},
            {event=g1000.EC9X.increment, action=module.actions[id].right_small_knob_inc},
            {event=g1000.EC9X.decrement, action=module.actions[id].right_small_knob_dec},
            {event=g1000.EC9P.down, action=module.actions[id].right_small_knob_push},
        }
    end

    return component
end

return module
