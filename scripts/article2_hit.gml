if (enemy_hitboxID.type != 2) {
    ds_list_remove(player_id.my_tape, self);
    instance_destroy();
    exit;
}
