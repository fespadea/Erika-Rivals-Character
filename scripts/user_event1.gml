var x_dist = player_id.x - tethered_id.x;
var abs_x_dist = abs(x_dist);
var y_dist = owner_true_y - tethered_true_y;

if (x_dist == 0) {
    // we divide by x_dist so we need a special case when its 0
    print_debug("X positions are equal");
} else {
    var target_val = power(sqrt(sqr(chain_length) - sqr(y_dist)) / abs_x_dist - 1, -0.5);
    var guess = target_val / (2 * sqrt(6));
    if (guess < 0.05) {
        guess = 0.05;
    }
    var error = error_calc(guess, target_val);
    for (var i = 0; i < 3; i++) {
        guess -= error / error_calc_derivative(guess);
        error = error_calc(guess, target_val);
    }
    var a = -guess * abs_x_dist;
    if(abs(a) < 0.05) {
        exit; // we will get a sqrt negative number error because the vertex will be millions of units away from the players
    }

    var xv_guess = -abs_x_dist / 2;
    var target_y_dist = y_dist * -sign(x_dist);
    var init_y_error = catenary_distance(xv_guess, a, abs_x_dist, target_y_dist);
    var y_error = init_y_error;

    for (var i = 0; i < 3; i++) {
        xv_guess -= y_error / catenary_distance_derivative(xv_guess, a, abs_x_dist);
        y_error = catenary_distance(xv_guess, a, abs_x_dist, target_y_dist);
    }

    var left_x = x_dist < 0 ? player_id.x : tethered_id.x;
    var right_x = x_dist < 0 ? tethered_id.x : player_id.x;
    var left_vy = x_dist < 0 ? owner_true_y : tethered_true_y;
    var vertex_x = left_x - xv_guess;
    var vertex_y = left_vy - catenary(xv_guess, a) + a;

    var start_x = left_x;
    var target_arc_length = chain_length / chain_segments;

    end_iter = chain_segments - 1;
	chain_x_positions = array_create(chain_segments, 0);
	chain_y_positions = array_create(chain_segments, 0);
	chain_angles = array_create(chain_segments, 0);
    for (var i = 0; i < chain_segments; i++) {
        var start_arc = arclength(start_x, a, vertex_x);
        var new_arc = start_arc;
        var x_guess = start_x + target_arc_length / arclength_derivative(start_x, a, vertex_x);
        for (var j = 0; j < 2; j++) {
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
        var left_y = catenary_with_offset(start_x, a, vertex_x, vertex_y);
        var right_y = catenary_with_offset(x_guess, a, vertex_x, vertex_y);
        var segment_angle = darctan2(right_y - left_y, -(x_guess - start_x)) + 180;
		chain_x_positions[i] = start_x;
		chain_y_positions[i] = left_y;
		chain_angles[i] = segment_angle;
        start_x = x_guess;
    }
    start_x = right_x;
    for (var i = chain_segments - 1; i >= end_iter; i--) {
        var start_arc = arclength(start_x, a, vertex_x);
        var new_arc = start_arc;
        var x_guess = start_x - target_arc_length / arclength_derivative(start_x, a, vertex_x);
        for (var j= 0; j < 2; j++) {
            new_arc = arclength(x_guess, a, vertex_x);
            x_guess -= (new_arc - start_arc + target_arc_length) / arclength_derivative(x_guess, a, vertex_x);
        }
        if (x_guess < left_x) {
            x_guess = left_x;
        }
        var left_y = catenary_with_offset(x_guess, a, vertex_x, vertex_y);
        var right_y = catenary_with_offset(start_x, a, vertex_x, vertex_y);
        var segment_angle = darctan2(right_y - left_y, -(start_x - x_guess)) + 180;
		chain_x_positions[i] = start_x;
		chain_y_positions[i] = right_y;
		chain_angles[i] = segment_angle;
        start_x = x_guess;
    }
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
return -a_val * sqrt(sqr_val + 1) * tanh((x_offset - x_coord) / a_val);

#define arclength_derivative(x_coord, a_val, x_offset)
sqr_val = sqr(sinh((x_coord - x_offset) / a_val));
if (sqr_val + 1 < 0) {
    return -1;
}
return sqrt(sqr_val + 1);