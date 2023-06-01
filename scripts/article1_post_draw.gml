x_dist = player_id.x - tethered_id.x;
abs_x_dist = abs(x_dist);
y_dist = owner_true_y - tethered_true_y;

if (point_distance(player_id.x, owner_true_y, tethered_id.x, tethered_true_y) >= chain_length) {
	return;
}

if (x_dist == 0) {
    // we divide by x_dist so we need a special case when its 0
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16), "lmao");
} else {
    target_val = power(sqrt(sqr(chain_length) - sqr(y_dist)) / abs_x_dist - 1, -0.5);
    guess = target_val / (2 * sqrt(6));
    error = error_calc(guess, target_val);
    for (i = 0; i < 4; i++) {
        guess -= error / error_calc_derivative(guess);
        error = error_calc(guess, target_val);
    }
    a = -guess * abs_x_dist;

    x_guess = -abs_x_dist / 2;
    target_y_dist = y_dist * -sign(x_dist);
    init_y_error = catenary_distance(x_guess, a, abs_x_dist, target_y_dist);
    y_error = init_y_error;

    for (i = 0; i < 3; i++) {
        x_guess -= y_error / catenary_distance_derivative(x_guess, a, abs_x_dist);
        y_error = catenary_distance(x_guess, a, abs_x_dist, target_y_dist);
    }

    left_x = x_dist < 0 ? player_id.x : tethered_id.x;
    right_x = x_dist < 0 ? tethered_id.x : player_id.x;
    left_y = x_dist < 0 ? owner_true_y : tethered_true_y;
    vertex_x = left_x - x_guess;
    vertex_y = left_y - catenary(x_guess, a) + a;

    start_x = left_x;
    target_arc_length = chain_length / chain_segments;

    for (i = 0; i < chain_segments; i++) {
        x_guess = start_x + x_dist / chain_segments;
        for (j = 0; j < 2; j++) {
            x_guess -= arclength_with_start_target(x_guess, a, vertex_x, start_x, target_arc_length) / arclength_derivative(x_guess, a, vertex_x);
        }
        if (x_guess > right_x) {
            x_guess = right_x;
        }
        left_y = catenary_with_offset(start_x, a, vertex_x, vertex_y);
        right_y = catenary_with_offset(x_guess, a, vertex_x, vertex_y);
        segment_angle = darctan2(right_y - left_y, -(x_guess - start_x)) + 180;
        draw_sprite_ext(sprite_get("chain_link"), 0, start_x, left_y, 1.2 * target_arc_length / 14, 1, segment_angle, c_white, 1);
        start_x = x_guess;
    }

    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16), string(a) + ", " + string(error) + ", " + string(point_distance(player_id.x, owner_true_y, tethered_id.x, tethered_true_y)));
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 64), string(y_error));
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 80), string(x_guess) + ", " + string(init_y_error));
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 96), string(x_dist) + ", " + string(target_y_dist));
}

#define cosh
value = argument[0];
return (exp(value) + exp(value * -1)) / 2;

#define sinh
value = argument[0];
return (exp(value) - exp(value * -1)) / 2;

#define tanh
value = argument[0];
return sinh(value) / cosh(value);

#define error_calc
guess = argument[0];
target = argument[1];
return power(2 * guess * sinh(1 / (2 * guess)) - 1, -0.5) - target;

#define error_calc_derivative
guess = argument[0];
return (1 / (2 * guess) * cosh(1 / (2 * guess)) - sinh(1 / (2 * guess))) * power(2 * guess * sinh(1 / (2 * guess)) - 1, -1.5);

#define catenary
x_coord = argument[0];
a_val = argument[1];
return a_val * cosh(x_coord / a_val);

#define catenary_with_offset
x_coord = argument[0];
a_val = argument[1];
x_offset = argument[2];
y_offset = argument[3];
return y_offset + a_val * cosh((x_coord - x_offset) / a_val) - a_val;

#define catenary_with_offset_derivative
x_coord = argument[0];
a_val = argument[1];
x_offset = argument[2];
return sinh((x_coord - x_offset) / a_val);

#define catenary_distance
x_coord = argument[0];
a_val = argument[1];
x_range = argument[2];
target = argument[3];
return catenary(x_coord, a_val) - catenary(x_coord + x_range, a_val) - target;

#define catenary_distance_derivative
x_coord = argument[0];
a_val = argument[1];
x_range = argument[2];
return sinh(x_coord / a_val) - sinh((x_range + x_coord) / a_val);

#define arclength
x_coord = argument[0];
a_val = argument[1];
x_offset = argument[2];
sqr_val = sqr(sinh((x_coord - x_offset) / a_val));
if (sqr_val < 0) {
    return -1;
}
return -a * sqrt(sqr_val + 1) * tanh((x_offset - x_coord) / a_val);

#define arclength_derivative
x_coord = argument[0];
a_val = argument[1];
x_offset = argument[2];
sqr_val = sqr(sinh((x_coord - x_offset) / a_val));
if (sqr_val < 0) {
    return -1;
}
return sqrt(sqr_val + 1);

#define arclength_with_start
x_coord = argument[0];
a_val = argument[1];
x_offset = argument[2];
x_start = argument[3];
return arclength(x_coord, a_val, x_offset) - arclength(x_start, a_val, x_offset);

#define arclength_with_start_target
x_coord = argument[0];
a_val = argument[1];
x_offset = argument[2];
x_start = argument[3];
target = argument[4];
return arclength(x_coord, a_val, x_offset) - arclength(x_start, a_val, x_offset) - target;