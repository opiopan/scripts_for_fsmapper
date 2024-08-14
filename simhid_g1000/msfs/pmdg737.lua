function start(config)
    local display = config.simhid_g1000_display
    local scale = 1
    if config.debug then
        display = 1
        scale = 0.5
    end


    local captured_windows = {
        cdu = mapper.view_elements.captured_window{name="B737 CDU"},
    }

    local global_mappings = {}

    local cdu_panel = require("pmdg737/cdu")
    msfs.mfwasm.add_observed_data(cdu_panel.observed_data)
    global_mappings[#global_mappings + 1] = cdu_panel.mappings

    local aratio = cdu_panel.width / cdu_panel.height
    local viewport = mapper.viewport{
        name = "PMDG 737 Viewport",
        displayno = display,
        x = 0, y = 0,
        width = scale * 0.5 * (aratio / (2 / 3)),
        height = scale,
        aspect_ratio = aratio,
    }

    local viewdef_cdu = cdu_panel.viewdef("cdu", captured_windows.cdu)

    local view_cdu = viewport:register_view(viewdef_cdu)

    return {
        move_next_view = function() end,
        move_previous_view = function () end,
        global_mappings = global_mappings,
        need_to_start_viewports = true,
    }
end

local function stop()
    msfs.mfwasm.clear_observed_data()
end

return {
    start = start,
    stop = stop,
}
