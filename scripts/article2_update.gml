var should_break = false;
with asset_get("oPlayer") {
    if (self != other.player_id && place_meeting(x, y, other)) {
        if (state_cat == SC_HITSTUN) {
            // nested if instead of and because we don't want to slow while they are in hitstun
            if (collision_rectangle(other.x - other.width_proportion / 2, other.y - other.height_proportion / 2, other.x + other.width_proportion / 2, other.y + other.height_proportion / 2, self, true, false)) {
                should_break = true;
                set_state(PS_WRAPPED);
                wrap_time = other.stun_time;
            }
        } else if (!other.player_id.slowed_by_tape[player]) {
            other.player_id.slowed_by_tape[player] = true;
            x -= round(hsp * other.slow_factor);
            y -= round(vsp * other.slow_factor);
        }
    }
}
if (should_break) {
    ds_list_remove(player_id.my_tape, self);
    instance_destroy();
    exit;
}
