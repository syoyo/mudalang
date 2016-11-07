//
// Reciprocal square root estimate + one round of Newton-Raphson.
//
// TODO: make sqrt() intrinsic function?
//
// PRECISIOn: 2 ulp in maximum on x86/SSE
//
static always_inline vec sqrtmu(vec x)
{
    vec y0, y0x, y0xhalf;
    vec oneish = bit(0x3f800001);

    y0  = rsqrt(x);
    y0x = y0 * x;
    y0xhalf = 0.5f * y0x;
    
    vec ret = (oneish - y0 * y0x) * y0xhalf + y0x; 

    // Handle 0.0
    vec isZero = x == 0.0f;
    ret = sel(ret, x, isZero); 

    // Hande Inf
    // x = +Inf, return x
    vec isNeg    = (x < 0.0f);
    vec isInf    = ((x & bit(0x7fffffff)) == bit(0x7f800000));
    vec isNegInf = isNeg & isInf;

    // NaN check. NaN: exp = 255 and mantissa != 0
    vec isNaN0     = ((x & bit(0x7fffffff)) != bit(0x7f800000));
    vec isNaN1     = ((x & bit(0x7f800000)) == bit(0x7f800000));
    vec isNaN      = isNaN0 & isNaN1;

    ret = sel(ret, x, isInf);
    ret = sel(ret, bit(0xffc00000), isNegInf);	// x = -Inf -> NaN
    ret = sel(ret, x, isNaN);

    return ret;
}

//
// Faster version with no Inf&NaN case handling
//
static always_inline vec fast_sqrtmu(vec x)
{
    vec y0, y0x, y0xhalf;
    vec oneish = bit(0x3f800001);

    y0  = rsqrt(x);
    y0x = y0 * x;
    y0xhalf = 0.5f * y0x;
    
    vec ret = (oneish - y0 * y0x) * y0xhalf + y0x; 

    // Handle 0.0
    vec isZero = x == 0.0f;
    ret = sel(ret, x, isZero); 

    return ret;
}
