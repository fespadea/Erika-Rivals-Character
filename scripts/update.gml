// MunoPhone Touch code - don't touch
// should be at TOP of file
muno_event_type = 1;
user_event(14);

doing_goku_beam = (phone_attacking && attack == AT_NSPECIAL && window == clamp(window, 4, 6));

if phone_cheats[CHEAT_FLY] && !shield_down vsp = -1;

// for (var i = 0; i < array_length(slowed_by_tape); i++) {
//     slowed_by_tape[@i] = false;
// }
with oPlayer{
    erikaTapeSlowed = false;
}
