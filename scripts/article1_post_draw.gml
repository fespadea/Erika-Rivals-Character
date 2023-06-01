x_dist = player_id.x - tethered_id.x;
abs_x_dist = abs(x_dist);
y_dist = player_id.y - tethered_id.y;

if (x_dist == 0) {
    // we divide by x_dist so we need a special case when its 0
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16), "lmao");
} else {
    target_val = power(sqrt(sqr(chain_length) - sqr(y_dist)) / abs_x_dist - 1, -0.5);
    guess = target_val / (2 * sqrt(6));
    error = error_calc(guess, target_val);
    for (i = 0; i < 2; i++) {
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
    left_y = x_dist < 0 ? player_id.y : tethered_id.y;
    vertex_x = left_x - x_guess;
    vertex_y = left_y - catenary(x_guess, a) + a;

    /*for (i = 0; i < 16; i++) {
        curr_x = ease_linear(left_x, right_x, i, 15);
        draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 112 - 16 * i), string(curr_x));
        draw_debug_text(floor(curr_x), floor(catenary_with_offset(curr_x, a, vertex_x, vertex_y)), ".");
    }*/

    /*curr_x = ease_linear(left_x, right_x, 1, 15);
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 112 - 16 * 1), string(curr_x));*/
    draw_debug_text(floor(ease_linear(left_x, right_x, 0, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 0, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 1, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 1, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 2, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 2, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 3, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 3, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 4, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 4, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 5, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 5, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 6, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 6, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 7, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 7, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 8, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 8, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 9, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 9, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 10, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 10, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 11, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 11, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 12, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 12, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 13, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 13, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 14, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 14, 15), a, vertex_x, vertex_y)), ".");
    draw_debug_text(floor(ease_linear(left_x, right_x, 15, 15)), floor(catenary_with_offset(ease_linear(left_x, right_x, 15, 15), a, vertex_x, vertex_y)), ".");


    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 16), string(a) + ", " + string(error) + ", " + string(point_distance(player_id.x, player_id.y, tethered_id.x, tethered_id.y)));
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 64), string(y_error));
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 80), string(x_guess) + ", " + string(init_y_error));
    draw_debug_text(floor(view_get_xview() + 16), floor(view_get_yview() + view_get_hview() - 96), string(x_dist) + ", " + string(target_y_dist));
}

#define cosh
value = argument[0];
return (exp(value) + exp(value * -1))/2;

#define sinh
value = argument[0];
return (exp(value) - exp(value * -1))/2;

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
return y_offset + a_val * cosh((x_coord - x_offset) / a_val);

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