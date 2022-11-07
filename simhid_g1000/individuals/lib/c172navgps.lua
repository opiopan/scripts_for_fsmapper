local module = {
    width = 373.333,
    height = 126,
    actions = {},
    events = {},
    observed_data = {},
    global_mapping_sources = {},
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    navgps = fs2020.event_sender("TOGGLE_GPS_DRIVES_NAV1"),
}

--------------------------------------------------------------------------------------
-- operable area definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=165.172, height=67.227, rratio=0.1}
local buttons = {
    navgps = {x=22.135, y=44.257, attr=attr_normal},
}

for i = 1,#module.actions do
    module.events[i] = {}
    for name, button in pairs(buttons) do
        module.events[i][name] = mapper.register_event("C172 NAV-GPS:" .. name .. "_tapped")
    end
end

--------------------------------------------------------------------------------------
-- indicator definitions
--------------------------------------------------------------------------------------
local img_all = graphics.bitmap("assets/c172navgps.png")
local img_base = img_all:create_partial_bitmap(0, 0, module.width, module.height)
local img_nav = img_all:create_partial_bitmap(375, 0, 48.849, 47.172)
local img_gps = img_all:create_partial_bitmap(375, 49, 48.849, 47.172)

local attr_indicator = {width=48.849, height=47.172}
local indicators ={}
indicators[1]= {
    navgps_indicator = {x=46.163, y=54.047, attr=attr_indicator, bitmaps={img_nav, img_gps}, rpn="(A:GPS DRIVES NAV1, Bool)"},
}

for i, indicator in ipairs(indicators) do
    module.global_mapping_sources[i] = {}
    for name, indicator in pairs(indicators[i]) do
        local evid = mapper.register_event("GC172 NAV-GPS:"..name)
        module.events[i][name] = evid
        module.observed_data[#module.observed_data + 1] = {rpn=indicator.rpn, event=evid}
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
function module.reset()
    for i, value in ipairs(module.global_mapping_sources) do
        module.global_mapping_sources[i] = {}
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
        viewport_mappings = {},
        callback = nil,
    }

    -- update view background bitmap
    rctx:draw_bitmap{bitmap=img_base, x=x, y=y, scale=scale}

    -- operable area
    local function notify_tapped()
        if component.callback then
            component.callback(component_name)
        end
    end
    for name, button in pairs(buttons) do
        component.view_elements[#component.view_elements + 1] = {
            object = mapper.view_elements.operable_area{event_tap = module.events[id][name], round_ratio=button.attr.rratio},
            x = x + button.x * scale, y = y + button.y * scale,
            width = button.attr.width * scale, height = button.attr.height * scale
        }
        component.view_mappings[#component.view_mappings + 1] = {event=module.events[id][name], action=module.actions[id][name]}
    end

    -- indicators
    for name, indicator in pairs(indicators[id]) do
        local canvas = mapper.view_elements.canvas{
            logical_width = indicator.attr.width,
            logical_height = indicator.attr.height,
            value = 0,
            renderer = function (ctx, value)
                local image = indicator.bitmaps[value + 1]
                if image then
                    ctx:draw_bitmap(image, 0, 0)
                end
            end
        }
        component.view_elements[#component.view_elements + 1] = {
            object = canvas,
            x = x + indicator.x * scale, y = y + indicator.y * scale,
            width = indicator.attr.width * scale, height = indicator.attr.height * scale
        }
        if module.global_mapping_sources[id][name] == nil then
            module.global_mapping_sources[id][name] = {}
        end
        module.global_mapping_sources[id][name][#module.global_mapping_sources[id][name] + 1] = function (value) canvas:set_value(value) end
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
