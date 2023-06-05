owner_true_y = player_id.y - player_id.char_height / 2;
tethered_true_y = tethered_id.y - tethered_id.char_height / 2;
if (point_distance(player_id.x, owner_true_y, tethered_id.x, tethered_true_y) >= chain_length) {
	with (player_id) {
		chain_ind = ds_list_find_index(my_chains, other);
		if (chain_ind >= 0) {
			ds_list_delete(my_chains, chain_ind);
		} else {
			print_debug("Chain to delete does not exist!");
		}
	}
	instance_destroy(self);
    exit;
}
user_event(1);
