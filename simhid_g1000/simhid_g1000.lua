local fs2020_map = {}
fs2020_map["SR22 Asobo"] = require("g1000")
fs2020_map["SR 22"] = require("g1000")
fs2020_map["DA40-NG Asobo"] = require("g1000")
fs2020_map["DA 40 NG"] = require("g1000")
fs2020_map["DA62 Asobo"] = require("g1000")
fs2020_map["DA 62"] = require("g1000")
fs2020_map["Baron G58"] = require("g1000")
fs2020_map["Bonanza G36"] = require("g1000")
fs2020_map["Cessna Skyhawk G1000"] = require("g1000")
fs2020_map["Cessna Skyhawk 172Sp G1000"] = require("g1000")
fs2020_map["Cessna 208B Grand Caravan EX"] = require("g1000")
fs2020_map["Cessna Grand Caravan"] = require("g1000")
fs2020_map["Pilatus PC-6 G950 Wheels"] = require("g1000")
fs2020_map["Pilatus PC-6 G950 Floats"] = require("g1000")
fs2020_map["Airbus A320 Neo FlyByWire"] = require("a32nx")
fs2020_map["FenixA320"] = require("fnx32")
fs2020_map["PMDG 737"] = require("pmdg737")
fs2020_map["Beechcraft King Air 350i Asobo"] = require("g3x_touch")
fs2020_map["Asobo NXCub"] = require("g3x_touch")
fs2020_map["Asobo XCub"] = require("g3x_touch")
fs2020_map["Asobo XCub Floats"] = require("g3x_touch")
fs2020_map["Asobo XCub Skis"] = require("g3x_touch")
fs2020_map["VL3 Asobo"] = require("g3x_touch")
fs2020_map["Volocity Microsoft"] = require("g3x_touch")
fs2020_map["TBM 930 Asobo"] = require("tbm930")
fs2020_map["Extra 330 Asobo"] = require("extra330")
fs2020_map["Pipistrel Alpha Electro Asobo"] = require("sw121")
fs2020_map["Cessna Skyhawk Asobo"] = require("c172")
fs2020_map["Cessna Skyhawk Floaters Asobo"] = require("c172")
fs2020_map["Cessna Skyhawk Skis Asobo"] = require("c172")
fs2020_map["Cessna Skyhawk 172Sp Classic"] = require("c172")
fs2020_map["DA40 TDI Asobo"] = require("da40tdi")
fs2020_map["DV20 Asobo"] = require("da40tdi")
fs2020_map["DV 20"] = require("da40tdi")
fs2020_map["Cessna Longitude"] = require("longitude")
fs2020_map["Blackbird Simulations DHC-2"] = require("dhc2")
fs2020_map["Cessna 152"] = require("c152")

local fallback={
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

local global_config = nil
local current = fallback

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
                current = fallback
            end
        end
    else
        current = fallback
    end
    return current.start(global_config, aircraft)
end

return {
    init = init,
    change = change,
}
