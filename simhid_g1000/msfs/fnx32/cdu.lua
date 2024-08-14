local view_width = 1084
local view_height = 1541

local mod_context = {}

--------------------------------------------------------------------------------------
-- button definitions
--------------------------------------------------------------------------------------
local attr_side = {width = 73, height = 58, rratio = 0.1}
local attr_func = {width = 119, height = 63, rratio = 0.1}
local attr_num = {width = 80, height = 80, rratio = 0.5}
local attr_alphabet = {width = 80, height = 80, rratio = 0.1}

local buttons = {
    l1 = {x = 20, y = 95, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK1L) 2 + (>L:S_CDU1_KEY_LSK1L)")},
    l2 = {x = 20, y = 177, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK2L) 2 + (>L:S_CDU1_KEY_LSK2L)")},
    l3 = {x = 20, y = 266, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK3L) 2 + (>L:S_CDU1_KEY_LSK3L)")},
    l4 = {x = 20, y = 354, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK4L) 2 + (>L:S_CDU1_KEY_LSK4L)")},
    l5 = {x = 20, y = 440, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK5L) 2 + (>L:S_CDU1_KEY_LSK5L)")},
    l6 = {x = 20, y = 534, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK6L) 2 + (>L:S_CDU1_KEY_LSK6L)")},
    r1 = {x = 988, y = 98, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK1R) 2 + (>L:S_CDU1_KEY_LSK1R)")},
    r2 = {x = 988, y = 180, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK2R) 2 + (>L:S_CDU1_KEY_LSK2R)")},
    r3 = {x = 988, y = 269, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK3R) 2 + (>L:S_CDU1_KEY_LSK3R)")},
    r4 = {x = 988, y = 357, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK4R) 2 + (>L:S_CDU1_KEY_LSK4R)")},
    r5 = {x = 988, y = 443, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK5R) 2 + (>L:S_CDU1_KEY_LSK5R)")},
    r6 = {x = 988, y = 537, attr=attr_side, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_LSK6R) 2 + (>L:S_CDU1_KEY_LSK6R)")},
    dir = {x = 120, y = 711, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_DIR) 2 + (>L:S_CDU1_KEY_DIR)")},
    prog = {x = 247, y = 712, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_PROG) 2 + (>L:S_CDU1_KEY_PROG)")},
    perf = {x = 374, y = 712, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_PERF) 2 + (>L:S_CDU1_KEY_PERF)")},
    init = {x = 501, y = 712, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_INIT) 2 + (>L:S_CDU1_KEY_INIT)")},
    data = {x = 627, y = 712, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_DATA) 2 + (>L:S_CDU1_KEY_DATA)")},
    fpln = {x = 120, y = 799, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_FPLN) 2 + (>L:S_CDU1_KEY_FPLN)")},
    rad = {x = 247, y = 799, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_RAD_NAV) 2 + (>L:S_CDU1_KEY_RAD_NAV)")},
    fuel = {x = 374, y = 799, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_FUEL_PRED) 2 + (>L:S_CDU1_KEY_FUEL_PRED)")},
    sec = {x = 501, y = 799, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_SEC_FPLN) 2 + (>L:S_CDU1_KEY_SEC_FPLN)")},
    atc = {x = 627, y = 800, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_ATC_COM) 2 + (>L:S_CDU1_KEY_ATC_COM)")},
    menu = {x = 754, y = 800, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_MENU) 2 + (>L:S_CDU1_KEY_MENU)")},
    airport = {x = 120, y = 883, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_AIRPORT) 2 + (>L:S_CDU1_KEY_AIRPORT)")},
    next = {x = 120, y = 1057, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_ARROW_RIGHT) 2 + (>L:S_CDU1_KEY_ARROW_RIGHT)")},
    prev = {x = 120, y = 973, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_ARROW_LEFT) 2 + (>L:S_CDU1_KEY_ARROW_LEFT)")},
    up = {x = 247, y = 973, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_ARROW_UP) 2 + (>L:S_CDU1_KEY_ARROW_UP)")},
    down = {x = 247, y = 1057, attr=attr_func, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_ARROW_DOWN) 2 + (>L:S_CDU1_KEY_ARROW_DOWN)")},
    num0 = {x = 240, y = 1440, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_0) 2 + (>L:S_CDU1_KEY_0)")},
    num1 = {x = 135, y = 1163, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_1) 2 + (>L:S_CDU1_KEY_1)")},
    num2 = {x = 239, y = 1163, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_2) 2 + (>L:S_CDU1_KEY_2)")},
    num3 = {x = 344, y = 1163, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_3) 2 + (>L:S_CDU1_KEY_3)")},
    num4 = {x = 135, y = 1256, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_4) 2 + (>L:S_CDU1_KEY_4)")},
    num5 = {x = 239, y = 1256, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_5) 2 + (>L:S_CDU1_KEY_5)")},
    num6 = {x = 344, y = 1256, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_6) 2 + (>L:S_CDU1_KEY_6)")},
    num7 = {x = 136, y = 1350, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_7) 2 + (>L:S_CDU1_KEY_7)")},
    num8 = {x = 240, y = 1350, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_8) 2 + (>L:S_CDU1_KEY_8)")},
    num9 = {x = 345, y = 1350, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_9) 2 + (>L:S_CDU1_KEY_9)")},
    dot = {x = 136, y = 1440, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_DOT) 2 + (>L:S_CDU1_KEY_DOT)")},
    plusminus = {x = 345, y = 1440, attr=attr_num, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_MINUS) 2 + (>L:S_CDU1_KEY_MINUS)")},
    a = {x = 453, y = 921, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_A) 2 + (>L:S_CDU1_KEY_A)")},
    b = {x = 558, y = 923, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_B) 2 + (>L:S_CDU1_KEY_B)")},
    c = {x = 666, y = 921, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_C) 2 + (>L:S_CDU1_KEY_C)")},
    d = {x = 767.5, y = 923, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_D) 2 + (>L:S_CDU1_KEY_D)")},
    e = {x = 874, y = 923, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_E) 2 + (>L:S_CDU1_KEY_E)")},
    f = {x = 453, y = 1018, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_F) 2 + (>L:S_CDU1_KEY_F)")},
    g = {x = 558, y = 1020, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_G) 2 + (>L:S_CDU1_KEY_G)")},
    h = {x = 666, y = 1018, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_H) 2 + (>L:S_CDU1_KEY_H)")},
    i = {x = 767.5, y = 1020, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_I) 2 + (>L:S_CDU1_KEY_I)")},
    j = {x = 874, y = 1020, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_J) 2 + (>L:S_CDU1_KEY_J)")},
    k = {x = 453, y = 1126, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_K) 2 + (>L:S_CDU1_KEY_K)")},
    l = {x = 558, y = 1128, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_L) 2 + (>L:S_CDU1_KEY_L)")},
    m = {x = 666, y = 1126, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_M) 2 + (>L:S_CDU1_KEY_M)")},
    n = {x = 767.5, y = 1128, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_N) 2 + (>L:S_CDU1_KEY_N)")},
    o = {x = 874, y = 1128, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_O) 2 + (>L:S_CDU1_KEY_O)")},
    p = {x = 453, y = 1233, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_P) 2 + (>L:S_CDU1_KEY_P)")},
    q = {x = 558, y = 1235, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_Q) 2 + (>L:S_CDU1_KEY_Q)")},
    r = {x = 666, y = 1233, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_R) 2 + (>L:S_CDU1_KEY_R)")},
    s = {x = 767.5, y = 1235, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_S) 2 + (>L:S_CDU1_KEY_S)")},
    t = {x = 874, y = 1235, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_T) 2 + (>L:S_CDU1_KEY_T)")},
    u = {x = 453, y = 1339, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_U) 2 + (>L:S_CDU1_KEY_U)")},
    v = {x = 558, y = 1341, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_V) 2 + (>L:S_CDU1_KEY_V)")},
    w = {x = 666, y = 1339, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_W) 2 + (>L:S_CDU1_KEY_W)")},
    x = {x = 767.5, y = 1341, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_X) 2 + (>L:S_CDU1_KEY_X)")},
    y = {x = 874, y = 1341, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_Y) 2 + (>L:S_CDU1_KEY_Y)")},
    z = {x = 455.5, y = 1443, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_Z) 2 + (>L:S_CDU1_KEY_Z)")},
    div = {x = 560.5, y = 1445, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_SLASH) 2 + (>L:S_CDU1_KEY_SLASH)")},
    sp = {x = 668.5, y = 1443, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_SPACE) 2 + (>L:S_CDU1_KEY_SPACE)")},
    ovfy = {x = 770, y = 1445, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_OVFLY) 2 + (>L:S_CDU1_KEY_OVFLY)")},
    clr = {x = 876.5, y = 1445, attr=attr_alphabet, action=msfs.mfwasm.rpn_executer("(L:S_CDU1_KEY_CLEAR) 2 + (>L:S_CDU1_KEY_CLEAR)")},
}

--------------------------------------------------------------------------------------
-- Register events / Build Event-Action mappings / Build View element definitions
--------------------------------------------------------------------------------------
local mappings = {}
local view_elements = {}
for key, button in pairs(buttons) do
    local evid = mapper.register_event("A320_CDU_" .. string.upper(key))
    mappings[#mappings + 1] = {event=evid, action=button.action}
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.operable_area{round_ratio= button.attr.rratio, event_tap=evid},
        x = button.x, y = button.y,
        width = button.attr.width, height = button.attr.height
    }
end

--------------------------------------------------------------------------------------
-- function to create view definition
--------------------------------------------------------------------------------------
local assets = require("a32nx/assets")
local scale_factor = assets.cdu.width /view_width
local bg_image = assets.cdu:create_partial_bitmap(0, 0, view_width * scale_factor, view_height * scale_factor)

function mod_context.viewdef(name, window)
    local elements = {
        {
            object =window,
            x = 168, y = 0,
            width = 726, height = 670
        }
    }

    for i, element in ipairs(view_elements) do
        elements[#elements + 1] = element
    end

    local view_definition = {
        name = name,
        elements = elements,
        background = bg_image,
        logical_width = view_width,
        logical_height = view_height,
        horizontal_alignment = "center",
        vertical_alignment = "top",
        mappings = mappings,
    }

    return view_definition
end

return mod_context
