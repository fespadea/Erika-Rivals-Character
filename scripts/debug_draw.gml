//debug-draw
if (player == 1 && DEBUG_FLAG) {
    debug_draw_text(1, string(grav));
    debug_draw_text(2, string(vsp));
}

#define debug_draw_text(ySlot, text)
draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16 * ySlot), text);
