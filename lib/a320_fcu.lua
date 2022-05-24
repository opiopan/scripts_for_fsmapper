local view_width = 1084
local view_height = 1541 - view_width
local panel_height = 370

--------------------------------------------------------------------------------------
-- create background image
--------------------------------------------------------------------------------------
local bg_image = graphics.bitmap(view_width, view_height)
local ctx = graphics.rendering_context(bg_image)
ctx:set_brush(graphics.color(80, 105, 123))
ctx:fill_rectangle(0, view_height - panel_height, view_width, panel_height)
ctx:finish_rendering()

--------------------------------------------------------------------------------------
-- view definition generator
--------------------------------------------------------------------------------------
local function create_view_def(name, window)
    local elements = {}
    elements[#elements + 1] = {
        object=window, x= 0, y=0, width=view_width, height=view_width
    }

    return {
        name = name,
        logical_width = view_width,
        logical_height = view_height,
        background = bg_image,
        elements = elements,
        -- mappings = view_mappings,
    }
end

return {viewdef=create_view_def}