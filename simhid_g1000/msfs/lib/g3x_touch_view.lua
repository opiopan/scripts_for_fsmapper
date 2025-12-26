local context = {}

local view_width = 2224
local view_height = 1668
local frame_height = view_height / 12

--------------------------------------------------------------------------------------
-- button & action definitions
--------------------------------------------------------------------------------------
context.buttons = {
    nrst = {x=309, y=1559, event=mapper.register_event("G3X Touch:NRST")},
    direct_to = {x=613, y=1559, event=mapper.register_event("G3X Touch:DIRECT TO")},
    menu = {x=1485.811, y=1559, event=mapper.register_event("G3X Touch: MENU")},
    back = {x=1789.811, y=1559, event=mapper.register_event("G3X Touch:BACK")},
}

context.actions = {}
context.actions[1] = {
    nrst = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_NRST_Push)"),
    direct_to = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_DirectTo_Push)"),
    menu = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Menu_Push)"),
    back = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Back_Push)"),
    lknob_inner_inc = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Knob_Inner_L_INC)"),
    lknob_inner_dec = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Knob_Inner_L_DEC)"),
    lknob_outer_inc = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Knob_Outer_L_INC)"),
    lknob_outer_dec = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Knob_Outer_L_DEC)"),
    rknob_inner_inc = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Knob_Inner_R_INC)"),
    rknob_inner_dec = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Knob_Inner_R_DEC)"),
    rknob_outer_inc = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Knob_Outer_R_INC)"),
    rknob_outer_dec = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_1_Knob_Outer_R_DEC)"),
}
context.actions[2] = {
    nrst = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_NRST_Push)"),
    direct_to = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_DirectTo_Push)"),
    menu = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Menu_Push)"),
    back = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Back_Push)"),
    lknob_inner_inc = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Knob_Inner_L_INC)"),
    lknob_inner_dec = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Knob_Inner_L_DEC)"),
    lknob_outer_inc = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Knob_Outer_L_INC)"),
    lknob_outer_dec = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Knob_Outer_L_DEC)"),
    rknob_inner_inc = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Knob_Inner_R_INC)"),
    rknob_inner_dec = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Knob_Inner_R_DEC)"),
    rknob_outer_inc = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Knob_Outer_R_INC)"),
    rknob_outer_dec = msfs.mfwasm.rpn_executer("(>H:AS3X_Touch_2_Knob_Outer_R_DEC)"),
}

--------------------------------------------------------------------------------------
-- initialize module
--------------------------------------------------------------------------------------
function context.init(g1000, has_buttons)
    context.has_buttons = has_buttons
    context.assets = require("lib/g3x_touch_assets")
    context.g1000 = g1000.events

    if has_buttons then
        context.background = graphics.bitmap(view_width, view_height)
        local rctx = graphics.rendering_context(context.background)

        rctx:set_brush(graphics.color(66, 66, 61))
        rctx:fill_rectangle(0, 0, view_width, frame_height)
        rctx:fill_rectangle(0, frame_height * 11, view_width, frame_height)
        local shadow_height = 6
        rctx:set_brush(graphics.color(49, 49, 44))
        rctx:fill_rectangle(0, frame_height - shadow_height, view_width, shadow_height)
        rctx:set_brush(graphics.color(103, 103, 95))
        rctx:fill_rectangle(0, frame_height * 11, view_width, shadow_height)

        for key, button in pairs(context.buttons) do
            rctx:draw_bitmap(context.assets[key], button.x, button.y)
        end

        rctx:finish_rendering()
    end
end

--------------------------------------------------------------------------------------
-- celan up module
--------------------------------------------------------------------------------------
function context.term()
    context.assets = nil
    context.g1000 = nil
    context.background = nil
end

--------------------------------------------------------------------------------------
-- view definition generator
--------------------------------------------------------------------------------------
function context.create_view(name, num)
    local actions = context.actions[num]
    local mappings = {}
    local view_elements = {}
    if context.has_buttons then
        mappings = {
            {event=context.g1000.EC4X.increment, action=actions.lknob_inner_inc},
            {event=context.g1000.EC4X.decrement, action=actions.lknob_inner_dec},
            {event=context.g1000.EC4Y.increment, action=actions.lknob_outer_inc},
            {event=context.g1000.EC4Y.decrement, action=actions.lknob_outer_dec},
            {event=context.g1000.EC9X.increment, action=actions.rknob_inner_inc},
            {event=context.g1000.EC9X.decrement, action=actions.rknob_inner_dec},
            {event=context.g1000.EC9Y.increment, action=actions.rknob_outer_inc},
            {event=context.g1000.EC9Y.decrement, action=actions.rknob_outer_dec},
            {event=context.g1000.SW27.down, action=actions.direct_to},
            {event=context.g1000.SW28.down, action=actions.menu},
            {event=context.g1000.SW31.down, action=actions.back},
        }
        for key, button in pairs(context.buttons) do
            local action = actions[key]
            mappings[#mappings + 1] = {event=button.event, action=action}
            view_elements[#view_elements + 1] = {
                object = mapper.view_elements.operable_area{round_ratio=0.1, event_tap = button.event},
                x = button.x, y = button.y,
                width = context.assets.button_size.width, height = context.assets.button_size.height,
            }
        end
    end
    local g3x_window_y_pos = frame_height
    if not context.has_buttons then
        g3x_window_y_pos = frame_height * 2
    end
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.captured_window{
            name=name,
            window_titles={
                "AS3X_TOUCH_" .. num,
                "G3XTOUCH_" .. num,
                "G3XTOUCH_" .. (num + 2),
            },
        },
        x = 0, y = g3x_window_y_pos,
        width = view_width, height = frame_height * 10
    }

    local view_definition = {
        name = name,
        elements = view_elements,
        background = context.background,
        logical_width = view_width,
        logical_height = view_height,
        mappings = mappings,
    }

    return view_definition
end

--------------------------------------------------------------------------------------
-- return module context
--------------------------------------------------------------------------------------
return context
