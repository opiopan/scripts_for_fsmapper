local config = {
    -- debug = true,
    simhid_g1000_identifier = {path = "COM3"},
    simhid_g1000_display = 2,
    x56_stick_identifier = {name = "Saitek Pro Flight X-56 Rhino Stick"},
    x56_throttle_identifier = {name = "Saitek Pro Flight X-56 Rhino Throttle"},
}

package.path = package.path .. 
               ";" .. mapper.script_dir .. "\\simhid_g1000\\?.lua" ..
               ";" .. mapper.script_dir .. "\\x56\\?.lua"

local context = {
    simhid_g1000 = require("simhid_g1000"),
    hotas = require("x56"),
}

mapper.add_primery_mappings(context.simhid_g1000.init(config))
mapper.add_primery_mappings(context.hotas.init(config))

local function change_aircraft(host, aircraft)
    mapper.reset_viewports()
    mapper.set_secondary_mappings({})
    
    local controller = context.simhid_g1000.change(host, aircraft)
    context.hotas.change(host, aircraft, controller)
    if controller.need_to_start_viewports then
        mapper.start_viewports()
    end
end

mapper.add_primery_mappings({
    {event=mapper.events.change_aircraft, action=function (event, value)
        change_aircraft(value.host, value.aircraft)
    end},
})

if config.debug then
    change_aircraft("fs2020", "Airbus A320 Neo FlyByWire")
else
    change_aircraft("", "")
end
