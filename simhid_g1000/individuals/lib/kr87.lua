local module = {
    width = 1112,
    height = 260,
    actions = {},
    events = {},
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    adf=fs2020.mfwasm.rpn_executer("(>H:adf_AntAdf)"),
    bfo=fs2020.mfwasm.rpn_executer("(>H:adf_bfo)"),
    frq=fs2020.mfwasm.rpn_executer("(>H:adf_frqTransfert)"),
    flt_et=fs2020.mfwasm.rpn_executer("(>H:FltEt)"),
    set_rst=fs2020.mfwasm.rpn_executer("(>H:SetRst)"),
    knob_large_inc=fs2020.mfwasm.rpn_executer("(>K:ADF_100_INC)"),
    knob_large_dec=fs2020.mfwasm.rpn_executer("(>K:ADF_100_DEC)"),
    knob_small_inc=fs2020.mfwasm.rpn_executer("(L:XMLVAR_ADF_Frequency_10_Khz) if{ (>K:ADF_10_INC) } els{ (>K:ADF_1_INC) }"),
    knob_small_dec=fs2020.mfwasm.rpn_executer("(L:XMLVAR_ADF_Frequency_10_Khz) if{ (>K:ADF_10_DEC) } els{ (>K:ADF_1_DEC) }"),
    knob_push=fs2020.mfwasm.rpn_executer("(L:XMLVAR_ADF_Frequency_10_Khz) ! (>L:XMLVAR_ADF_Frequency_10_Khz)"),
}
--------------------------------------------------------------------------------------
-- operable are definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=62.203, height=36.762, rratio=0.05}
local buttons = {
    adf = {x=229.467, y=182.609, attr=attr_normal},
    bfo = {x=327.91, y=182.609, attr=attr_normal},
    frq = {x=426.969, y=182.609, attr=attr_normal},
    flt_et = {x=524.898, y=182.609, attr=attr_normal},
    set_rst = {x=625.701, y=182.609, attr=attr_normal},
}

for i = 1,#module.actions do
    module.events[i] = {}
    for name, button in pairs(buttons) do
        module.events[i][name] = mapper.register_event("KR-87:" .. name .. "_tapped")
    end
    module.events[i].all = mapper.register_event("KR-87: background_tapped")
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
    local background = graphics.bitmap("assets/kr87.png")
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
        x = x + 877.248 * scale, y = y + 52.11 * scale,
        width = 160.909 * scale, height = 160.909 * scale
    }
    function component.activate(state)
        canvas1:set_value(state)
    end

    -- captured window
    component.view_elements[#component.view_elements + 1] = {
        object = captured_window,
        x = x + 28 * scale, y = y + 16 * scale,
        width = 704 * scale, height = 131 * scale,
    }

    -- Event-Action mappings which are enabled when the component is activated
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.component_mappings = {
            {event=g1000.EC2Y.increment, action=module.actions[id].knob_large_inc},
            {event=g1000.EC2Y.decrement, action=module.actions[id].knob_large_dec},
            {event=g1000.EC2X.increment, action=module.actions[id].knob_small_inc},
            {event=g1000.EC2X.decrement, action=module.actions[id].knob_small_dec},
            {event=g1000.EC2P.down, action=module.actions[id].knob_push},
            {event=g1000.SW1.down, action=module.actions[id].frq},
        }
    end
    
    return component
end

return module
