local module = {}

local common = require("lib/common")
local libs = {
    g3x = require("lib/g3x_portrate"),
    gns430 = require("lib/gns430"),
    gtx330 = require("lib/gtx330"),
    gmc305 = require("lib/gmc305")
}

local captured_window_defs ={
    {key="g3x_left", name="G3X Left Display"},
    {key="g3x_right", name="G3X Right Display"},
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
            {name="Left G3X", module=libs.g3x, cw="g3x_left", type_id=1, x=0, y=67, scale=1, instance=nil},
            {name="Right G3X", module=libs.g3x, cw="g3x_right", type_id=2, x=1112, y=67, scale=1, instance=nil},
        },
        mappings = {},
        initial_active_component = 1,
    },
    {
        name = "Secondary View",
        viewid = nil,
        width = 2224, height = 1668,
        background_regions = {
            {x=0, y=0, width=1112, height=67},
            {x=0, y=1601, width=1112, height=67},
            {x=1112, y=0, width=1112, height=666},
            {x=1112, y=1414, width=1112, height=254},
        },
        components = {
            {name="Left G3X", module=libs.g3x, cw="g3x_left", type_id=1, x=0, y=67, scale=1, instance=nil},
            {name="gmc305", module=libs.gmc305, cw=nil, type_id=1, x=1112, y=254, scale=1, instance=nil},
            {name="gns430", module=libs.gns430, cw="gns430", type_id=1, x=1112, y=666, scale=1, instance=nil},
            {name="gtx330", module=libs.gtx330, cw="gtx330", type_id=1, x=1112, y=1132, scale=1, instance=nil},
        },
        mappings = {},
        initial_active_component = 1,
    },
    {
        name = "3rd View",
        viewid = nil,
        width = 2224, height = 1668,
        background_regions = {
            {x=0, y=0, width=2224, height=546},
            {x=0, y=546, width=278, height=1122},
            {x=1946, y=546, width=278, height=1122},
        },
        components = {
            {name="gmc305", module=libs.gmc305, cw=nil, type_id=1, x=278, y=0, scale=1.5, instance=nil},
            {name="gns430", module=libs.gns430, cw="gns430", type_id=1, x=278, y=546, scale=1.5, instance=nil},
            {name="gtx330", module=libs.gtx330, cw="gtx330", type_id=1, x=278, y=1245, scale=1.5, instance=nil},
        },
        mappings = {},
        initial_active_component = 2,
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

    views[1].mappings = {
        {event=g1000.SW14.down, action=libs.g3x.actions[1].softkey1},
        {event=g1000.SW15.down, action=libs.g3x.actions[1].softkey2},
        {event=g1000.SW16.down, action=libs.g3x.actions[1].softkey3},
        {event=g1000.SW17.down, action=libs.g3x.actions[1].softkey4},
        {event=g1000.SW18.down, action=libs.g3x.actions[1].softkey5},
        {event=g1000.SW20.down, action=libs.g3x.actions[2].softkey1},
        {event=g1000.SW21.down, action=libs.g3x.actions[2].softkey2},
        {event=g1000.SW22.down, action=libs.g3x.actions[2].softkey3},
        {event=g1000.SW23.down, action=libs.g3x.actions[2].softkey4},
        {event=g1000.SW24.down, action=libs.g3x.actions[2].softkey5},
    }
    views[2].mappings = {
        {event=g1000.SW14.down, action=libs.g3x.actions[1].softkey1},
        {event=g1000.SW15.down, action=libs.g3x.actions[1].softkey2},
        {event=g1000.SW16.down, action=libs.g3x.actions[1].softkey3},
        {event=g1000.SW17.down, action=libs.g3x.actions[1].softkey4},
        {event=g1000.SW18.down, action=libs.g3x.actions[1].softkey5},
    }

    for name, lib in pairs(libs) do
        if lib.reset ~= nil then
            lib.reset()
        end
        if lib.observed_data ~= nil then
            fs2020.mfwasm.add_observed_data(lib.observed_data)
        end
    end

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

        {event=g1000.EC3.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
        {event=g1000.EC3.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
        {event=g1000.EC4X.increment, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
        {event=g1000.EC4X.decrement, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
        {event=g1000.EC4Y.increment, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
        {event=g1000.EC4Y.decrement, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
    })

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
        common.merge_array(view_mappings, view.mappings)
        rctx:set_brush(graphics.color(50, 50, 50))
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
            common.merge_array(view_elements, component.instance.view_elements)
            common.merge_array(view_mappings, component.instance.view_mappings)
            component.instance.callback = change_active_component
            if component.instance.viewport_mappings ~= nil then
                common.merge_array(viewport_mappings, component.instance.viewport_mappings)
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

    viewport:set_mappings(viewport_mappings)
    local target_view = views[current_view]
    viewport:add_mappings(target_view.components[target_view.active_component].instance.component_mappings)

    local global_mappings = {}
    for name, lib in pairs(libs) do
        if lib.create_global_mappings ~= nil then
            global_mappings[#global_mappings + 1] = lib.create_global_mappings()
        end
    end

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
