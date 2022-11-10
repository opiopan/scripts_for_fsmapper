local module = {
    width = 500,
    height = 500,
    type = {
        general = 1,
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
local module_options ={{}} -- initialize when reset() will be called based on specified values and default values
local option_defaults = {
    type = module.type.general,
    red_mark = false,
    heading_bug = false,
}

--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    gyro_drift_inc = fs2020.event_sender("GYRO_DRIFT_INC"),
    gyro_drift_dec = fs2020.event_sender("GYRO_DRIFT_DEC"),
    heading_bug_inc = fs2020.event_sender("HEADING_BUG_INC"),
    heading_bug_dec = fs2020.event_sender("HEADING_BUG_DEC"),
}

--------------------------------------------------------------------------------------
-- operable area definitions
--------------------------------------------------------------------------------------
for i = 1,#module.actions do
    module.events[i] = {}
    module.events[i].all = mapper.register_event("DG instrument: background_tapped")
end

--------------------------------------------------------------------------------------
-- indicator definitions
--------------------------------------------------------------------------------------
local parts = require("lib/instrument_parts")

local indicators ={}
indicators[module.type.general] = {}
indicators[module.type.general][1]= {
    standard_indicator = {x=193, y=97, attr={width=123, height=314.478}, bitmaps={parts.dg_standard.image}},
    standard_red_indicator = {
        x=15, y=15, attr={width=470, height=470}, bitmaps={parts.dg_standard_red.image},
        enable_condition=function (option) return option.red_mark end
    },
    heading_bug_indicator = {
        x=52.219, y=52.219, attr={width=197.783*2, height=197.783*2}, rotation={bitmap=parts.dg_heading_bug.image, center={x=197.783, y=197.783}},
        rpn="(A:AUTOPILOT HEADING LOCK DIR, Degrees) (A:HEADING INDICATOR, Degrees) -", epsilon=0.5,
        enable_condition=function (option) return option.heading_bug end
    },
    bearing_indicator = {
        x=40, y=40, attr={width=420, height=420}, rotation={bitmap=parts.dg_bearing.image, center={x=420/2, y=420/2}},
        rpn="360 (A:HEADING INDICATOR, Degrees) -", epsilon=0.5
    },
}

local indicator_orders = {}
indicator_orders[module.type.general] = {
    "standard_indicator",
    "standard_red_indicator",
    "heading_bug_indicator",
    "bearing_indicator",
}

for type, typedef in ipairs(indicators) do
    for i, indicatordefs in ipairs(typedef) do
        module.global_mapping_sources[i] = {}
        for name, indicator in pairs(indicatordefs) do
            if module.events[i][name] == nil and indicator.rpn ~= nil then
                module.events[i][name] = mapper.register_event("DG:"..i..":"..name)
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
    rctx:draw_bitmap{bitmap=parts.base.image, x=x, y=y, scale=scale}
    rctx:draw_bitmap{bitmap=parts.dg_knob_left.image, x=x + 18.44 * scale, y=y + 410 * scale, scale=scale}
    if module_options[id].heading_bug then
        rctx:draw_bitmap{bitmap=parts.dg_knob_right.image, x=x + 400.376 * scale, y=y + 410 * scale, scale=scale}
    end

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
    local canvas2 = mapper.view_elements.canvas{
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
        object = canvas2,
        x = x + 400.376 * scale, y = y + 410 * scale,
        width = 81.624 * scale, height = 81.624 * scale
    }
    function component.activate(state)
        canvas1:set_value(state)
        canvas2:set_value(state)
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
            {event=g1000.EC3.increment, action=module.actions[id].heading_bug_inc},
            {event=g1000.EC3.decrement, action=module.actions[id].heading_bug_dec},
            {event=g1000.EC4X.increment, action=module.actions[id].gyro_drift_inc},
            {event=g1000.EC4X.decrement, action=module.actions[id].gyro_drift_dec},
            {event=g1000.EC4Y.increment, action=module.actions[id].gyro_drift_inc},
            {event=g1000.EC4Y.decrement, action=module.actions[id].gyro_drift_dec},
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
