//debug-draw
if (player == 1 && debug_flag) {
	debug_draw_text(5, string(slowed_by_tape));
	debug_draw_text(6, string(state_cat == SC_HITSTUN));
	debug_draw_text(7, string(hitstun));
	debug_draw_text(8, string(hitstun_full));
	debug_draw_text(9, string(x) + ", " + string(y));
	// draw_debug_text(x - 23, y - 64, string(x) + ", " + string(y));
	// debug_draw_text(8, string(my_chains));
}

#define debug_draw_text(ySlot, text)
draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16 * ySlot), text);
