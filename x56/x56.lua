local x56_context ={}

local function init(config)
    x56_context.config = config
    if x56_context.config.disable_hotas then
        return
    end

    x56_context.throttle = mapper.device{
        name = "X-56 Throttle",
        type = "dinput",
        identifier = config.x56_throttle_identifier,
        options = {denylist = {"z", "rx", "ry", "rz", "slider1"}},
        modifiers = {
            {name = "button33", modtype = "button"},
            {name = "button34", modtype = "button"},
            {name = "button35", modtype = "button"},
            {name = "button36", modtype = "button"},
            {name = "button28", modtype = "button"},
            {name = "button29", modtype = "button"},
            {name = "button21", modtype = "button"},
            {name = "button23", modtype = "button"},
        },
    }
    local x56throttle = x56_context.throttle.events

    x56_context.stick = mapper.device{
        name = "X-56 Stick",
        type = "dinput",
        identifier = config.x56_stick_identifier,
        options = {
            allowlist = {"rx", "ry"},
            vpovs = {{name = "vpov1", xaxis = "rx", yaxis = "ry", resolution = 4, disable_source = true}},
        },
    }
    local x56stick = x56_context.stick.events

    x56_context.vjoy = mapper.virtual_joystick(1)
    local vjoy = x56_context.vjoy
    local throttle1 = vjoy:get_axis("rx")
    local throttle2 = vjoy:get_axis("ry")
    local throttle1a = vjoy:get_axis("x")
    local throttle2a = vjoy:get_axis("y")
    local zoom_level = vjoy:get_axis("z")
    local airbrake_open = vjoy:get_button(1)
    local airbrake_close = vjoy:get_button(2)
    local ab1 = vjoy:get_button(3)
    local ab2 = vjoy:get_button(4)
    local reverse1 = vjoy:get_button(31)
    local reverse2 = vjoy:get_button(32)

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

    local cms_fwd = vjoy:get_button(51)
    local cms_aft = vjoy:get_button(52)
    local cms_right = vjoy:get_button(53)
    local cms_left = vjoy:get_button(54)


    function x56_context.reset()
        reverse1:value_setter(false)
        reverse2:value_setter(false)
    end
    
    x56_context.joymap ={
        base = nill,
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
        if x56_context.joymap.change_zoom then
            mapper.add_secondary_mappings({
                {event=x56throttle.button29.down, action=function () x56_context.joymap.change_zoom(false) end},
                {event=x56throttle.button29.up, action=function () x56_context.joymap.change_zoom(true) end},
            })
        else
            mapper.add_secondary_mappings({
                {event=x56throttle.button28.down, action=x56_context.joymap.move_previous_view},
                {event=x56throttle.button29.down, action=x56_context.joymap.move_next_view},
            })
        end
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

    local zoom_mode = true
    local zoom_in = -34200
    local zoom_normal = 0
    local function toggle_zoom(mode)
        zoom_mode = mode
        if zoom_mode then
            zoom_level:set_value(zoom_normal)
        else
            zoom_level:set_value(zoom_in)
        end
    end
    local function set_zoom_level(evid, value)
        zoom_normal = math.floor(value / 2)
        if zoom_mode then
            zoom_level:set_value(zoom_normal)
        end
    end
    x56_context.toggle_zoom = toggle_zoom

    local cms_dict = {}
    cms_dict[0] = cms_fwd
    cms_dict[9000] = cms_right
    cms_dict[18000] = cms_aft
    cms_dict[27000] = cms_left
    local cms_pos = -1
    local function reflect_cms(evid, value)
        if cms_pos >= 0 then
            cms_dict[cms_pos]:set_value(0)
        end
        cms_pos = value
        if cms_pos >= 0 then
            cms_dict[cms_pos]:set_value(1)
        end
    end

    local airbrake = {
        count = 0,
    }
    function airbrake.on(self)
        self.count = self.count + 1
        local last_count = self.count
        airbrake_close:set_value(false)
        airbrake_open:set_value(true)
        mapper.delay(4000, function ()
            if self.count == last_count then
                airbrake_open:set_value(false)
            end
        end)
    end
    function airbrake.off(self)
        self.count = self.count + 1
        local last_count = self.count
        airbrake_open:set_value(false)
        airbrake_close:set_value(true)
        mapper.delay(200, function ()
            if self.count == last_count then
                airbrake_close:set_value(false)
            end
        end)
    end

    x56_context.joymap_dcs = {
        {event=x56throttle.x.change, action=filter.duplicator(
            filter.lerp(throttle1a:value_setter(),{
                {-50000, -50000},
                {-30254, -30156},
                {-29961, -30156},
                {50000, 50000},
            }),
            filter.lerp(throttle1:value_setter(),{
                {-50000, -50000},
                {-29765, -50000},
                {50000, 50000},
            }),
            filter.branch(
                {condition="falled", value=-44000, action=ab1:value_setter(true)},
                {condition="exceeded", value=-39000, action=ab1:value_setter(false)}
            )
        )},
        {event=x56throttle.y.change, action=filter.duplicator(
            filter.lerp(throttle2a:value_setter(),{
                {-50000, -50000},
                {-30254, -30156},
                {-29961, -30156},
                {50000, 50000},
            }),
            filter.lerp(throttle2:value_setter(),{
                {-50000, -50000},
                {-30254, -50000},
                {50000, 50000},
            }),
            filter.branch(
                {condition="falled", value=-44000, action=ab2:value_setter(true)},
                {condition="exceeded", value=-39000, action=ab2:value_setter(false)}
            )
        )},
        {event=x56throttle.button33.up, action=function () airbrake:on() end},
        {event=x56throttle.button33.down, action=function () airbrake:off() end},
        {event=x56throttle.slider2.change, action=set_zoom_level},
        {event=x56stick.vpov1.change, action=reflect_cms},
        {event=x56throttle.button21.down, action=mapper.keystroke{codes={"f1"}}:synthesizer()},
        {event=x56throttle.button23.down, action=mapper.keystroke{codes={"f2"}}:synthesizer()},
    }

    x56_context.joymap_noab = {
        {event=x56throttle.x.change, action=filter.duplicator(
            filter.lerp(throttle1:value_setter(),{
                {-50000, -50000},
                {-29765, -50000},
                {50000, 50000},
            }),
            filter.branch(
                {condition="falled", value=-44000, action=ab1:value_setter(true)},
                {condition="exceeded", value=-39000, action=ab1:value_setter(false)}
            )
        )},
        {event=x56throttle.y.change, action=filter.duplicator(
            filter.lerp(throttle2:value_setter(),{
                {-50000, -50000},
                {-30254, -50000},
                {50000, 50000},
            }),
            filter.branch(
                {condition="falled", value=-44000, action=ab2:value_setter(true)},
                {condition="exceeded", value=-39000, action=ab2:value_setter(false)}
            )
        )},
        {event=x56throttle.button33.up, action=airbrake_open:value_setter(true)},
        {event=x56throttle.button33.down, action=filter.duplicator(
            airbrake_open:value_setter(false),
            airbrake_close:value_setter(true)
        )},
        {event=x56throttle.button33.following_down, action=airbrake_close:value_setter(false)},
    }

    x56_context.throttle_map_normal ={
        {-50000, -50000},
        {50000, 50000},
    }
    x56_context.throttle_map_reverse ={
        {-50000, -50000},
        {-29500, -50000},
        {50000, 370},
    }
    x56_context.throttle_map = x56_context.throttle_map_normal

    function x56_context.make_joymap_airbus()
        return {
            {event=x56throttle.x.change, action=filter.lerp(throttle1:value_setter(), x56_context.throttle_map)},
            {event=x56throttle.y.change, action=filter.lerp(throttle2:value_setter(), x56_context.throttle_map)},
            {event=x56throttle.button33.up, action=filter.duplicator(
                reverse1:value_setter(true), reverse2:value_setter(true),
                function ()
                    x56_context.throttle_map = x56_context.throttle_map_reverse
                    x56_context.joymap.base =  x56_context.make_joymap_airbus()
                    x56_context.update_secondary_mappings()
                    mapper.raise_event(x56throttle.x.change, 50000)
                    mapper.raise_event(x56throttle.y.change, 50000)
                end
            )},
            {event=x56throttle.button33.down, action=filter.duplicator(
                reverse1:value_setter(false), reverse2:value_setter(false),
                function ()
                    x56_context.throttle_map = x56_context.throttle_map_normal
                    x56_context.joymap.base =  x56_context.make_joymap_airbus()
                    x56_context.update_secondary_mappings()
                    mapper.raise_event(x56throttle.x.change, 50000)
                    mapper.raise_event(x56throttle.y.change, 50000)
                end
            )},
        }
    end

    x56_context.joymap_airbus = x56_context.make_joymap_airbus()

    x56_context.throttle_map_normal2 ={
        {-50000, -50000},
        {50000, 25000},
    }
    x56_context.throttle_map_reverse2 ={
        {-50000, 50000},
        {-29500, 50000},
        {50000, 30000},
    }
    x56_context.throttle_map2 = x56_context.throttle_map_normal2

    function x56_context.make_joymap_airbus2()
        return {
            {event=x56throttle.x.change, action=filter.lerp(throttle1:value_setter(), x56_context.throttle_map2)},
            {event=x56throttle.y.change, action=filter.lerp(throttle2:value_setter(), x56_context.throttle_map2)},
            {event=x56throttle.button33.up, action=filter.duplicator(
                function ()
                    x56_context.throttle_map2 = x56_context.throttle_map_reverse2
                    x56_context.joymap.base =  x56_context.make_joymap_airbus2()
                    x56_context.update_secondary_mappings()
                    mapper.raise_event(x56throttle.x.change, 50000)
                    mapper.raise_event(x56throttle.y.change, 50000)
                end
            )},
            {event=x56throttle.button33.down, action=filter.duplicator(
                function ()
                    x56_context.throttle_map2 = x56_context.throttle_map_normal2
                    x56_context.joymap.base =  x56_context.make_joymap_airbus2()
                    x56_context.update_secondary_mappings()
                    mapper.raise_event(x56throttle.x.change, 50000)
                    mapper.raise_event(x56throttle.y.change, 50000)
                end
            )},
        }
    end

    x56_context.joymap_airbus2 = x56_context.make_joymap_airbus2()

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

    x56_context.joymap.base = x56_context.joymap_dcs

    x56_context.msfs_maps = {}
    x56_context.msfs_maps["Airbus A320 Neo FlyByWire"] = x56_context.joymap_airbus2
    x56_context.msfs_maps["FenixA320"] = x56_context.joymap_airbus2

    return static_mappings
end

local function change(host, aircraft, simhid_g1000)
    if x56_context.config.disable_hotas then
        mapper.set_secondary_mappings{}
        for i, mappings in ipairs(simhid_g1000.global_mappings) do
            mapper.add_secondary_mappings(mappings)
        end
        return
    end

    mapper.set_secondary_mappings({})
    x56_context.reset()

    x56_context.joymap.others = simhid_g1000.global_mappings
    x56_context.joymap.move_next_view = simhid_g1000.move_next_view
    x56_context.joymap.move_previous_view = simhid_g1000.move_previous_view
    x56_context.joymap.change_zoom = nil
    
    if host ~= "msfs" then
        x56_context.joymap.base = x56_context.joymap_dcs
        x56_context.joymap.move_next_view = function () end
        x56_context.joymap.move_previous_view = function () end
        x56_context.joymap.change_zoom = x56_context.toggle_zoom
    else
        local map = x56_context.msfs_maps[aircraft]
        if map then
            x56_context.joymap.base = map
        else
            x56_context.joymap.base = x56_context.joymap_noab
        end
    end
    x56_context.update_secondary_mappings()
end

return {
    init = init,
    change = change,
}
