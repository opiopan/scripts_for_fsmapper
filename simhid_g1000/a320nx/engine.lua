local view_width = 1084
local view_height = 1541

local assets = require("a320nx/assets")

--------------------------------------------------------------------------------------
-- create background image
--------------------------------------------------------------------------------------
local bg_image = graphics.bitmap(view_width, view_height)
local ctx = graphics.rendering_context(bg_image)
ctx:set_brush(graphics.color(80, 105, 123))
ctx:fill_rectangle(0, 0, view_width, view_height - view_width)
ctx:set_brush(graphics.color(40, 52, 61))
ctx:fill_rectangle(0, 0, 1.5, view_height)
ctx:fill_rectangle(view_width - 1.5, 0, 1.5, view_height)

--------------------------------------------------------------------------------------
-- view element definitions
--------------------------------------------------------------------------------------
local view_elements = {}
local global_mappings = {}

--------------------------------------------------------------------------------------
-- view definition generator
--------------------------------------------------------------------------------------
local function create_view_def(name, window)
    local elements = {}
    for i, element in ipairs(view_elements) do
        elements[#elements + 1] = element
    end
    elements[#elements + 1] = {
        object=window, x= 0, y=view_height - view_width, width=view_width, height=view_width + 2
    }

    return {
        name = name,
        logical_width = view_width, logical_height = view_height,
        background = bg_image,
        elements = elements,
        mappings = view_mappings,
    }
end

return {viewdef=create_view_def, observed_data=observed_data, mappings=global_mappings}