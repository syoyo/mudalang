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
static always_inline vec
log2mu(vec x)
{
    vec emsb     =  1.4426950216293f;
    vec elsb     =  1.9259629911e-8f;
    vec e        = -1.4426950408890f;

    vec c0       = -0.2988439998f;
    vec c1       = -0.3997655209f;
    vec c2       = -0.6666679125f;

    vec zeros    = vec(0.0f);
    vec ones     = vec(1.0f);
    vec zeroMask = (x == zeros);

    //
    // extract exponent bits, and make it float value.
    //
    vec expMask  = bit(0x7f800000);
    vec xexp     = itof((x & expMask) >> 23) - 126.0f;

    vec xx       = sel(x, bit(0x3f000000), expMask);

    vec mask     = vec(0.7071067811865f) > xx;
    xx = sel(xx, xx + xx, mask);
    xexp = sel(xexp, xexp - 1.0f, mask);

    vec x1 = xx - 1.0f;
    vec z = x1 /. (xx + 1.0f);        // approximate division
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
    vec isNeg    = (x < 0.0f);
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

// Faster version of log2().
// from musicdsp.org
static always_inline vec
fastlog2mu(vec x)
{
    ivec emask   = 255;
    ivec ebit    = (as_ivec(x >> 23) & emask) - 128; 
    ivec mbit    = as_ivec(x) & 0x807fffff;         // ~(255 << 23)

    mbit         = mbit + 0x3f800000;               // 127 << 23

    return itof(mbit) + itof(ebit);

}

// log(x) = log2(x) / log2(e)
static always_inline vec logmu(vec x)
{
    vec kINVLOG2E = 0.693147180559945f;	// 1.0 / log2(e)
    return log2mu(x) * kINVLOG2E;
}

static always_inline vec fastlogmu(vec x)
{
    vec kINVLOG2E = 0.693147180559945f;	// 1.0 / log2(e)
    return fastlog2mu(x) * kINVLOG2E;
}
