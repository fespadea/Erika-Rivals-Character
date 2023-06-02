// article 1 update

ownerX = owner_id.x;
ownerY = owner_id.y - owner_id.char_height / 2;
tetheredX = tethered_id.x;
tetheredY = tethered_id.y - tethered_id.char_height / 2;

dist = point_distance(ownerX, ownerY, tetheredX, tetheredY);

if(dist < normalChainLength){ // calculate A and B in Ax^2 + Bx
    var calcArcResults = calcArc(ownerX, ownerY, tetheredX, tetheredY, normalChainLength);
    A = calcArcResults;
    B = calcArcResults;
    arcLength = normalChainLength;
} else{
    A = 0;
    B = (tetheredY - ownerY) / (tetheredX - ownerX);
    arcLength = dist;
}
xShift = ownerX;
yShift = ownerY;

for(var chainIndex = 0; chainIndex < numChainSegments; chainIndex++){
    chainArcLength = arcLength / numChainSegments * chainIndex + chainLinkWidth/2;
    
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
for(var i = 0; i < N; i++){
    var dguess = (sFunc(guess, x0, y0) - s0) / dsFunc(guess, x0, y0);
    guess -= dguess;
    if(abs(dguess) <= EPSILON)
        break;
}
var A = guess;
var B = y0/x0 - a*x0;

return [A, B];


#define calcArc(x0, y0, x1, y1, S)
return findCoeff(x1 - x0, y1 - y0, S);