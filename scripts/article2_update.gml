should_break = false;
with asset_get("oPlayer") {
    if (/*self != other.player_id && */place_meeting(x, y, other)) {
        if (state_cat == SC_HITSTUN) {
            other.should_break = true;
        } else if (!other.player_id.slowed_by_tape[player]) {
            other.player_id.slowed_by_tape[player] = true;
            x -= round(hsp * other.slow_factor);
            y -= round(vsp * other.slow_factor);
        }
    }
}
if (should_break) {
    print("x, y: (" + string(x) + ", " + string(y) + ")");
    create_hitbox(AT_DSPECIAL, 2, x, y);
    instance_destroy(other);
    exit;
}
