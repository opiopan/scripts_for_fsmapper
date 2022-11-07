local module = {
    width = 500,
    height = 500,
    type = {
        general = 1,
        no_glideslope = 2,
    },
    actions = {},
    events = {},
    observed_data = {},
    global_mapping_sources = {},
}

local common = require("lib/common")

--------------------------------------------------------------------------------------
-- appearance and behavior option
--------------------------------------------------------------------------------------
local module_options ={{}, {}} -- initialize when reset() will be called based on specified values and default values
local option_defaults = {
    type = module.type.general,
    gps_dependency  = false,
    source_is_gps = "0",  -- rpn fragment that return non-zero when cdi source is GPS
    enable_nav = true, 
}

--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    obs_inc = fs2020.event_sender("VOR1_OBI_INC"),
    obs_dec = fs2020.event_sender("VOR1_OBI_DEC"),
}

module.actions[2] = {
    obs_inc = fs2020.event_sender("VOR2_OBI_INC"),
    obs_dec = fs2020.event_sender("VOR2_OBI_DEC"),
}

--------------------------------------------------------------------------------------
-- operable area definitions
--------------------------------------------------------------------------------------
for i = 1,#module.actions do
    module.events[i] = {}
    module.events[i].all = mapper.register_event("CDI for NAV"..i..": background_tapped")
end

--------------------------------------------------------------------------------------
-- indicator definitions
--------------------------------------------------------------------------------------
local base_image = graphics.bitmap("assets/cdi.png")

local cdi_parts = {
    base = base_image:create_partial_bitmap(0, 0, 500, 500),
    bearing = base_image:create_partial_bitmap(502, 0, 427.05, 427.05),
    nav = base_image:create_partial_bitmap(503, 429, 54.443, 29.862),
    vloc = base_image:create_partial_bitmap(503, 460, 70.606, 31.143),
    gps = base_image:create_partial_bitmap(573.606, 429.422, 47.405, 30.578),
    na_loc = base_image:create_partial_bitmap(588, 469, 63.307, 22.075),
    na_gs = base_image:create_partial_bitmap(662, 436, 22.075, 63.306),
    to = base_image:create_partial_bitmap(694, 432, 83.607, 36.622),
    from = base_image:create_partial_bitmap(782, 432, 83.607, 36.622),
    heading = base_image:create_partial_bitmap(702, 475, 26, 22.517),
    tail = base_image:create_partial_bitmap(746, 482, 15, 12.99),
}
cdi_parts.bearing:set_origin(213.525, 213.525)
local source_indicator = graphics.bitmap(71*2, 118)
local rctx = graphics.rendering_context(source_indicator)
rctx:draw_bitmap{bitmap=cdi_parts.vloc, x=0, y=0}
rctx:draw_bitmap{bitmap=cdi_parts.gps, x=71 + 8.738, y=86.797}
rctx:finish_rendering()
cdi_parts.source ={
    source_indicator:create_partial_bitmap(0, 0, 71, 118),
    source_indicator:create_partial_bitmap(71, 0, 71, 118),
}

local needle_width = 8
local needle_movable_length = 240
local needle_color=graphics.color("white")
local needle_canvas_size = needle_movable_length + needle_width
local needle_value_scale = needle_movable_length / (127 * 2)
cdi_parts.cdi_needle = graphics.bitmap(needle_width, needle_movable_length)
cdi_parts.gs_needle = graphics.bitmap(needle_movable_length, needle_width)
rctx = graphics.rendering_context(cdi_parts.cdi_needle)
rctx:set_brush(needle_color)
rctx:fill_rectangle(0, 0, cdi_parts.cdi_needle.width, cdi_parts.cdi_needle.height)
rctx:finish_rendering()
rctx = graphics.rendering_context(cdi_parts.gs_needle)
rctx:set_brush(needle_color)
rctx:fill_rectangle(0, 0, cdi_parts.gs_needle.width, cdi_parts.gs_needle.height)
rctx:finish_rendering()
cdi_parts.cdi_needle:set_origin(needle_movable_length / -2, needle_width / -2)
cdi_parts.gs_needle:set_origin(needle_width / -2, needle_movable_length  / -2)

local indicators ={}
indicators[module.type.general] = {}
indicators[module.type.general][1]= {
    heading_indicator = {x=237, y=92.731, attr={width=26, height=22.517}, bitmaps={cdi_parts.heading}},
    tail_indicator = {x=242.5, y=383.711, attr={width=15, height=12.99}, bitmaps={cdi_parts.tail}},
    bearing_indicator = {
        x=36.577, y=36.577, attr={width=427.05, height=427.05}, rotation={bitmap=cdi_parts.bearing, center={x=427.05/2, y=427.05/2}},
        rpn="360 (A:NAV OBS:1, Degrees) -"
    },
    cdi_needle = {
        x=(module.width - needle_canvas_size) / 2, y=(module.height - needle_canvas_size) / 2, attr={width=needle_canvas_size, height=needle_canvas_size},
        shift={bitmap=cdi_parts.cdi_needle, axis="x", scale=needle_value_scale}, 
        rpn="%s if{ (A:GPS CDI NEEDLE:1, Number) } els{ (A:NAV CDI:1, Number) }", epsilon=0.5
    },
    gs_needle = {
        x=(module.width - needle_canvas_size) / 2, y=(module.height - needle_canvas_size) / 2, attr={width=needle_canvas_size, height=needle_canvas_size},
        shift={bitmap=cdi_parts.gs_needle, axis="y", scale=needle_value_scale}, 
        rpn="%s if{ (A:GPS HSI NEEDLE:1, Number) } els{ (A:NAV GSI:1, Number) }", epsilon = 0.5
    },
    source_indicator = {
        x=138.201, y=194.857, attr={width=70.606, height=117.375}, bitmaps={cdi_parts.source[1], cdi_parts.source[2]}, rpn="%s",
        enable_condition=function (option) return option.gps_dependency end
    },
    nav_indicator = {
        x=145.419, y=157.943, attr={width=54.444, height=29.862}, bitmaps={nil, cdi_parts.nav},
        rpn="%s if{ (A:GPS IS ACTIVE FLIGHT PLAN:1, Bool) } els{ (A:NAV HAS NAV:1, Bool) }",
        enable_condition=function (option) return option.enable_nav end
    },
    tofrom_indicator = {
        x=281.399, y=168.058, attr={width=83.607, height=36.622}, bitmaps={nil, cdi_parts.to, cdi_parts.from},
        rpn="%s if{ 0 } els{ (A:NAV TOFROM:1, Enum) }"
    },
    na_loc_indicator = {
        x=218.346, y=374.625, attr={width=63.307, height=22.075}, bitmaps={nil, cdi_parts.na_loc},
        rpn="%s if{ (A:GPS IS ACTIVE FLIGHT PLAN:1, Bool) } els{ (A:NAV HAS NAV:1, Bool) } !"
    },
    na_gs_indicator = {
        x=375, y=218.346, attr={width=22.075, height=63.306}, bitmaps={nil, cdi_parts.na_gs},
        rpn="%s if{ (A:GPS IS ACTIVE FLIGHT PLAN:1, Bool) (A:GPS HAS GLIDEPATH:1, Bool) and } els{ (A:NAV GS FLAG:1, Bool) } !"
    },
}

indicators[module.type.general][2] = {}
for name, data in pairs(indicators[module.type.general][1]) do
    indicators[module.type.general][2][name] = common.merge_table({}, data)
end
indicators[module.type.general][2].bearing_indicator.rpn = "360 (A:NAV OBS:2, Degrees) -"
indicators[module.type.general][2].cdi_needle.rpn = "%s if{ (A:GPS CDI NEEDLE:1, Number) } els{ (A:NAV CDI:2, Number) }"
indicators[module.type.general][2].gs_needle.rpn = "%s if{ (A:GPS HSI NEEDLE:1, Number) } els{ (A:NAV GSI:2, Number) }"
indicators[module.type.general][2].nav_indicator.rpn = "%s if{ (A:GPS IS ACTIVE FLIGHT PLAN:1, Bool) } els{ (A:NAV HAS NAV:2, Bool) }"
indicators[module.type.general][2].tofrom_indicator.rpn = "%s if{ 0 } els{ (A:NAV TOFROM:2, Enum) }"
indicators[module.type.general][2].na_loc_indicator.rpn = "%s if{ (A:GPS IS ACTIVE FLIGHT PLAN:1, Bool) } els{ (A:NAV HAS NAV:2, Bool) } !"
indicators[module.type.general][2].na_gs_indicator.rpn = "%s if{ (A:GPS IS ACTIVE FLIGHT PLAN:1, Bool) (A:GPS HAS GLIDEPATH:1, Bool) and } els{ (A:NAV GS FLAG:2, Bool) } !"

local indicator_orders = {}
indicator_orders[module.type.general] = {
    "heading_indicator",
    "tail_indicator",
    "bearing_indicator",
    "cdi_needle",
    "gs_needle",
    "source_indicator",
    "nav_indicator",
    "tofrom_indicator",
    "na_loc_indicator",
    "na_gs_indicator",
}

for type, typedef in ipairs(indicators) do
    for i, indicatordefs in ipairs(typedef) do
        module.global_mapping_sources[i] = {}
        for name, indicator in pairs(indicatordefs) do
            if module.events[i][name] == nil and indicator.rpn ~= nil then
                module.events[i][name] = mapper.register_event("CDI:"..i..":"..name)
            end
        end
    end
end

--------------------------------------------------------------------------------------
-- module destructor (GC handler)
--------------------------------------------------------------------------------------
setmetatable(module, {
    __gc = function (obj)
        for i = 1,#module.actions do
            for key, evid in pairs(obj.events[i]) do
                mapper.unregister_message(evid)
            end
        end
    end
})

--------------------------------------------------------------------------------------
-- reset function called when aircraft evironment is build each
--------------------------------------------------------------------------------------
function module.reset(options)
    module_options[1] = common.merge_table({}, option_defaults)
    module_options[2] = common.merge_table({}, option_defaults)
    if options ~= nil then
        for i, option in ipairs(options) do
            for key, value in pairs(option) do
                module_options[i][key] = value
            end
        end
    end

    for i, value in ipairs(module.global_mapping_sources) do
        module.global_mapping_sources[i] = {}
    end

    module.observed_data = {}
    for i, option in ipairs(module_options) do
        for name, indicator in pairs(indicators[option.type][i]) do
            if indicator.rpn ~= nil then
                module.observed_data[#module.observed_data + 1] = {
                    rpn = string.format(indicator.rpn, option.source_is_gps),
                    epsilon= indicator.epsilon,
                    event = module.events[i][name]
                }
            end
        end
    end
end

--------------------------------------------------------------------------------------
-- instance generator
--------------------------------------------------------------------------------------
function module.create_component(component_name, id, captured_window, x, y, scale, rctx, simhid_g1000)
    local component = {
        name = component_name,
        view_elements = {},
        view_mappings = {},
        component_mappings = {},
        callback = nil,
    }

    -- update view background bitmap
    rctx:draw_bitmap{bitmap=cdi_parts.base, x=x, y=y, scale=scale}

    -- operable area
    local function notify_tapped()
        if component.callback then
            component.callback(component_name)
        end
    end
    component.view_elements[#component.view_elements + 1] = {
        object = mapper.view_elements.operable_area{event_tap = module.events[id].all, reaction_color=graphics.color(0, 0, 0, 0)},
        x = x, y = y,
        width = module.width * scale, height = module.height * scale
    }
    component.view_mappings[#component.view_mappings + 1] = {event=module.events[id].all, action=notify_tapped}

    -- activation indicator
    local canvas1 = mapper.view_elements.canvas{
        logical_width = 1,
        logical_height = 1,
        value = 0,
        renderer = function (rctx, value)
            if value > 0 then
                rctx:set_brush(common.active_indicator_color)
                rctx:fill_geometry{geometry = common.circle, x = 0, y = 0}
            end
        end
    }
    component.view_elements[#component.view_elements + 1] = {
        object = canvas1,
        x = x + 18.44 * scale, y = y + 410 * scale,
        width = 81.624 * scale, height = 81.624 * scale
    }
    function component.activate(state)
        canvas1:set_value(state)
    end

    -- indicators
    local option = module_options[id]
    for i, name in ipairs(indicator_orders[option.type]) do
        local indicator = indicators[option.type][id][name]
        if indicator.enable_condition == nil or indicator.enable_condition(option) then
            local renderer = nil
            if indicator.bitmaps ~= nil then
                renderer = function (ctx, value)
                    local image = indicator.bitmaps[value + 1]
                    if image then
                        ctx:draw_bitmap(image, 0, 0)
                    end
                end
            elseif indicator.rotation ~= nil then
                renderer = function (ctx, value)
                    ctx:draw_bitmap{bitmap=indicator.rotation.bitmap, x=indicator.rotation.center.x, y=indicator.rotation.center.y, angle=value}
                end
            elseif indicator.shift ~= nil and indicator.shift.axis == "x" then
                renderer = function (ctx, value)
                    ctx:draw_bitmap{bitmap=indicator.shift.bitmap, x=indicator.shift.scale * value, y=0}
                end
            elseif indicator.shift ~= nil and indicator.shift.axis == "y" then
                renderer = function (ctx, value)
                    ctx:draw_bitmap{bitmap=indicator.shift.bitmap, x=0, y=indicator.shift.scale * value}
                end
            end

            local canvas = mapper.view_elements.canvas{
                logical_width = indicator.attr.width,
                logical_height = indicator.attr.height,
                value = 0,
                renderer = renderer
            }
            component.view_elements[#component.view_elements + 1] = {
                object = canvas,
                x = x + indicator.x * scale, y = y + indicator.y * scale,
                width = indicator.attr.width * scale, height = indicator.attr.height * scale
            }
            if indicator.rpn ~= nil then
                if module.global_mapping_sources[id][name] == nil then
                    module.global_mapping_sources[id][name] = {}
                end
                module.global_mapping_sources[id][name][#module.global_mapping_sources[id][name] + 1] = function (value) canvas:set_value(value) end
            end
        end
    end

    -- Event-Action mappings which are enabled when the component is activated
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.component_mappings = {
            {event=g1000.EC7X.increment, action=module.actions[id].obs_dec},
            {event=g1000.EC7X.decrement, action=module.actions[id].obs_inc},
        }
    end

    return component
end

--------------------------------------------------------------------------------------
-- global mappings generator
--------------------------------------------------------------------------------------
function module.create_global_mappings()
    local mappings = {}
    for i, source in ipairs(module.global_mapping_sources) do
        for key, actions in pairs(source) do
            mappings[#mappings + 1] = {event=module.events[i][key], action = function (evid, value)
                for num, action in pairs(actions) do
                    action(value)
                end
            end}
        end
    end
    return mappings
end

return module
