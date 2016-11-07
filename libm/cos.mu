//
// Codes from
//
// "A Fast, Vectorizable Algorithm for Producing Single-Precision
//  Sine-Cosine Pairs",
// Marcus H. Mendenhall
//
vec cosmu(vec x)
{
    // !faster sincos
    //vec kSS1 =  1.5707963268;
    //vec kSS2 = -0.6466386396;
    //vec kSS3 =  0.0679105987;
    //vec kSS4 = -0.0012573807;
    //vec kCC1 = -1.2341299769;
    //vec kCC2 =  0.2465220241;
    //vec kCC3 = -0.0123926176;

    vec kSS1 =  1.5707963235;
    vec kSS2 = -0.645963615;
    vec kSS3 =  0.0796819754;
    vec kSS4 = -0.0046075748;
    vec kCC1 = -1.2336977925;
    vec kCC2 =  0.2536086171;
    vec kCC3 = -0.0204391631;
    vec kONE_OVER_TWOPI = 0.1591549367;

    vec s1, s2, c1, c2, fixmag1;

    vec x1 = x * kONE_OVER_TWOPI;

    // range reduction
    vec q1 = x1 - round(x1);
    vec q2 = q1 * q1;

    // Significant precision loss when we don't use FMA?
    s1 = q1 * (q2 * (q2 * (q2 * kSS4 + kSS3) + kSS2) + kSS1);
    c1 = q2 * (q2 * (q2 * kCC3 + kCC2) + kCC1) + 1.0;

    c2 = c1 * c1 - s1 * s1;
    s2 = 2.0 * (s1 * c1);

    // faster version
    fixmag1 = (2.0 - c2 * c2) - s2 * s2;

    c1 = c2 * c2 - s2 * s2;
    s1 = 2.0 * (s2 * c2);

    return c1 * fixmag1; 
    // s1 * fixmag1
    
}


/*

//
// Not so exact when `x' is larger.
//
vec cosmu(vec x)
{
    vec kPI           =  3.14159265358979323846;
    vec kHALF_PI      =  1.570796326;
    vec kONE_OVER_PI  =  0.318309886;
    vec kEPS          =  7.4505859692e-9;

    vec r0            = -0.1666665668;
    vec r1            =  0.8333025139e-02;
    vec r2            = -0.1980741872e-03;
    vec r3            =  0.2601903036e-5; 

    vec kYMAX         =  210828714.0;

    vec y, n, xn, g, r, res;

    //
    // TODO: handle NaN and Inf case
    //

    vec sgn;
    vec absMask = bit(0x7fffffff);

    // fabs(x) + HALF_PI
    vec absx = x & absMask;
    y = absx + kHALF_PI;

    vec largerMask = y > kYMAX; // if true, overflow
    
    vec negMask = y < 0.0; 
    vec offset  = sel(0.5, -0.5, negMask);

    // N = (int)(y * ONE_OVER_PI + sign(negMask) *  0.5)
    n = ftoi(trunc(y * kONE_OVER_PI + offset));

    xn = itof(n) - 0.5;

    vec oneMask = (n & bit(0x00000001)) == bit(0x00000001);

    // if (oneMask) then -1 else 1
    sgn = oneMask & bit(0x80000000);

    
    // range reduction. larger precision loss may occur here.
    y = absx - xn * kPI;

    // small Y check
    // fabs(y) < eps
    vec absy = y & absMask;
    vec smallYMask = absy < kEPS;

    g = y * y;

    // Taylor series
    r = (((r3 * g + r2) * g + r1) * g + r0) * g;

    res = sel(y + y * r, y, smallYMask);

    // res *= sgn
    res = sgn ^ res;

    // return res;
    return res;

}

*/

/*
vec cosmu(vec x)
{
    vec kSINCOS_C1   = 1.57079625129;
    vec kSINCOS_C2   = 7.54978995489e-8;

    vec kSINCOS_CC0 =  -0.0013602249;
    vec kSINCOS_CC1 =   0.0416566950;
    vec kSINCOS_CC2 =  -0.4999990225;
    vec kSINCOS_SC0 =  -0.0001950727;
    vec kSINCOS_SC1 =   0.0083320758;
    vec kSINCOS_SC2 =  -0.1666665247;
   
    vec xl, xl2, xl3, res;
    vec q;

    // range reduction
    // xl = angle * twoOverPi
    xl = x * 0.63661977236;
    
    // q = ftoi(ceil(abs(xl))*sign(xl))
    xl = xl + sel(0.5, xl, bit(0x80000000));
    q  = ftoi(xl);

    //vec offset = 1.0 + itof(q & bit(0x00000003));
    vec mq     = q & bit(0x00000003);
    vec offset = 1.0 + itof(mq);

    vec qf = itof(q);
    vec p1 = x - (qf * kSINCOS_C1);
    xl     = p1 - (qf * kSINCOS_C2);

    xl2    = xl * xl;
    xl3    = xl2 * xl;

    vec ct1 = kSINCOS_CC0 * xl2 + kSINCOS_CC1;
    vec st1 = kSINCOS_SC0 * xl2 + kSINCOS_SC1;

    vec ct2 = ct1 * xl2 + kSINCOS_CC2;
    vec st2 = st1 * xl2 + kSINCOS_SC2;

    vec cx  = ct2 * xl2 + 1.0;
    vec sx  = st2 * xl3 + xl;

    //vec mask1 = (ftoi(offset) & bit(0x00000001)) == bit(0x00000000);
    vec mask1 = (ftoi(offset) & bit(0x00000001)) > bit(0x00000000);
    res       = sel(cx, sx, mask1);

    vec mask2 = (ftoi(offset) & bit(0x00000002)) == bit(0x00000000);
    vec tmp   = bit(0x80000000) ^ res;
    res       = sel(tmp, res, mask2);
    
    //return offset;
    //return ct2;
    
    //return res;
    //return mask1;
    return res;
    //return sx;
}
*/
