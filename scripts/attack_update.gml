//B - Reversals
switch(attack){
    case AT_NSPECIAL:
    case AT_FSPECIAL:
    case AT_DSPECIAL:
    case AT_USPECIAL:
        trigger_b_reverse();
        break;
}



// per-attack logic

switch(attack){
    
    // give your moves some "pop" by spawning dust during them!
    
    case AT_JAB:
        was_parried = false; // easy method for single-hit jabs
        if window == 3 && attack_pressed {
            window = 5;
            window_timer = 0;
        } else if window == 7 && attack_pressed && hitWithJab2 {
            window = 9;
            window_timer = 0;
        } else if window == 4 && window_timer == get_window_value(AT_JAB, 4, AG_WINDOW_LENGTH) - 1 {
            window = 11;
        } else if window == 8 && window_timer == get_window_value(AT_JAB, 8, AG_WINDOW_LENGTH) - 1 {
            window = 11;
        }
    case AT_FTILT:
    case AT_DTILT:
        if window == 1 && window_timer == phone_window_end{
            array_push(phone_dust_query, [x, y, "dash", spr_dir]);
        }
        break;
    case AT_UTILT:
        if window == 1 && window_timer == phone_window_end{
            array_push(phone_dust_query, [x, y, "dash", spr_dir]);
            array_push(phone_dust_query, [x, y, "dash", -spr_dir]);
        }
        break;
    case AT_FSTRONG:
        if window == 2 && window_timer == phone_window_end{
            array_push(phone_dust_query, [x, y, "dash_start", spr_dir]);
        }
        break;
    case AT_USTRONG:
        if window == 2 && window_timer == phone_window_end{
            array_push(phone_dust_query, [x, y, "dash_start", spr_dir]);
            array_push(phone_dust_query, [x, y, "dash_start", -spr_dir]);
        }
        break;
    
    
    
    case AT_NSPECIAL:
        switch(window){
            case 1: // startup
                beam_juice = 30; // amt of energy "left" in the beam
                beam_juice_max = 60 * 8;
                beam_length = 0; // current length of beam
                hsp = clamp(hsp, -2, 2);
                vsp = min(vsp, 3);
                can_fast_fall = false;
                has_updated_beam_kb = false;
                beam_clash_buddy = noone;
                beam_clash_timer = 0;
                beam_clash_timer_max = 120;
                break;
            case 2: // charge loop
                if window_timer == 1{
                    sound_play(sfx_dbfz_kame_charge, false, noone, 1, 1 + beam_juice * 0.001);
                }
                if beam_juice > 180{
                    shake_camera(floor((beam_juice - 180) / 30), 1);
                }
                if special_down && beam_juice < beam_juice_max{
                    beam_juice++;
                }
                else{
                    window++;
                    window_timer = 0;
                    
                    var can_angle = false;
                    
                    switch((right_down - left_down) * spr_dir){
                        default:
                            beam_angle = 30;
                            break;
                        case 1:
                            beam_angle = 15;
                            break;
                        case -1:
                            beam_angle = 45;
                            break;
                    }
                    beam_angle *= (up_down - down_down) * can_angle;
                    beam_angle = (beam_angle + 360) % 360;
                    beam_angle = point_direction(0, 0, lengthdir_x(1, beam_angle) * spr_dir, lengthdir_y(1, beam_angle));
                }
                hsp = clamp(hsp, -2, 2);
                vsp = min(vsp, 3);
                can_fast_fall = false;
                
                if window_timer == phone_window_end || window_timer == phone_window_end - 3|| window_timer == phone_window_end - 6{
                    array_push(phone_dust_query, [x - 20 * spr_dir + sin(window_timer + 2) * 6 * spr_dir, y, beam_juice > 300 ? "dash_start" : (beam_juice > 180 ? "dash" : "walk"), spr_dir]);
                }
                break;
            case 3: // post-charge
                hsp *= 0.75;
                vsp *= 0.75;
                can_move = false;
                can_fast_fall = false;
                was_fully_charged = (beam_juice >= beam_juice_max);
                if window_timer == phone_window_end{
                    spawn_nspecial_hitbox(1);
                    sound_play(sfx_dbfz_kame_fire);
                    array_push(phone_dust_query, [x, y, "dash_start", spr_dir]);
                    
                    var x1 = x + 72 * spr_dir;
                    var y1 = y - 24 + lengthdir_y(32, beam_angle);
                    
                    switch((abs(lengthdir_y(1, beam_angle)) > abs(lengthdir_y(1, 15))) * sign(lengthdir_y(1, beam_angle))){
                        case 1: // down
                            x1 = x + 74 * spr_dir;
                            y1 = y - 6;
                            break;
                        case -1: // up
                            x1 = x + 60 * spr_dir;
                            y1 = y - 72;
                            break;
                    }
                    
                    var h = spawn_hit_fx(x1, y1, vfx_nspecial_fire);
                    h.spr_dir = 1;
                    h.draw_angle = beam_angle;
                    h.depth = depth - 1;
                }
                break;
            case 5: // beam loop
                if beam_juice <= 0{
                    window++;
                    window_timer = 0;
                    spawn_nspecial_hitbox(2);
                }
                hsp = 0;
                vsp = 0;
                can_move = false;
                can_fast_fall = false;
                
                if window_timer % 2{
                    array_push(phone_dust_query, [x - 20 * spr_dir + sin(window_timer + 2) * 6 * spr_dir, y, "dash", spr_dir]);
                }
                shake_camera(1, 1);
            case 4: // beam overshoot
                if beam_clash_buddy != noone{
                    beam_clash_logic();
                }
                else if !was_fully_charged && !hitpause && (was_parried || has_hit || place_meeting(x + lengthdir_x(beam_length + 32, beam_angle), y + lengthdir_y(beam_length, beam_angle), asset_get("par_block"))){
                    if beam_juice > 0{
                        beam_juice -= 10;
                    }
                }
                else if !hitpause{
                    if beam_juice > 0{
                        beam_length += 32 + 64 * was_fully_charged;
                        beam_juice -= 10;
                    }
                }
                if window != 6{
                    spawn_nspecial_hitbox(1);
                    
                    if beam_clash_buddy == noone{
                        var me = self;
                        with oPlayer if "has_goku_beam" in self && doing_goku_beam && abs((me.beam_angle + 180) % 360 - beam_angle % 360) < 5 && instance_exists(beam_newest_hbox){
                            var him = self;
                            with beam_newest_hbox if distance_to_object(me.beam_newest_hbox) < (32 + 64 * (me.was_fully_charged || him.was_fully_charged)){
                                me.beam_clash_buddy = him;
                                him.beam_clash_buddy = me;
                                with me sound_play(sfx_dbfz_hit_broken);
                                me.beam_juice = max(me.beam_juice, 30);
                                him.beam_juice = max(him.beam_juice, 30);
                                me.beam_clash_timer_max = max(me.beam_clash_timer_max, him.beam_clash_timer_max);
                                him.beam_clash_timer_max = max(me.beam_clash_timer_max, him.beam_clash_timer_max);
                            }
                        }
                    }
                }
                
                hsp = 0;
                vsp = 0;
                can_move = false;
                can_fast_fall = false;
                shake_camera(4, 1);
                break;
            case 6: // last hit
                if beam_clash_buddy != noone{
                    beam_clash_logic();
                }
                else if window_timer == phone_window_end{
        
                    var x1 = x + 72 * spr_dir;
                    var y1 = y - 24 + lengthdir_y(32, beam_angle);
                    
                    switch((abs(lengthdir_y(1, beam_angle)) > abs(lengthdir_y(1, 15))) * sign(lengthdir_y(1, beam_angle))){
                        case 1: // down
                            x1 = x + 74 * spr_dir;
                            y1 = y - 6;
                            break;
                        case -1: // up
                            x1 = x + 60 * spr_dir;
                            y1 = y - 72;
                            break;
                    }
                    
                    var h = spawn_hit_fx(x1 + lengthdir_x(beam_length - 34, beam_angle), y1 + lengthdir_y(beam_length - 34, beam_angle), vfx_ftilt_destroy);
                    h.spr_dir = 1;
                    h.draw_angle = beam_angle;
                    h.depth = depth;
                }
                hsp = 0;
                vsp = 0;
                can_move = false;
                can_fast_fall = false;
                break;
            case 7: // endlag
                hsp = 0;
                vsp = 0;
                can_move = false;
                can_fast_fall = false;
                break;
        }
    break;
    
    
    
    case AT_FSPECIAL:
        can_move = false;
        can_fast_fall = false;
        switch(window){
            case 1:
                hsp *= 0.5;
                vsp *= 0.5;
                if window_timer == phone_window_end{
                    hsp = 35 * spr_dir;
                }
                break;
            case 2:
                vsp = 0;
                can_wall_jump = true;
                if (special_pressed){
                    window = 3;
                    window_timer = 0;
                    destroy_hitboxes();
                }
                break;
            case 3:
                hsp *= 0.5;
                // vsp *= 0.5;
                can_wall_jump = true;
                break;
        }
        break;
    
    
    
    case AT_USPECIAL:
        can_move = false;
        can_fast_fall = false;
        can_wall_jump = true;
        fall_through = true;
        switch(window){
            case 1: // startup
                hsp = 0;
                vsp = 0;
                if window_timer == phone_window_end{
                    vsp = -5;
                }
                break;
            case 2: // flight
                if (!joy_pad_idle){
                    hsp += lengthdir_x(1, joy_dir);
                    vsp += lengthdir_y(1, joy_dir);
                } else {
                    hsp *= .6;
                    vsp *= .6;
                }
                var fly_dir = point_direction(0,0,hsp,vsp);
                var fly_dist = point_distance(0,0,hsp,vsp);
                var max_speed = 10; // 12
                if (fly_dist > max_speed){
                    hsp = lengthdir_x(max_speed, fly_dir);
                    vsp = lengthdir_y(max_speed, fly_dir);
                }
                break;
            case 3: // atk startup
            case 4: // atk active
            case 5: // endlag
                hsp = 0;
                vsp = 0;
                break;
        }
        break;
    
    
    
    case AT_DSPECIAL:
        if (!hitpause && !was_parried && has_hit){
            can_jump = true;
        }
        can_fast_fall = false;
        can_move = false;
        if (window == 3 && window_timer == 15 && ds_list_size(my_tape) < MAX_TAPE) {
            var tape = instance_create(x, y, "obj_article2");
            ds_list_add(my_tape, tape);
        }
        break;
    
    
    
    case AT_TAUNT:
        if window_timer == 1{
            clear_button_buffer(PC_SHIELD_PRESSED);
        }
        if shield_pressed && window == 1 && window_timer < 16{
            attack_end();
            set_attack(AT_TAUNT_2);
        }
        break;
    
    
    
    case AT_TAUNT_2:
        if !(shield_down || taunt_down){
            attack_end();
            set_state(PS_IDLE);
        }
        if window_timer == phone_window_end - 32{
            spawn_hit_fx(x + 16 * spr_dir, y - 44, 113);
            sound_play(asset_get("mfx_star"));
        }
        if window_timer == phone_window_end - 4{
            spawn_hit_fx(x, y - 32, 143);
        }
        break;
}



#define beam_clash_logic

if !beam_clash_buddy.doing_goku_beam{
    beam_clash_buddy.beam_clash_buddy = noone;
    beam_clash_buddy = noone;
}
else{
    if beam_clash_timer >= beam_clash_timer_max{
        var winner = noone;
        if beam_length > beam_clash_buddy.beam_length{
            winner = self;
        }
        if beam_length < beam_clash_buddy.beam_length{
            winner = beam_clash_buddy;
        }
        if winner == self{
            window = 5;
            window_timer = 0;
        }
        else{
            beam_juice = 0;
        }
        if winner == beam_clash_buddy{
            
        }
        else{
            beam_clash_buddy.beam_juice = 0;
        }
    }
    else{
        beam_clash_timer++;
        if special_pressed{
            clear_button_buffer(PC_SPECIAL_PRESSED);
            beam_length += 32;
            beam_clash_buddy.beam_length -= 32;
            beam_juice = min(beam_juice + 20, beam_juice_max);
            beam_clash_buddy.beam_juice = max(beam_clash_buddy.beam_juice - 10, 10);
            sound_play(sfx_dbfz_kame_charge, false, noone, 1, 1 + beam_juice * 0.001);
        }
    }
}



#define spawn_nspecial_hitbox(num)

if hitpause && num == 1 return;

attack_end();

var x1 = 72;
var y1 = -20 + lengthdir_y(32, beam_angle);

switch((abs(lengthdir_y(1, beam_angle)) > abs(lengthdir_y(1, 15))) * sign(lengthdir_y(1, beam_angle))){
    case 1: // down
        x1 = 74;
        y1 = -6;
        break;
    case -1: // up
        x1 = 60;
        y1 = -72;
        break;
}

// x1 += lengthdir_x(beam_length - 32 * !has_hit, beam_angle) * spr_dir;
// y1 += lengthdir_y(beam_length - 32 * !has_hit, beam_angle);

var cur_x = x1;
var cur_y = y1;

set_hitbox_value(attack, num, HG_WIDTH, 64 + 16 * has_hit);
set_hitbox_value(attack, num, HG_HEIGHT, 64 + 16 * has_hit);

var ld_x = lengthdir_x(32, beam_angle) * spr_dir;
var ld_y = lengthdir_y(32, beam_angle);

for (var i = 0; i * 32 < beam_length && i < 32 && cur_x == clamp(cur_x, phone_blastzone_l, phone_blastzone_r); i++){
    if i % 3 == 0 || (i+1) * 32 >= beam_length{
        if (i+1) * 32 >= beam_length{
            set_hitbox_value(attack, num, HG_WIDTH, 64 + 64 * has_hit);
            set_hitbox_value(attack, num, HG_HEIGHT, 64 + 64 * has_hit);
        }
        beam_newest_hbox = create_hitbox(attack, num, round(x + cur_x * spr_dir), round(y + cur_y));
        beam_newest_hbox.x_pos = round(cur_x * spr_dir);
        beam_newest_hbox.y_pos = round(cur_y);
    }
    cur_x += ld_x;
    cur_y += ld_y;
}



#define spawn_base_dust // written by supersonic
/// spawn_base_dust(x, y, name, dir = 0)
///spawn_base_dust(x, y, name, ?dir)
//This function spawns base cast dusts. Names can be found below.
var dlen; //dust_length value
var dfx; //dust_fx value
var dfg; //fg_sprite value
var dfa = 0; //draw_angle value
var dust_color = 0;
var x = argument[0], y = argument[1], name = argument[2];
var dir = argument_count > 3 ? argument[3] : 0;

switch (name) {
    default: 
    case "dash_start":dlen = 21; dfx = 3; dfg = 2626; break;
    case "dash": dlen = 16; dfx = 4; dfg = 2656; break;
    case "jump": dlen = 12; dfx = 11; dfg = 2646; break;
    case "doublejump": 
    case "djump": dlen = 21; dfx = 2; dfg = 2624; break;
    case "walk": dlen = 12; dfx = 5; dfg = 2628; break;
    case "land": dlen = 24; dfx = 0; dfg = 2620; break;
    case "walljump": dlen = 24; dfx = 0; dfg = 2629; dfa = dir != 0 ? -90*dir : -90*spr_dir; break;
    case "n_wavedash": dlen = 24; dfx = 0; dfg = 2620; dust_color = 1; break;
    case "wavedash": dlen = 16; dfx = 4; dfg = 2656; dust_color = 1; break;
}
var newdust = spawn_dust_fx(x,y,asset_get("empty_sprite"),dlen);
if newdust == noone return noone;
newdust.dust_fx = dfx; //set the fx id
if dfg != -1 newdust.fg_sprite = dfg; //set the foreground sprite
newdust.dust_color = dust_color; //set the dust color
if dir != 0 newdust.spr_dir = dir; //set the spr_dir
newdust.draw_angle = dfa;
return newdust;


