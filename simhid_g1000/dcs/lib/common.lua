common = {}

function common.instantiate(class, super, ...)
    local self = (super and super.new(...) or {})
    setmetatable(self, {__index = class})
    setmetatable(class, {__index = super})
    return self
end

function common.parse_indication(indication_text)
    local parsed_data = {}
    for key, value in indication_text:gmatch('-+\n([^\n]+)\n([^\n]*)\n') do
        parsed_data[key] = value
    end
    return parsed_data
end

return common
