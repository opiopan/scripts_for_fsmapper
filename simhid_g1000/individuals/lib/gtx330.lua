local module = {
    width = 1112,
    height = 282,
    actions = {},
    events = {},
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    ident = fs2020.mfwasm.rpn_executer("(>H:AS430_COMSWAP_Push)"),
}
--------------------------------------------------------------------------------------
-- operable are definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=69.189, height=45.569, rratio=0.05}
local buttons = {
    ident = {x=25.693, y=45.803, attr=attr_normal},
}

for i = 1,2 do
    module.events[i] = {}
    for name, button in pairs(buttons) do
        module.events[i][name] = mapper.register_event("GTX330:" .. name .. "_tapped")
    end
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
    local background = graphics.bitmap("assets/gtx330.png")
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
        component.view_mappings[#component.view_mappings + 1] = {event=module.events[id][name], action=module.actions[id][name]}
    end

    -- captured window
    component.view_elements[#component.view_elements + 1] = {
        object = captured_window,
        x = x + 303 * scale, y = y + 28 * scale,
        width = 580 * scale, height = 140 * scale,
    }

    return component
end

return module
