local module = {}

local common = require("lib/common")
local libs = {
    gns430 = require("lib/gns430"),
    gtx330 = require("lib/gtx330"),
    cdi = require("lib/cdi"),
    dg = require("lib/dg"),
}
local lib_options = {
    cdi = {
        {type=libs.cdi.type.general, gps_dependency=true, enable_nav=true, source_is_gps="(L:AS430_CDI_Source_1)"},
    },
    dg = {
        {type=libs.dg.type.general, indicator_type=2, heading_bug=false},
    },
}

local captured_window_defs ={
    {key="gns430", name="GNS430 GPS"},
    {key="gtx330", name="GTX330 Transponder"},
}

local bg_color = graphics.color(60, 60, 60)
local views = {
    {
        -----------------------------------------------------------------------------------
        name = "Normal View",
        viewid = nil,
        width = 2224, height = 1668,
        background_color = bg_color,
        background_regions = {
            {x=0, y=0, width=2224, height=546},
            {x=0, y=546, width=278, height=1122},
            {x=1946, y=546, width=278, height=1122},
        },
        components = {
            {name="gns430", module=libs.gns430, cw="gns430", type_id=1, x=278, y=546, scale=1.5},
            {name="gtx330", module=libs.gtx330, cw="gtx330", type_id=1, x=278, y=1245, scale=1.5},
            {name="DG", module=libs.dg, cw=nil, type_id=1, x=480.385, y=23, scale=1},
            {name="NAV1 CDI", module=libs.cdi, cw=nil, type_id=1, x=1243.615, y=23, scale=1},
        },
        initial_active_component = 1,       
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
        },
    }
    local g1000 = module.device.events

    common.init_component_modules(libs, lib_options)

    local viewport = mapper.viewport{
        name = "Main viewport",
        displayno = display,
        x = 0, y = 0, width = scale, height = scale,
        aspect_ratio = 4 / 3,
    }
    local viewport_mappings = {}
    local view_changer = common.create_default_view_changer(viewport, views, 1, viewport_mappings, module.device, {})
    common.arrange_views(viewport, viewport_mappings, captured_window_defs, views, module.device)
    viewport:set_mappings(viewport_mappings)
    local target_view = views[1]
    viewport:add_mappings(target_view.components[target_view.active_component].instance.component_mappings)

    local global_mappings = {
        {
            {event=g1000.EC3.increment, action=libs.dg.actions[1].heading_bug_inc},
            {event=g1000.EC3.decrement, action=libs.dg.actions[1].heading_bug_dec},
            {event=g1000.EC7X.increment, action=libs.cdi.actions[1].obs_inc},
            {event=g1000.EC7X.decrement, action=libs.cdi.actions[1].obs_dec},
        }
    }
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
