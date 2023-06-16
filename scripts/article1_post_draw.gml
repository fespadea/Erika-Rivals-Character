// article 1 post draw

for(var chainIndex = 0; chainIndex < numChainSegments; chainIndex++){
    // shader_start();
    draw_sprite_ext(chainLinkSprite, 0, chainSegmentXs[chainIndex], chainSegmentYs[chainIndex], 1, -((chainIndex % 2)*2-1), chainSegmentAngles[chainIndex], c_white, 1);
    // shader_end();
}
