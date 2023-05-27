muno_event_type = 6;
user_event(14);

var height_offset = round(sin(get_gameplay_time() / 8)) * 2;
var x_off = x + 110;
var y_off = y + 188 + height_offset;
var col = c_white;

// draw_rectangle_color(x_off, y_off - 2, x_off + 29, y_off + 27, col, col, col, col, false);
// draw_sprite_ext(sprite_get("_info_alert"), 0, x_off, y_off, 2, 2, 0, c_white, 1);

draw_sprite_ext(sprite_get("_info_outline"), 0, x_off-2, y_off-12-height_offset, 2, 2, 0, c_white, sin(get_gameplay_time() / 8) + 1);

// draw_debug_text(round(x+70), round(y+188 + height_offset), "!!! ->")
// draw_debug_text(round(x+70), round(y+186 + height_offset), "!!! ->")