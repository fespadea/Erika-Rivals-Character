// article 1 update

if(owner_id.x > tethered_id.x){
    leftX = tethered_id.x;
    leftY = tethered_id.y - tethered_id.char_height / 2;
    rightX = owner_id.x;
    rightY = owner_id.y - owner_id.char_height / 2;
} else{
    leftX = owner_id.x;
    leftY = owner_id.y - owner_id.char_height / 2;
    rightX = tethered_id.x;
    rightY = tethered_id.y - tethered_id.char_height / 2;
}

dist = point_distance(leftX, leftY, rightX, rightY);
if(abs(rightX - leftX) < 1){
    var dir = sign(rightX - leftX);
    rightX = leftX + (dir == 0 ? 1 : dir);
}

if(dist < normalChainLength){ // calculate A and B in Ax^2 + Bx
    var calcArcResults = calcArc(leftX, leftY, rightX, rightY, normalChainLength);
    A = calcArcResults.A;
    B = calcArcResults.B;
    arcLength = normalChainLength;
} else if(dist < maxChainLength){
    A = 0;
    B = (rightY - leftY) / (rightX - leftX);
    arcLength = dist;
} else{
    with (player_id) {
        chain_ind = ds_list_find_index(my_chains, other);
        if (chain_ind >= 0) {
            ds_list_delete(my_chains, chain_ind);
        } else {
            print_debug("Chain to delete does not exist!");
        }
    }
    instance_destroy(self);
    exit;
}
xShift = leftX;
yShift = leftY;

var bezPoints = quadToBez(A, B, leftX, leftY, rightX, rightY, xShift);
if(dist < normalChainLength){
    var approximationFactor = 4;
    if(player_id.phone_fast){
        approximationFactor *= floor(stillLagging);
        approximationFactor = min(approximationFactor, normalChainLength);
    }
    var numMeasurements = ceil(normalChainLength/approximationFactor);
    var chainLengths = array_create(numMeasurements+1);
    for(var tIndex = 1; tIndex <= numMeasurements; tIndex++){
        position = bezPointToCart(bezPoints, tIndex/numMeasurements);
        chainLengths[tIndex] = sFunc2(position.x-xShift, A, B);
    }
    
    tIndex = 1;
    for(var chainIndex = 0; chainIndex < numChainSegments; chainIndex++){
        var chainLinkArcLength = arcLength / numChainSegments * (chainIndex + 0.5);
        while(chainLengths[tIndex] < chainLinkArcLength){
            tIndex++;
        }
        var overShootProportion = (chainLengths[tIndex]-chainLinkArcLength) / (chainLengths[tIndex]-chainLengths[tIndex-1]);
        var t = (tIndex-overShootProportion)/numMeasurements;
        var position = bezPointToCart(bezPoints, t);
        chainSegmentXs[chainIndex] = round(position.x);
        chainSegmentYs[chainIndex] = round(position.y);
        chainSegmentAngles[chainIndex] = calcAngle(chainSegmentXs[chainIndex], A, B, xShift);
    }
} else{
    for(var chainIndex = 0; chainIndex < numChainSegments; chainIndex++){
        var t = 1/numChainSegments * (chainIndex + 0.5);
        var position = bezPointToCart(bezPoints, t);
        chainSegmentXs[chainIndex] = round(position.x);
        chainSegmentYs[chainIndex] = round(position.y);
        chainSegmentAngles[chainIndex] = calcAngle(chainSegmentXs[chainIndex], A, B, xShift);
    }
}

if(player_id.phone_fast){
    if(player_id.fps_real < 60 && stillLagging < 201){
        stillLagging += 0.2;
    } else{
        stillLagging = floor(stillLagging);
    }
}

/* ////////////////////////////////////////////////////////////////////////////////////
    These functions are used to calculate the arc of the chain.
    Most of the code is adapted from the python code here: https://stackoverflow.com/questions/48486254/determine-parabola-with-given-arc-length-between-two-known-points
*/ ////////////////////////////////////////////////////////////////////////////////////
#define dIFunc(t)
return sqrt(1 + t * t);

#define IFunc(t)
var rt = sqrt(1 + t * t);
return 0.5 * (t * rt + ln(t + rt));

#define sFunc(a, x0, y0)
var u = y0/x0 + a*x0;
var l = y0/x0 - a*x0;
return 0.5 * (IFunc(u) - IFunc(l)) / a;

#define dsFunc(a, x0, y0)
var u = y0/x0 + a*x0;
var l = y0/x0 - a*x0;
return 0.5 * (a*x0*(dIFunc(u) + dIFunc(l)) + IFunc(l) - IFunc(u)) / (a*a);

#define findCoeff(x0, y0, s0)
var N = 10;
var EPSILON = 0.001;
if(player_id.phone_fast){
    N -= floor(stillLagging / 25);
}

var guess = y0/x0;
for(var i = 0; i < N; i++){
    if(guess == 0){
        guess = 0.0000001
    }
    var dguess = (sFunc(guess, x0, y0) - s0) / dsFunc(guess, x0, y0);
    guess -= dguess;
    if(abs(dguess) <= EPSILON)
        break;
}
var A = -abs(guess);
var B = y0/x0 - A*x0;

return {A: A, B: B};


#define calcArc(x0, y0, x1, y1, S)
return findCoeff(x1 - x0, y1 - y0, S);

#define quadToBez(A, B, leftX, leftY, rightX, rightY, xShift)
if(A == 0){
    return {A: {x: leftX, y: leftY}, B: "N/A", C: {x: rightX, y: rightY}};
}
var leftSlope = calcSlope(leftX, A, B, xShift);

var controlX = (leftX + rightX) / 2;
var controlY = leftSlope*(controlX - leftX) + leftY;

return {A: {x: leftX, y: leftY}, B: {x: controlX, y: controlY}, C: {x: rightX, y: rightY}};

#define bezPointToCart(bezPoints, t)
var xVal;
var yVal;
if(bezPoints.B == "N/A"){
    xVal = (1-t)*bezPoints.A.x + t*bezPoints.C.x;
    yVal = (1-t)*bezPoints.A.y + t*bezPoints.C.y;
} else{
    xVal = sqr(1-t)*bezPoints.A.x + 2*(1-t)*t*bezPoints.B.x + sqr(t)*bezPoints.C.x;
    yVal = sqr(1-t)*bezPoints.A.y + 2*(1-t)*t*bezPoints.B.y + sqr(t)*bezPoints.C.y;
}

return {x: xVal, y: yVal};

#define sFunc2(x0, a, b)
var u = 2 * a * x0 + b;
var l = b;
return 0.5 * (IFunc(u) - IFunc(l)) / a;


// functions to calculate angle at position on arc
#define calcSlope(x0, A, B, xShift)
return 2 * A * (x0 - xShift) + B;

#define calcAngle(x0, A, B, xShift)
var slope = -calcSlope(x0, A, B, xShift);
return darctan2(slope, 1);
