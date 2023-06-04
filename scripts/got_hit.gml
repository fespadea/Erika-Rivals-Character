if (orig_knock >= chain_breaking_kb) {
    for (i = 0; i < ds_list_size(my_chains); i++) {
        instance_destroy(my_chains[| i]);
    }
    ds_list_clear(my_chains);
}