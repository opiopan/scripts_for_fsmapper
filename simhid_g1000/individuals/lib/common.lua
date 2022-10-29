local module = {
    active_indicator_color = graphics.color(0, 254, 255, 0.36),
    view_background_color = graphics.color(50, 50, 50),
}

--------------------------------------------------------------------------------------
-- graphical assets
--------------------------------------------------------------------------------------
module.circle = graphics.path()
module.circle:add_figure{
    fill_mode = "winding", -- none | winding | alternate (default: none)
    from = {0, 0.5},
    segments = {
        {to = {0.5, 0}, radius = 0.5, direction="clockwise", arc_type="small"},
        {to = {1, 0.5}, radius = 0.5, direction="clockwise", arc_type="small"},
        {to = {0.5, 1}, radius = 0.5, direction="clockwise", arc_type="small"},
        {to = {0, 0.5}, radius = 0.5, direction="clockwise", arc_type="small"},
    }
}

--------------------------------------------------------------------------------------
-- utility functions
--------------------------------------------------------------------------------------
function module.merge_array(target, source)
    for i, value in ipairs(source) do
        target[#target + 1] = value
    end
    return target
end

--------------------------------------------------------------------------------------
-- handling component based view
--------------------------------------------------------------------------------------
function module.init_component_modules(libs)
    for name, lib in pairs(libs) do
        if lib.reset ~= nil then
            lib.reset()
        end
        if lib.observed_data ~= nil then
            fs2020.mfwasm.add_observed_data(lib.observed_data)
        end
    end
end

function module.create_default_view_changer(viewport, views, initial_view, viewport_mappings, g1000, additional_viewport_mappings)
    local current_view = initial_view
    local function change_view(d)
        current_view = current_view + d
        if current_view > #views then
            current_view = 1
        elseif current_view < 1 then
            current_view = #views
        end
        viewport:change_view(views[current_view].viewid)
        mapper.delay(1, function ()
            viewport:set_mappings(viewport_mappings)
            local view = views[current_view]
            viewport:add_mappings(view.components[view.active_component].instance.component_mappings)
        end)
    end

    module.merge_array(viewport_mappings, {
        {event=g1000.AUX1D.down, action=function () change_view(1) end},
        {event=g1000.AUX1U.down, action=function () change_view(-1) end},
        {event=g1000.AUX2D.down, action=function () change_view(1) end},
        {event=g1000.AUX2U.down, action=function () change_view(-1) end},
    })

    module.merge_array(viewport_mappings, additional_viewport_mappings)

    return {
        move_next_view = function () change_view(1) end,
        move_previous_view = function () change_view(-1) end,
    }
end

function module.arrange_views(viewport, viewport_mappings, captured_window_defs, views)
    local captured_windows ={}
    for i, def in ipairs(captured_window_defs) do
        captured_windows[def.key] ={
            object = mapper.view_elements.captured_window{name=def.name}
        }
    end

    for viewix, view in ipairs(views) do
        view.active_component = view.initial_active_component
        local background = graphics.bitmap(view.width, view.height)
        local rctx = graphics.rendering_context(background)
        local view_elements = {}
        local view_mappings = {}
        module.merge_array(view_mappings, view.mappings)
        rctx:set_brush(module.view_background_color)
        for i, rect in ipairs(view.background_regions) do
            rctx:fill_rectangle(rect.x, rect.y, rect.width, rect.height)    
        end
        local change_active_component = function (cid)
            if view.active_component ~= cid then
                view.components[view.active_component].instance.activate(0)
                view.active_component = cid
                view.components[view.active_component].instance.activate(1)
                viewport:set_mappings(viewport_mappings)
                viewport:add_mappings(view.components[view.active_component].instance.component_mappings)
            end
        end
        for i, component in ipairs(view.components) do
            local cw = nil
            if component.cw ~= nil then
                cw = captured_windows[component.cw].object
            end
            component.instance = component.module.create_component(
                i, component.type_id, cw,
                component.x, component.y, component.scale,
                rctx, module.device
            )
            module.merge_array(view_elements, component.instance.view_elements)
            module.merge_array(view_mappings, component.instance.view_mappings)
            component.instance.callback = change_active_component
            if component.instance.viewport_mappings ~= nil then
                module.merge_array(viewport_mappings, component.instance.viewport_mappings)
            end
        end
        rctx:finish_rendering()
        view.viewid = viewport:register_view{
            name = view.name,
            elements = view_elements,
            logical_width = view.width,
            logical_height = view.height,
            background = background,
            mappings = view_mappings,
        }
        view.components[view.active_component].instance.activate(1)
    end
end

function module.set_global_mappings(global_mappings, libs)
    for name, lib in pairs(libs) do
        if lib.create_global_mappings ~= nil then
            global_mappings[#global_mappings + 1] = lib.create_global_mappings()
        end
    end
end

function module.clear_component_instance(views)
    for i, view in ipairs(views) do
        view.viewid = nil
        for j, component in ipairs(view.components) do
            component.instance = nil
        end
    end
end

return module