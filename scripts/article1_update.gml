if (point_distance(player_id.x, player_id.y, tethered_id.x, tethered_id.y) > chain_length) {
	instance_destroy(self);
}

/*if (init == 0) {
	hsp = lengthdir_x(player_id.up_b_speed, player_id.up_b_dir);
	vsp = lengthdir_y(player_id.up_b_speed, player_id.up_b_dir);
	var angle = player_id.up_b_dir;
	if (angle == 90 || angle == 270) {
		spr_dir = player_id.spr_dir;
		angle = (angle + 90 * (1 - spr_dir)) % 360;
	}
	if (angle > 90 && angle < 270) {
		angle = (180 + angle) % 360;
		spr_dir = -1;
	}
	image_angle = angle;

	if (x > stage_x && x < room_width - stage_x && y > stage_y) {
		spawned_in_floor = true;
	}
	
	for (i = 0; i < 6; i++) {
		var temp_x = 62 - player_id.hornet_x_offset + 8 * i;
		var temp_y = -60 + player_id.hornet_y_offset;
		var final_x = temp_x * dcos(angle * spr_dir) - temp_y * dsin(angle * spr_dir);
		var final_y = temp_x * dsin(angle * spr_dir) + temp_y * dcos(angle * spr_dir);
		var hitbox = create_hitbox(AT_USPECIAL, 1, x + round(final_x) * spr_dir, y - round(final_y));
		hitbox.hsp = hsp;
		hitbox.vsp = vsp;
		hitbox.kb_angle = angle;
		hitbox.hornet = self;
	}
	
	init = 1;
	sound_play(sound_get("hornet_yell_" + string(random_func(0, 2, true) + 1)));
	sprite_index = sprite_get("hornet");
	with (asset_get("obj_article1")){
		if (id != other.id && player_id == other.player_id){
			active = false;
		}
	}
}

if (x > stage_x && x < room_width - stage_x && y > stage_y && life_timer < spawn_grace_period) {
	spawned_in_floor = true;
}

life_timer++;
invalidation_timer += invalidating;

if (life_timer % 5 == 0) {
	image_index = (image_index + 1) % image_number;
}

if (player_id.state_cat == SC_HITSTUN) {
	active = false;
	keep_life = true;
}
if (player_id.state == PS_AIR_DODGE || player_id.state == PS_PARRY_START) {
	active = false;
	if (!keep_life) {
		invalidation_timer = wall_grace_period;
	}
}

if (grabbed == 0 && active) {
	if (hsp > 0 && vsp > 0 && (x >= player_x || y >= player_y)) {
		grabbed = 1;
		keep_life = true;
	}
	if (hsp < 0 && vsp > 0 && (x <= player_x || y >= player_y)) {
		grabbed = 1;
		keep_life = true;
	}
	if (hsp < 0 && vsp < 0 && (x <= player_x || y <= player_y)) {
		grabbed = 1;
		keep_life = true;
	}
	if (hsp > 0 && vsp < 0 && (x >= player_x || y <= player_y)) {
		grabbed = 1;
		keep_life = true;
	}
	if (hsp > 0 && vsp == 0 && x >= player_x) {
		grabbed = 1;
		keep_life = true;
	}
	if (hsp < 0 && vsp == 0 && x <= player_x) {
		grabbed = 1;
		keep_life = true;
	}
	if (hsp == 0 && vsp > 0 && y >= player_y) {
		grabbed = 1;
		keep_life = true;
	}
	if (hsp == 0 && vsp < 0 && y <= player_y) {
		grabbed = 1;
		keep_life = true;
	}
}

if (grabbed > 0 && player_id.window == 2 && active) {
	player_id.window = 3;
	player_id.window_timer = 0;
	player_id.x = x - player_id.up_b_knight_x_offset;
	player_id.hsp = hsp;
	player_id.y = y + player_id.up_b_knight_y_offset;
	player_id.vsp = vsp;
	active = false;
}

if ((y < -50 && vsp < 0) || (y > room_height + 50 && vsp > 0) || (x < -50 && hsp < 0) || (x > room_width + 50 && hsp > 0)) {
	with(asset_get("pHitBox")) {
		if (variable_instance_exists(self, "hornet") && hornet == other) {
			destroyed = true;
		}
	}
	instance_destroy();
	exit;
}

if (x > stage_x && x < room_width - stage_x && y > stage_y && !spawned_in_floor) {
	invalidating = 1;
}
else if (invalidation_timer < wall_grace_period) {
	invalidating = 0;
	invalidation_timer = 0;
}

if (invalidation_timer >= wall_grace_period && active) {
	active = false;
	if (player_id.window == 2) {
		player_id.window_timer = max(80 + invalidation_timer, player_id.window_timer);
	}
}

if (invalidation_timer >= wall_grace_period) {
	with (asset_get("pHitBox")) {
		if (variable_instance_exists(self, "hornet") && hornet == other) {
			destroyed = true;
		}
	}
	vsp++;
	image_angle = (darctan2(-vsp, hsp) + 90 * (1 - spr_dir)) % 360;
	//dumb case where hornet going straight up facing right and vsp is 0 so tan gets angry
	if (spr_dir = 1 && image_angle == -180) {
		image_angle = 0;
	}
}*/