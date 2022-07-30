local context = {
    width = 1344,
    display_height = 983,
    menu_height = 48,
}
context.height = context.display_height + context.menu_height
context.aspect_ratio = context.width / context.height

--------------------------------------------------------------------------------------
-- define event-action mappings
--------------------------------------------------------------------------------------
local view_mappings = {
}

local global_mappings = {
}

--------------------------------------------------------------------------------------
-- define data to observe
--------------------------------------------------------------------------------------
local observed_data = {
}

--------------------------------------------------------------------------------------
-- function to generate definition of view elements
--------------------------------------------------------------------------------------
function context.gen_view_elements(x, y, width, height, captured_window)
    local elements = {}

    elements[#elements + 1] = {
        object = captured_window,
        x = x, y = y,
        width = width, height = height * (context.display_height / context.height),
    }

    return {
        elements = elements,
        view_mappings = view_mappings,
        global_mappings = global_mappings,
        observed_data = observed_data,
    }
end

--------------------------------------------------------------------------------------
-- function to generate event-action mappings correnspond to SimHID G1000
--------------------------------------------------------------------------------------
function context.gen_mappings_for_g1000(events)
    return {
        {event=events.SW31.down, action=fs2020.event_sender("Mobiflight.AS530_CLR_Push")},
        {event=events.SW31.longpressed, action=fs2020.event_sender("Mobiflight.AS530_CLR_Push_Long")},
        {event=events.SW26.down, action=fs2020.event_sender("Mobiflight.AS530_COMSWAP_Push")},
        {event=events.SW27.down, action=fs2020.event_sender("Mobiflight.AS530_DirectTo_Push")},
        {event=events.SW32.down, action=fs2020.event_sender("Mobiflight.AS530_ENT_Push")},
        {event=events.SW23.down, action=fs2020.event_sender("Mobiflight.AS530_FPL_Push")},
        {event=events.SW29.down, action=fs2020.event_sender("Mobiflight.AS530_FPL_Push")},
        {event=events.EC2Y.decrement, action=fs2020.event_sender("Mobiflight.AS530_LeftLargeKnob_Left")},
        {event=events.EC2Y.increment, action=fs2020.event_sender("Mobiflight.AS530_LeftLargeKnob_Right")},
        {event=events.EC2X.decrement, action=fs2020.event_sender("Mobiflight.AS530_LeftSmallKnob_Left")},
        {event=events.EC2X.increment, action=fs2020.event_sender("Mobiflight.AS530_LeftSmallKnob_Right")},
        {event=events.EC2P.down, action=fs2020.event_sender("Mobiflight.AS530_LeftSmallKnob_Push")},
        {event=events.SW28.down, action=fs2020.event_sender("Mobiflight.AS530_MENU_Push")},
        {event=events.SW22.down, action=fs2020.event_sender("Mobiflight.AS530_MSG_Push")},
        {event=events.SW1.down, action=fs2020.event_sender("Mobiflight.AS530_NAVSWAP_Push")},
        {event=events.SW21.down, action=fs2020.event_sender("Mobiflight.AS530_OBS_Push")},
        {event=events.SW25.down, action=fs2020.event_sender("Mobiflight.AS530_PROC_Push")},
        {event=events.SW30.down, action=fs2020.event_sender("Mobiflight.AS530_PROC_Push")},
        {event=events.EC8.increment, action=fs2020.event_sender("Mobiflight.AS530_RNG_Dezoom")},
        {event=events.EC8.decrement, action=fs2020.event_sender("Mobiflight.AS530_RNG_Zoom")},
        {event=events.EC9Y.decrement, action=fs2020.event_sender("Mobiflight.AS530_RightLargeKnob_Left")},
        {event=events.EC9Y.increment, action=fs2020.event_sender("Mobiflight.AS530_RightLargeKnob_Right")},
        {event=events.EC9X.decrement, action=fs2020.event_sender("Mobiflight.AS530_RightSmallKnob_Left")},
        {event=events.EC9X.increment, action=fs2020.event_sender("Mobiflight.AS530_RightSmallKnob_Right")},
        {event=events.EC9P.down, action=fs2020.event_sender("Mobiflight.AS530_RightSmallKnob_Push")},
        {event=events.SW24.down, action=fs2020.event_sender("Mobiflight.AS530_VNAV_Push")},
        {event=events.SW24.down, action=fs2020.event_sender("Mobiflight.AS530_VNAV_Push")},
    }
end

--------------------------------------------------------------------------------------
-- return module object
--------------------------------------------------------------------------------------
return context
