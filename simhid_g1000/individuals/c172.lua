local module = {}

local common = require("lib/common")
local libs = {
    gns530 = require("lib/gns530"),
    gns430 = require("lib/gns430"),
    kap140 = require("lib/kap140"),
    kt76c = require("lib/kt76c"),
    kr87 = require("lib/kr87"),
    cdi = require("lib/cdi")
}
local lib_options = {
    cdi = {
        {type=libs.cdi.type.general, gps_dependency=true, enable_nav=true, source_is_gps="(L:AS530_CDI_Source_1)"}, -- NAV1
        {type=libs.cdi.type.general, gps_dependency=true, enable_nav=true, source_is_gps="(L:AS430_CDI_Source_1)"}, -- NAV2
    },
}

local captured_window_defs ={
    {key="gns530", name="GNS530 GPS"},
    {key="gns430", name="GNS430 GPS"},
    {key="kap140", name="KAP-140 Auto Pilot Control"},
    {key="kr87", name="KR-87 ADF"},
}

local views = {
    {
        -----------------------------------------------------------------------------------
        name = "Normal View",
        viewid = nil,
        width = 2224, height = 1668,
        background_regions = {
            {x=0, y=569, width=1112, height=1099},
            {x=1112, y=0, width=1112, height=63},
            {x=1112, y=1605, width=1112, height=63},
        },
        components = {
            {name="gns530", module=libs.gns530, cw="gns530", type_id=1, x=1112, y=63, scale=1, instance=nil},
            {name="gns430", module=libs.gns430, cw="gns430", type_id=1, x=1112, y=879, scale=1, instance=nil},
            {name="kap140", module=libs.kap140, cw="kap140", type_id=1, x=0, y=0, scale=1, instance=nil},
            {name="kt76c", module=libs.kt76c, cw=nil, type_id=1, x=0, y=296, scale=1, instance=nil},
            {name="kr87", module=libs.kr87, cw="kr87", type_id=1, x=1112, y=1345, scale=1, instance=nil},
            {name="NAV1 CDI", module=libs.cdi, cw=nil, type_id=1, x=306, y=606, scale=1, instance=nil},
            {name="NAV2 CDI", module=libs.cdi, cw=nil, type_id=2, x=306, y=1141, scale=1, instance=nil},
        },
        mappings = {},
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
        name = "C172 viewport",
        displayno = display,
        x = 0, y = 0, width = scale, height = scale,
        aspect_ratio = 4 / 3,
    }
    local viewport_mappings = {}
    local view_changer = common.create_default_view_changer(viewport, views, 1, viewport_mappings, module.device, {
        {event=g1000.EC3.increment, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
        {event=g1000.EC3.decrement, action=fs2020.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
    })
    common.arrange_views(viewport, viewport_mappings, captured_window_defs, views, module.device)
    viewport:set_mappings(viewport_mappings)
    local target_view = views[1]
    viewport:add_mappings(target_view.components[target_view.active_component].instance.component_mappings)

    local global_mappings = {
        {
            {event=g1000.EC4X.increment, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC4X.decrement, action=fs2020.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC4Y.increment, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC4Y.decrement, action=fs2020.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
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