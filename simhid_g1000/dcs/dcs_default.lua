local module={}

function module.start(config)
    module.device = mapper.device{
        name = "SimHID G1000",
        type = "simhid",
        identifier = config.simhid_g1000_identifier,
        modifiers = {
            {class = "relative", modtype = "incdec", modparam={pulse_mode = true}},
        },
    }
    local g1000 = module.device.events

    module.vjoy = mapper.virtual_joystick(2)
    local vjoy = module.vjoy

    local mappings = {
        {
            {event=g1000.SW1.change, action=vjoy:get_button(1):value_setter()},
            {event=g1000.SW2.change, action=vjoy:get_button(2):value_setter()},
            {event=g1000.SW3.change, action=vjoy:get_button(3):value_setter()},
            {event=g1000.SW4.change, action=vjoy:get_button(4):value_setter()},
            {event=g1000.SW5.change, action=vjoy:get_button(5):value_setter()},
            {event=g1000.SW6.change, action=vjoy:get_button(6):value_setter()},
            {event=g1000.SW7.change, action=vjoy:get_button(7):value_setter()},
            {event=g1000.SW8.change, action=vjoy:get_button(8):value_setter()},
            {event=g1000.SW9.change, action=vjoy:get_button(9):value_setter()},
            {event=g1000.SW10.change, action=vjoy:get_button(10):value_setter()},
            {event=g1000.SW11.change, action=vjoy:get_button(11):value_setter()},
            {event=g1000.SW12.change, action=vjoy:get_button(12):value_setter()},
            {event=g1000.SW13.change, action=vjoy:get_button(13):value_setter()},
            {event=g1000.SW14.change, action=vjoy:get_button(14):value_setter()},
            {event=g1000.SW15.change, action=vjoy:get_button(15):value_setter()},
            {event=g1000.SW16.change, action=vjoy:get_button(16):value_setter()},
            {event=g1000.SW17.change, action=vjoy:get_button(17):value_setter()},
            {event=g1000.SW18.change, action=vjoy:get_button(18):value_setter()},
            {event=g1000.SW19.change, action=vjoy:get_button(19):value_setter()},
            {event=g1000.SW20.change, action=vjoy:get_button(20):value_setter()},
            {event=g1000.SW21.change, action=vjoy:get_button(21):value_setter()},
            {event=g1000.SW22.change, action=vjoy:get_button(22):value_setter()},
            {event=g1000.SW23.change, action=vjoy:get_button(23):value_setter()},
            {event=g1000.SW24.change, action=vjoy:get_button(24):value_setter()},
            {event=g1000.SW25.change, action=vjoy:get_button(25):value_setter()},
            {event=g1000.SW26.change, action=vjoy:get_button(26):value_setter()},
            {event=g1000.SW27.change, action=vjoy:get_button(27):value_setter()},
            {event=g1000.SW28.change, action=vjoy:get_button(28):value_setter()},
            {event=g1000.SW29.change, action=vjoy:get_button(29):value_setter()},
            {event=g1000.SW30.change, action=vjoy:get_button(30):value_setter()},
            {event=g1000.SW31.change, action=vjoy:get_button(31):value_setter()},
            {event=g1000.SW32.change, action=vjoy:get_button(32):value_setter()},

            {event=g1000.AUX1D.change, action=vjoy:get_button(33):value_setter()},
            {event=g1000.AUX1U.change, action=vjoy:get_button(34):value_setter()},
            {event=g1000.AUX1P.change, action=vjoy:get_button(35):value_setter()},
            {event=g1000.AUX2D.change, action=vjoy:get_button(36):value_setter()},
            {event=g1000.AUX2U.change, action=vjoy:get_button(37):value_setter()},
            {event=g1000.AUX2P.change, action=vjoy:get_button(38):value_setter()},

            {event=g1000.EC1.increment_pulse, action=vjoy:get_button(39):value_setter()},
            {event=g1000.EC1.decrement_pulse, action=vjoy:get_button(40):value_setter()},
            {event=g1000.EC1P.change, action=vjoy:get_button(41):value_setter()},
            {event=g1000.EC2X.increment_pulse, action=vjoy:get_button(42):value_setter()},
            {event=g1000.EC2X.decrement_pulse, action=vjoy:get_button(43):value_setter()},
            {event=g1000.EC2Y.increment_pulse, action=vjoy:get_button(44):value_setter()},
            {event=g1000.EC2Y.decrement_pulse, action=vjoy:get_button(45):value_setter()},
            {event=g1000.EC2P.change, action=vjoy:get_button(46):value_setter()},
            {event=g1000.EC3.increment_pulse, action=vjoy:get_button(47):value_setter()},
            {event=g1000.EC3.decrement_pulse, action=vjoy:get_button(48):value_setter()},
            {event=g1000.EC3P.change, action=vjoy:get_button(49):value_setter()},
            {event=g1000.EC4X.increment_pulse, action=vjoy:get_button(50):value_setter()},
            {event=g1000.EC4X.decrement_pulse, action=vjoy:get_button(51):value_setter()},
            {event=g1000.EC4Y.increment_pulse, action=vjoy:get_button(52):value_setter()},
            {event=g1000.EC4Y.decrement_pulse, action=vjoy:get_button(53):value_setter()},
            {event=g1000.EC4P.change, action=vjoy:get_button(54):value_setter()},
            {event=g1000.EC5.increment_pulse, action=vjoy:get_button(55):value_setter()},
            {event=g1000.EC5.decrement_pulse, action=vjoy:get_button(56):value_setter()},
            {event=g1000.EC5P.change, action=vjoy:get_button(57):value_setter()},
            {event=g1000.EC6X.increment_pulse, action=vjoy:get_button(58):value_setter()},
            {event=g1000.EC6X.decrement_pulse, action=vjoy:get_button(59):value_setter()},
            {event=g1000.EC6Y.increment_pulse, action=vjoy:get_button(60):value_setter()},
            {event=g1000.EC6Y.decrement_pulse, action=vjoy:get_button(61):value_setter()},
            {event=g1000.EC6P.change, action=vjoy:get_button(62):value_setter()},
            {event=g1000.EC7X.increment_pulse, action=vjoy:get_button(63):value_setter()},
            {event=g1000.EC7X.decrement_pulse, action=vjoy:get_button(64):value_setter()},
            {event=g1000.EC7Y.increment_pulse, action=vjoy:get_button(65):value_setter()},
            {event=g1000.EC7Y.decrement_pulse, action=vjoy:get_button(66):value_setter()},
            {event=g1000.EC7P.change, action=vjoy:get_button(67):value_setter()},
            {event=g1000.EC8.increment_pulse, action=vjoy:get_button(68):value_setter()},
            {event=g1000.EC8.decrement_pulse, action=vjoy:get_button(69):value_setter()},
            {event=g1000.EC8P.change, action=vjoy:get_button(70):value_setter()},
            {event=g1000.EC8U.change, action=vjoy:get_button(71):value_setter()},
            {event=g1000.EC8D.change, action=vjoy:get_button(72):value_setter()},
            {event=g1000.EC8L.change, action=vjoy:get_button(73):value_setter()},
            {event=g1000.EC8R.change, action=vjoy:get_button(74):value_setter()},
            {event=g1000.EC9X.increment_pulse, action=vjoy:get_button(75):value_setter()},
            {event=g1000.EC9X.decrement_pulse, action=vjoy:get_button(76):value_setter()},
            {event=g1000.EC9Y.increment_pulse, action=vjoy:get_button(77):value_setter()},
            {event=g1000.EC9Y.decrement_pulse, action=vjoy:get_button(78):value_setter()},
            {event=g1000.EC9P.change, action=vjoy:get_button(79):value_setter()},
        }
    }

    return {
        move_next_view = function () end,
        move_previous_view = function () end,
        global_mappings = mappings,
        need_to_start_viewports = false,
    }
end

function module.stop()
    if module.device then
        module.device:close()
    end
    module.device = nil
    module.vjoy = nil
end

return module
