local view_width = 1084
local view_height = 1541

local assets = require("a32nx/assets")

local mod_context = {}

--------------------------------------------------------------------------------------
-- register events
--------------------------------------------------------------------------------------
local events = {
    spdmach_push = mapper.register_event("FCU:SPD_MACH:push"),
    loc_push = mapper.register_event("FCU:SPD_MACH:push"),
    loc_change = mapper.register_event("FCU:SPD_MACH:change"),
    hdgtrk_push = mapper.register_event("FCU:HDG_TRK:push"),
    ap1_push = mapper.register_event("FCU:AP1:push"),
    ap1_change = mapper.register_event("FCU:AP1:change"),
    ap2_push = mapper.register_event("FCU:AP2:push"),
    ap2_change = mapper.register_event("FCU:AP2:change"),
    athr_push = mapper.register_event("FCU:A/THR:push"),
    athr_change = mapper.register_event("FCU:A/THR:change"),
    exped_push = mapper.register_event("FCU:EXPD:push"),
    exped_change = mapper.register_event("FCU:EXPD:change"),
    metricalt_push = mapper.register_event("FCU:METRIC ALT:push"),
    appr_push = mapper.register_event("FCU:APPR:push"),
    appr_change = mapper.register_event("FCU:APPR:change"),
    fd_push = mapper.register_event("FCU:fd:push"),
    fd_change = mapper.register_event("FCU:fd:change"),
    ls_push = mapper.register_event("FCU:LS:push"),
    ls_change = mapper.register_event("FCU:LS:push"),
    hghpa_push = mapper.register_event("FCU:inHg_hPa:push"),
    baro_mode_change = mapper.register_event("FCU:BARO Mode:change"),
    baro_unit_change = mapper.register_event("FCU:BARO Unit:change"),
    baro_inhg_change = mapper.register_event("FCU:BARO InHg:change"),
    baro_hpa_change = mapper.register_event("FCU:BARO hPa:change"),
}

--------------------------------------------------------------------------------------
-- observed data definitions
--------------------------------------------------------------------------------------
local observed_data = {
    {rpn="(L:I_FCU_LOC)", event=events.loc_change},
    {rpn="(L:I_FCU_AP1)", event=events.ap1_change},
    {rpn="(L:I_FCU_AP2)", event=events.ap2_change},
    {rpn="(L:I_FCU_ATHR)", event=events.athr_change},
    {rpn="(L:I_FCU_EXPED)", event=events.exped_change},
    {rpn="(L:I_FCU_APPR)", event=events.appr_change},
    {rpn="(L:I_FCU_EFIS1_FD)", event=events.fd_change},
    {rpn="(L:I_FCU_EFIS1_LS)", event=events.ls_change},
    {rpn="(L:S_FCU_EFIS1_BARO_STD)", event=events.baro_mode_change},
    {rpn="(L:S_FCU_EFIS1_BARO_MODE)", event=events.baro_unit_change},
    {rpn="(A:KOHLSMAN SETTING HG:1,Inches of Mercury)", event=events.baro_inhg_change},
    {rpn="(A:KOHLSMAN SETTING MB:1,Millibars)", event=events.baro_hpa_change},
}

--------------------------------------------------------------------------------------
-- event-action mappings
--------------------------------------------------------------------------------------
local view_mappings = {
    {event=events.spdmach_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_SPD_MACH) 2 + (>L:S_FCU_SPD_MACH)")},
    {event=events.loc_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_LOC) 2 + (>L:S_FCU_LOC)")},
    {event=events.hdgtrk_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_HDGVS_TRKFPA) 2 + (>L:S_FCU_HDGVS_TRKFPA)")},
    {event=events.ap1_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_AP1) 2 + (>L:S_FCU_AP1)")},
    {event=events.ap2_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_AP2) 2 + (>L:S_FCU_AP2)")},
    {event=events.athr_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_ATHR) 2 + (>L:S_FCU_ATHR)")},
    {event=events.exped_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EXPED) 2 + (>L:S_FCU_EXPED)")},
    {event=events.metricalt_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_METRIC_ALT) 2 + (>L:S_FCU_METRIC_ALT)")},
    {event=events.appr_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_APPR) 2 + (>L:S_FCU_APPR)")},
    {event=events.fd_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_FD) 2 + (>L:S_FCU_EFIS1_FD)")},
    {event=events.ls_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_LS) 2 + (>L:S_FCU_EFIS1_LS)")},
    {event=events.hghpa_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_BARO_MODE) 0 == if{ 1 (>L:S_FCU_EFIS1_BARO_MODE) } els{ 0 (>L:S_FCU_EFIS1_BARO_MODE) }")},
}

local global_mappings = {
}

--------------------------------------------------------------------------------------
-- button definitions
--------------------------------------------------------------------------------------
local rbutton_size = {width = 96, height = 66, rratio=0.1}
local cbutton_size = {width = 76, height = 76, rratio=0.5}

local buttons = {
    spdmach = {x=65, y=116, size=cbutton_size},
    loc = {x=216, y=120, size=rbutton_size},
    hdgtrk = {x=504, y=116, size=cbutton_size},
    ap1 = {x=423, y=225, size=rbutton_size},
    ap2 = {x=565, y=225, size=rbutton_size},
    athr = {x=494, y=338, size=rbutton_size},
    exped = {x=729, y=174, size=rbutton_size},
    metricalt = {x=862, y=116, size=cbutton_size},
    appr = {x=968, y=174, size=rbutton_size},
    fd = {x=56, y=330, size=rbutton_size},
    ls = {x=216, y=330, size=rbutton_size},
    hghpa = {x=952, y=322, size=cbutton_size}
}

--------------------------------------------------------------------------------------
-- create view element definition for buttons
--------------------------------------------------------------------------------------
local img_off = assets.buttons:create_partial_bitmap(0, 0, rbutton_size.width, rbutton_size.height / 2)
local img_on = assets.buttons:create_partial_bitmap(0, rbutton_size.height / 2, rbutton_size.width, rbutton_size.height / 2)

local function button_renderer(ctx, value)
    if value > 0.8 then
        ctx:draw_bitmap(img_on, 0, 0)
    else
        ctx:draw_bitmap(img_off, 0, 0)
    end
end

local view_elements={}
for key, button in pairs(buttons) do
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.operable_area{
            round_ratio = button.size.rratio,
            event_tap = events[key .. "_push"]
        },
        x = button.x, y= button.y,
        width = button.size.width, height = button.size.height,
    }
    change_event = events[key .. "_change"]
    if change_event then
        local canvas = mapper.view_elements.canvas{
            logical_width = button.size.width,
            logical_height = button.size.height,
            value = 0,
            renderer = button_renderer,
        }
        view_elements[#view_elements + 1] = {
            object = canvas,
            x = button.x, y = button.y,
            width = button.size.width, height = button.size.height,
        }
        global_mappings[#global_mappings + 1] = {
            event = change_event,
            action = canvas:value_setter()
        }
    end
end

--------------------------------------------------------------------------------------
-- create view element definition for baro display
--------------------------------------------------------------------------------------
local function create_mode_bitmap(ix)
    return assets.buttons:create_partial_bitmap(
        assets.baro_mode.x + assets.baro_mode.width * ix, assets.baro_mode.y,
        assets.baro_mode.width, assets.baro_mode.height
    )
end
local mode_bitmaps = {
    create_mode_bitmap(1),
}
local baro_context = {
    inhg = 29.92,
    hpa = 1013.2,
    mode = -1,
    unit = 0,
}

local canvas_digits = mapper.view_elements.canvas{
    logical_width = 4 * assets.sseg.width,
    logical_height = assets.sseg.height,
    value = 0,
    renderer = function (ctx, value)
        ctx:set_font(assets.sseg_font)
        if baro_context.mode == 1 then
            ctx:draw_string(" 5td")
        elseif baro_context.mode >= 0 then
            if baro_context.unit == 0 then
                ctx:draw_number{
                    value = baro_context.inhg,
                    precision = 4,
                    fraction_precision = 2,
                    leading_zero = true,
                }
            else
                ctx:draw_number{
                    value = baro_context.hpa,
                    precision = 4,
                    fraction_precision = 0,
                    leading_zero = true,
                }
            end
        end
    end
}

local canvas_mode = mapper.view_elements.canvas{
    logical_width = 2 * assets.baro_mode.width,
    logical_height = assets.baro_mode.height,
    value = 0,
    renderer = function (ctx, value)
        local bitmap = mode_bitmaps[baro_context.mode + 1]
        if bitmap then
            ctx:draw_bitmap(bitmap)
        end
    end
}

view_elements[#view_elements + 1] = {
    object = canvas_digits,
    x = 760, y = 354,
    width = 120, height = 39.474
}
view_elements[#view_elements + 1] = {
    object = canvas_mode,
    x = 768, y = 324,
    width = assets.baro_mode.width * 2, height = assets.baro_mode.height
}

global_mappings[#global_mappings + 1] = {
    event=events.baro_inhg_change, action=function (evid, value)
        baro_context.inhg = value
        if baro_context.unit == 0 and baro_context.mode ~= 2 then
            canvas_digits:set_value(baro_context)
            canvas_mode:set_value(baro_context)
        end
    end
}
global_mappings[#global_mappings + 1] = {
    event=events.baro_hpa_change, action=function (evid, value)
        baro_context.hpa = value
        if baro_context.unit == 1 and baro_context.mode ~= 2 then
            canvas_digits:set_value(baro_context)
            canvas_mode:set_value(baro_context)
        end
    end
}
global_mappings[#global_mappings + 1] = {
    event=events.baro_mode_change, action=function (evid, value)
        baro_context.mode = value
        canvas_digits:set_value(baro_context)
        canvas_mode:set_value(baro_context)
    end
}
global_mappings[#global_mappings + 1] = {
    event=events.baro_unit_change, action=function (evid, value)
        baro_context.unit = value
        canvas_mode:set_value(baro_context)
        canvas_digits:set_value(baro_context)
    end
}

--------------------------------------------------------------------------------------
-- create background image
--------------------------------------------------------------------------------------
local bg_image = graphics.bitmap(assets.fcu.width, assets.fcu.height)
local ctx = graphics.rendering_context(bg_image)
ctx:draw_bitmap(assets.fcu)
ctx:set_brush(graphics.color("black"))
ctx:fill_rectangle(0, 0, assets.fcu.width, 87)
ctx:finish_rendering()

--------------------------------------------------------------------------------------
-- view definition generator
--------------------------------------------------------------------------------------
local function create_view_def(name, main_window)
    local elements = {}
    for i, element in ipairs(view_elements) do
        elements[#elements + 1] = element
    end
    elements[#elements + 1] = {
        object=main_window, x= 0, y=view_height - view_width , width=view_width, height=view_width + 2
    }

    return {
        name = name,
        logical_width = view_width,
        logical_height = view_height,
        background = bg_image,
        elements = elements,
        mappings = view_mappings,
    }
end

mod_context.viewdef = create_view_def
mod_context.observed_data = observed_data
mod_context.mappings = global_mappings

return mod_context