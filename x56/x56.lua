local x56_context ={}

local function init(config)
    x56_context.throttle = mapper.device({
        name = "X-56 Throttle",
        type = "dinput",
        identifier = config.x56_throttle_identifier,
        options = {denylist = {"z", "rx", "ry", "rz", "slider1", "slider2"}},
        modifiers = {
            {name = "button33", modtype = "button", modparam={follow_down = 200}},
            {name = "button34", modtype = "button"},
            {name = "button35", modtype = "button"},
            {name = "button36", modtype = "button"},
            {name = "button28", modtype = "button"},
            {name = "button29", modtype = "button"},
        },
    })
    local x56throttle = x56_context.throttle.events

    x56_context.vjoy = mapper.virtual_joystick(1)
    local vjoy = x56_context.vjoy
    local throttle1 = vjoy:get_axis("rx")
    local throttle2 = vjoy:get_axis("ry")
    local throttle1a = vjoy:get_axis("x")
    local throttle2a = vjoy:get_axis("y")
    local airbrake_open = vjoy:get_button(1)
    local airbrake_close = vjoy:get_button(2)
    local ab1 = vjoy:get_button(3)
    local ab2 = vjoy:get_button(4)

    local marm_on = vjoy:get_button(5)
    local marm_off = vjoy:get_button(6)

    local eng1idle = vjoy:get_button(7)
    local eng1cut = vjoy:get_button(8)
    local eng2idle = vjoy:get_button(9)
    local eng2cut = vjoy:get_button(10)
    local eng1start = vjoy:get_button(11)
    local eng2start = vjoy:get_button(12)
    local canopy_open = vjoy:get_button(13)
    local canopy_close = vjoy:get_button(14)
    local start_aux1 = vjoy:get_button(15)
    local start_aux2 = vjoy:get_button(16)

    local gearup = vjoy:get_button(17)
    local geardown = vjoy:get_button(18)
    local flapup = vjoy:get_button(19)
    local flapdown = vjoy:get_button(20)
    local hookup = vjoy:get_button(21)
    local hookdown = vjoy:get_button(22)
    local llight_on = vjoy:get_button(23)
    local llight_off = vjoy:get_button(24)
    local flight_aux1 = vjoy:get_button(31)
    local flight_aux2 = vjoy:get_button(32)

    local aa_mode = vjoy:get_button(25)
    local ag_mode = vjoy:get_button(26)
    local arm_aux1 = vjoy:get_button(27)
    local arm_aux2 = vjoy:get_button(28)
    local arm_aux3 = vjoy:get_button(29)
    local arm_aux4 = vjoy:get_button(30)

    x56_context.joymap_dcs = {
        {event=x56throttle.x.change, action=filter.duplicator(
            filter.lerp(throttle1a:value_setter(),{
                {-1023, -1023},
                {-619, -617},
                {-613, -617},
                {1023, 1023},
            }),
            filter.lerp(throttle1:value_setter(),{
                {-1023, -1023},
                {-609, -1023},
                {1023, 1023},
            }),
            filter.branch(
                {condition="falled", value=-900, action=ab1:value_setter(true)},
                {condition="exceeded", value=-800, action=ab1:value_setter(false)}
            )
        )},
        {event=x56throttle.y.change, action=filter.duplicator(
            filter.lerp(throttle2a:value_setter(),{
                {-1023, -1023},
                {-619, -617},
                {-613, -617},
                {1023, 1023},
            }),
            filter.lerp(throttle2:value_setter(),{
                {-1023, -1023},
                {-619, -1023},
                {1023, 1023},
            }),
            filter.branch(
                {condition="falled", value=-900, action=ab2:value_setter(true)},
                {condition="exceeded", value=-800, action=ab2:value_setter(false)}
            )
        )},
        {event=x56throttle.button33.up, action=airbrake_open:value_setter(true)},
        {event=x56throttle.button33.down, action=filter.duplicator(
            airbrake_open:value_setter(false),
            airbrake_close:value_setter(true)
        )},
        {event=x56throttle.button33.following_down, action=airbrake_close:value_setter(false)},
    }

    x56_context.joymap_noab = {
        {event=x56throttle.x.change, action=filter.duplicator(
            filter.lerp(throttle1:value_setter(),{
                {-1023, -1023},
                {-609, -1023},
                {1023, 1023},
            }),
            filter.branch(
                {condition="falled", value=-900, action=ab1:value_setter(true)},
                {condition="exceeded", value=-800, action=ab1:value_setter(false)}
            )
        )},
        {event=x56throttle.y.change, action=filter.duplicator(
            filter.lerp(throttle2:value_setter(),{
                {-1023, -1023},
                {-619, -1023},
                {1023, 1023},
            }),
            filter.branch(
                {condition="falled", value=-900, action=ab2:value_setter(true)},
                {condition="exceeded", value=-800, action=ab2:value_setter(false)}
            )
        )},
        {event=x56throttle.button33.up, action=airbrake_open:value_setter(true)},
        {event=x56throttle.button33.down, action=filter.duplicator(
            airbrake_open:value_setter(false),
            airbrake_close:value_setter(true)
        )},
        {event=x56throttle.button33.following_down, action=airbrake_close:value_setter(false)},
    }

    x56_context.joymap_full = {
        {event=x56throttle.x.change, action=throttle1:value_setter()},
        {event=x56throttle.y.change, action=throttle2:value_setter()},
        {event=x56throttle.button33.up, action=airbrake_open:value_setter(true)},
        {event=x56throttle.button33.down, action=filter.duplicator(
            airbrake_open:value_setter(false), airbrake_close:value_setter(true)
        )},
        {event=x56throttle.button33.following_down, action=airbrake_close:value_setter(false)},
    }

    x56_context.joymap_preflight = {
        {event=x56throttle.button6.change, action=eng1idle:value_setter()},
        {event=x56throttle.button7.change, action=eng1cut:value_setter()},
        {event=x56throttle.button8.change, action=eng2idle:value_setter()},
        {event=x56throttle.button9.change, action=eng2cut:value_setter()},
        {event=x56throttle.button10.change, action=eng1start:value_setter()},
        {event=x56throttle.button11.change, action=eng2start:value_setter()},
        {event=x56throttle.button18.change, action=canopy_open:value_setter()},
        {event=x56throttle.button19.change, action=canopy_close:value_setter()},
        {event=x56throttle.button12.change, action=start_aux1:value_setter()},
        {event=x56throttle.button13.change, action=start_aux2:value_setter()},
    }

    x56_context.joymap_inflight = {
        {event=x56throttle.button6.change, action=gearup:value_setter()},
        {event=x56throttle.button7.change, action=geardown:value_setter()},
        {event=x56throttle.button8.change, action=flapup:value_setter()},
        {event=x56throttle.button9.change, action=flapdown:value_setter()},
        {event=x56throttle.button10.change, action=hookup:value_setter()},
        {event=x56throttle.button11.change, action=hookdown:value_setter()},
        {event=x56throttle.button12.change, action=llight_on:value_setter()},
        {event=x56throttle.button13.change, action=llight_off:value_setter()},
        {event=x56throttle.button18.change, action=flight_aux1:value_setter()},
        {event=x56throttle.button19.change, action=flight_aux2:value_setter()},
    }

    x56_context.joymap_combat = {
        {event=x56throttle.button6.change, action=aa_mode:value_setter()},
        {event=x56throttle.button7.change, action=ag_mode:value_setter()},
        {event=x56throttle.button8.change, action=arm_aux1:value_setter()},
        {event=x56throttle.button9.change, action=arm_aux2:value_setter()},
        {event=x56throttle.button10.change, action=arm_aux3:value_setter()},
        {event=x56throttle.button11.change, action=arm_aux4:value_setter()},
    }

    x56_context.joymap ={
        base = x56_context.joymap_dcs,
        modal = {},
        others = {},
        move_next_view = nil,
        move_previous_view = nil,
    }

     x56_context.update_secondary_mappings = function ()
        mapper.set_secondary_mappings(x56_context.joymap.base)
        mapper.add_secondary_mappings(x56_context.joymap.modal)
        for i, mappings in ipairs(x56_context.joymap.others) do
            mapper.add_secondary_mappings(mappings)
        end
        mapper.add_secondary_mappings({
            {event=x56throttle.button28.down, action=x56_context.joymap.move_previous_view},
            {event=x56throttle.button29.down, action=x56_context.joymap.move_next_view},
        })
    end

    local static_mappings = {
        {event=x56throttle.button34.down, action=filter.duplicator(
            function ()
                x56_context.joymap.modal = x56_context.joymap_combat
                x56_context.update_secondary_mappings()
                marm_on:set_value(true)
            end,
            filter.delay(200, marm_on:value_setter(false)))
        },
    
        {event=x56throttle.button35.down, action=function ()
            x56_context.joymap.modal = x56_context.joymap_inflight
            x56_context.update_secondary_mappings()
            marm_off:set_value(true)
            mapper.delay(200, function () marm_off:set_value(false) end)
        end},
    
        {event=x56throttle.button36.down, action=function ()
            x56_context.joymap.modal = x56_context.joymap_preflight
            x56_context.update_secondary_mappings()
        end},
    }

    return static_mappings
end

local function change(host, aircraft, simhid_g1000)
    mapper.set_secondary_mappings({})

    x56_context.joymap.others = simhid_g1000.global_mappings
    x56_context.joymap.move_next_view = simhid_g1000.move_next_view
    x56_context.joymap.move_previous_view = simhid_g1000.move_next_view
    
    if host ~= "fs2020" then
        x56_context.joymap.base = x56_context.joymap_dcs
    elseif aircraft == "Airbus A320 Neo FlyByWire" then
        x56_context.joymap.base = x56_context.joymap_full
    else
        x56_context.joymap.base = x56_context.joymap_noab
    end
    x56_context.update_secondary_mappings()
end

return {
    init = init,
    change = change,
}
