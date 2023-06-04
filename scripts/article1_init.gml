can_be_grounded = false;
ignores_walls = true;
with (player_id) {
    other.tethered_id = hit_player_obj;
}
owner_true_y = player_id.y - player_id.char_height / 2;
tethered_true_y = tethered_id.y - tethered_id.char_height / 2;
chain_length = player_id.chain_length * 16;
chain_segments = player_id.chain_segments;
chain_link_sprite = sprite_get("chain_link");
chain_link_sprite2 = sprite_get("chain_link2");
debug_flag = player_id.debug_flag;