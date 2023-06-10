// article 1 init

can_be_grounded = false;
ignores_walls = true;
uses_shader = true;
owner_id = player_id;
tethered_id = player_id.hit_player_obj;
depth = min(owner_id.depth, tethered_id.depth) - 1;
chainLinkSprite = sprite_get("chain_link");

normalChainLength = player_id.DEFAULT_CHAIN_LENGTH;
maxChainLength = normalChainLength + player_id.DEFAULT_STRETCH_AMOUNT;
adjustedChainSpriteWidth = sprite_get_width(chainLinkSprite) - 3;
numChainSegments = ceil(maxChainLength / adjustedChainSpriteWidth);
chainSegmentXs = array_create(numChainSegments);
chainSegmentYs = array_create(numChainSegments);
chainSegmentAngles = array_create(numChainSegments);

// for detecting if the chain needs to be simpler
stillLagging = 1;
