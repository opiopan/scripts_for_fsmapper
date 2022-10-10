local context = {
    afcs_view = require("tbm930/afcs"),
    g3000_view = require("tbm930/g3000"),
    tsc_view = require("tbm930/tsc"),
}

function context.start(config, aircraft)
    local display = config.simhid_g1000_display
    local scale = 1.0
    if config.debug then
        display = 1
        scale = 0.5
    end

    context.device = mapper.device{
        name = "SimHID G1000",
        type = "simhid",
        identifier = config.simhid_g1000_identifier,
        modifiers = {
            {class = "binary", modtype = "button"},
            {class = "relative", modtype = "incdec"},
        },
    }
    local g1000 = context.device.events

    local global_mappings = {}
    fs2020.mfwasm.add_observed_data(context.afcs_view.observed_data)
    global_mappings[#global_mappings + 1] = context.afcs_view.mappings
    context.afcs_view.init(context.device)
    fs2020.mfwasm.add_observed_data(context.g3000_view.observed_data)
    global_mappings[#global_mappings + 1] = context.g3000_view.mappings
    context.g3000_view.init(context.device)
    fs2020.mfwasm.add_observed_data(context.tsc_view.observed_data)
    global_mappings[#global_mappings + 1] = context.tsc_view.mappings
    context.tsc_view.init(context.device)
    
    local viewport_afcs = mapper.viewport{
        name = "TBM 930 AFCS Viewport",
        displayno = display,
        x = 0, y = 0,
        width = scale, height = 2 / 12 * scale,
        aspect_ratio = 16 / 2,
        horizontal_alignment = "center",
        vertical_alignment = "bottom",
    }
    viewport_afcs:register_view(context.afcs_view.create_view("TBM930 AFCS"))

    local viewport_main = mapper.viewport{
        name = "TBM 930 Main Viewport",
        displayno = display,
        x = 0, y = 2/ 12 * scale,
        width = scale, height = 10 / 12 * scale,
        aspect_ratio = 16 / 10,
        horizontal_alignment = "center",
        vertical_alignment = "top",
    }
    context.views = {
        viewport_main:register_view(context.g3000_view.create_view("G3000 PFD", 1)),
        viewport_main:register_view(context.g3000_view.create_view("G3000 MFD", 2)),
        viewport_main:register_view(context.tsc_view.create_view("G3000 TSC")),
    }

    context.current_view = 1
    local function change_view(d)
        context.current_view = context.current_view + d
        if context.current_view > #context.views then
            context.current_view = 1
        elseif context.current_view < 1 then
            context.current_view = #context.views
        end
        viewport_main:change_view(context.views[context.current_view])
    end

    viewport_main:set_mappings{
        {event=g1000.AUX1D.down, action=function () change_view(1) end},
        {event=g1000.AUX1U.down, action=function () change_view(-1) end},
        {event=g1000.AUX2D.down, action=function () change_view(1) end},
        {event=g1000.AUX2U.down, action=function () change_view(-1) end},
    }

    return {
        move_next_view = function () change_view(1) end,
        move_previous_view = function () change_view(-1) end,
        global_mappings = {},
        need_to_start_viewports = true,
    }
end

function context.stop()
    context.views = nil
    context.afcs_view.term()
    context.g3000_view.term()
    context.tsc_view.term()
    context.device:close()
    context.device = nil
    fs2020.mfwasm.clear_observed_data()
end

return context