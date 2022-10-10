local view_width = 1280
local view_height = 160

local context = {}
context.mappings = {}

--------------------------------------------------------------------------------------
-- initialize module
--------------------------------------------------------------------------------------
function context.init(g1000)
    context.g1000 = g1000.events
end

--------------------------------------------------------------------------------------
-- celan up module
--------------------------------------------------------------------------------------
function context.term()
    context.g1000 = nil
end

--------------------------------------------------------------------------------------
-- view definition generator
--------------------------------------------------------------------------------------
function context.create_view(name)
    local mappings = {}
    local view_elements = {}

    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.canvas{
            renderer = function () end,
        },
        x = 0, y = 0,
        width = 10, height = 10,
    }

    local view_definition = {
        name = name,
        elements = view_elements,
        logical_width = view_width,
        logical_height = view_height,
        mappings = mappings,
        background = graphics.color("black"),
    }

    return view_definition
end

--------------------------------------------------------------------------------------
-- return module context
--------------------------------------------------------------------------------------
return context
