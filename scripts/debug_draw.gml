//debug-draw
if (player == 1 && debug_flag) {
	// draw_debug_text(x - 23, y - 64, string(x) + ", " + string(y));
	debug_draw_text(8, string(my_chains));
}

#define debug_draw_text(ySlot, text)
draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16 * ySlot), text);
