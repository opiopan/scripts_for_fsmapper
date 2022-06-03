local view_width = 1084
local view_height = 1541

local assets = require("a320nx/assets")

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
}

--------------------------------------------------------------------------------------
-- observed data definitions
--------------------------------------------------------------------------------------
local observed_data = {
    {rpn="(L:A32NX_FCU_LOC_MODE_ACTIVE)", event=events.loc_change},
    {rpn="(L:A32NX_AUTOPILOT_1_ACTIVE)", event=events.ap1_change},
    {rpn="(L:A32NX_AUTOPILOT_2_ACTIVE)", event=events.ap2_change},
    {rpn="(L:A32NX_AUTOTHRUST_STATUS)", event=events.athr_change},
    {rpn="(L:A32NX_FMA_EXPEDITE_MODE)", event=events.exped_change},
    {rpn="(L:A32NX_FCU_APPR_MODE_ACTIVE)", event=events.appr_change},
    {rpn="(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1,Bool) (L:A32NX_ELEC_DC_1_BUS_IS_POWERED) (L:A32NX_ELEC_DC_2_BUS_IS_POWERED) or and", event=events.fd_change},
    {rpn="(L:BTN_LS_1_FILTER_ACTIVE)", event=events.ls_change},
}

--------------------------------------------------------------------------------------
-- event-action mappings
--------------------------------------------------------------------------------------
local view_mappings = {
    {event=events.spdmach_push, action=fs2020.event_sender("MobiFlight.A320_Neo_FCU_SPEED_TOGGLE_SPEED_MACH")},
    {event=events.loc_push, action=fs2020.event_sender("MobiFlight.A320NX_LOC")},
    {event=events.hdgtrk_push, action=fs2020.event_sender("MobiFlight.TRK_FPA_Mode_Toggle")},
    {event=events.ap1_push, action=fs2020.event_sender("MobiFlight.Autopilot_1_Push")},
    {event=events.ap2_push, action=fs2020.event_sender("MobiFlight.Autopilot_2_Push")},
    {event=events.athr_push, action=fs2020.event_sender("MobiFlight.ATHR_Push")},
    {event=events.exped_push, action=fs2020.event_sender("MobiFlight.A32NX_FCU_EXPED_PUSH")},
    {event=events.metricalt_push, action=fs2020.event_sender("MobiFlight.A320NX_METRIC_ALT_TOGGLE")},
    {event=events.appr_push, action=fs2020.event_sender("MobiFlight.A320NX_APPR")},
    {event=events.fd_push, action=fs2020.event_sender("MobiFlight.A32NX_EFIS_FD_PUSH")},
    {event=events.ls_push, action=fs2020.event_sender("MobiFlight.A32NX_EFIS_LS_1_PUSH")},
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
}

--------------------------------------------------------------------------------------
-- create view element definition
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
-- view definition generator
--------------------------------------------------------------------------------------
local function create_view_def(name, fcu_window, main_window)
    local elements = {}
    for i, element in ipairs(view_elements) do
        elements[#elements + 1] = element
    end
    elements[#elements + 1] = {
        object=fcu_window, x= 0, y=0, width=view_width, height=view_width
    }
    elements[#elements + 1] = {
        object=main_window, x= 0, y=view_height - view_width , width=view_width, height=view_width + 2
    }

    return {
        name = name,
        logical_width = view_width,
        logical_height = view_height,
        background = assets.fcu,
        elements = elements,
        mappings = view_mappings,
    }
end

return {viewdef=create_view_def, observed_data=observed_data, mappings = global_mappings}