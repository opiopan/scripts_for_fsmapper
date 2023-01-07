local fs2020_map = {}
fs2020_map["SR22 Asobo"] = require("fs2020/g1000")
fs2020_map["SR 22"] = require("fs2020/g1000")
fs2020_map["DA40-NG Asobo"] = require("fs2020/g1000")
fs2020_map["DA 40 NG"] = require("fs2020/g1000")
fs2020_map["DA62 Asobo"] = require("fs2020/g1000")
fs2020_map["DA 62"] = require("fs2020/g1000")
fs2020_map["Baron G58"] = require("fs2020/g1000")
fs2020_map["Bonanza G36"] = require("fs2020/g1000")
fs2020_map["Cessna Skyhawk G1000"] = require("fs2020/g1000")
fs2020_map["Cessna Skyhawk 172Sp G1000"] = require("fs2020/g1000")
fs2020_map["Cessna 208B Grand Caravan EX"] = require("fs2020/g1000")
fs2020_map["Cessna Grand Caravan"] = require("fs2020/g1000")
fs2020_map["C-6 G950"] = require("fs2020/g1000") -- Pilatus PC-6 G950
fs2020_map["Airbus A320 Neo FlyByWire"] = require("fs2020/a32nx")
fs2020_map["FenixA320"] = require("fs2020/fnx32")
fs2020_map["PMDG 737"] = require("fs2020/pmdg737")
fs2020_map["Beechcraft King Air 350"] = require("fs2020/g3x_touch")
fs2020_map["Asobo NXCub"] = require("fs2020/g3x_touch")
fs2020_map["Asobo XCub"] = require("fs2020/g3x_touch")
fs2020_map["Xcub"] = require("fs2020/g3x_touch")
fs2020_map["VL3"] = require("fs2020/g3x_touch")
fs2020_map["Volocity Microsoft"] = require("fs2020/g3x_touch")
fs2020_map["TBM 930"] = require("fs2020/tbm930")
fs2020_map["Extra 330"] = require("fs2020/extra330")
fs2020_map["Pipistrel Alpha Electro Asobo"] = require("fs2020/sw121")
fs2020_map["Pipistrel 121SW"] = require("fs2020/sw121")
fs2020_map["Cessna Skyhawk Asobo"] = require("fs2020/c172")
fs2020_map["Cessna Skyhawk Floaters Asobo"] = require("fs2020/c172")
fs2020_map["Cessna Skyhawk Skis Asobo"] = require("fs2020/c172")
fs2020_map["Cessna Skyhawk 172Sp Classic"] = require("fs2020/c172")
fs2020_map["DA40 TDI Asobo"] = require("fs2020/da40tdi")
fs2020_map["DA 40 TDI"] = require("fs2020/da40tdi")
fs2020_map["DV20 Asobo"] = require("fs2020/da40tdi")
fs2020_map["DV 20"] = require("fs2020/da40tdi")
fs2020_map["Cessna Longitude"] = require("fs2020/longitude")
fs2020_map["Blackbird Simulations DHC-2"] = require("fs2020/dhc2")
fs2020_map["Cessna 152"] = require("fs2020/c152")

local fs2020_fallback={
    start = function ()
        return {
            move_next_view = function () end,
            move_previous_view = function () end,
            global_mappings = {},
            need_to_start_viewports = false,
        }
    end,
    stop = function () end,
}

local dcs_config = require("dcs/dcs_default")

local global_config = nil
local current = dcs_config

local function init(config)
    global_config = config
    return {}
end

local function change(host, aircraft)
    current.stop()
    if host == "fs2020" then
        current = fs2020_map[aircraft]
        if not current then
            for name, mod in pairs(fs2020_map) do
                if string.find(aircraft, name) ~= nil then
                    current = mod
                    break
                end
            end
            if not current then
                current = fs2020_fallback
            end
        end
    else
        current = dcs_config
    end
    return current.start(global_config, aircraft)
end

return {
    init = init,
    change = change,
}
