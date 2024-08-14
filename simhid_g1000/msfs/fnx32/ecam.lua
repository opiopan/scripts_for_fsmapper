local view_width = 1084
local view_height = 1541

--------------------------------------------------------------------------------------
-- register events
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

--------------------------------------------------------------------------------------
-- observed data definitions
--------------------------------------------------------------------------------------
local observed_data = {
    {rpn="(L:I_ECAM_ENGINE)", event=events.eng_change},
    {rpn="(L:I_ECAM_BLEED)", event=events.bleed_change},
    {rpn="(L:I_ECAM_CAB_PRESS)", event=events.press_change},
    {rpn="(L:I_ECAM_ELEC)", event=events.elec_change},
    {rpn="(L:I_ECAM_HYD)", event=events.hyd_change},
    {rpn="(L:I_ECAM_FUEL)", event=events.fuel_change},
    {rpn="(L:I_ECAM_APU)", event=events.apu_change},
    {rpn="(L:I_ECAM_COND)", event=events.cond_change},
    {rpn="(L:I_ECAM_DOOR)", event=events.door_change},
    {rpn="(L:I_ECAM_WHEEL)", event=events.wheel_change},
    {rpn="(L:I_ECAM_FCTL)", event=events.fctl_change},
    {rpn="(L:I_ECAM_STATUS)", event=events.sts_change},
    {rpn="(L:I_ECAM_CLR_LEFT)", event=events.lclr_change},
    {rpn="(L:I_ECAM_CLR_RIGHT)", event=events.rclr_change},
}

--------------------------------------------------------------------------------------
-- event-action mappings
--------------------------------------------------------------------------------------
local view_mappings = {
    {event=events.toconfig_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_TO) 2 + (>L:S_ECAM_TO)")},
    {event=events.eng_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_ENGINE) 2 + (>L:S_ECAM_ENGINE)")},
    {event=events.bleed_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_BLEED) 2 + (>L:S_ECAM_BLEED)")},
    {event=events.press_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_CAB_PRESS) 2 + (>L:S_ECAM_CAB_PRESS)")},
    {event=events.elec_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_ELEC) 2 + (>L:S_ECAM_ELEC)")},
    {event=events.hyd_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_HYD) 2 + (>L:S_ECAM_HYD)")},
    {event=events.fuel_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_FUEL) 2 + (>L:S_ECAM_FUEL)")},
    {event=events.apu_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_APU) 2 + (>L:S_ECAM_APU)")},
    {event=events.cond_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_COND) 2 + (>L:S_ECAM_COND)")},
    {event=events.door_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_DOOR) 2 + (>L:S_ECAM_DOOR)")},
    {event=events.wheel_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_WHEEL) 2 + (>L:S_ECAM_WHEEL)")},
    {event=events.fctl_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_FCTL) 2 + (>L:S_ECAM_FCTL)")},
    {event=events.sts_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_STATUS) 2 + (>L:S_ECAM_STATUS)")},
    {event=events.rcl_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_RCL) 2 + (>L:S_ECAM_RCL)")},
    {event=events.lclr_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_CLR_LEFT) 2 + (>L:S_ECAM_CLR_LEFT)")},
    {event=events.rclr_push, action=msfs.mfwasm.rpn_executer("(L:S_ECAM_CLR_RIGHT) 2 + (>L:S_ECAM_CLR_RIGHT)")},

    -- need to consider which mapping method is reasonable regarding following events
    -- {event=events.all_push, action=},
}

local global_mappings = {
}

--------------------------------------------------------------------------------------
-- create bitmaps of buttons 
--------------------------------------------------------------------------------------
local assets = require("a32nx/assets")
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
    eng =   {x=0, y=0, led=true, page=0},
    bleed = {x=1, y=0, led=true, page=1},
    press = {x=2, y=0, led=true, page=2},
    elec =  {x=3, y=0, led=true, page=3},
    hyd =   {x=4, y=0, led=true, page=4},
    fuel =  {x=5, y=0, led=true, page=5},
    apu =   {x=0, y=1, led=true, page=6},
    cond =  {x=1, y=1, led=true, page=7},
    door =  {x=2, y=1, led=true, page=8},
    wheel = {x=3, y=1, led=true, page=9},
    fctl =  {x=4, y=1, led=true, page=10},
    all =   {x=5, y=1},
    lclr =  {x=0, y=2, led=true},
    sts =   {x=2, y=2, led=true, page=11},
    rcl =   {x=3, y=2},
    rclr =  {x=5, y=2, led=true},
}

local grid_h_num = 6
local grid_v_num = 3
local grid_width = view_width - 200
local grid_height = view_height - view_width - 210
local grid_bottom_gap = 40
local grid_x = (view_width - grid_width) / 2
local grid_y = view_height - grid_height - grid_bottom_gap - view_width
local grid_h_space = (grid_width - button_width) / (grid_h_num - 1)
local grid_v_space = (grid_height - button_height) / (grid_v_num - 1)

for key, button in pairs(buttons) do
    buttons[key].x = buttons[key].x * grid_h_space + grid_x
    buttons[key].y = buttons[key].y * grid_v_space + grid_y
end

buttons["toconfig"] = {x=buttons.bleed.x, y=grid_bottom_gap}

--------------------------------------------------------------------------------------
-- create background image
--------------------------------------------------------------------------------------
local bg_image = graphics.bitmap(view_width, view_height)
local ctx = graphics.rendering_context(bg_image)
ctx:set_brush(graphics.color(80, 105, 123))
ctx:fill_rectangle(0, 0, view_width, view_height - view_width)
ctx:set_brush(graphics.color(40, 52, 61))
ctx:fill_rectangle(0, 0, 1.5, view_height)
ctx:fill_rectangle(view_width - 1.5, 0, 1.5, view_height)

for key, button in pairs(buttons) do
    ctx:draw_bitmap(btn_imgs[key], button.x, button.y)
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

local view_elements = {}
for key, button in pairs(buttons) do
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.operable_area{
            round_ratio = 0.1,
            event_tap = events[key .. "_push"],
        },
        x = button.x, y = button.y,
        width = button_width, height = button_height,
    }
    if button.led then
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
        local change_event = events[key .. "_change"]
        if change_event then
            global_mappings[#global_mappings + 1] = {
                event = change_event,
                action = canvas:value_setter()
            }
        end
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

return {viewdef=create_view_def, observed_data=observed_data, mappings=global_mappings}