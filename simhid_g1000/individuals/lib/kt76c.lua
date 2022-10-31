local module = {
    width = 1112,
    height = 282,
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
    idt = fs2020.mfwasm.rpn_executer("(>K:XPNDR_IDENT_ON)"),
    vfr = fs2020.mfwasm.rpn_executer("(>H:TransponderVFR)"),
    clr = fs2020.mfwasm.rpn_executer("(>H:TransponderCLR)"),
    num0 = fs2020.mfwasm.rpn_executer("(>H:Transponder0)"),
    num1 = fs2020.mfwasm.rpn_executer("(>H:Transponder1)"),
    num2 = fs2020.mfwasm.rpn_executer("(>H:Transponder2)"),
    num3 = fs2020.mfwasm.rpn_executer("(>H:Transponder3)"),
    num4 = fs2020.mfwasm.rpn_executer("(>H:Transponder4)"),
    num5 = fs2020.mfwasm.rpn_executer("(>H:Transponder5)"),
    num6 = fs2020.mfwasm.rpn_executer("(>H:Transponder6)"),
    num7 = fs2020.mfwasm.rpn_executer("(>H:Transponder7)"),
    mode_inc = fs2020.mfwasm.rpn_executer("(A:TRANSPONDER STATE:1, Enum) d 4 < if{ ++ (>A:TRANSPONDER STATE:1, Enum) }"),
    mode_dec = fs2020.mfwasm.rpn_executer("(A:TRANSPONDER STATE:1, Enum) d 0 > if{ -- (>A:TRANSPONDER STATE:1, Enum) }"),
}
--------------------------------------------------------------------------------------
-- operable area definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=63.434, height=36.762, rratio=0.05}
local buttons = {
    idt = {x=42.043, y=56.615, attr=attr_normal},
    vfr = {x=1008.966, y=210.206, attr=attr_normal},
    clr = {x=866.978, y=210.206, attr=attr_normal},
    num0 = {x=40.101, y=207.865, attr=attr_normal},
    num1 = {x=136.019, y=207.865, attr=attr_normal},
    num2 = {x=231.938, y=207.865, attr=attr_normal},
    num3 = {x=330.01, y=207.865, attr=attr_normal},
    num4 = {x=428.083, y=207.865, attr=attr_normal},
    num5 = {x=525.078, y=207.865, attr=attr_normal},
    num6 = {x=622.074, y=207.865, attr=attr_normal},
    num7 = {x=719.069, y=207.865, attr=attr_normal},
}

for i = 1,#module.actions do
    module.events[i] = {}
    for name, button in pairs(buttons) do
        module.events[i][name] = mapper.register_event("KT-76C:" .. name .. "_tapped")
    end
    module.events[i].all = mapper.register_event("KT-76C: background_tapped")
end

--------------------------------------------------------------------------------------
-- indicator definitions
--------------------------------------------------------------------------------------
local attr_indicator = {width=124, height=105}

module.base_image = graphics.bitmap("assets/kt76c-indicators.png")
local mode_images = {}
do
    local width = attr_indicator.width
    local height = attr_indicator.height
    for i = 0, 4 do
        mode_images[i + 1] = module.base_image:create_partial_bitmap(width * i, 0, width, height)
    end
end

local indicators ={}
indicators[1]= {
    mode_indicator = {x=924.181, y=78.362, attr=attr_indicator, bitmaps=mode_images, rpn="(A:TRANSPONDER STATE:1, Enum)"},
}

for i, val in ipairs(indicators) do
    module.global_mapping_sources[i] = {}
    for name, indicator in pairs(indicators[i]) do
        local evid = mapper.register_event("KT-76C:"..name)
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
        callback = nil,
    }

    -- update view background bitmap
    local background = graphics.bitmap("assets/kt76c.png")
    rctx:draw_bitmap{bitmap=background, x=x, y=y, scale=scale}

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
        component.view_mappings[#component.view_mappings + 1] = {event=module.events[id][name], action=filter.duplicator(module.actions[id][name], notify_tapped)}
    end
    component.view_elements[#component.view_elements + 1] = {
        object = mapper.view_elements.operable_area{event_tap = module.events[id].all, reaction_color=graphics.color(0, 0, 0, 0)},
        x = x, y = y,
        width = module.width * scale, height = module.height * scale
    }
    component.view_mappings[#component.view_mappings + 1] = {event=module.events[id].all, action=notify_tapped}

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
        x = x + 957.831 * scale, y = y + 102.31 * scale,
        width = 75 * scale, height = 75 * scale
    }
    function component.activate(state)
        canvas1:set_value(state)
    end

    -- Event-Action mappings which are enabled when the component is activated
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.component_mappings = {
            {event=g1000.EC9Y.increment, action=module.actions[id].mode_inc},
            {event=g1000.EC9Y.decrement, action=module.actions[id].mode_dec},
            {event=g1000.EC9X.increment, action=module.actions[id].mode_inc},
            {event=g1000.EC9X.decrement, action=module.actions[id].mode_dec},
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
