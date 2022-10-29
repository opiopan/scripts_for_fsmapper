local module = {
    width = 1112,
    height = 282,
    actions = {},
    events = {},
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    ident = fs2020.mfwasm.rpn_executer("(>K:XPNDR_IDENT_ON)"),
    vfr = fs2020.mfwasm.rpn_executer("(>H:TransponderVFR)"),
    on = fs2020.mfwasm.rpn_executer("(>H:TransponderON)"),
    off = fs2020.mfwasm.rpn_executer("(>H:TransponderOFF)"),
    stby = fs2020.mfwasm.rpn_executer("(>H:TransponderSTBY)"),
    alt = fs2020.mfwasm.rpn_executer("(>H:TransponderALT)"),
    func = fs2020.mfwasm.rpn_executer("(>H:TransponderFUNC)"),
    crsr = fs2020.mfwasm.rpn_executer("(>H:TransponderCRSR)"),
    startstop= fs2020.mfwasm.rpn_executer("(>H:TransponderSTARTSTOP)"),
    clr = fs2020.mfwasm.rpn_executer("(>H:TransponderCLR)"),
    num0 = fs2020.mfwasm.rpn_executer("(>H:Transponder0)"),
    num1 = fs2020.mfwasm.rpn_executer("(>H:Transponder1)"),
    num2 = fs2020.mfwasm.rpn_executer("(>H:Transponder2)"),
    num3 = fs2020.mfwasm.rpn_executer("(>H:Transponder3)"),
    num4 = fs2020.mfwasm.rpn_executer("(>H:Transponder4)"),
    num5 = fs2020.mfwasm.rpn_executer("(>H:Transponder5)"),
    num6 = fs2020.mfwasm.rpn_executer("(>H:Transponder6)"),
    num7 = fs2020.mfwasm.rpn_executer("(>H:Transponder7)"),
    num8 = fs2020.mfwasm.rpn_executer("(>H:Transponder8)"),
    num9 = fs2020.mfwasm.rpn_executer("(>H:Transponder9)"),
}
--------------------------------------------------------------------------------------
-- operable are definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=69.189, height=45.569, rratio=0.05}
local attr_portrate = {width=47.887, height=62.842, rratio=0.05}
local attr_alt = {width=47.211, height=47.211, rratio=0.5}
local buttons = {
    ident = {x=25.693, y=45.803, attr=attr_normal},
    vfr = {x=25.693, y=120.552, attr=attr_normal},
    on = {x=150.054, y=22.1, attr=attr_normal},
    stby = {x=105.642, y=103.28, attr=attr_portrate},
    off = {x=215.212, y=103.28, attr=attr_portrate},
    alt = {x=161.043, y=79.063, attr=attr_alt},
    func = {x=920.375, y=45.803, attr=attr_normal},
    crsr = {x=1012.494, y=45.803, attr=attr_normal},
    startstop = {x=920.375, y=118.215, attr=attr_normal},
    clr = {x=1012.494, y=118.215, attr=attr_normal},
    num0 = {x=31.259, y=210.824, attr=attr_normal},
    num1 = {x=130.809, y=210.824, attr=attr_normal},
    num2 = {x=232.153, y=210.824, attr=attr_normal},
    num3 = {x=330.561, y=210.824, attr=attr_normal},
    num4 = {x=429.458, y=210.824, attr=attr_normal},
    num5 = {x=551.365, y=210.824, attr=attr_normal},
    num6 = {x=652.22, y=210.824, attr=attr_normal},
    num7 = {x=749.159, y=210.824, attr=attr_normal},
    num8 = {x=917.138, y=210.824, attr=attr_normal},
    num9 = {x=1010.16, y=210.824, attr=attr_normal},
}

for i = 1,#module.actions do
    module.events[i] = {}
    for name, button in pairs(buttons) do
        module.events[i][name] = mapper.register_event("GTX330:" .. name .. "_tapped")
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
    local background = graphics.bitmap("assets/gtx330.png")
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
        component.view_mappings[#component.view_mappings + 1] = {event=module.events[id][name], action=module.actions[id][name]}
    end

    -- captured window
    component.view_elements[#component.view_elements + 1] = {
        object = captured_window,
        x = x + 303 * scale, y = y + 32 * scale,
        width = 580 * scale, height = 142 * scale,
    }

    return component
end

return module
