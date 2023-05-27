// press shield during taunt's startup!

set_attack_value(AT_TAUNT_2, AG_MUNO_ATTACK_MISC_ADD, "Access by pressing shield during startup.");

set_attack_value(AT_TAUNT_2, AG_SPRITE, sprite_get("idle"));
set_attack_value(AT_TAUNT_2, AG_NUM_WINDOWS, 1);
set_attack_value(AT_TAUNT_2, AG_HURTBOX_SPRITE, asset_get("ex_guy_hurt_box"));

set_window_value(AT_TAUNT_2, 1, AG_WINDOW_LENGTH, 90);
set_window_value(AT_TAUNT_2, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_TAUNT_2, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_TAUNT_2, 1, AG_WINDOW_SFX, asset_get("sfx_ell_uspecial_explode"));
set_window_value(AT_TAUNT_2, 1, AG_WINDOW_SFX_FRAME, 87);

set_num_hitboxes(AT_TAUNT_2, 1);

set_hitbox_value(AT_TAUNT_2, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_TAUNT_2, 1, HG_WINDOW, 1);
set_hitbox_value(AT_TAUNT_2, 1, HG_WINDOW_CREATION_FRAME, 88);
set_hitbox_value(AT_TAUNT_2, 1, HG_LIFETIME, 3);
set_hitbox_value(AT_TAUNT_2, 1, HG_HITBOX_Y, -32);
set_hitbox_value(AT_TAUNT_2, 1, HG_WIDTH, 128);
set_hitbox_value(AT_TAUNT_2, 1, HG_HEIGHT, 128);
set_hitbox_value(AT_TAUNT_2, 1, HG_PRIORITY, 1);
set_hitbox_value(AT_TAUNT_2, 1, HG_DAMAGE, 9);
set_hitbox_value(AT_TAUNT_2, 1, HG_EFFECT, 1);
set_hitbox_value(AT_TAUNT_2, 1, HG_ANGLE, 45);
set_hitbox_value(AT_TAUNT_2, 1, HG_ANGLE_FLIPPER, 3);
set_hitbox_value(AT_TAUNT_2, 1, HG_BASE_KNOCKBACK, 8);
set_hitbox_value(AT_TAUNT_2, 1, HG_KNOCKBACK_SCALING, 1.0);
set_hitbox_value(AT_TAUNT_2, 1, HG_BASE_HITPAUSE, 12);
set_hitbox_value(AT_TAUNT_2, 1, HG_HITPAUSE_SCALING, 0.7);
set_hitbox_value(AT_TAUNT_2, 1, HG_VISUAL_EFFECT, 148);
set_hitbox_value(AT_TAUNT_2, 1, HG_HIT_SFX, asset_get("sfx_blow_heavy1"));