local view_width = 1084
local view_height = 1541

--------------------------------------------------------------------------------------
-- register events & observed data
--------------------------------------------------------------------------------------
local events = {
    toconfig_push = mapper.register_event("ECAM:T.O_CONFIG:push"),
    eng_push = mapper.register_event("ECAM:END:push"),
    eng_change = mapper.register_event("ECAM:END:change"),
    bleed_push = mapper.register_event("ECAM:BLEED:push"),
    bleed_change = mapper.register_event("ECAM:BLEED:change"),
    press_push = mapper.register_event("ECAM:PRESS:push"),
    press_change = mapper.register_event("ECAM:PRESS:change"),
    elec_push = mapper.register_event("ECAM:ELEC:push"),
    elec_change = mapper.register_event("ECAM:ELEC:change"),
    hyd_push = mapper.register_event("ECAM:HYD:push"),
    hyd_change = mapper.register_event("ECAM:HYD:change"),
    fuel_push = mapper.register_event("ECAM:FUEL:push"),
    fuel_change = mapper.register_event("ECAM:FUEL:change"),
    apu_push = mapper.register_event("ECAM:APU:push"),
    apu_change = mapper.register_event("ECAM:APU:change"),
    cond_push = mapper.register_event("ECAM:COND:push"),
    cond_change = mapper.register_event("ECAM:COND:change"),
    door_push = mapper.register_event("ECAM:DOOR:push"),
    door_change = mapper.register_event("ECAM:DOOR:change"),
    wheel_push = mapper.register_event("ECAM:WHEEL:push"),
    wheel_change = mapper.register_event("ECAM:WHEEL:change"),
    fctl_push = mapper.register_event("ECAM:F_CTL:push"),
    fctl_change = mapper.register_event("ECAM:F_CTL:change"),
    all_push = mapper.register_event("ECAM:ALL:push"),
    lclr_push = mapper.register_event("ECAM:L-CLR:push"),
    lclr_change = mapper.register_event("ECAM:L-CLR:change"),
    sts_push = mapper.register_event("ECAM:STS:push"),
    sts_change = mapper.register_event("ECAM:STS:change"),
    rcl_push = mapper.register_event("ECAM:RCL:push"),
    rclr_push = mapper.register_event("ECAM:R_CLR:push"),
    rclr_change = mapper.register_event("ECAM:R_CLR:change"),
}

fs2020.mfwasm.add_observed_data{
    {rpn="()", event=events.eng_change},
    {rpn="()", event=events.bleed_change},
    {rpn="()", event=events.press_change},
    {rpn="()", event=events.elec_change},
    {rpn="()", event=events.hyd_change},
    {rpn="()", event=events.fuel_change},
    {rpn="()", event=events.apu_change},
    {rpn="()", event=events.cond_change},
    {rpn="()", event=events.door_change},
    {rpn="()", event=events.wheel_change},
    {rpn="()", event=events.fctl_change},
    {rpn="()", event=events.lclr_change},
    {rpn="()", event=events.sts_change},
    {rpn="()", event=events.rclr_change},
}

--------------------------------------------------------------------------------------
-- create bitmaps of buttons 
--------------------------------------------------------------------------------------
local assets = require("lib/a320_assets")
local button_width = 96
local button_height = 66
local function button_bitmap(ix)
    return assets.buttons:create_partial_bitmap(button_width * ix, 0, button_width, button_height)
end
btn_imgs = {
    off = assets.buttons:create_partial_bitmap(0, 0, button_width, button_height / 2),
    on = assets.buttons:create_partial_bitmap(0, button_height / 2, button_width, button_height / 2),
    toconfig = button_bitmap(1),
    eng = button_bitmap(2),
    bleed = button_bitmap(3),
    press = button_bitmap(4),
    elec = button_bitmap(5),
    hyd = button_bitmap(6),
    fuel = button_bitmap(7),
    apu = button_bitmap(8),
    cond = button_bitmap(9),
    door = button_bitmap(10),
    wheel = button_bitmap(11),
    fctl = button_bitmap(12),
    all = button_bitmap(13),
    lclr = button_bitmap(14),
    rclr = button_bitmap(14),
    sts = button_bitmap(15),
    rcl = button_bitmap(16),
}

--------------------------------------------------------------------------------------
-- button definitions
--------------------------------------------------------------------------------------
local buttons = {
    {x=0, y=0, key="eng"},
    {x=1, y=0, key="bleed"},
    {x=2, y=0, key="press"},
    {x=3, y=0, key="elec"},
    {x=4, y=0, key="hyd"},
    {x=5, y=0, key="fuel"},
    {x=0, y=1, key="apu"},
    {x=1, y=1, key="cond"},
    {x=2, y=1, key="door"},
    {x=3, y=1, key="wheel"},
    {x=4, y=1, key="fctl"},
    {x=5, y=1, key="all"},
    {x=0, y=2, key="lclr"},
    {x=2, y=2, key="sts"},
    {x=3, y=2, key="rcl"},
    {x=5, y=2, key="rclr"},
}

local grid_h_num = 6
local grid_v_num = 3
local grid_width = view_width - 200
local grid_height = view_height - view_width - 210
local grid_bottom_gap = 50
local grid_x = (view_width - grid_width) / 2
local grid_y = view_height - grid_height - grid_bottom_gap - view_width
local grid_h_space = (grid_width - button_width) / (grid_h_num - 1)
local grid_v_space = (grid_height - button_height) / (grid_v_num - 1)

for i, button in ipairs(buttons) do
    buttons[i].x = buttons[i].x * grid_h_space + grid_x
    buttons[i].y = buttons[i].y * grid_v_space + grid_y
end

buttons[#buttons + 1] = {x=buttons[2].x, y=50, key="toconfig"}

--------------------------------------------------------------------------------------
-- create background image
--------------------------------------------------------------------------------------
local bg_image = graphics.bitmap(view_width, view_height)
local ctx = graphics.rendering_context(bg_image)
ctx:set_brush(graphics.color(80, 105, 123))
ctx:fill_rectangle(0, 0, view_width, view_height - view_width)
ctx:set_brush(graphics.color(40, 52, 61))
ctx:fill_rectangle(0, 0, 1.5, view_height)

for i, button in ipairs(buttons) do
    ctx:draw_bitmap(btn_imgs[button.key], button.x, button.y)
end

ctx:finish_rendering()

--------------------------------------------------------------------------------------
-- view element definition
--------------------------------------------------------------------------------------
local function button_renderer(ctx, value)
    if value > 0.8 then
        ctx:draw_bitmap(btn_imgs.on, 0, 0)
    else
        ctx:draw_bitmap(btn_imgs.off, 0, 0)
    end
end

local view_mappings = {
    {event=events.toconfig_push, action=fs2020.event_sender("MobiFlight.A32NX_ECAM_BTN_TOCONFIG_Push")},
    {event=events.eng_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_ENG")},
    {event=events.bleed_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_BLEED")},
    {event=events.press_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_PRESS")},
    {event=events.elec_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_ELEC")},
    {event=events.hyd_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_HYD")},
    {event=events.fuel_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_FUEL")},
    {event=events.apu_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_APU")},
    {event=events.cond_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_COND")},
    {event=events.door_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_DOOR")},
    {event=events.wheel_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_WHEEL")},
    {event=events.fctl_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_FTCL")},
    {event=events.sts_push, action=fs2020.event_sender("MobiFlight.A320_Neo_EICAS_2_ECAM_CHANGE_PAGE_STS")},

    -- need to consider which mapping method is reasonable regarding following events
    -- {event=events.all_push, action=},
    -- {event=events.rcl_push, action=},
    -- {event=events.lclr_push, action=},
    -- {event=events.rclr_push, action=},
}

local view_elements = {}
for i, button in ipairs(buttons) do
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.operable_area{
            round_ratio = 0.1,
            event_tap = events[button.key .. "_push"],
        },
        x = button.x, y = button.y,
        width = button_width, height = button_height,
    }
    local change_event = events[button.key .. "_change"]
    if change_event then
        local canvas = mapper.view_elements.canvas{
            logical_width = button_width,
            logical_height = button_height,
            value = 0,
            renderer = button_renderer,
        }
        view_elements[#view_elements + 1] = {
            object = canvas,
            x = button.x, y = button.y,
            width = button_width, height = button_height,
        }
        view_mappings[#view_mappings + 1] = {
            event = change_event,
            action = canvas:value_setter()
        }
    end
end

--------------------------------------------------------------------------------------
-- view definition generator
--------------------------------------------------------------------------------------
local function create_view_def(name, window)
    local elements = {}
    for i, element in ipairs(view_elements) do
        elements[#elements + 1] = element
    end
    elements[#elements + 1] = {
        object=window, x= 0, y=view_height - view_width, width=view_width, height=view_width + 2
    }

    return {
        name = name,
        logical_width = view_width, logical_height = view_height,
        background = bg_image,
        elements = elements,
        mappings = view_mappings,
    }
end

return create_view_def