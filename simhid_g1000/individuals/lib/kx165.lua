local module = {
    width = 1112,
    height = 339,
    type = {
        general = 1,
    },
}

local module_defs = {
    prefix = "KX165",
    activatable = true,
    options = {{}, {}},
    option_defaults = {
        type = module.type.general,
    },
}

local common = require("lib/common")
--------------------------------------------------------------------------------------
-- action definitions
--------------------------------------------------------------------------------------
module.actions = {}
module.actions[1] = {
    nav_knob_large_inc=fs2020.event_sender("NAV1_RADIO_WHOLE_INC"),
    nav_knob_large_dec=fs2020.event_sender("NAV1_RADIO_WHOLE_DEC"),
    nav_knob_small_inc=fs2020.event_sender("NAV1_RADIO_FRACT_INC"),
    nav_knob_small_dec=fs2020.event_sender("NAV1_RADIO_FRACT_DEC"),
    nav_swap=fs2020.event_sender("NAV1_RADIO_SWAP"),
    com_knob_large_inc=fs2020.event_sender("COM_RADIO_WHOLE_INC"),
    com_knob_large_dec=fs2020.event_sender("COM_RADIO_WHOLE_DEC"),
    com_knob_small_inc=fs2020.event_sender("COM_RADIO_FRACT_INC"),
    com_knob_small_dec=fs2020.event_sender("COM_RADIO_FRACT_DEC"),
    com_swap=fs2020.event_sender("COM1_RADIO_SWAP"),
}
module.actions[2] = {
    nav_knob_large_inc=fs2020.event_sender("NAV2_RADIO_WHOLE_INC"),
    nav_knob_large_dec=fs2020.event_sender("NAV2_RADIO_WHOLE_DEC"),
    nav_knob_small_inc=fs2020.event_sender("NAV2_RADIO_FRACT_INC"),
    nav_knob_small_dec=fs2020.event_sender("NAV2_RADIO_FRACT_DEC"),
    nav_swap=fs2020.event_sender("NAV2_RADIO_SWAP"),
    com_knob_large_inc=fs2020.event_sender("COM2_RADIO_WHOLE_INC"),
    com_knob_large_dec=fs2020.event_sender("COM2_RADIO_WHOLE_DEC"),
    com_knob_small_inc=fs2020.event_sender("COM2_RADIO_FRACT_INC"),
    com_knob_small_dec=fs2020.event_sender("COM2_RADIO_FRACT_DEC"),
    com_swap=fs2020.event_sender("COM2_RADIO_SWAP"),
}

--------------------------------------------------------------------------------------
-- operable are definitions
--------------------------------------------------------------------------------------
local attr_swap = {width=58.022, height=37.177, rratio=0.05}
module_defs.operables = {}
module_defs.operables[module.type.general] = {
    com_swap = {x=211.434, y=170.849, attr=attr_swap},
    nav_swap = {x=772.932, y=170.849, attr=attr_swap},
}

--------------------------------------------------------------------------------------
-- active indicator difinitions
--------------------------------------------------------------------------------------
module_defs.active_indicators= {}
module_defs.active_indicators[module.type.general] = {
    {x=346.37, y=182.204, width=108.551, height=108.551},
    {x=914.382, y=182.204, width=108.551, height=108.551},
}

--------------------------------------------------------------------------------------
-- virtual NAVCOM implementation
--------------------------------------------------------------------------------------
local navcom = {
    {power=0, nav=0, nav_stby=0, com=0, com_stby=0},
    {power=0, nav=0, nav_stby=0, com=0, com_stby=0},
}

local function set_canvas_value(canvases, value)
    for i, canvas in pairs(canvases) do
        canvas.value = value
    end
end

local function update_navcom (self)
    set_canvas_value(self.canvases.nav_active, self.power * self.nav)
    set_canvas_value(self.canvases.nav_standby, self.power * self.nav_stby)
    set_canvas_value(self.canvases.com_active, self.power * self.com)
    set_canvas_value(self.canvases.com_standby, self.power * self.com_stby)
end
navcom[1].update = update_navcom
navcom[2].update = update_navcom

module_defs.reactions = {}
module_defs.reactions[module.type.general] = {}
module_defs.reactions[module.type.general][1] = {
    com_power = {rpn="(A:COM STATUS:1, Enum) 0 == if{ 1 } els{ 0 }", action=function (value) navcom[1].power=value; navcom[1]:update() end},
    com_active = {rpn="(A:COM ACTIVE FREQUENCY:1, Megahertz)", action=function (value) navcom[1].com=value; set_canvas_value(navcom[1].canvases.com_active, value*navcom[1].power) end},
    com_standby = {rpn="(A:COM STANDBY FREQUENCY:1, Megahertz)", action=function (value) navcom[1].com_stby=value; set_canvas_value(navcom[1].canvases.com_standby, value*navcom[1].power) end},
    nav_active = {rpn="(A:NAV ACTIVE FREQUENCY:1, Megahertz)", action=function (value) navcom[1].nav=value; set_canvas_value(navcom[1].canvases.nav_active, value*navcom[1].power) end},
    nav_standby = {rpn="(A:NAV STANDBY FREQUENCY:1, Megahertz)", action=function (value) navcom[1].nav_stby=value; set_canvas_value(navcom[1].canvases.nav_standby, value*navcom[1].power) end},
}
module_defs.reactions[module.type.general][2] = {
    com_power = {rpn="(A:COM STATUS:2, Enum) 0 == if{ 1 } els{ 0 }", action=function (value) navcom[2].power=value; navcom[2]:update() end},
    com_active = {rpn="(A:COM ACTIVE FREQUENCY:2, Megahertz)", action=function (value) navcom[2].com=value; set_canvas_value(navcom[2].canvases.com_active, value*navcom[2].power) end},
    com_standby = {rpn="(A:COM STANDBY FREQUENCY:2, Megahertz)", action=function (value) navcom[2].com_stby=value; set_canvas_value(navcom[2].canvases.com_standby, value*navcom[2].power) end},
    nav_active = {rpn="(A:NAV ACTIVE FREQUENCY:2, Megahertz)", action=function (value) navcom[2].nav=value; set_canvas_value(navcom[2].canvases.nav_active, value*navcom[2].power) end},
    nav_standby = {rpn="(A:NAV STANDBY FREQUENCY:2, Megahertz)", action=function (value) navcom[2].nav_stby=value; set_canvas_value(navcom[2].canvases.nav_standby, value*navcom[2].power) end},
}

--------------------------------------------------------------------------------------
-- indicator definitions
--------------------------------------------------------------------------------------
local segdisp = require("lib/segdisp")
local seg_font_attr = {width=43.334, height=48.284}
local seg_font = segdisp.create_font{type=segdisp.seg7_type1, width=seg_font_attr.width, height=seg_font_attr.height, color=graphics.color(248, 87, 43)}
local attr_indicator = {width=seg_font_attr.width * 6, height=seg_font_attr.height}
local function com_renderer(rctx, value)
    if value > 0 then
        rctx.font = seg_font
        rctx:draw_number{
            value = value,
            precision = 6,
            fraction_precision = 3,
            leading_zero = false
        }
    end
end
local function nav_renderer(rctx, value)
    if value > 0 then
        rctx.font = seg_font
        rctx:draw_number{
            value = value,
            precision = 6,
            fraction_precision = 2,
            leading_zero = false
        }
    end
end
module_defs.indicators ={}
module_defs.indicators[module.type.general] = {}
module_defs.indicators[module.type.general][1]= {
    com_active = {x=18.303, y=33.696, attr=attr_indicator, renderer=com_renderer, pin=navcom[1]},
    com_standby = {x=285.003, y=33.696, attr=attr_indicator, renderer=com_renderer, pin=navcom[1]},
    nav_active = {x=576.973, y=33.696, attr=attr_indicator, renderer=nav_renderer, pin=navcom[1]},
    nav_standby = {x=843.673, y=33.696, attr=attr_indicator, renderer=nav_renderer, pin=navcom[1]},
}
module_defs.indicators[module.type.general][2]= {
    com_active = {x=18.303, y=33.696, attr=attr_indicator, renderer=com_renderer, pin=navcom[2]},
    com_standby = {x=285.003, y=33.696, attr=attr_indicator, renderer=com_renderer, pin=navcom[2]},
    nav_active = {x=576.973, y=33.696, attr=attr_indicator, renderer=nav_renderer, pin=navcom[2]},
    nav_standby = {x=843.673, y=33.696, attr=attr_indicator, renderer=nav_renderer, pin=navcom[2]},
}

--------------------------------------------------------------------------------------
-- prepare module scope environment
--------------------------------------------------------------------------------------
common.component_module_init(module, module_defs, true)

--------------------------------------------------------------------------------------
-- instance generator
--------------------------------------------------------------------------------------
function module.create_component(component_name, id, captured_window, x, y, scale, rctx, simhid_g1000)
    local component = common.component_module_create_instance(module, module_defs,{
        name = component_name,
        id = id,
        captured_window = captured_window,
        x = x, y = y, scale = scale,
        simhid_g1000 = simhid_g1000
    })

    -- update view background bitmap
    local background = graphics.bitmap("assets/kx165.png")
    rctx:draw_bitmap{bitmap=background, x=x, y=y, scale=scale}

    -- Event-Action mappings which are enabled when the component is activated
    if simhid_g1000 then
        local g1000 = simhid_g1000.events
        component.component_mappings = {
            {event=g1000.EC2Y.increment, action=module.actions[id].nav_knob_large_inc},
            {event=g1000.EC2Y.decrement, action=module.actions[id].nav_knob_large_dec},
            {event=g1000.EC2X.increment, action=module.actions[id].nav_knob_small_inc},
            {event=g1000.EC2X.decrement, action=module.actions[id].nav_knob_small_dec},
            {event=g1000.SW1.down, action=module.actions[id].nav_swap},
            {event=g1000.EC6Y.increment, action=module.actions[id].com_knob_large_inc},
            {event=g1000.EC6Y.decrement, action=module.actions[id].com_knob_large_dec},
            {event=g1000.EC6X.increment, action=module.actions[id].com_knob_small_inc},
            {event=g1000.EC6X.decrement, action=module.actions[id].com_knob_small_dec},
            {event=g1000.SW26.down, action=module.actions[id].com_swap},
        }
    end
    
    return component
end

return module