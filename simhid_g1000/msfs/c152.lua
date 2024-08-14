local module = {}

local common = require("lib/common")
local libs = {
    kx165 = require("lib/kx165"),
    kt76c = require("lib/kt76c"),
    kr87 = require("lib/kr87_emu"),
    cdi = require("lib/cdi"),
    adf = require("lib/adf"),
    dg = require("lib/dg"),
}
local lib_options = {
    kr87 = {
        {power_rpn = "1 (>A:BUS LOOKUP INDEX, Number) (A:BUS CONNECTION ON:2, Bool) (A:ADF VOLUME:1, Percent Over 100) 0 > and"}
    },
    cdi = {
        {type=libs.cdi.type.general, gps_dependency=false, enable_nav=true, source_is_gps="0"}, -- NAV1
        {type=libs.cdi.type.general, gps_dependency=false, enable_nav=true, source_is_gps="0"}, -- NAV2
    },
    dg = {
        {type=libs.dg.type.general, indicator_type=2, heading_bug=false},
    },
}

local captured_window_defs ={
    -- {key="kap140", name="KAP-140 Auto Pilot Control"},
}

local bg_color = graphics.color(30, 40, 50)
local views = {
    {
        -----------------------------------------------------------------------------------
        name = "Normal View",
        viewid = nil,
        width = 2224, height = 1668,
        background_color = bg_color,
        background_regions = {
            {x=0, y=0, width=2224, height=1668},
        },
        components = {
            {name="navcom1", module=libs.kx165, cw=nil, type_id=1, x=1112, y=224, scale=1},
            {name="navcom2", module=libs.kx165, cw=nil, type_id=2, x=1112, y=563, scale=1},
            {name="kt76c", module=libs.kt76c, cw=nil, type_id=1, x=1112, y=902, scale=1},
            {name="kr87", module=libs.kr87, cw=nil, type_id=1, x=1112, y=1184, scale=1},

            {name="NAV1 CDI", module=libs.cdi, cw=nil, type_id=1, x=579.119, y=316.5, scale=1},
            {name="NAV2 CDI", module=libs.cdi, cw=nil, type_id=2, x=579.119, y=851.5, scale=1},
            {name="DG", module=libs.dg, cw=nil, type_id=1, x=32.881, y=316.5, scale=1},
            {name="ADF", module=libs.adf, cw=nil, type_id=1, x=32.881, y=851.5, scale=1},
        },
        initial_active_component = 1,       
    },
}

function module.start(config, aircraft)
    local display = config.simhid_g1000_display
    local scale = config.simhid_g1000_display_scale

    module.device = common.open_simhid_g1000{
        config = config,
        modifiers = {
            {class = "binary", modtype = "button"},
            {class = "relative", modtype = "incdec"},
            {name = "SW31", modtype = "button", modparam={longpress = 2000}},
        },
    }
    local g1000 = module.device.events

    common.init_component_modules(libs, lib_options)

    local viewport = mapper.viewport{
        name = "C152 viewport",
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
