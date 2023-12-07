local view_width = 1280
local view_height = 800

local context = {}
context.mappings = {}

--------------------------------------------------------------------------------------
-- initialize module
--------------------------------------------------------------------------------------
function context.init(g1000)
    context.g1000 = g1000.events
    context.background = graphics.bitmap(view_width, view_height)

    local rctx = graphics.rendering_context(context.background)
    rctx:set_brush(graphics.color(0, 0, 0, 1 / 255))
    rctx:fill_rectangle(1152, 0, 128, view_height)
    rctx:finish_rendering()
end

--------------------------------------------------------------------------------------
-- celan up module
--------------------------------------------------------------------------------------
function context.term()
    context.background = nil
    context.g1000 = nil
end

--------------------------------------------------------------------------------------
-- view definition generator
--------------------------------------------------------------------------------------
local button_size = {width = 128, height = 366 / 3}
local buttons = {
    {x=1152, y=244 + button_size.height * 0, evid=mapper.register_event("TMB930 TSC:SOFT1"), action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_SoftKey_1) 1 (>O:_ButtonAnimVar)")},
    {x=1152, y=244 + button_size.height * 1, evid=mapper.register_event("TMB930 TSC:SOFT2"), action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_SoftKey_2) 1 (>O:_ButtonAnimVar)")},
    {x=1152, y=244 + button_size.height * 2, evid=mapper.register_event("TMB930 TSC:SOFT3"), action=fs2020.mfwasm.rpn_executer("(>H:AS3000_TSC_Horizontal_1_SoftKey_3) 1 (>O:_ButtonAnimVar)")},
}

function context.create_view(name)
    local mappings = {}
    local view_elements = {}

    for i, button in ipairs(buttons) do
        view_elements[#view_elements + 1] = {
            object = mapper.view_elements.operable_area{event_tap = button.evid},
            x = button.x, y = button.y,
            width = button_size.width, height = button_size.height,
        }
        mappings[#mappings + 1] = {event=button.evid, action=button.action}
    end
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.captured_window{name=name, window_title='WTG3000_GTC_1'},
        x = 0, y = 0,
        width = view_width, height = view_height
    }

    local view_definition = {
        name = name,
        elements = view_elements,
        logical_width = view_width,
        logical_height = view_height,
        mappings = mappings,
        background = context.background,
    }

    return view_definition
end

--------------------------------------------------------------------------------------
-- return module context
--------------------------------------------------------------------------------------
return context
