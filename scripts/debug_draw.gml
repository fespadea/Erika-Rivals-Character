//debug-draw
if (player == 1 && debug_flag) {
	// debug_draw_text(1, something);
}

#define debug_draw_text(ySlot, text)
draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16 * ySlot), text);
