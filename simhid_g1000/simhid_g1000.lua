local fs2020_map = {}
fs2020_map["SR22 Asobo"] = require("g1000")
fs2020_map["DA40-NG Asobo"] = require("g1000")
fs2020_map["DA62 Asobo"] = require("g1000")
fs2020_map["Asobo Baron G58"] = require("g1000")
fs2020_map["Bonanza G36 Asobo"] = require("g1000")
fs2020_map["Cessna Skyhawk G1000 Asobo"] = require("g1000")
fs2020_map["Cessna Skyhawk G1000 Floaters Asobo"] = require("g1000")
fs2020_map["Cessna Skyhawk G1000 Skis Asobo"] = require("g1000")
fs2020_map["Cessna 208B Grand Caravan EX"] = require("g1000")
fs2020_map["Airbus A320 Neo FlyByWire"] = require("a320nx")
fs2020_map["Airbus A320 NX ANA All Nippon Airways JA219A SoccerYCA "] = require("a320nx")

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
            current = fallback
        end
    else
        current = fallback
    end
    return current.start(global_config)
end

return {
    init = init,
    change = change,
}
