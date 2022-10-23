local module = {
    active_indicator_color = graphics.color(0, 254, 255, 0.36)
}

module.circle = graphics.path()
module.circle:add_figure{
    fill_mode = "winding", -- none | winding | alternate (default: none)
    from = {0, 0.5},
    segments = {
        {to = {0.5, 0}, radius = 0.5, direction="clockwise", arc_type="small"},
        {to = {1, 0.5}, radius = 0.5, direction="clockwise", arc_type="small"},
        {to = {0.5, 1}, radius = 0.5, direction="clockwise", arc_type="small"},
        {to = {0, 0.5}, radius = 0.5, direction="clockwise", arc_type="small"},
    }
}

function module.merge_array(target, source)
    for i, value in ipairs(source) do
        target[#target + 1] = value
    end
    return target
end

return module