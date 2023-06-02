// article 1 init

can_be_grounded = false;
ignores_walls = true;
owner_id = player_id;
tethered_id = hit_player_obj;
depth = min(owner_id, tethered_id) - 1;
chainLinkSprite = sprite_get("chain_link");

normalChainLength = player_id.DEFAULT_CHAIN_LENGTH;
maxChainLength = normalChainLength + player_id.DEFAULT_STRETCH_AMOUNT;
chainLinkWidth = sprite_get_width(chainLinkSprite) * .6;
numChainSegments = floor(normalChainLength / chainLinkWidth);
chainSegmentXs = array_create(numChainSegments);
chainSegmentYs = array_create(numChainSegments);