//
// Compute exp(x).
//

//
// x * 2^exp
//
// exp is actually a integer value.
//
// static inline vec ldexpmu(vec x, vec exp)
// {
//     vec zeros   = 0.0;
// 
//     vec expMask = bit(0x7F800000);
//     vec e2      = itof((x & expMask) >> 23);
// 
//     vec maxMask = exp >= 255.0;
//     vec minMask = -255.0 > exp;
//     minMask     = minMask | (x == zeros);
// 
//     vec eSum    = e2 + exp; 
// 
//     maxMask     = maxMask | (eSum >= 255.0);
//     // maxMask     = maxMask & bit(0x7FFFFFFF);
//     minMask     = minMask | (zeros > eSum);
// 
//     vec eSumI   = trunc(eSum);
// 
//     // vec sign    = maxMask & bit(0x80000000);
//     vec maxVal  = bit(0x7f800000);
// 
//     vec xx      = sel(x, (bit(ftoi(eSumI)) << 23), expMask);
//     xx          = sel(xx, zeros, minMask);
//     xx          = sel(xx, maxVal, maxMask);
// 
//     return xx;
// }

static always_inline vec ldexpmu(vec x, vec exp)
{
    vec zeros   = 0.0f;

    vec expMask = bit(0x7F800000);
    vec e2      = itof(((x & expMask) >> 23));

    vec maxMask = bit(exp >= 255.0f);
    vec minMask = bit(-255.0f > exp);
    minMask     = minMask | (x == zeros);

    vec eSum   = e2 + exp; 

    maxMask     = maxMask | bit(eSum >= 255.0f);
    // maxMask     = maxMask & bit(0x7FFFFFFF);
    minMask     = minMask | bit(0.0f > eSum);

    // vec eSumI   = trunc(eSum);

    // vec sign    = maxMask & bit(0x80000000);
    vec maxVal  = bit(0x7f800000);

    vec eBits   = as_vec(ftoi(eSum) << 23);
    vec xx      = sel(x, eBits, expMask);
    xx          = sel(xx, zeros, minMask);
    xx          = sel(xx, maxVal, maxMask);

    return xx;
}

static always_inline vec expmu(vec x)
{
    // vec kC1     = -0.6931470632553101f;
    // vec kC2     = -1.1730463525082e-7f;
    // vec kINVLN2 =  1.442695040f;

    // vec zeros    = vec(0.0);
    // vec xNegMask = (0.0 > x);
    // vec gOffset  = sel(0.5, -0.5, xNegMask);
    // vec g        = x * kINVLN2;
    // vec xExp     = trunc(g + gOffset);

    // g            = itof(xExp);
    // g            = g * kC2 + (g * kC1 + x);

    // vec z        = g * g;
    // vec a        = z * 0.0999748594;
    // vec b        = g * (z * 0.0083208258 + 0.4999999992);
    // 
    // vec foo      = (1.0 + a + b) /. (1.0 + a - b);

    vec kLN2     = 0.693147180f;
    vec kINVLN2  = 1.442695040f;
    vec kP0      = 0.249999999950f;
    vec kP1      = 0.00416028863f;
    vec kQ0      = 0.5f;
    vec kQ1      = 0.04998717878f;
    //vec thres    = 1.7263349182589107e-4f;
    vec thres    = 2.384185222581e-7f;	// 1/2**22

    vec zeros    = vec(0.0f);
    vec xNegMask = (0.0f > x);
    vec gOffset  = sel(0.5f, -0.5f, xNegMask);
    vec g        = x * kINVLN2;
    vec N        = trunc(g + gOffset);

    g            = x - N * kLN2;

    vec z        = g * g;
    vec P        = g * (kP1 * z + kP0);
    vec Q        = kQ1 * z + kQ0;
    
    vec R        = 0.5f + P /. (Q - P);
    
    vec smallMask = abs(x) < thres;
    vec one       = 1.0f; 

    vec N_1       = N + 1.0f;
    // ivec N_1      = ftoi(N) + 1;

    // if abs(x) < small, return 1.0
    vec ret       = sel(ldexpmu(R, N_1), one, smallMask);

    // NaN check. NaN: exp = 255 and mantissa != 0
    vec isNaN0     = ((x & bit(0x7fffffff)) != bit(0x7f800000));
    vec isNaN1     = ((x & bit(0x7f800000)) == bit(0x7f800000));
    vec isNaN      = isNaN0 & isNaN1;

    ret = sel(ret, x, isNaN);

    return ret;
}

// from muiscdsp.org
static always_inline vec fastexpmu(vec x)
{
    // return (40320.0+x*(40320.0+x*(20160.0+x*(6720.0+x*(1680.0+x*(336.0+x*(56.0+x*(8.0+x))))))))*2.4801587301e-5f;

    return (362880.0f+x*(362880.0f+x*(181440.0f+x*(60480.0f+x*(15120.0f+x*(3024.0f+x*(504.0f+x*(72.0f+x*(9.0f+x)))))))))*2.75573192e-6f;
}
