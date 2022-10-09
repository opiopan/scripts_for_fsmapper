local context = {}

context.bitmap = graphics.bitmap("assets/g3x_touch_buttons.png")
context.button_size = {width=125.189, height=88}
context.direct_to = context.bitmap:create_partial_bitmap(0, 0, context.button_size.width, context.button_size.height)
context.nrst = context.bitmap:create_partial_bitmap(126, 0, context.button_size.width, context.button_size.height)
context.menu = context.bitmap:create_partial_bitmap(252, 0, context.button_size.width, context.button_size.height)
context.back = context.bitmap:create_partial_bitmap(378, 0, context.button_size.width, context.button_size.height)

return context