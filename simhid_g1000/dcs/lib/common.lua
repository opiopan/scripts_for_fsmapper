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

function common.exported_instruments(path, unit)
    local env = {}
    setmetatable(env, {__index=_ENV})
    local chunk = loadfile(path, 'bt', env)
    chunk()
    if env.reconfigure_for_unit then
        env.reconfigure_for_unit(unit)
    end
    return env
end

return common
