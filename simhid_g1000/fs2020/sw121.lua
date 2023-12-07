local module = {}

local common = require("lib/common")
local libs = {
    g3x = require("lib/g3x_portrate"),
    gns430 = require("lib/gns430"),
    gtx330 = require("lib/gtx330"),
    gmc305 = require("lib/gmc305")
}

local captured_window_defs ={
    {key="g3x_left", name="G3X Left Display", window_title="AS3X_1"},
    {key="g3x_right", name="G3X Right Display", window_title="AS3X_2"},
    {key="gns430", name="GNS430 GPS", window_title="AS430"},
    {key="gtx330", name="GTX330 Transponder", window_title="AS330"},
}

local views = {
    {
        -----------------------------------------------------------------------------------
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
        -----------------------------------------------------------------------------------
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
        -----------------------------------------------------------------------------------
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
            {name = "EC8U", modtype = "button", modparam={repeat_interval = 80, repeat_delay = 500}},
            {name = "EC8D", modtype = "button", modparam={repeat_interval = 80, repeat_delay = 500}},
            {name = "EC8R", modtype = "button", modparam={repeat_interval = 80, repeat_delay = 500}},
            {name = "EC8L", modtype = "button", modparam={repeat_interval = 80, repeat_delay = 500}},
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

    common.init_component_modules(libs)

    local viewport = mapper.viewport{
        name = "SW121 viewport",
        displayno = display,
        x = 0, y = 0, width = scale, height = scale,
        aspect_ratio = 4 / 3,
    }
    local viewport_mappings = {}
    local view_changer = common.create_default_view_changer(viewport, views, 1, viewport_mappings, module.device, {
        {event=g1000.EC3.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
        {event=g1000.EC3.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
        {event=g1000.EC4X.increment, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
        {event=g1000.EC4X.decrement, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
        {event=g1000.EC4Y.increment, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
        {event=g1000.EC4Y.decrement, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
    })
    common.arrange_views(viewport, viewport_mappings, captured_window_defs, views, module.device)

    viewport:set_mappings(viewport_mappings)
    local target_view = views[1]
    viewport:add_mappings(target_view.components[target_view.active_component].instance.component_mappings)

    local global_mappings = {}
    common.set_global_mappings(global_mappings, libs)

    return {
        move_next_view = view_changer.move_next_view,
        move_previous_view = view_changer.move_previous_view,
        global_mappings = global_mappings,
        need_to_start_viewports = true,
    }
end

function module.stop()
    common.clear_component_instance(views)
    module.device:close()
    module.device = nil
end

return module
