local context = {}

context.image = graphics.bitmap("assets/tbm930_buttons.png")

context.safety_button_size = {width = 244.302, height = 175.634}
context.warning = context.image:create_partial_bitmap(0, 0, context.safety_button_size.width, context.safety_button_size.height)
context.caution = context.image:create_partial_bitmap(246, 0, context.safety_button_size.width, context.safety_button_size.height)

context.lvl_indicator_size = {width = 82.352, height = 52.688}
context.lvl = context.image:create_partial_bitmap(492, 0, context.lvl_indicator_size.width, context.lvl_indicator_size.height)

context.xfr_indicator_size = {width = 218.903, height = 38.534}
context.xfr_left = context.image:create_partial_bitmap(494, 54, context.xfr_indicator_size.width, context.xfr_indicator_size.height)
context.xfr_right = context.image:create_partial_bitmap(494, 94, context.xfr_indicator_size.width, context.xfr_indicator_size.height)

context.button_indicator_size = {width = 7, height = 68}
context.button_indicator_dark = graphics.bitmap(context.button_indicator_size.width, context.button_indicator_size.height)
context.button_indicator_light = graphics.bitmap(context.button_indicator_size.width, context.button_indicator_size.height)
local rctx = graphics.rendering_context(context.button_indicator_dark)
rctx:set_brush(graphics.color(53, 53, 53))
rctx:fill_rectangle(0, 0, context.button_indicator_size.width, context.button_indicator_size.height)
rctx:finish_rendering()
rctx = graphics.rendering_context(context.button_indicator_light)
rctx:set_brush(graphics.color(222, 222, 222))
rctx:fill_rectangle(0, 0, context.button_indicator_size.width, context.button_indicator_size.height)
rctx:finish_rendering()

return context