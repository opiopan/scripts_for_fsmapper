local context = {}

context.bitmap = graphics.bitmap("assets/g3x_touch_buttons.png")

context.button_size = {width=125.189, height=88}
context.direct_to = context.bitmap:create_partial_bitmap(0, 0, context.button_size.width, context.button_size.height)
context.nrst = context.bitmap:create_partial_bitmap(126, 0, context.button_size.width, context.button_size.height)
context.menu = context.bitmap:create_partial_bitmap(252, 0, context.button_size.width, context.button_size.height)
context.back = context.bitmap:create_partial_bitmap(378, 0, context.button_size.width, context.button_size.height)

context.gmc307_button_size = {width=122, height=83.266}
context.ap = context.bitmap:create_partial_bitmap(504, 0, context.gmc307_button_size.width, context.gmc307_button_size.height)
context.lvl = context.bitmap:create_partial_bitmap(627, 0, context.gmc307_button_size.width, context.gmc307_button_size.height)

context.kingair_caution_size = {width=151.098, height=108.647}
context.kingair_warn_fire = context.bitmap:create_partial_bitmap(0, 89, context.kingair_caution_size.width, context.kingair_caution_size.height)
context.kingair_master_caution = context.bitmap:create_partial_bitmap(153, 89, context.kingair_caution_size.width, context.kingair_caution_size.height)

context.kingair_button_size = {width=95.713, height=71.719}
context.kingair_button = context.bitmap:create_partial_bitmap(310.287, 95, context.kingair_button_size.width, context.kingair_button_size.height)

return context