static inline vec myldexpmu(vec x, vec exp)
{
    vec zeros   = 0.0;

    vec expMask = bit(0x7F800000);
    vec e2      = itof((x & expMask) >> 23);

    vec maxMask = exp >= 255.0;
    vec minMask = -255.0 > exp;
    minMask     = minMask | (x == zeros);

    vec eSum    = e2 + exp; 

    maxMask     = maxMask | (eSum >= 255.0);
    maxMask     = maxMask & bit(0x7FFFFFFF);
    minMask     = minMask | (zeros > eSum);

    vec eSumI   = ftoi(eSum);

    vec sign    = maxMask & bit(0x80000000);
    vec maxVal  = sign | bit(0x7f800000);

    vec xx      = sel(x, (eSumI << 23), expMask);
    xx          = sel(xx, zeros, minMask);
    xx          = sel(xx, maxVal, maxMask); // +Inf or -Inf if maxMask = true

    return xx;
}

static inline vec myexpmu(vec x)
{
    vec kC1     = -0.6931470632553101f;
    vec kC2     = -1.1730463525082e-7f;
    vec kINVLN2 =  1.4426950408889634f;

    vec zeros    = vec(0.0);
    vec xNegMask = (0.0 > x);
    vec gOffset  = sel(0.5, -0.5, xNegMask);
    vec g        = x * kINVLN2;
    vec xExp     = ftoi(g + gOffset);

    g            = itof(xExp);
    g            = g * kC2 + (g * kC1 + x);

    vec z        = g * g;
    vec a        = z * 0.0999748594;
    vec b        = g * (z * 0.0083208258 + 0.4999999992);
    
    vec foo      = (1.0 + a + b) /. (1.0 + a - b);

    
    return myldexpmu(foo, itof(xExp));

}

static inline vec mylog2mu(vec x)
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

    return ret;

}

vec powmu(vec x, vec y)
{
    vec zeros = 0.0;

    vec zeroMask = (x == zeros);
    vec negMask  = (zeros > x);

    vec nsbit = bit(0x7FFFFFFF);
    vec absx = x & nsbit;
    vec absy = y & nsbit;

    vec oddy = ftoi(absy) & bit(0x00000001);
    vec co   = (oddy > zeros);
    negMask  = negMask & co;

    vec res  = myexpmu(y * mylog2mu(absx));

    vec mres = nsbit | res;
    res      = sel(res, mres, negMask); 

    return sel(res, zeros, zeroMask);
    
}
