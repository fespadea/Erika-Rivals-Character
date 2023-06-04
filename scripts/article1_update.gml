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
if(rightX == leftX){
    rightX += 1;
    print(rightX)
}

if(dist < normalChainLength){ // calculate A and B in Ax^2 + Bx
    var calcArcResults = calcArc(leftX, leftY, rightX, rightY, normalChainLength);
    A = calcArcResults[0];
    B = calcArcResults[1];
    arcLength = normalChainLength;
} else{
    A = 0;
    B = (rightY - leftY) / (rightX - leftX);
    arcLength = dist;
}
xShift = leftX;
yShift = leftY;

// for(var chainIndex = 0; chainIndex < numChainSegments; chainIndex++){
//     chainArcLength = arcLength / numChainSegments * chainIndex + chainLinkWidth/2;
//     var positions = calcPos(A, B, xShift, yShift, arcLength);
//     chainSegmentXs[chainIndex] = positions[0];
//     chainSegmentYs[chainIndex] = positions[1];
//     chainSegmentAngles[chainIndex] = calcAngle(chainSegmentXs[chainIndex], A, B, xShift);
// }



/* ////////////////////////////////////////////////////////////////////////////////////
    These functions are used to calculate the arc of the chain.
    Most of the code is adapted from the python code here: https://stackoverflow.com/questions/48486254/determine-parabola-with-given-arc-length-between-two-known-points
*/ ////////////////////////////////////////////////////////////////////////////////////
#define dIFunc(t)
if(1 + t * t < 0)
    return sqrt(1 + t * t);
else{
    return 1
}

#define IFunc(t)
if(1 + t * t < 0)
    var rt = sqrt(1 + t * t);
else{
    var rt = 1
}
return 0.5 * (t * rt + ln(t + rt));

#define sFunc(a, x0, y0)
var u = y0/x0 + a * x0;
var l = y0/x0 - a*x0;
return 0.5 * (IFunc(u) - IFunc(l)) / a;

#define dsFunc(a, y0, x0)
var u = y0/x0 + a*x0;
var l = y0/x0 - a*x0;
return 0.5 * (a*x0 * (dIFunc(u) + dIFunc(l)) + IFunc(l) - IFunc(u)) / (a*a);

#define findCoeff(x0, y0, s0)
var N = 1000;
var EPSILON = 0.5;

var guess = y0 / x0;
print(guess)
for(var i = 0; i < N; i++){
    var dguess = (sFunc(guess, x0, y0) - s0) / dsFunc(guess, x0, y0);
    guess -= dguess;
    if(abs(dguess) <= EPSILON)
        break;
}
var A = guess;
var B = y0/x0 - A*x0;

return [A, B];


#define calcArc(x0, y0, x1, y1, S)
return findCoeff(x1 - x0, y1 - y0, S);


// functions to calculate a position along an arc with given arc length
#define sFunc2(x0, a, b)
var u = 2 * a * x0 + b
var l = b
return 0.5 * (IFunc(u) - IFunc(l)) / a

#define dsFunc2(x0, a, b)
return dIFunc(x0)

#define findPos(a, b, s0)
var N = 1000;
var EPSILON = 0.5;

var guess = (rightX - leftX) / numChainSegments;
for(var i = 0; i < N; i++){
    var dguess = (sFunc2(guess, a, b) - s0) / dsFunc(guess, a, b);
    guess -= dguess;
    if(abs(dguess) <= EPSILON)
        break;
}
var x0 = guess;
var y0 = a*x0*x0 + b*x0;

return [x0, y0];

#define calcPos(A, B, xShift, yShift, arcLength)
var positions = findPos(A, B, arcLength)
return [positions[0] + xShift, positions[1] + yShift]

// functions to calculate angle at position on arc
#define calcSlope(x0, A, B, xShift)
return 2 * A * (x0 - xShift) + B

#define calcAngle(x0, A, B, xShift)
var slope = calcSlope(x0, A, B, xShift)
return arctan2(slope, 1)