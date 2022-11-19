local module = {
    width = 0,
    height = 0,
    type = {
        general = 1,
    },
}

local evid_tap = mapper.register_event("captured_window: tapped")

setmetatable(module, {
    __gc = function (obj)
        mapper.unregister_message(evid_tap)
    end
})


--------------------------------------------------------------------------------------
-- reset function called when aircraft evironment is build each
--------------------------------------------------------------------------------------
function module.reset()
end

--------------------------------------------------------------------------------------
-- instance generator
--------------------------------------------------------------------------------------
function module.create_component(component_name, id, captured_window, x, y, scale, rctx, simhid_g1000, options)
    local component = {
        name = component_name,
        view_elements = {
            {object = captured_window, x=x, y=y, width=options.width, height=options.height}
        },
        view_mappings = {},
        component_mappings = {},
    }

    if options.on_tap ~= nil then
        rctx:set_brush(graphics.color(0, 0, 0, 1/255))
        rctx:fill_rectangle(x, y, options.width, options.height)
        component.view_elements[#component.view_elements + 1] = {
            object = mapper.view_elements.operable_area{event_tap=evid_tap, reaction_color=graphics.color(0,0,0,0)},
            x=x, y=y, width=options.width, height=options.height
        }
        component.view_mappings[#component.view_mappings + 1] = {event=evid_tap, action=function () options.on_tap() end}
    end

    return component
end

--------------------------------------------------------------------------------------
-- global mappings generator
--------------------------------------------------------------------------------------
function module.create_global_mappings()
end

return module