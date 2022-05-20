--------------------------------------------------------------------------------------
-- Create viewports
--------------------------------------------------------------------------------------
local display = 1
local ratio = 0.949652777777778
local scale = 0.5
local compensate = (4/3) / (16/9)

-- local display = 2
-- local ratio = 0.949652777777778
-- local scale = 1
-- local compensate = 1

local viewport_left = mapper.viewport{
    name = "A320 left Viewport",
    displayno = display,
    x = 0, y = 0,
    width = 0.5 * scale * compensate, height = ratio * scale,
}

local viewport_right = mapper.viewport{
    name = "A320 right Viewport",
    displayno = display,
    x = 0.5 * scale * compensate, y = 0,
    width = 0.5 * scale * compensate, height = ratio * scale,
}

local viewport_menu = mapper.viewport{
    name = "A320 menu Viewport",
    displayno = display,
    x = 0, y = ratio * scale,
    width = scale * compensate, height = (1 - ratio) * scale,
}

--------------------------------------------------------------------------------------
-- Register views to right & left viewports
--------------------------------------------------------------------------------------
local viewdef_dummy = {
    name = "dummy",
    elements = {{object = mapper.view_elements.operable_area{event_tap = 0}}},
    background = graphics.color(0, 64, 0),
}

local viewdef_left_pfd = viewdef_dummy
local viewdef_left_nd = viewdef_dummy
local viewdef_left_uecam = viewdef_dummy
local viewdef_left_lecam = viewdef_dummy
local viewdef_right_pfd = viewdef_dummy
local viewdef_right_nd = viewdef_dummy
local viewdef_right_uecam = viewdef_dummy
local viewdef_right_lecam = viewdef_dummy
local viewdef_right_mcdu = require("lib/a320_cdu")

local view_left_nd = viewport_left:register_view(viewdef_left_nd)
local view_left_pfd = viewport_left:register_view(viewdef_left_pfd)
local view_left_uecam = viewport_left:register_view(viewdef_left_uecam)
local view_left_lecam = viewport_left:register_view(viewdef_left_lecam)
local view_right_pfd = viewport_right:register_view(viewdef_right_pfd)
local view_right_nd = viewport_right:register_view(viewdef_right_nd)
local view_right_uecam = viewport_right:register_view(viewdef_right_uecam)
local view_right_lecam = viewport_right:register_view(viewdef_right_lecam)
local view_right_mcdu = viewport_right:register_view(viewdef_right_mcdu)

--------------------------------------------------------------------------------------
-- Register menu view
--------------------------------------------------------------------------------------
local img_menu = graphics.bitmap("assets/a320_menu.png")
local img_width = 128
local img_height = 58
local function make_label_image(x, y)
    return img_menu:create_partial_bitmap(x * img_width, y * img_height, img_width, img_height)
end
local img_pfd_selected = make_label_image(0, 0)
local img_pfd_unselected = make_label_image(0, 1)
local img_pfd_disabled = make_label_image(0, 2)
local img_nd_selected = make_label_image(1, 0)
local img_nd_unselected = make_label_image(1, 1)
local img_nd_disabled = make_label_image(1, 2)
local img_uecam_selected = make_label_image(2, 0)
local img_uecam_unselected = make_label_image(2, 1)
local img_uecam_disabled = make_label_image(2, 2)
local img_lecam_selected = make_label_image(3, 0)
local img_lecam_unselected = make_label_image(3, 1)
local img_lecam_disabled = make_label_image(3, 2)
local img_mcdu_selected = make_label_image(4, 0)
local img_mcdu_unselected = make_label_image(4, 1)
local img_mcdu_disabled = make_label_image(4, 2)
local img_blank = make_label_image(5, 0)

local rule_left = {
    pfd = {
        pos = 0, 
        view = view_left_pfd,
        selected = img_pfd_selected,
        unselected = img_pfd_unselected,
        disabled = img_pfd_disabled,
        next = "nd", 
        prev = "lecam",
        mutex = {pfd = true},
    },
    nd = {
        pos = 1, 
        view = view_left_nd,
        selected = img_nd_selected,
        unselected = img_nd_unselected,
        disabled = img_nd_disabled,
        next = "uecam", 
        prev = "pfd",
        mutex = {nd = true},
    },
    uecam = {
        pos = 2, 
        view = view_left_uecam,
        selected = img_uecam_selected,
        unselected = img_uecam_unselected,
        disabled = img_uecam_disabled,
        next = "lecam", 
        prev = "nd",
        mutex = {uecam = true},
    },
    lecam = {
        pos = 3, 
        view = view_left_lecam,
        selected = img_lecam_selected,
        unselected = img_lecam_unselected,
        disabled = img_lecam_disabled,
        next = "pfd",
        prev = "uecam",
        mutex = {lecam = true},
    },
}

local rule_right = {
    pfd = {
        pos = 7, 
        view = view_right_pfd,
        selected = img_pfd_selected,
        unselected = img_pfd_unselected,
        disabled = img_pfd_disabled,
        next = "nd", 
        prev = "mcdu",
        mutex = {pfd = true},
    },
    nd = {
        pos = 8, 
        view = view_right_nd,
        selected = img_nd_selected,
        unselected = img_nd_unselected,
        disabled = img_nd_disabled,
        next = "uecam", 
        prev = "pfd",
        mutex = {nd = true},
    },
    uecam = {
        pos = 9, 
        view = view_right_uecam,
        selected = img_uecam_selected,
        unselected = img_uecam_unselected,
        disabled = img_uecam_disabled,
        next = "lecam", 
        prev = "nd",
        mutex = {uecam = true},
    },
    lecam = {
        pos = 10, 
        view = view_right_lecam,
        selected = img_lecam_selected,
        unselected = img_lecam_unselected,
        disabled = img_lecam_disabled,
        next = "mcdu",
        prev = "uecam",
        mutex = {lecam = true},
    },
    mcdu = {
        pos = 11,
        view = view_right_mcdu,
        selected = img_mcdu_selected,
        unselected = img_mcdu_unselected,
        disabled = img_mcdu_disabled,
        next = "pfd",
        prev = "lecam",
        mutex = {},
    },
}

local menu_context = {
    left = {current = "pfd", rule = rule_left, viewport = viewport_left},
    right = {current = "nd", rule = rule_right, viewport = viewport_right},
}

local function make_renderer_value()
    value = {}
    for k, v in pairs(menu_context.left.rule) do
        if k == menu_context.left.current then
            value[v.pos] = v.selected
        elseif v.mutex[menu_context.right.current] then
            value[v.pos] = v.disabled
        else
            value[v.pos] = v.unselected
        end
    end
    for k, v in pairs(menu_context.right.rule) do
        if k == menu_context.right.current then
            value[v.pos] = v.selected
        elseif v.mutex[menu_context.left.current] then
            value[v.pos] = v.disabled
        else
            value[v.pos] = v.unselected
        end
    end
    return value
end

local menu_bar = mapper.view_elements.canvas{
    logical_width = 1536,
    logical_height = 58,
    value = make_renderer_value(),
    renderer = function (ctx, value)
        for i = 0, 11 do
            local img = value[i]
            if img then
                ctx:draw_bitmap(img, img_width * i, 0)
            else
                ctx:draw_bitmap(img_blank, img_width * i, 0)
            end
        end
    end,
}

local function change_view(target, view_name, opposite)
    target_ctx = menu_context[target]
    opposite_ctx = menu_context[opposite]
    rule = target_ctx.rule[view_name]
    if rule.mutex[opposite_ctx.current] then
        return false
    elseif target_ctx.current ~= view_name then
        target_ctx.current = view_name
        target_ctx.viewport:change_view(rule.view)
        menu_bar:set_value(make_renderer_value())
        return true
    else
        return true
    end
end

g1000_dev = mapper.device{
    name = "SimHID G1000",
    type = "simhid",
    identifier = {path = "COM3"},
    modifiers = {
        {class = "binary", modtype = "button"},
        {class = "relative", modtype = "incdec"},
        {name = "EC8U", modtype = "button", modparam={repeat_interval = 80}},
        {name = "EC8D", modtype = "button", modparam={repeat_interval = 80}},
        {name = "EC8R", modtype = "button", modparam={repeat_interval = 80}},
        {name = "EC8L", modtype = "button", modparam={repeat_interval = 80}},
    },
}
local g1000 = g1000_dev.events

local mappings = {
    {event=g1000.SW14.down, action=function () change_view("left", "pfd", "right") end},
    {event=g1000.SW15.down, action=function () change_view("left", "nd", "right") end},
    {event=g1000.SW16.down, action=function () change_view("left", "uecam", "right") end},
    {event=g1000.SW17.down, action=function () change_view("left", "lecam", "right") end},
    {event=g1000.SW21.down, action=function () change_view("right", "pfd", "left") end},
    {event=g1000.SW22.down, action=function () change_view("right", "nd", "left") end},
    {event=g1000.SW23.down, action=function () change_view("right", "uecam", "left") end},
    {event=g1000.SW24.down, action=function () change_view("right", "lecam", "left") end},
    {event=g1000.SW25.down, action=function () change_view("right", "mcdu", "left") end},
}

viewport_menu:register_view{
    name = "menu",
    background = "black",
    elements = {
        {object = menu_bar},
    },
    mappings = mappings,
}

mapper.start_viewports()

--------------------------------------------------------------------------------------
-- Register Simvar observation event
--------------------------------------------------------------------------------------
local simvar_evt = {
    alt = mapper.register_event("altitude"),
    alt2 = mapper.register_event("simvar:altitude"),
    ap1 = mapper.register_event("A320_AP1"),
    ap_hdg = mapper.register_event("A320_AP_HEADING"),
    ap_fd = mapper.register_event("A320_AP_FD"),
    ap_fd2 = mapper.register_event("simvar:A320_AP_FD"),
}

fs2020.mfwasm.clear_observed_data()
fs2020.mfwasm.add_observed_data{
    {rpn="(A:PLANE ALTITUDE,Feet)", event=simvar_evt.alt, epsilon=0.1},
    {rpn="(L:A32NX_AUTOPILOT_1_ACTIVE)", event=simvar_evt.ap1, epsilon=0.1},
    {rpn="(L:A32NX_AUTOPILOT_HEADING_SELECTED)", event=simvar_evt.ap_hdg, epsilon=0.1},
    {rpn="(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1,Bool)", event=simvar_evt.ap_fd, epsilon=0.1},
}

fs2020.add_observed_simvars{
    {name="PLANE ALTITUDE", unit="Feet", event=simvar_evt.alt2, epsilon=0.1},
    {name="AUTOPILOT FLIGHT DIRECTOR ACTIVE:1", unit="Bool", event=simvar_evt.ap_fd2, epsilon=0.1},
}

mapper.set_primery_mappings{
    {event=g1000.AUX2D.down, action=fs2020.mfwasm.rpn_executer("(>K:TOGGLE_FLIGHT_DIRECTOR)")},
    {event=g1000.AUX2U.down, action=fs2020.mfwasm.rpn_executer("1 (>L:XMLVAR_Baro_Selector_HPA_1)")},
}