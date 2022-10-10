local view_width = 1280
local view_height = 800

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
function context.create_view(name, num)
    local mappings = {}
    local view_elements = {}
    for i = 1, 12 do
        mappings[#mappings + 1] = {
            event = context.g1000["SW" .. 13 + i].down,
            action = fs2020.mfwasm.rpn_executer("(>H:AS3000_PFD_" .. num .. "_SOFTKEYS_" .. i .. ")")
        }
    end
    view_elements[#view_elements + 1] = {
        object = mapper.view_elements.captured_window{name=name},
        x = 0, y = 0,
        width = view_width, height = view_height
    }

    local view_definition = {
        name = name,
        elements = view_elements,
        logical_width = view_width,
        logical_height = view_height,
        mappings = mappings,
    }

    return view_definition
end

--------------------------------------------------------------------------------------
-- return module context
--------------------------------------------------------------------------------------
return context
