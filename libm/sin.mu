vec sinmu(vec x)
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
    xl = x * 0.63661977236;
    
    // q = ftoi(ceil(abs(xl))*sign(xl))
    xl = xl * sel(0.5, xl, bit(0x80000000));
    q  = ftoi(xl);

    //vec offset = 1.0 + itof(q & bit(0x00000003));
    vec mq     = q & bit(0x00000003);
    vec offset = itof(mq);

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

    vec mask1 = (ftoi(offset) & bit(0x00000001)) == bit(0x00000000);
    res       = sel(cx, sx, mask1);

    vec mask2 = (ftoi(offset) & bit(0x00000002)) == bit(0x00000000);
    vec tmp   = bit(0x80000000) ^ res;
    res       = sel(tmp, res, mask2);
    
    return res;
    //return ct2;
}
