local msfs_map = {}
msfs_map["SR22 Asobo"] = require("msfs/g1000")
msfs_map["SR 22"] = require("msfs/g1000")
msfs_map["SR22T Working Title"] = require("msfs/g1000abs")
msfs_map["DA40-NG Asobo"] = require("msfs/g1000")
msfs_map["DA 40 NG"] = require("msfs/g1000")
msfs_map["DA62"] = require("msfs/g1000")
msfs_map["DA 62"] = require("msfs/g1000")
msfs_map["Baron G58"] = require("msfs/g1000")
msfs_map["Bonanza G36"] = require("msfs/g1000")
msfs_map["Cessna Skyhawk G1000"] = require("msfs/g1000")
msfs_map["Cessna Skyhawk 172Sp G1000"] = require("msfs/g1000")
msfs_map["Cessna 208B Grand Caravan EX"] = require("msfs/g1000")
msfs_map["Cessna Grand Caravan"] = require("msfs/g1000")
msfs_map["C-6 G950"] = require("msfs/g1000") -- Pilatus PC-6 G950
msfs_map["Airbus A320 Neo FlyByWire"] = require("msfs/a32nx")
msfs_map["FenixA320"] = require("msfs/fnx32")
msfs_map["PMDG 737"] = require("msfs/pmdg737")
msfs_map["Beechcraft King Air 350"] = require("msfs/g3x_touch")
msfs_map["NXCub"] = require("msfs/g3x_touch")
msfs_map["XCub"] = require("msfs/g3x_touch")
msfs_map["Xcub"] = require("msfs/g3x_touch")
msfs_map["VL3"] = require("msfs/g3x_touch")
msfs_map["Volocity Microsoft"] = require("msfs/g3x_touch")
msfs_map["TBM 930"] = require("msfs/tbm930")
msfs_map["Extra 330"] = require("msfs/extra330")
msfs_map["Pipistrel Alpha Electro Asobo"] = require("msfs/sw121")
msfs_map["Pipistrel 121SW"] = require("msfs/sw121")
msfs_map["Cessna Skyhawk Asobo"] = require("msfs/c172")
msfs_map["Cessna Skyhawk Floaters Asobo"] = require("msfs/c172")
msfs_map["Cessna Skyhawk Skis Asobo"] = require("msfs/c172")
msfs_map["Cessna Skyhawk 172Sp Classic"] = require("msfs/c172")
msfs_map["C172SP Classic"] = require("msfs/c172")
msfs_map["DA40 TDI Asobo"] = require("msfs/da40tdi")
msfs_map["DA40  TDI"] = require("msfs/da40tdi")
msfs_map["DA 40 TDI"] = require("msfs/da40tdi")
msfs_map["DV20 Asobo"] = require("msfs/da40tdi")
msfs_map["DV 20"] = require("msfs/da40tdi")
msfs_map["Cessna Longitude"] = require("msfs/longitude")
msfs_map["Cessna Citation Longitude"] = require("msfs/longitude")
msfs_map["Blackbird Simulations DHC-2"] = require("msfs/dhc2")
msfs_map["Cessna 152"] = require("msfs/c152")

local msfs_fallback={
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

local dcs_map = {}
dcs_map["F-16C_50"] = require("dcs/f16")

local def_config = require("dcs/dcs_default")

local global_config = nil
local current = def_config

local function init(config)
    global_config = config
    return {}
end

local function change(sim_type, aircraft)
    current.stop()
    if sim_type == "msfs" then
        current = msfs_map[aircraft]
        if not current then
            for name, mod in pairs(msfs_map) do
                if string.find(aircraft, name) ~= nil then
                    current = mod
                    break
                end
            end
            if not current then
                current = msfs_fallback
            end
        end
    else
        current = def_config
    end
    return current.start(global_config, aircraft)
end

return {
    init = init,
    change = change,
}
