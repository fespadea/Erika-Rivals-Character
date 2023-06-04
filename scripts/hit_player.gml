// code for kamehameha

if my_hitboxID.attack == AT_NSPECIAL && !has_updated_beam_kb{
	has_updated_beam_kb = true;
	set_hitbox_value(AT_NSPECIAL, 2, HG_BASE_KNOCKBACK, lerp(7, 12, beam_juice / beam_juice_max));
	set_hitbox_value(AT_NSPECIAL, 2, HG_KNOCKBACK_SCALING, lerp(0.5, 1.6, beam_juice / beam_juice_max));
	set_hitbox_value(AT_NSPECIAL, 2, HG_BASE_HITPAUSE, lerp(8, 20, beam_juice / beam_juice_max));
	set_hitbox_value(AT_NSPECIAL, 2, HG_HITPAUSE_SCALING, lerp(0.5, 1.5, beam_juice / beam_juice_max));
	set_hitbox_value(AT_NSPECIAL, 2, HG_DAMAGE, lerp(2, 22, beam_juice / beam_juice_max));
	set_hitbox_value(AT_NSPECIAL, 2, HG_ANGLE, round(lerp(55, 35, beam_juice / beam_juice_max)));
}

if my_hitboxID.attack == AT_NSPECIAL && my_hitboxID.hbox_num == 2 && my_hitboxID.hitpause > 15{
	sound_play(sfx_dbfz_hit_broken);
}

if my_hitboxID.attack == AT_FSPECIAL {
	for (i = 0; i < ds_list_size(my_chains); i++) {
		curr_chain = my_chains[| i];
		if (curr_chain.tethered_id == hit_player_obj) {
			return;
		}
	}
	new_chain = instance_create(x, y, "obj_article1");
	ds_list_add(my_chains, new_chain);
	new_chain.tethered_id = hit_player_obj;
	new_chain.owner_true_y = y - char_height / 2;
	new_chain.tethered_true_y = hit_player_obj.y - hit_player_obj.char_height / 2;
}