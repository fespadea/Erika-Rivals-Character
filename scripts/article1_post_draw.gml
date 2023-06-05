for(var i = 0; i < chain_segments; i++) {
    draw_sprite_ext(i < end_iter ? chain_link_sprite : chain_link_sprite2, 0, chain_x_positions[i], chain_y_positions[i], 1.2 * chain_length / chain_segments / sprite_get_width(chain_link_sprite), 1, chain_angles[i], c_white, 1);
}

debug_draw_text(1, "p1: (" + string(player_id.x) + ", " + string(owner_true_y) + ")");
debug_draw_text(2, "p2: (" + string(tethered_id.x) + ", " + string(tethered_true_y) + ")");
debug_draw_text(3, "distance: " + string(point_distance(player_id.x, owner_true_y, tethered_id.x, tethered_true_y)));
// debug_draw_text(4, "a: " + string(a*100) + ", vertex: (" + string(vertex_x) + ", " + string(vertex_y) + ")");

#define debug_draw_text(ySlot, text)
if (debug_flag) {
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16 * ySlot), text);
}