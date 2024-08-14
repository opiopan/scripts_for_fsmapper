local module = {}

local common = require("lib/common")
local libs = {
    gns530 = require("lib/gns530"),
    gns430 = require("lib/gns430"),
    kap140 = require("lib/kap140"),
    gtx330 = require("lib/gtx330"),
    kr87 = require("lib/kr87_emu"),
    kx165 = require("lib/kx165"),
    cdi = require("lib/cdi"),
    adf = require("lib/adf"),
    dg = require("lib/dg"),
}
local lib_options = {
    kr87 = {
        {power_rpn = "3 (>A:BUS LOOKUP INDEX, Number) (A:BUS CONNECTION ON:4, Bool) (A:ADF VOLUME:1, Percent Over 100) 0 > and"}
    },
    cdi = {
        {type=libs.cdi.type.general, gps_dependency=true, enable_nav=true, source_is_gps="(L:AS530_CDI_Source_1) (L:DHC2_TAB_RADIOS) ! and"}, -- NAV1
        {type=libs.cdi.type.general, gps_dependency=true, enable_nav=true, source_is_gps="(L:AS430_CDI_Source_1) (L:DHC2_TAB_RADIOS) ! and"}, -- NAV2
    },
    dg = {
        {type=libs.dg.type.general, red_mark=true, heading_bug=true},
    },
}

local captured_window_defs ={
    {key="gns530", name="GNS530 GPS", window_title="AS530"},
    {key="gns430", name="GNS430 GPS", window_title="AS430"},
    {key="kap140", name="KAP-140 Auto Pilot Control", window_title="KAP140"},
    {key="gtx330", name="GTX330 Transponder", window_title="AS330"},
}

local bg_color = graphics.color(30, 40, 50)
local views = {
    {
        -----------------------------------------------------------------------------------
        name = "GPS with ADF",
        viewid = nil,
        width = 2224, height = 1668,
        background_color = bg_color,
        background_regions = {
            {x=0, y=569, width=1112, height=1099},
            {x=1112, y=0, width=1112, height=63},
            {x=1112, y=1605, width=1112, height=63},
        },
        components = {
            {name="gns530", module=libs.gns530, cw="gns530", type_id=1, x=1112, y=63, scale=1},
            {name="gns430", module=libs.gns430, cw="gns430", type_id=1, x=1112, y=879, scale=1},
            {name="kap140", module=libs.kap140, cw="kap140", type_id=1, x=0, y=0, scale=1},
            {name="gtx330", module=libs.gtx330, cw="gtx330", type_id=1, x=0, y=296, scale=1},
            {name="kr87", module=libs.kr87, cw=nil, type_id=1, x=1112, y=1345, scale=1},
            {name="NAV1 CDI", module=libs.cdi, cw=nil, type_id=1, x=579.119, y=601, scale=1},
            {name="ADF", module=libs.adf, cw=nil, type_id=1, x=579.119, y=1136, scale=1},
            {name="DG", module=libs.dg, cw=nil, type_id=1, x=32.881, y=601, scale=1},
        },
        initial_active_component = 1,
    },
    {
        -----------------------------------------------------------------------------------
        name = "GPS with dual NAV",
        viewid = nil,
        width = 2224, height = 1668,
        background_color = bg_color,
        background_regions = {
            {x=0, y=569, width=1112, height=1099},
            {x=1112, y=0, width=1112, height=193},
            {x=1112, y=1475, width=1112, height=193},
        },
        components = {
            {name="gns530", module=libs.gns530, cw="gns530", type_id=1, x=1112, y=193, scale=1},
            {name="gns430", module=libs.gns430, cw="gns430", type_id=1, x=1112, y=1009, scale=1},
            {name="kap140", module=libs.kap140, cw="kap140", type_id=1, x=0, y=0, scale=1},
            {name="gtx330", module=libs.gtx330, cw="gtx330", type_id=1, x=0, y=296, scale=1},
            {name="NAV1 CDI", module=libs.cdi, cw=nil, type_id=1, x=579.119, y=601, scale=1},
            {name="NAV2 CDI", module=libs.cdi, cw=nil, type_id=2, x=579.119, y=1136, scale=1},
            {name="DG", module=libs.dg, cw=nil, type_id=1, x=32.881, y=601, scale=1},
        },
        initial_active_component = 1,
    },
    {
        -----------------------------------------------------------------------------------
        name = "Analogue with ADF",
        viewid = nil,
        width = 2224, height = 1668,
        background_color = bg_color,
        background_regions = {
            {x=0, y=0, width=1112, height=1668},
            {x=1112, y=0, width=1112, height=76},
            {x=1112, y=1592, width=1112, height=76},
        },
        components = {
            {name="kap140", module=libs.kap140, cw="kap140", type_id=1, x=1112, y=76, scale=1},
            {name="navcom1", module=libs.kx165, cw=nil, type_id=1, x=1112, y=372, scale=1},
            {name="navcom2", module=libs.kx165, cw=nil, type_id=2, x=1112, y=711, scale=1},
            {name="gtx330", module=libs.gtx330, cw="gtx330", type_id=1, x=1112, y=1050, scale=1},
            {name="kr87", module=libs.kr87, cw=nil, type_id=1, x=1112, y=1332, scale=1},
            {name="NAV1 CDI", module=libs.cdi, cw=nil, type_id=1, x=579.119, y=316.5, scale=1},
            {name="ADF", module=libs.adf, cw=nil, type_id=1, x=579.119, y=851.5, scale=1},
            {name="DG", module=libs.dg, cw=nil, type_id=1, x=32.881, y=316.5, scale=1},
        },
        initial_active_component = 2,
    },
    {
        -----------------------------------------------------------------------------------
        name = "Analogue with dualNAV",
        viewid = nil,
        width = 2224, height = 1668,
        background_color = bg_color,
        background_regions = {
            {x=0, y=0, width=1112, height=1668},
            {x=1112, y=0, width=1112, height=206},
            {x=1112, y=1462, width=1112, height=206},
        },
        components = {
            {name="kap140", module=libs.kap140, cw="kap140", type_id=1, x=1112, y=206, scale=1},
            {name="navcom1", module=libs.kx165, cw=nil, type_id=1, x=1112, y=502, scale=1},
            {name="navcom2", module=libs.kx165, cw=nil, type_id=2, x=1112, y=841, scale=1},
            {name="gtx330", module=libs.gtx330, cw="gtx330", type_id=1, x=1112, y=1180, scale=1},
            {name="NAV1 CDI", module=libs.cdi, cw=nil, type_id=1, x=579.119, y=316.5, scale=1},
            {name="NAV2 CDI", module=libs.cdi, cw=nil, type_id=2, x=579.119, y=851.5, scale=1},
            {name="DG", module=libs.dg, cw=nil, type_id=1, x=32.881, y=316.5, scale=1},
        },
        initial_active_component = 2,
    },
}

module.events = {
    tab_radios = mapper.register_event("DHC-2:TAB_RADIOS"),
    tab_nav = mapper.register_event("DHC-2:TAB_NAV"),
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

    views[1].mappings = {
        {event=g1000.EC7X.increment, action=libs.cdi.actions[1].obs_inc},
        {event=g1000.EC7X.decrement, action=libs.cdi.actions[1].obs_dec},
    }
    views[3].mappings = {
        {event=g1000.EC7X.increment, action=libs.cdi.actions[1].obs_inc},
        {event=g1000.EC7X.decrement, action=libs.cdi.actions[1].obs_dec},
    }

    common.init_component_modules(libs, lib_options)

    local viewport = mapper.viewport{
        name = "DHC-2 viewport",
        displayno = display,
        x = 0, y = 0, width = scale, height = scale,
        aspect_ratio = 4 / 3,
    }
    local viewport_mappings = {}
    common.arrange_views(viewport, viewport_mappings, captured_window_defs, views, module.device)
    viewport:set_mappings(viewport_mappings)
    local target_view = views[1]
    viewport:add_mappings(target_view.components[target_view.active_component].instance.component_mappings)

    msfs.mfwasm.add_observed_data{
        {rpn="(L:DHC2_TAB_RADIOS)", event=module.events.tab_radios},
        {rpn="(L:DHC2_TAB_NAV)", event=module.events.tab_nav},
    }
    local radios_settings = 0
    local nav_settings = 0
    local view_table = {
        {views[1], views[2]},
        {views[3], views[4]}
    }
    local function change_view()
        local view_group = view_table[radios_settings + 1]
        if view_group ~= nil then
            local view = view_group[nav_settings + 1]
            if view ~= nil then
                viewport:change_view(view.viewid)
                common.change_viewport_mappings(viewport, viewport_mappings, view)
            end
        end
    end

    local global_mappings = {
        {
            {event=module.events.tab_radios, action=function (evid, value)
                radios_settings = value
                change_view()
            end},
            {event=module.events.tab_nav, action=function (evid, value)
                nav_settings = value
                change_view()
            end},

            {event=g1000.EC3.increment, action=msfs.mfwasm.rpn_executer("1 (>K:HEADING_BUG_INC)")},
            {event=g1000.EC3.decrement, action=msfs.mfwasm.rpn_executer("1 (>K:HEADING_BUG_DEC)")},
            {event=g1000.EC4X.increment, action=msfs.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC4X.decrement, action=msfs.mfwasm.rpn_executer("100 (>K:AP_ALT_VAR_DEC)")},
            {event=g1000.EC4Y.increment, action=msfs.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_INC)")},
            {event=g1000.EC4Y.decrement, action=msfs.mfwasm.rpn_executer("1000 (>K:AP_ALT_VAR_DEC)")},
        }
    }
    common.set_global_mappings(global_mappings, libs)

    return {
        move_next_view = function () end,
        move_previous_view = function () end,
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
