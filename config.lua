local config = {
    -- debug = true,
    simhid_g1000_identifier = {path = "COM3"},
    simhid_g1000_display = 2,
    x56_stick_identifier = {name = "Saitek Pro Flight X-56 Rhino Stick"},
    x56_throttle_identifier = {name = "Saitek Pro Flight X-56 Rhino Throttle"},
}

package.path = package.path .. ";" .. mapper.script_dir .. "\\simhid_g1000\\?.lua"
package.path = package.path .. ";" .. mapper.script_dir .. "\\x56\\?.lua"


local context = {
    simhid_g1000 = require("simhid_g1000"),
    hotas = require("x56"),
    controller = nil,
}
mapper.set_primery_mappings(context.hotas.mappings)

local function change_aircraft(host, aircraft)
    if context.controller then
        context.simhid_g1000.stop()
        context.hotas.stop()
        mapper.reset_viewports()
        mapper.set_secondary_mappings({})
    end
    
    context.controller = context.simhid_g1000.start(config, host, aircraft)
    context.hotas.start(host, aircraft, context.controller)
    if context.controller.need_to_start_viewports then
        mapper.start_viewports()
    end
end

change_aircraft("", "")

mapper.add_primery_mappings({
    {event=mapper.events.change_aircraft, action=function (event, value)
        change_aircraft(value.host, value.aircraft)
    end},
})
