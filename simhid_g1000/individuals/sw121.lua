local module = {}

local common = require("lib/common")
local g3x = require("lib/g3x_portrate")
local vigilus = require("lib/vigilus")
local gns430 = require("lib/gns430")
local gtx330 = require("lib/gtx330")

local captured_window_defs ={
    {key="g3x_left", name="G3X Left Display"},
    {key="g3x_right", name="G3X Right Display"},
    -- {key="vigilus", name="Vigilus Engine Status Display"},
    {key="gns430", name="GNS430 GPS"},
    {key="gtx330", name="GTX330 Transponder"},
}

local views = {
    {
        name = "Primery View",
        viewid = nil,
        width = 2224, height = 1668,
        background_regions = {
            {x=0, y=0, width=2224, height=67},
            {x=0, y=1601, width=2224, height=67},
        },
        components = {
            {name="Left G3X", module=g3x, cw="g3x_left", type_id=1, x=0, y=67, scale=1, instance=nil},
            {name="Right G3X", module=g3x, cw="g3x_right", type_id=2, x=1112, y=67, scale=1, instance=nil},
        },
        mappings = {},
        active_component = 1,
    },
    {
        name = "Secondary View",
        viewid = nil,
        width = 2224, height = 1668,
        background_regions = {
            {x=0, y=0, width=1112, height=67},
            {x=0, y=1601, width=1112, height=67},
            {x=1112, y=0, width=1112, height=460},
            {x=1112, y=1208, width=1112, height=460},
        },
        components = {
            {name="Left G3X", module=g3x, cw="g3x_left", type_id=1, x=0, y=67, scale=1, instance=nil},
            -- {name="Vigilus", module=vigilus, cw="vigilus", type_id=1, x=1269, y=30, scale=1, instance=nil},
            {name="gns430", module=gns430, cw="gns430", type_id=1, x=1112, y=460, scale=1, instance=nil},
            {name="gtx330", module=gtx330, cw="gtx330", type_id=1, x=1112, y=926, scale=1, instance=nil},
        },
        mappings = {},
        active_component = 1,
    },
    {
        name = "3rd View",
        viewid = nil,
        width = 2224, height = 1668,
        background_regions = {
            {x=0, y=0, width=2224, height=273},
            {x=0, y=1395, width=2224, height=273},
            {x=0, y=273, width=278, height=1122},
            {x=1946, y=273, width=278, height=1122},
        },
        components = {
            {name="gns430", module=gns430, cw="gns430", type_id=1, x=278, y=273, scale=1.5, instance=nil},
            {name="gtx330", module=gtx330, cw="gtx330", type_id=1, x=278, y=972, scale=1.5, instance=nil},
        },
        mappings = {},
        active_component = 1,
    },
}

local current_view = 1

function module.start(config, aircraft)
    local display = config.simhid_g1000_display
    local scale = 1.0
    if config.debug then
        display = 1
        scale = 0.5
    end

    module.device = mapper.device{
        name = "SimHID G1000",
        type = "simhid",
        identifier = config.simhid_g1000_identifier,
        modifiers = {
            {class = "binary", modtype = "button"},
            {class = "relative", modtype = "incdec"},
            {name = "SW31", modtype = "button", modparam={longpress = 2000}},
            {name = "EC8U", modtype = "button", modparam={repeat_interval = 80}},
            {name = "EC8D", modtype = "button", modparam={repeat_interval = 80}},
            {name = "EC8R", modtype = "button", modparam={repeat_interval = 80}},
            {name = "EC8L", modtype = "button", modparam={repeat_interval = 80}},
        },
    }
    local g1000 = module.device.events

    local viewport = mapper.viewport{
        name = "Extra 330 viewport",
        displayno = display,
        x = 0, y = 0, width = scale, height = scale,
        aspect_ratio = 4 / 3,
    }

    local viewport_mappings = {}

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

    common.merge_array(viewport_mappings, {
        {event=g1000.AUX1D.down, action=function () change_view(1) end},
        {event=g1000.AUX1U.down, action=function () change_view(-1) end},
        {event=g1000.AUX2D.down, action=function () change_view(1) end},
        {event=g1000.AUX2U.down, action=function () change_view(-1) end},
    })

    local captured_windows ={}
    for i, def in ipairs(captured_window_defs) do
        captured_windows[def.key] ={
            object = mapper.view_elements.captured_window{name=def.name}
        }
    end

    local global_mappings = {}
    for viewix, view in ipairs(views) do
        view.active_component = 1
        local background = graphics.bitmap(view.width, view.height)
        local rctx = graphics.rendering_context(background)
        local view_elements = {}
        local view_mappings = {}
        common.merge_array(view_mappgins, view.mappings)
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
            component.instance = component.module.create_component(
                i, component.type_id, captured_windows[component.cw].object,
                component.x, component.y, component.scale,
                rctx, module.device
            )
            common.merge_array(view_elements, component.instance.view_elements)
            global_mappings[#global_mappings + 1] = component.instance.global_mappings
            common.merge_array(view_mappings, component.instance.view_mappings)
            component.instance.callback = change_active_component
        end
        rctx:set_brush(graphics.color(50, 50, 50))
        for i, rect in ipairs(view.background_regions) do
            rctx:fill_rectangle(rect.x, rect.y, rect.width, rect.height)    
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

    viewport:set_mappings(viewport_mappings)
    local target_view = views[current_view]
    viewport:add_mappings(target_view.components[target_view.active_component].instance.component_mappings)

    return {
        move_next_view = function () change_view(1) end,
        move_previous_view = function () change_view(-1) end,
        global_mappings = global_mappings,
        need_to_start_viewports = true,
    }
end

function module.stop()
    for i, view in ipairs(views) do
        view.viewid = nil
        for j, component in ipairs(view.components) do
            component.instance = nil
        end
    end
    module.device:close()
    module.device = nil
end

return module
