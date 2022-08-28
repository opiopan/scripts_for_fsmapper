local view_width = 1084
local view_height = 1541

local assets = require("a32nx/assets")

--------------------------------------------------------------------------------------
-- register events
--------------------------------------------------------------------------------------
local events = {
    cstr_push = mapper.register_event("EFIS:CSTR:push"),
    cstr_change = mapper.register_event("EFIS:CSTR:change"),
    wpt_push = mapper.register_event("EFIS:WPT:push"),
    wpt_change = mapper.register_event("EFIS:WPT:change"),
    vord_push = mapper.register_event("EFIS:VORD:push"),
    vord_change = mapper.register_event("EFIS:VORD:change"),
    ndb_push = mapper.register_event("EFIS:NDB:push"),
    ndb_change = mapper.register_event("EFIS:NDB:change"),
    aprt_push = mapper.register_event("EFIS:APRT:push"),
    aprt_change = mapper.register_event("EFIS:APRT:change"),
    ndmode_change = mapper.register_event("EFIS:ND mode:change"),
    ndrange_change = mapper.register_event("EFIS:ND range:change"),
    adfvor1_left = mapper.register_event("EFIS:ADFVOR1:flick left"),
    adfvor1_right = mapper.register_event("EFIS:ADFVOR1:flick right"),
    adfvor1_change = mapper.register_event("EFIS:ADFVOR1:change"),
    adfvor2_left = mapper.register_event("EFIS:ADFVOR2:flick left"),
    adfvor2_right = mapper.register_event("EFIS:ADFVOR2:flick right"),
    adfvor2_change = mapper.register_event("EFIS:ADFVOR2:change"),
    brklo_push = mapper.register_event("EFIS:AUTO BRK LO:push"),
    brklo_change = mapper.register_event("EFIS:AUTO BRK LO:change"),
    brklo_change2 = mapper.register_event("EFIS:AUTO BRK LO:change2"),
    brkmed_push = mapper.register_event("EFIS:AUTO BRK MED:push"),
    brkmed_change = mapper.register_event("EFIS:AUTO BRK MED:change"),
    brkmed_change2 = mapper.register_event("EFIS:AUTO BRK MED:change2"),
    brkmax_push = mapper.register_event("EFIS:AUTO BRK MAX:push"),
    brkmax_change = mapper.register_event("EFIS:AUTO BRK MAX:change"),
    brkmax_change2 = mapper.register_event("EFIS:AUTO BRK MAX:change2"),
    terronnd_push = mapper.register_event("TERR ON ND:push"),
    terronnd_change = mapper.register_event("TERR ON ND:change"),
    chrono_push = mapper.register_event("EFIS:CHRONO:push")
}

--------------------------------------------------------------------------------------
-- observed data definitions
--------------------------------------------------------------------------------------
local observed_data = {
    {rpn="(L:I_FCU_EFIS1_CSTR)", event=events.cstr_change},
    {rpn="(L:I_FCU_EFIS1_WPT)", event=events.wpt_change},
    {rpn="(L:I_FCU_EFIS1_VORD)", event=events.vord_change},
    {rpn="(L:I_FCU_EFIS1_NDB)", event=events.ndb_change},
    {rpn="(L:I_FCU_EFIS1_ARPT)", event=events.aprt_change},
    {rpn="(L:S_FCU_EFIS1_ND_MODE)", event=events.ndmode_change},
    {rpn="(L:S_FCU_EFIS1_ND_ZOOM)", event=events.ndrange_change},
    {rpn="(L:S_FCU_EFIS1_NAV1)", event=events.adfvor1_change},
    {rpn="(L:S_FCU_EFIS1_NAV2)", event=events.adfvor2_change},
    {rpn="(L:I_MIP_AUTOBRAKE_LO_L)", event=events.brklo_change},
    {rpn="(L:I_MIP_AUTOBRAKE_LO_U)", event=events.brklo_change2},
    {rpn="(L:I_MIP_AUTOBRAKE_MED_L)", event=events.brkmed_change},
    {rpn="(L:I_MIP_AUTOBRAKE_MED_U)", event=events.brkmed_change2},
    {rpn="(L:I_MIP_AUTOBRAKE_MAX_L)", event=events.brkmax_change},
    {rpn="(L:I_MIP_AUTOBRAKE_MAX_U)", event=events.brkmax_change2},
    {rpn="(L:I_MIP_GPWS_TERRAIN_ON_ND_CAPT_L)", event=events.terronnd_change},
}

--------------------------------------------------------------------------------------
-- event-action mappings
--------------------------------------------------------------------------------------
local view_mappings = {
    {event=events.cstr_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_CSTR) 2 + (>L:S_FCU_EFIS1_CSTR)")},
    {event=events.wpt_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_WPT) 2 + (>L:S_FCU_EFIS1_WPT)")},
    {event=events.vord_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_VORD) 2 + (>L:S_FCU_EFIS1_VORD)")},
    {event=events.ndb_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_NDB) 2 + (>L:S_FCU_EFIS1_NDB)")},
    {event=events.aprt_push, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_ARPT) 2 + (>L:S_FCU_EFIS1_ARPT)")},
    {event=events.adfvor1_left, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_NAV1) -- 0 max (>L:S_FCU_EFIS1_NAV1)")},
    {event=events.adfvor1_right, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_NAV1) ++ 2 min (>L:S_FCU_EFIS1_NAV1)")},
    {event=events.adfvor2_left, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_NAV2) -- 0 max (>L:S_FCU_EFIS1_NAV2)")},
    {event=events.adfvor2_right, action=fs2020.mfwasm.rpn_executer("(L:S_FCU_EFIS1_NAV2) ++ 2 min (>L:S_FCU_EFIS1_NAV2)")},
    {event=events.brklo_push, action=fs2020.mfwasm.rpn_executer("(L:S_MIP_AUTOBRAKE_LO) 2 + (>L:S_MIP_AUTOBRAKE_LO)")},
    {event=events.brkmed_push, action=fs2020.mfwasm.rpn_executer("(L:S_MIP_AUTOBRAKE_MED) 2 + (>L:S_MIP_AUTOBRAKE_MED)")},
    {event=events.brkmax_push, action=fs2020.mfwasm.rpn_executer("(L:S_MIP_AUTOBRAKE_MAX) 2 + (>L:S_MIP_AUTOBRAKE_MAX)")},
    {event=events.terronnd_push, action=fs2020.mfwasm.rpn_executer("(L:S_MIP_GPWS_TERRAIN_ON_ND_CAPT) 2 + (>L:S_MIP_GPWS_TERRAIN_ON_ND_CAPT)")},
    {event=events.chrono_push, action=fs2020.mfwasm.rpn_executer("(L:S_MIP_CHRONO_CAPT) 2 + (>L:S_MIP_CHRONO_CAPT)")},
}

local global_mappings = {
}

--------------------------------------------------------------------------------------
-- create view element definitions for ND filter buttons
--------------------------------------------------------------------------------------
local view_elements={}

local button_size = {width = 96, height = 66, rratio = 0.1}
local rbutton_size = {width = 76, height = 76, rratio = 0.5}
local buttons = {
    cstr = {x=34, y=32, ix=1, size=button_size},
    wpt = {x=147, y=32, ix=3, size=button_size},
    vord = {x=260, y=32, ix=2, size=button_size},
    ndb = {x=373, y=32, ix=4, size=button_size},
    aprt = {x=486, y=32, ix=5, size=button_size},
    chrono = {x=932, y=332, size=rbutton_size},
}

local img_off = assets.buttons:create_partial_bitmap(0, 0, button_size.width, button_size.height / 2)
local img_on = assets.buttons:create_partial_bitmap(0, button_size.height / 2, button_size.width, button_size.height / 2)

local function render_button(ctx, value)
    if value > 0.8 then
        ctx:draw_bitmap(img_on, 0, 0)
    else
        ctx:draw_bitmap(img_off, 0, 0)
    end
end

for key, button in pairs(buttons) do
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.operable_area{
            round_ratio = button.size.rratio,
            event_tap = events[key .. "_push"]
        },
        x = button.x, y= button.y,
        width = button.size.width, height = button.size.height,
    }
    if button.ix then
        local canvas = mapper.view_elements.canvas{
            logical_width = button.size.width,
            logical_height = button.size.height,
            value = 0,
            renderer = render_button,
        }
        view_elements[#view_elements + 1] = {
            object = canvas,
            x = button.x, y = button.y,
            width = button.size.width, height = button.size.height,
        }

        global_mappings[#global_mappings + 1] = {
            event = events[key .. "_change"],
            action = canvas:value_setter()
        }
    end
end

--------------------------------------------------------------------------------------
-- create view element definitions for ND mode knob and Range knob
--------------------------------------------------------------------------------------
local knob_size = {width = assets.knob.width, height = assets.knob.height}
local knobs = {
    ndmode = {x = 93, y = 157},
    ndrange = {x = 383, y = 157},
}

local function create_knob_image(ix)
    local y_gap = 2
    local bitmap = assets.buttons:create_partial_bitmap(
        assets.knob.x + knob_size.width * ix,
        assets.knob.y + y_gap,
        knob_size.width,
        knob_size.height - y_gap
    )
    bitmap:set_origin{x=0, y=-y_gap}
    return bitmap
end
local knob_images = {
    create_knob_image(0),
    create_knob_image(1),
    create_knob_image(2),
    create_knob_image(3),
    create_knob_image(4),
    create_knob_image(5),
}

local function render_knob(ctx, value)
    local image = knob_images[value + 1]
    if image then
        ctx:draw_bitmap(image, 0, 0)
    else
        ctx:draw_bitmap(knob_images[1], 0, 0)
    end
end

for key, knob in pairs(knobs) do
    local canvas = mapper.view_elements.canvas{
        logical_width = knob_size.width,
        logical_height = knob_size.height,
        value = 0,
        renderer = render_knob,
    }
    view_elements[#view_elements + 1] = {
        object = canvas,
        x = knob.x, y = knob.y,
        width = knob_size.width, height = knob_size.height,
    }
    global_mappings[#global_mappings + 1] = {
        event = events[key .. "_change"],
        action = canvas:value_setter()
    }
end

--------------------------------------------------------------------------------------
-- create view element definitions for the toggle switches to select VOR or ADF
--------------------------------------------------------------------------------------
local switch_size = {width = assets.htoggle.width, height = assets.htoggle.height, rratio = 0.2}
local switches = {
    adfvor1 = {x = 68, y = 338, ix = 1},
    adfvor2 = {x = 358, y = 338, ix = 2},
}

local function create_switch_image(ix)
    return assets.buttons:create_partial_bitmap(
        switch_size.width * ix + assets.htoggle.x,
        assets.htoggle.y,
        switch_size.width,
        switch_size.height)
end
local switch_images = {
    create_switch_image(1),
    create_switch_image(0),
    create_switch_image(2),
}

local function render_switch(ctx, value)
    local image = switch_images[value + 1]
    if image then
        ctx:draw_bitmap(image, 0, 0)
    else
        ctx:draw_bitmap(switch_images[1], 0, 0)
    end
end

for key, switch in pairs(switches) do
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.operable_area{
            round_ratio = switch_size.rratio,
            event_flick_left = events[key .. "_left"],
            event_flick_right = events[key .. "_right"],
        },
        x = switch.x, y= switch.y,
        width = switch_size.width, height = switch_size.height,
    }

    local canvas = mapper.view_elements.canvas{
        logical_width = switch_size.width,
        logical_height = switch_size.height,
        value = 0,
        renderer = render_switch,
    }

    view_elements[#view_elements + 1] = {
        object = canvas,
        x = switch.x, y = switch.y,
        width = switch_size.width, height = switch_size.height,
    }

    global_mappings[#global_mappings + 1] = {
        event = events[key .. "_change"],
        action = canvas:value_setter()
    }
end

--------------------------------------------------------------------------------------
-- create view element definitions for Auto Brake Mode buttons
--------------------------------------------------------------------------------------
local sbutton_size = {
    width = assets.sbutton_indicator.width,
    height = assets.sbutton_indicator.height * 2,
    rratio = 0.05
}
local brk_buttons = {
    brklo = {x=675, y=113, ix=1},
    brkmed = {x=791, y=113, ix=2},
    brkmax = {x=928, y=113, ix=3},
}

local function create_indicator_image(ix)
    return assets.buttons:create_partial_bitmap(
        sbutton_size.width * ix + assets.sbutton_indicator.x,
        assets.sbutton_indicator.y,
        sbutton_size.width,
        sbutton_size.height / 2)
end
local img_sbutton_inop = create_indicator_image(0)
local img_sbutton_on_gray = create_indicator_image(1)
local img_sbutton_on_skyblue = create_indicator_image(2)
local img_sbutton_on_green = create_indicator_image(3)
local img_sbutton_decel_green = create_indicator_image(4)

local function render_brk_upper(ctx, value)
    if value > 0 then
        ctx:draw_bitmap(img_sbutton_decel_green)
    end
end

local function render_brk_lower(ctx, value)
    if value > 0 then
        ctx:draw_bitmap(img_sbutton_on_skyblue)
    else
        ctx:draw_bitmap(img_sbutton_on_gray)
    end
end

for key, sbutton in pairs(brk_buttons) do
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.operable_area{
            round_ratio = sbutton_size.rratio,
            event_tap = events[key .. "_push"]
        },
        x = sbutton.x, y= sbutton.y,
        width = sbutton_size.width, height = sbutton_size.height,
    }
    local upper_canvas = mapper.view_elements.canvas{
        logical_width = sbutton_size.width,
        logical_height = sbutton_size.height / 2,
        value = 0,
        renderer = render_brk_upper,
    }
    view_elements[#view_elements + 1] = {
        object = upper_canvas,
        x = sbutton.x, y = sbutton.y,
        width = sbutton_size.width, height = sbutton_size.height / 2,
    }
    global_mappings[#global_mappings + 1] = {
        event = events[key .. "_change2"],
        action = upper_canvas:value_setter()
    }
    local lower_canvas = mapper.view_elements.canvas{
        logical_width = sbutton_size.width,
        logical_height = sbutton_size.height / 2,
        value = 0,
        renderer = render_brk_lower,
    }
    view_elements[#view_elements + 1] = {
        object = lower_canvas,
        x = sbutton.x, y = sbutton.y + sbutton_size.height / 2,
        width = sbutton_size.width, height = sbutton_size.height / 2,
    }
    global_mappings[#global_mappings + 1] = {
        event = events[key .. "_change"],
        action = lower_canvas:value_setter()
    }
end

--------------------------------------------------------------------------------------
-- create view element definitions for terrain on ND button
--------------------------------------------------------------------------------------
local terr_button = {x=694, y=320}

view_elements[#view_elements + 1] = {
    object = mapper.view_elements.operable_area{
        round_ratio = sbutton_size.rratio,
        event_tap = events.terronnd_push
    },
    x = terr_button.x, y= terr_button.y,
    width = sbutton_size.width, height = sbutton_size.height,
}

local upper_canvas = mapper.view_elements.canvas{
    logical_width = sbutton_size.width,
    logical_height = sbutton_size.height / 2,
    value = 0,
    renderer = function (ctx, value)
        ctx:draw_bitmap(img_sbutton_inop, 0, 0)
    end
}
view_elements[#view_elements + 1] = {
    object = upper_canvas,
    x = terr_button.x, y = terr_button.y,
    width = sbutton_size.width, height = sbutton_size.height / 2,
}

local lower_canvas = mapper.view_elements.canvas{
    logical_width = sbutton_size.width,
    logical_height = sbutton_size.height / 2,
    value = 0,
    renderer = function (ctx, value)
        if value > 0 then
            ctx:draw_bitmap(img_sbutton_on_green, 0, 0)
        else
            ctx:draw_bitmap(img_sbutton_on_gray, 0, 0)
        end
    end
}
view_elements[#view_elements + 1] = {
    object = lower_canvas,
    x = terr_button.x, y = terr_button.y + sbutton_size.height / 2,
    width = sbutton_size.width, height = sbutton_size.height / 2,
}

global_mappings[#global_mappings + 1] = {event=events.terronnd_change, action=lower_canvas:value_setter()}

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
        logical_width = view_width,
        logical_height = view_height,
        background = assets.efis,
        elements = elements,
        mappings = view_mappings,
    }
end

return {viewdef=create_view_def, observed_data=observed_data, mappings = global_mappings}