local config = {
    simhid_g1000_identifier = {path = "COM3"},
    simhid_g1000_display = 2,
    x56_stick_identifier = {name = "Saitek Pro Flight X-56 Rhino Stick"},
    x56_throttle_identifier = {name = "Saitek Pro Flight X-56 Rhino Throttle"},
}

if override_config ~= nil then
    for key, value in pairs(override_config) do
        config[key] = value
    end
end
if config.simhid_g1000_display_scale == nil then
    config.simhid_g1000_display_scale = 1
end

package.path = package.path .. 
               ";" .. mapper.script_dir .. "\\simhid_g1000\\?.lua" ..
               ";" .. mapper.script_dir .. "\\simhid_g1000\\msfs\\?.lua" ..
               ";" .. mapper.script_dir .. "\\x56\\?.lua"

local context = {
    simhid_g1000 = require("simhid_g1000"),
    hotas = require("x56"),
}

mapper.add_primary_mappings(context.simhid_g1000.init(config))
mapper.add_primary_mappings(context.hotas.init(config))

local synonym_map_msfs = {}
synonym_map_msfs["Airbus A320neo FlyByWire"] = "Airbus A320 Neo FlyByWire"
synonym_map_msfs["Airbus A320 NX ANA All Nippon Airways JA219A SoccerYCA "] = "Airbus A320 Neo FlyByWire"
synonym_map_msfs["Airbus A320 Neo Bhutan Airlines (A32NX Converted)"] = "Airbus A320 Neo FlyByWire"

local function normalize_msfs_aircraft_name(name)
    local synonym = synonym_map_msfs[name]
    if synonym then
        return synonym
    else
        if string.find(name, "FenixA320") == 1 then
            return "FenixA320"
        end
        if string.find(name, "Fenix A320") == 1 then
            return "FenixA320"
        end
        if string.find(name, "PMDG 737") == 1 then
            return "PMDG 737"
        end
        if string.find(name, "Blackbird Simulations DHC-") == 1 then
            return "Blackbird Simulations DHC-2"
        end
        return name
    end
end

local function change_aircraft(sim_type, aircraft)
    mapper.reset_viewports()
    mapper.set_secondary_mappings({})

    if sim_type == "msfs" then
        aircraft = normalize_msfs_aircraft_name(aircraft)
    end
    
    local controller = context.simhid_g1000.change(sim_type, aircraft)
    context.hotas.change(sim_type, aircraft, controller)
    if controller.need_to_start_viewports then
        mapper.start_viewports()
    end
end

mapper.add_primary_mappings({
    {event=mapper.events.change_aircraft, action=function (event, value)
        change_aircraft(value.sim_type, value.aircraft)
    end},
})

if config.initial_sim ~= nil and config.initial_aircraft ~= nil then
    mapper.print('Emulating: [' .. config.initial_sim .. '] ' .. config.initial_aircraft)
    change_aircraft(config.initial_sim, config.initial_aircraft)
else
    change_aircraft("", "")
end
