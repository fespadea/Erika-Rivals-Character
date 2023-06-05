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
if(abs(rightY - leftY) < 1){
    var dir = sign(rightY - leftY);
    rightY = leftY + (dir == 0 ? 1 : dir);
}

if(dist < normalChainLength){ // calculate A and B in Ax^2 + Bx
    var calcArcResults = calcArc(leftX, leftY, rightX, rightY, normalChainLength);
    A = calcArcResults[0];
    B = calcArcResults[1];
    arcLength = normalChainLength;
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
    var remainingChain;
    var positions;
    if(rightX - leftX >= abs(rightY - leftY) && rightX - leftX > numChainSegments*5){
        var baseGuess;
        if(chainIndex > 0){
            var remainingChainSegment = (rightX-chainSegmentXs[chainIndex-1]) / (numChainSegments-chainIndex);
            baseGuess = chainSegmentXs[chainIndex-1] - xShift + remainingChainSegment*0.5;
        } else{
            baseGuess = ((rightX-leftX) / (numChainSegments)) * 0.5;
        }
        positions = calcPos(A, B, xShift, yShift, chainLinkArcLength, baseGuess);
    } else{
        var baseGuess;
        if(chainIndex > 0){
            var left = determineLeft(A, B, chainLinkArcLength);
            var remainingChainSegment;
            if(left){
                var maxX = determineMaxX(A, B);
                var maxY = determineMaxY(A, B, maxX);
                remainingChainSegment = (maxY-(chainSegmentYs[chainIndex-1]-yShift)) / ((numChainSegments-chainIndex) * ((maxX-(chainSegmentXs[chainIndex-1]-xShift)) / (rightX-chainSegmentXs[chainIndex-1])));
            } else{
                remainingChainSegment = (rightY-chainSegmentYs[chainIndex-1]) / (numChainSegments-chainIndex);
            }
            baseGuess = chainSegmentYs[chainIndex-1]-yShift + remainingChainSegment*0.5;
        } else{
            var left = determineLeft(A, B, chainLinkArcLength);
            var remainingChainSegment;
            if(left){
                var maxX = determineMaxX(A, B);
                var maxY = determineMaxY(A, B, maxX);
                remainingChainSegment = maxY / (numChainSegments * (maxX / ((rightX-xShift)-maxX)));
            } else{
                remainingChainSegment = (rightY-yShift) / numChainSegments;
            }
            baseGuess = remainingChainSegment*0.5;
        }
        positions = calcPosY(A, B, xShift, yShift, chainLinkArcLength, baseGuess);
    }
    chainSegmentXs[chainIndex] = round(positions[0]);
    chainSegmentYs[chainIndex] = round(positions[1]);
    chainSegmentAngles[chainIndex] = calcAngle(chainSegmentXs[chainIndex], A, B, xShift);
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
    return sqrt(max(sqr(x0) + sqr(b*x0), 0));
}
var u = 2 * a * x0 + b;
var l = b;
return 0.5 * (IFunc(u) - IFunc(l)) / a;

#define findPos(a, b, s0, baseGuess)
var N = 10;

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
    if(abs(prevDArcLength) <= abs(dArcLength)){
        if(jumpAmount > 1){
            jumpAmount = round(jumpAmount/2);
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

// functions to calculate a position along an arc with the given arc length but via the y value instead of the x value
#define determineX(y0, a, b, left)
if(a == 0){
    return b == 0 ? 0 : y0/b;
}
var root = sqr(b) - 4*a*(-y0);
if(sign(root) == -1){
    return determineMaxY(a, b, determineMaxX(a, b));
}
var xPos = (-b + sqrt(max(root, 0))) / (2*a);
var xNeg = (-b - sqrt(max(root, 0))) / (2*a);
return left ? min(xNeg, xPos) : max(xNeg, xPos);

#define determineMaxX(A, B)
return A == 0 ? (leftY < rightY ? rightX-xShift : leftX-xShift) : -B/(2*A);

#define determineMaxY(A, B, maxX)
return maxX == infinity ? max(leftY-yShift, rightY-yShift) : A*sqr(maxX) + B*maxX;

#define sFunc2Y(y0, a, b, left)
if(a == 0){
    return b == 0 ? 0 : sqrt(max(sqr(y0/b) + sqr(y0), 0));
}
var x0 = determineX(y0, a, b, left);
var u = 2*a*x0 + b;
var l = b;
return 0.5 * (IFunc(u) - IFunc(l)) / a;

#define findPosY(a, b, s0, baseGuess, left)
var N = 10;

var guess = baseGuess;
var prevGuess = guess;
var dArcLength = sFunc2Y(guess, a, b, left) - s0;
var prevDArcLength = dArcLength;
var jumpAmount = 2;
var maxX = determineMaxX(A, B);
var maxY = determineMaxY(A, B, maxX);
for(var i = 0; i < N; i++){
    prevDArcLength = dArcLength;
    prevGuess = guess;
    guess -= sign(dArcLength)*jumpAmount*left;
    if(guess > maxY){
        guess = maxY;
    }
    dArcLength = sFunc2Y(guess, a, b, left) - s0;
    if(abs(prevDArcLength) <= abs(dArcLength)){
        if(jumpAmount > 1){
            jumpAmount = round(jumpAmount/2);
        } else{
            break;
        }
    }
}
print(i)
var y0 = prevGuess;
var x0 = determineX(y0, a, b, left);

return [x0, y0];

#define determineLeft(a, b, arcLength) // determine if our goal position is to the left or right of the max
var maxX = determineMaxX(a, b);
return sign(round((sFunc2(maxX, a, b) - arcLength)/15));

#define calcPosY(A, B, xShift, yShift, arcLength, baseGuess)
var left = determineLeft(A, B, arcLength)
var positions;
if(left == 0){
    var maxX = determineMaxX(A, B);
    positions = [maxX, determineMaxY(A, B, maxX)];
} else{
    positions = findPosY(A, B, arcLength, baseGuess, left);
}
return [positions[0] + xShift, positions[1] + yShift];

// functions to calculate angle at position on arc
#define calcSlope(x0, A, B, xShift)
return 2 * A * (x0 - xShift) + B;

#define calcAngle(x0, A, B, xShift)
var slope = -calcSlope(x0, A, B, xShift);
return darctan2(slope, 1);
