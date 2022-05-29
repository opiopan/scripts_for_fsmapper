local g1000 = require("g1000")

local fs2020_map = {}
fs2020_map["SR22 Asobo"] = g1000
fs2020_map["DA40-NG Asobo"] = g1000
fs2020_map["DA62 Asobo"] = g1000
fs2020_map["Asobo Baron G58"] = g1000
fs2020_map["Bonanza G36 Asobo"] = g1000
fs2020_map["Cessna Skyhawk G1000 Asobo"] = g1000
fs2020_map["Cessna Skyhawk G1000 Floaters Asobo"] = g1000
fs2020_map["Cessna Skyhawk G1000 Skis Asobo"] = g1000
fs2020_map["Cessna 208B Grand Caravan EX"] = g1000
fs2020_map["Airbus A320 Neo FlyByWire"] = require("a320nx")

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

local current = fallback

local function start(config, host, aircraft)
    if host == "fs2020" then
        current = fs2020_map[aircraft]
        if not current then
            current = fallback
        end
    else
        current = fallback
    end
    return current.start(config)
end

local function stop()
    current.stop()
end

return {
    start = start,
    stop = stop,
}
