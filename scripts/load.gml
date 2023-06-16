sprite_change_offset("idle", 23, 38);
sprite_change_offset("bighurt", 32, 62);
sprite_change_offset("hurt", 12, 36);
sprite_change_offset("crouch", 23, 38);
sprite_change_offset("walk", 12, 32);
sprite_change_offset("walkturn", 10, 38);
sprite_change_offset("dash", 10, 32);
sprite_change_offset("dashstart", 26, 42);
sprite_change_offset("dashstop", 26, 42);
sprite_change_offset("dashturn", 32, 62);

sprite_change_offset("jumpstart", 23, 30);
sprite_change_offset("jump", 14, 32);
sprite_change_offset("doublejump", 32, 62);
sprite_change_offset("walljump", 32, 62);
sprite_change_offset("pratfall", 32, 62);
sprite_change_offset("land", 32, 62);
sprite_change_offset("landinglag", 32, 62);

sprite_change_offset("parry", 32, 62);
sprite_change_offset("roll_forward", 64, 94);
sprite_change_offset("roll_backward", 64, 94);
sprite_change_offset("airdodge", 32, 62);
sprite_change_offset("waveland", 23, 29);
sprite_change_offset("tech", 32, 62);

sprite_change_offset("jab", 64, 94);
sprite_change_offset("dattack", 64, 94);
sprite_change_offset("ftilt", 32, 62);
sprite_change_offset("dtilt", 64, 94);
sprite_change_offset("utilt", 64, 94);
sprite_change_offset("nair", 64, 94);
sprite_change_offset("fair", 64, 94);
sprite_change_offset("bair", 64, 94);
sprite_change_offset("uair", 64, 94);
sprite_change_offset("dair", 64, 94);
sprite_change_offset("fstrong", 64, 94);
sprite_change_offset("ustrong", 64, 190);
sprite_change_offset("dstrong", 96, 94);
sprite_change_offset("nspecial", 64, 94);
sprite_change_offset("nspecial_beam_start", 64, 64);
sprite_change_offset("nspecial_beam_end", 64, 64);
sprite_change_offset("nspecial_beam_loop", 0, 64);
sprite_change_offset("nspecial_beam_fade", 0, 33);
sprite_change_offset("vfx_nspecial_fire", 100, 140);
sprite_change_offset("vfx_ftilt_destroy", 100, 140); // actually for nspecial, not ftilt
sprite_change_offset("fspecial", 64, 94);
sprite_change_offset("uspecial", 96, 126);
sprite_change_offset("dspecial", 64, 94);
sprite_change_offset("taunt", 64, 94);
sprite_change_offset("phone_open", 32, 64);

sprite_change_offset("plat", 64, 94);

sprite_change_offset("nspecial_proj", 64, 94);

sprite_change_offset("chain_link", 0, 2);
sprite_change_offset("chain_link2", 13, 2);
sprite_change_offset("duct_tape", sprite_get_width(sprite_get("duct_tape")) / 2, sprite_get_height(sprite_get("duct_tape")) / 2);
sprite_change_collision_mask( "duct_tape", false, 0, 0, 0, 0, 0, 0 );
