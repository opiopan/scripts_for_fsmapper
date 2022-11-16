local module = {
    width = 0,
    height = 0,
    type = {
        general = 1,
    },
}

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

    return component
end

--------------------------------------------------------------------------------------
-- global mappings generator
--------------------------------------------------------------------------------------
function module.create_global_mappings()
end

return module