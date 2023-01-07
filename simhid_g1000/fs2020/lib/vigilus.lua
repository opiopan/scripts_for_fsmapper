local module = {
    width = 797,
    height = 741,
    type = {
        general = 1,
    },
    actions = {},
    events = {},
}

local module_defs = {
    prefix = "Vigilus",
    activatable = true,
    options = {{}},
    option_defaults = {
        type = module.type.general,
    },
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions[1] = {
    left = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_push_left)"),
    right = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_push_right)"),
    knob_inc = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_knob_Inc)"),
    knob_dec = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_knob_Dec)"),
    knob_push = fs2020.mfwasm.rpn_executer("(>H:ASVigilus_knob_Push)"),
}
--------------------------------------------------------------------------------------
-- operable are definitions
--------------------------------------------------------------------------------------
local attr_normal = {width=80.088, height=76.472, rratio=0.07}
module_defs.operables = {}
module_defs.operables[module.type.general] = {
    left = {x=208.152, y=633.555, attr=attr_normal},
    right = {x=500.115, y=633.555, attr=attr_normal},
}

--------------------------------------------------------------------------------------
-- captured window placeholder definition
--------------------------------------------------------------------------------------
module_defs.captured_window = {}
module_defs.captured_window[module.type.general] = {x=52, y=56, width=688, height=523}

--------------------------------------------------------------------------------------
-- active indicator difinitions
--------------------------------------------------------------------------------------
module_defs.active_indicators= {}
module_defs.active_indicators[module.type.general] = {
    {x=364.5, y=625.29, width=95, height=95},
}

--------------------------------------------------------------------------------------
-- prepare module scope environment
--------------------------------------------------------------------------------------
common.component_module_init(module, module_defs)

--------------------------------------------------------------------------------------
-- instance generator
--------------------------------------------------------------------------------------
function module.create_component(component_name, id, captured_window, x, y, scale, rctx, simhid_g1000)
    local component = common.component_module_create_instance(module, module_defs,{
        name = component_name,
        id = id,
        captured_window = captured_window,
        x = x, y = y, scale = scale,
        simhid_g1000 = simhid_g1000
    })

    -- update view background bitmap
    local background = graphics.bitmap("assets/vigilus.png")
    rctx:draw_bitmap{bitmap=background, x=x, y=y, scale=scale}

    -- Event-Action mappings which are enabled when the component is activated
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.component_mappings = {
            {event=g1000.EC9Y.increment, action=module.actions[id].knob_inc},
            {event=g1000.EC9Y.decrement, action=module.actions[id].knob_dec},
            {event=g1000.EC9X.increment, action=module.actions[id].knob_inc},
            {event=g1000.EC9X.decrement, action=module.actions[id].knob_dec},
            {event=g1000.EC9P.down, action=module.actions[id].knob_push},
        }
    end

    return component
end

return module
