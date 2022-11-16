local config = {
    -- debug = true,
    simhid_g1000_identifier = {path = "COM3"},
    simhid_g1000_display = 2,
    x56_stick_identifier = {name = "Saitek Pro Flight X-56 Rhino Stick"},
    x56_throttle_identifier = {name = "Saitek Pro Flight X-56 Rhino Throttle"},
}

package.path = package.path .. 
               ";" .. mapper.script_dir .. "\\simhid_g1000\\?.lua" ..
               ";" .. mapper.script_dir .. "\\simhid_g1000\\individuals\\?.lua" ..
               ";" .. mapper.script_dir .. "\\x56\\?.lua"

local context = {
    simhid_g1000 = require("simhid_g1000"),
    hotas = require("x56"),
}

mapper.add_primary_mappings(context.simhid_g1000.init(config))
mapper.add_primary_mappings(context.hotas.init(config))

local synonym_map_fs2020 = {}
synonym_map_fs2020["Airbus A320neo FlyByWire"] = "Airbus A320 Neo FlyByWire"
synonym_map_fs2020["Airbus A320 NX ANA All Nippon Airways JA219A SoccerYCA "] = "Airbus A320 Neo FlyByWire"
synonym_map_fs2020["Airbus A320 Neo Bhutan Airlines (A32NX Converted)"] = "Airbus A320 Neo FlyByWire"

local function normalize_fs2020_aircraft_name(name)
    local synonym = synonym_map_fs2020[name]
    if synonym then
        return synonym
    else
        if string.find(name, "FenixA320") == 1 then
            return "FenixA320"
        end
        if string.find(name, "PMDG 737") == 1 then
            return "PMDG 737"
        end
        return name
    end
end

local function change_aircraft(host, aircraft)
    mapper.reset_viewports()
    mapper.set_secondary_mappings({})

    if host == "fs2020" then
        aircraft = normalize_fs2020_aircraft_name(aircraft)
    end
    
    local controller = context.simhid_g1000.change(host, aircraft)
    context.hotas.change(host, aircraft, controller)
    if controller.need_to_start_viewports then
        mapper.start_viewports()
    end
end

mapper.add_primary_mappings({
    {event=mapper.events.change_aircraft, action=function (event, value)
        change_aircraft(value.host, value.aircraft)
    end},
})

if config.debug then
    change_aircraft("fs2020", "Cessna Longitude Asobo")
    -- change_aircraft("fs2020", "Cessna Skyhawk Asobo")
else
    change_aircraft("", "")
end
