local module = {
    width = 0,
    height = 0,
    type = {
        general = 1,
    },
    evids = {},
}

setmetatable(module, {
    __gc = function (obj)
        module.reset()
    end
})


--------------------------------------------------------------------------------------
-- reset function called when aircraft evironment is build each
--------------------------------------------------------------------------------------
function module.reset()
    for i, evid in ipairs(module.evids) do
        mapper.unregister_event(evid)
    end
    module.evids = {}
end

--------------------------------------------------------------------------------------
-- instance generator
--------------------------------------------------------------------------------------
function module.create_component(component_name, id, captured_window, x, y, scale, rctx, simhid_g1000, options)
    local offset = {x=0, y=0}
    if options.x_offset ~= nil then offset.x = options.x_offset end
    if options.y_offset ~= nil then offset.y = options.y_offset end
    local component = {
        name = component_name,
        view_elements = {
            {object = captured_window, x=x+offset.x, y=y+offset.y, width=options.width-offset.x, height=options.height-offset.y}
        },
        view_mappings = {},
        component_mappings = {},
    }

    if options.bg_image ~= nil then
        rctx:draw_bitmap{bitmap=options.bg_image, x=x, y=y, scale=scale}
    end

    if options.on_tap ~= nil then
        if options.bg_image == nil then
            rctx:set_brush(graphics.color(0, 0, 0, 1/255))
            rctx:fill_rectangle(x, y, options.width, options.height)
        end

        local evid_tap = mapper.register_event(component_name .. ": tapped")
        module.evids[#module.evids + 1] = evid_tap
        if options.tap_area ~= nil then
            component.view_elements[#component.view_elements + 1] = {
                object = mapper.view_elements.operable_area{
                    event_tap=evid_tap,
                    reaction_color=options.tap_area.reaction_color,
                    round_ratio=options.tap_area.rratio,
                },
                x=x+options.tap_area.x , y=y+options.tap_area.y,
                width=options.tap_area.width, height=options.tap_area.height
            }
        else
            component.view_elements[#component.view_elements + 1] = {
                object = mapper.view_elements.operable_area{event_tap=evid_tap, reaction_color=graphics.color(0,0,0,0)},
                x=x, y=y, width=options.width, height=options.height
            }
        end
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