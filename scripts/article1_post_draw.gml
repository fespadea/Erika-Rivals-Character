x_dist = player_id.x - tethered_id.x;
abs_x_dist = abs(x_dist);
y_dist = owner_true_y - tethered_true_y;

if (point_distance(player_id.x, owner_true_y, tethered_id.x, tethered_true_y) >= chain_length) {
	return;
}

if (x_dist == 0) {
    // we divide by x_dist so we need a special case when its 0
    debug_draw(1, "X positions are equal");
} else {
    target_val = power(sqrt(sqr(chain_length) - sqr(y_dist)) / abs_x_dist - 1, -0.5);
    guess = target_val / (2 * sqrt(6));
    if (guess < 0.05) {
        guess = 0.05;
    }
    error = error_calc(guess, target_val);
    for (i = 0; i < 3; i++) {
        guess -= error / error_calc_derivative(guess);
        error = error_calc(guess, target_val);
    }
    a = -guess * abs_x_dist;
    if(abs(a) < 0.05) {
        print_debug(a);
        return;
    }

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

    end_iter = chain_segments - 1;
    for (i = 0; i < chain_segments; i++) {
        start_arc = arclength(start_x, a, vertex_x);
        new_arc = start_arc;
        x_guess = start_x + target_arc_length / arclength_derivative(start_x, a, vertex_x);
        for (j = 0; j < 2; j++) {
            new_arc = arclength(x_guess, a, vertex_x);
            x_guess -= (new_arc - start_arc - target_arc_length) / arclength_derivative(x_guess, a, vertex_x);
        }
        if (x_guess > vertex_x) {
            end_iter = i;
            break;
        }
        if (x_guess > right_x) {
            x_guess = right_x;
        }
        left_y = catenary_with_offset(start_x, a, vertex_x, vertex_y);
        right_y = catenary_with_offset(x_guess, a, vertex_x, vertex_y);
        segment_angle = darctan2(right_y - left_y, -(x_guess - start_x)) + 180;
        draw_sprite_ext(chain_link_sprite, 0, start_x, left_y, 1.2 * target_arc_length / 14, 1, segment_angle, c_white, 1);
        start_x = x_guess;
    }
    start_x = right_x;
    for (i = chain_segments - 1; i >= end_iter; i--) {
        start_arc = arclength(start_x, a, vertex_x);
        new_arc = start_arc;
        x_guess = start_x - target_arc_length / arclength_derivative(start_x, a, vertex_x);
        for (j= 0; j < 2; j++) {
            new_arc = arclength(x_guess, a, vertex_x);
            x_guess -= (new_arc - start_arc + target_arc_length) / arclength_derivative(x_guess, a, vertex_x);
        }
        if (x_guess < left_x) {
            x_guess = left_x;
        }
        left_y = catenary_with_offset(x_guess, a, vertex_x, vertex_y);
        right_y = catenary_with_offset(start_x, a, vertex_x, vertex_y);
        segment_angle = darctan2(right_y - left_y, -(start_x - x_guess)) + 180;
        draw_sprite_ext(chain_link_sprite2, 0, start_x, right_y, 1.2 * target_arc_length / 14, 1, segment_angle, c_white, 1);
        start_x = x_guess;
    }

    debug_draw(1, "p1: (" + string(player_id.x) + ", " + string(owner_true_y) + ")");
    debug_draw(2, "p2: (" + string(tethered_id.x) + ", " + string(tethered_true_y) + ")");
    debug_draw(3, "distance: " + string(point_distance(player_id.x, owner_true_y, tethered_id.x, tethered_true_y)));
    debug_draw(4, "a: " + string(a*100) + ", vertex: (" + string(vertex_x) + ", " + string(vertex_y) + ")");
}

#define debug_draw(ySlot, text)
if (debug_flag) {
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16 * ySlot), text);
}

#define cosh(value)
return (exp(value) + exp(-value)) / 2;

#define sinh(value)
return (exp(value) - exp(-value)) / 2;

#define tanh(value)
return (exp(value * 2) - 1) / (exp(value * 2) + 1);

#define error_calc(guess, target)
return power(2 * guess * sinh(1 / (2 * guess)) - 1, -0.5) - target;

#define error_calc_derivative(guess)
return (1 / (2 * guess) * cosh(1 / (2 * guess)) - sinh(1 / (2 * guess))) * power(2 * guess * sinh(1 / (2 * guess)) - 1, -1.5);

#define catenary(x_coord, a_val)
return a_val * cosh(x_coord / a_val);

#define catenary_with_offset(x_coord, a_val, x_offset, y_offset)
return y_offset + a_val * cosh((x_coord - x_offset) / a_val) - a_val;

#define catenary_with_offset_derivative(x_coord, a_val, x_offset)
return sinh((x_coord - x_offset) / a_val);

#define catenary_distance(x_coord, a_val, x_range, target)
return catenary(x_coord, a_val) - catenary(x_coord + x_range, a_val) - target;

#define catenary_distance_derivative(x_coord, a_val, x_range)
return sinh(x_coord / a_val) - sinh((x_range + x_coord) / a_val);

#define arclength(x_coord, a_val, x_offset)
sqr_val = sqr(sinh((x_coord - x_offset) / a_val));
if (sqr_val + 1 < 0) {
    return -1;
}
return -a * sqrt(sqr_val + 1) * tanh((x_offset - x_coord) / a_val);

#define arclength_derivative(x_coord, a_val, x_offset)
sqr_val = sqr(sinh((x_coord - x_offset) / a_val));
if (sqr_val + 1 < 0) {
    return -1;
}
return sqrt(sqr_val + 1);