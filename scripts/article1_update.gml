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
if(abs(rightX - leftX) < 0.01){
    rightX = leftX + 0.01*sign(rightX - leftX);
}
if(abs(rightY - leftY) < 0.01){
    rightY = leftY + 0.01*sign(rightY - leftY);
}

if(dist < normalChainLength){ // calculate A and B in Ax^2 + Bx
    var calcArcResults = calcArc(leftX, leftY, rightX, rightY, normalChainLength);
    A = calcArcResults[0];
    B = calcArcResults[1];
    arcLength = normalChainLength;
    print(A)
} else if(dist < maxChainLength){
    A = 0;
    B = (rightY - leftY) / (rightX - leftX);
    arcLength = dist;
} else{
    instance_destroy();
    exit;
}
xShift = leftX;
yShift = leftY;

for(var chainIndex = 0; chainIndex < numChainSegments; chainIndex++){
    var chainLinkArcLength = arcLength / numChainSegments * (chainIndex + 0.5);
    var positions = calcPos(A, B, xShift, yShift, chainLinkArcLength, chainIndex > 0 ? chainSegmentXs[chainIndex-1] - xShift + chainLinkWidth : chainLinkWidth);
    chainSegmentXs[chainIndex] = round(positions[0]);
    chainSegmentYs[chainIndex] = round(positions[1]);
    chainSegmentAngles[chainIndex] = calcAngle(chainSegmentXs[chainIndex], A, B, xShift);
}



/* ////////////////////////////////////////////////////////////////////////////////////
    These functions are used to calculate the arc of the chain.
    Most of the code is adapted from the python code here: https://stackoverflow.com/questions/48486254/determine-parabola-with-given-arc-length-between-two-known-points
*/ ////////////////////////////////////////////////////////////////////////////////////
#define dIFunc(t)
return sqrt(max(1 + t * t, 0));

#define IFunc(t)
var rt = sqrt(max(1 + t * t, 0));
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

return [A, B];


#define calcArc(x0, y0, x1, y1, S)
return findCoeff(x1 - x0, y1 - y0, S);


// functions to calculate a position along an arc with given arc length
#define sFunc2(x0, a, b)
if(a == 0){
    return sqrt(sqr(x0) + sqr(b*x0))
}
var u = 2 * a * x0 + b
var l = b
return 0.5 * (IFunc(u) - IFunc(l)) / a

#define findPos(a, b, s0, baseGuess)
var N = maxChainLength;

// var guess = round((rightX - leftX) * s0 / arcLength);
var guess = baseGuess;
var prevGuess = guess;
var dArcLength = sFunc2(guess, a, b) - s0;
var prevDArcLength = dArcLength;
var jumpAmount = 2;
for(var i = 0; i < N; i++){
    prevDArcLength = dArcLength;
    prevGuess = guess;
    guess -= sign(dArcLength)*jumpAmount;
    dArcLength = sFunc2(guess, a, b) - s0;
    if(prevDArcLength <= dArcLength){
        if(jumpAmount > 1){
            jumpAmount = round(jumpAmount/2)
        } else{
            break;
        }
    }
}
print(i)
var x0 = prevGuess;
var y0 = a*x0*x0 + b*x0;

return [x0, y0];

#define calcPos(A, B, xShift, yShift, arcLength, baseGuess)
var positions = findPos(A, B, arcLength, baseGuess);
return [positions[0] + xShift, positions[1] + yShift];

// functions to calculate angle at position on arc
#define calcSlope(x0, A, B, xShift)
return 2 * A * (x0 - xShift) + B;

#define calcAngle(x0, A, B, xShift)
var slope = -calcSlope(x0, A, B, xShift);
return darctan2(slope, 1);