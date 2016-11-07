//
// Compute log for each element of `x', in base 2.
//
// log2mu has 2 ulp err in maximum compared libm's log2f() for x86/SSE backend 
// see t/libm/log2/
//
// In x86/SSE2 backend, log2() function is compiled into around 60 instructions.
//

// x = +Inf      -> +Inf  
// x = -Inf      -> NaN
// x = 1         -> +0
// x = +/-0      -> -Inf  
static vec
log2mu(vec x)
{
    vec emsb     =  1.4426950216293;
    vec elsb     =  1.9259629911e-8;
    vec e        = -1.4426950408890;

    vec c0       = -0.2988439998;
    vec c1       = -0.3997655209;
    vec c2       = -0.6666679125;

    vec zeros    = vec(0.0);
    vec ones     = vec(1.0);
    vec zeroMask = (x == zeros);

    //
    // extract exponent bits, and make it float value.
    //
    vec expMask  = bit(0x7f800000);
    vec xexp     = itof((x & expMask) >> 23) - 126.0;

    vec xx       = sel(x, bit(0x3f000000), expMask);

    vec mask     = vec(0.7071067811865) > xx;
    xx = sel(xx, xx + xx, mask);
    xexp = sel(xexp, xexp - 1.0, mask);

    vec x1 = xx - 1.0;
    vec z = x1 /. (xx + 1.0);        // approximate division
    vec w = z * z; 

    vec p = (c0 * w + c1) * w + c2; 

    vec y = z * (p * w + x1);
    vec zz1 = emsb * x1 + xexp; 
    vec zz2 = elsb * x1 + (e * y);

    // return -Inf(0xFF800000) when x = 0
    vec ret = sel(zz1 + zz2, bit(0xFF800000), zeroMask);
    //vec ret = zz1 + zz2;

    // x = +/- Inf, return x
    //vec isNeg    = ((x & bit(0x80000000)) == bit(0x80000000));
    vec isNeg    = (x < 0.0);
    vec isInf    = ((x & bit(0x7fffffff)) == bit(0x7f800000));
    vec isNegInf = isNeg & isInf;

    // NaN check. NaN: exp = 255 and mantissa != 0
    vec isNaN0     = ((x & bit(0x7fffffff)) != bit(0x7f800000));
    vec isNaN1     = ((x & bit(0x7f800000)) == bit(0x7f800000));
    vec isNaN      = isNaN0 & isNaN1;

    ret = sel(ret, x, isInf);
    ret = sel(ret, bit(0xffc00000), isNegInf);	// -Inf
    ret = sel(ret, x, isNaN);
    
    return ret;

}

