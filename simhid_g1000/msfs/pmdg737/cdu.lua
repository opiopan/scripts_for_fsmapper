local view_width = 1189
local view_height = 1833

local attr_ls ={width=72.879, height=52.371, rratio=0.1}
local attr_mode = {width=126.484, height=87.598, rratio=0.1}
local attr_exec = {width=118.74, height=60.984, rratio=0.1}
local attr_num = {width=77.496, height=77.496, rratio=0.5}
local attr_alphabet = {width=82.952, height=82.952, rratio=0.1}

local buttons = {
    LS_1 = {x=14.277, y=203.489, attr=attr_ls},
    LS_2 = {x=14.277, y=294.64, attr=attr_ls},
    LS_3 = {x=14.277, y=385.385, attr=attr_ls},
    LS_4 = {x=14.277, y=477.843, attr=attr_ls},
    LS_5 = {x=14.277, y=570.3, attr=attr_ls},
    LS_6 = {x=14.277, y=660.852, attr=attr_ls},
    LS_7 = {x=1099.918, y=203.489, attr=attr_ls},
    LS_8 = {x=1099.918, y=294.64, attr=attr_ls},
    LS_9 = {x=1099.918, y=385.385, attr=attr_ls},
    LS_10 = {x=1099.918, y=477.843, attr=attr_ls},
    LS_11 = {x=1099.918, y=570.3, attr=attr_ls},
    LS_12 = {x=1099.918, y=660.852, attr=attr_ls},
    INIT_REF = {x=131.364, y=901.276, attr=attr_mode},
    RTE = {x=288.548, y=901.276, attr=attr_mode},
    CLB = {x=440.705, y=901.276, attr=attr_mode},
    CRZ= {x=591.736, y=901.276, attr=attr_mode},
    DES= {x=743.659, y=901.276, attr=attr_mode},
    MENU = {x=131.364, y=1016.594, attr=attr_mode},
    LEGS = {x=288.548, y=1016.594, attr=attr_mode},
    DEP_ARR = {x=440.705, y=1016.594, attr=attr_mode},
    HOLD = {x=591.736, y=1016.594, attr=attr_mode},
    PROG = {x=743.659, y=1016.594, attr=attr_mode},
    N1_LIMIT = {x=131.364, y=1128.101, attr=attr_mode},
    FIX = {x=288.548, y=1128.101, attr=attr_mode},
    PREV_PAGE = {x=131.364, y=1244.501, attr=attr_mode},
    NEXT_PAGE = {x=288.548, y=1244.501, attr=attr_mode},
    EXEC = {x=950.095, y=1040.504, attr=attr_exec},
    NUM_1 = {x=132.735, y=1360.596, attr=attr_num},
    NUM_2 = {x=251.405, y=1360.596, attr=attr_num},
    NUM_3 = {x=372.694, y=1360.596, attr=attr_num},
    NUM_4 = {x=132.735, y=1473.828, attr=attr_num},
    NUM_5 = {x=251.405, y=1473.828, attr=attr_num},
    NUM_6 = {x=372.694, y=1473.828, attr=attr_num},
    NUM_7 = {x=132.735, y=1587.37, attr=attr_num},
    NUM_8 = {x=251.405, y=1587.37, attr=attr_num},
    NUM_9 = {x=372.694, y=1587.37, attr=attr_num},
    DECIMAL = {x=132.735, y=1699.885, attr=attr_num},
    NUM_0 = {x=251.405, y=1699.885, attr=attr_num},
    __ = {x=372.694, y=1699.885, attr=attr_num},
    A = {x=505.224, y=1133.787, attr=attr_alphabet},
    B = {x=623.426, y=1133.787, attr=attr_alphabet},
    C = {x=743.659, y=1133.787, attr=attr_alphabet},
    D = {x=867.143, y=1133.787, attr=attr_alphabet},
    E = {x=985.883, y=1133.787, attr=attr_alphabet},
    F = {x=505.224, y=1246.824, attr=attr_alphabet},
    G = {x=623.426, y=1246.824, attr=attr_alphabet},
    H = {x=743.659, y=1246.824, attr=attr_alphabet},
    I = {x=867.143, y=1246.824, attr=attr_alphabet},
    J = {x=985.883, y=1246.824, attr=attr_alphabet},
    K = {x=505.224, y=1360.596, attr=attr_alphabet},
    L = {x=623.426, y=1360.596, attr=attr_alphabet},
    M = {x=743.659, y=1360.596, attr=attr_alphabet},
    N = {x=867.143, y=1360.596, attr=attr_alphabet},
    O = {x=985.883, y=1360.596, attr=attr_alphabet},
    P = {x=505.224, y=1471.1, attr=attr_alphabet},
    Q = {x=623.426, y=1471.1, attr=attr_alphabet},
    R = {x=743.659, y=1471.1, attr=attr_alphabet},
    S = {x=867.143, y=1471.1, attr=attr_alphabet},
    T = {x=985.883, y=1471.1, attr=attr_alphabet},
    U = {x=505.224, y=1584.642, attr=attr_alphabet},
    V = {x=623.426, y=1584.642, attr=attr_alphabet},
    W = {x=743.659, y=1584.642, attr=attr_alphabet},
    X = {x=867.143, y=1584.642, attr=attr_alphabet},
    Y = {x=985.883, y=1584.642, attr=attr_alphabet},
    Z = {x=505.224, y=1697.157, attr=attr_alphabet},
    SP = {x=623.426, y=1697.157, attr=attr_alphabet},
    DEL = {x=743.659, y=1697.157, attr=attr_alphabet},
    _ = {x=867.143, y=1697.157, attr=attr_alphabet},
    CLR = {x=985.883, y=1697.157, attr=attr_alphabet},
}

local mappings = {}
local view_elements = {}

for key, button in pairs(buttons) do
    local evid = mapper.register_event("B737_CDU_" .. key)
    mappings[#mappings + 1] = {event=evid, action=msfs.event_sender("Mobiflight.PMDG_B737_FMS_Left_" .. key)}
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.operable_area{round_ratio = button.attr.rratio, event_tap = evid},
        x = button.x, y = button.y,
        width = button.attr.width, height = button.attr.height
    }
end

local assets = require("pmdg737/assets")

local function create_view_def(name, window)
    local elements = {
        {
            object = window,
            x = 177, y= 118,
            width = 826, height = 644
        }
    }

    for i, element in ipairs(view_elements) do
        elements[#elements + 1] = element
    end

    local view_definition = {
        name = name,
        elements = elements,
        background = assets.cdu,
        logical_width = view_width,
        logical_height = view_height,
        horizontal_alignment = "right",
        vertical_alignment = "center",
        mappings = mappings,
    }

    return view_definition
end

return {
    viewdef = create_view_def,
    width = view_width,
    height = view_height,
}