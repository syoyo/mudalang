//
// MUDA version of Simplex noise(direct calculation version).
//

static always_inline vec fade(vec t)
{
    // bilinear version: fade(t) = 3 t t - 2 t t t
    return t * t * t * (t * (6.0f * t - 15.0f) + 10.0f);

    // mul   : 5
    // add   : 2
    // total : 7

}

static always_inline vec flerp(vec t, vec a, vec b)
{
    return (1.0f - t) * a + t * b;

    // mul   :           2
    // add   :           2
    // total :           4
}


static always_inline vec fastfloor(vec x)
{
    vec s  = x > vec(0.0f);
    vec xi = trunc(x);
    vec x1 = xi - vec(1.0f);
    
    // correct up to 2**23
    // if x > 0: (int)x else (int)x - 1
    return sel(x1, xi, s);

    // cmp   : 1
    // trunc : 1
    // add   : 1
    // sel   : 1
    // total : 4
}

// hash(x) = BBS(x) = x * x % m.
// Compute modulous with floating point unit.
//
// mod(x, m) = x - floor(x / m) * m
static always_inline vec hash(vec x, vec m, vec invm)
{
    vec x2 = x * x;

    return x2 - fastfloor(x2 * invm) * m;

    // add   :          1
    // mul   :          3
    // floor : 4 x 1 => 4
    // total : 8
}


static always_inline vec grad2(vec h, vec f0, vec f1)
{
	ivec ih = ftoi(h);

	ivec xs = (ih & 0x00000001) << 31;
	ivec ys = (ih & 0x00000002) << 30;

    // x = if (h & 0x1) -f0 : f0
    // y = if ((h>>1) & 0x1) -f1 : f1
    // return x + y

	return (f0 ^ as_vec(xs)) + (f1 ^ as_vec(ys));

    // ftoi  : 1
    // and   : 2
    // shift : 2
    // xor   : 2
    // add   : 1
    // total : 8

}

void snoise2(
    out vec value,
    vec x,
    vec y)
{
    //vec base    = vec(61.0f);
    //vec invbase = vec(0.0163934f);       // 1 / base

    vec base    = vec(251.0f);
    vec invbase = vec(0.0039841);       // 1 / base

    vec F2      = 0.36603f; // 0.5 * (sqrt(3) - 1)
    vec G2      = 0.21132f;   // (3 - sqrt(3)) / 6
    
    vec  s = (x + y) * F2;
    vec  i = trunc(x + s);
    vec  j = trunc(y + s);

    // -> add   : 1
    //    mul   : 1 
    //    trunc : 2,    total : 4

    vec t  = (i + j) * G2;
    vec xt = i - t;
    vec yt = j - t;
    vec x0 = x - xt;
    vec y0 = y - yt;

    // -> itof  : 2
    //    add   : 5
    //    mul   : 1,    total : 12

    vec vone  = 1.0;
    vec vzero = 0.0;

    vec mask = x0 > y0;

    vec i1   = sel(vzero, vone, mask);
    vec j1   = sel(vone , vzero, mask);

    vec x1   = x0 - i1 + G2;
    vec y1   = y0 - j1 + G2;
    vec x2   = x0 - 1.0 + 2.0 * G2;
    vec y2   = y0 - 1.0 + 2.0 * G2;

    // -> cmp  : 1
    //    sel  : 2
    //    add  : 8
    //    mul  : 2,     total : 25

    vec h0, h1, h2;

    h0 = hash(i + hash(j, base, invbase), base, invbase);
    h1 = hash(i + i1 + hash(j + j1, base, invbase), base, invbase);           // h1 can be optimized
    h2 = hash(i + 1.0 + hash(j + 1.0, base, invbase), base, invbase);

    // -> hash : 6x8  => 48
    //    add  :          7,   total : 80
    
    vec n0, n1, n2;

    vec t0 = 0.5 - x0 * x0 - y0 * y0;
    vec t0mask = t0 > vec(0.0);

    vec tt0 = t0 * t0;
    vec ttt0 = tt0 * tt0 * grad2(h0, x0, y0);

    n0 = sel(vzero, ttt0, t0mask);

    vec t1 = 0.5 - x1 * x1 - y1 * y1;
    vec t1mask = t1 > vec(0.0);

    vec tt1 = t1 * t1;
    vec ttt1 = tt1 * tt1 * grad2(h1, x1, y1);

    n1 = sel(vzero, ttt1, t1mask);

    vec t2 = 0.5 - x2 * x2 - y2 * y2;
    vec t2mask = t2 > vec(0.0);

    vec tt2 = t2 * t2;
    vec ttt2 = tt2 * tt2 * grad2(h2, x2, y2);

    n2 = sel(vzero, ttt2, t2mask);

    // -> add  : 3 x 2   => 6
    //    mul  : 3 x 5   => 15
    //    cmp  : 3 x 1   => 3
    //    grad : 3 x 1x8 => 24
    //    sel  : 3 x 1   => 3,        total : 131

    value =  70.0f * (n0 + n1 + n2);

    // -> add : 2
    //    mul : 1,          total : 134

    //
    // ====> theoretical min execution cycle: 134 cycles for 4 noise values.
    //                                        33.5 cycles/noise


}

static always_inline vec grad2_memo(vec xs, vec ys, vec f0, vec f1)
{
    // xs and ys are either 0x80000000 or 0x00000000
	return (f0 ^ xs) + (f1 ^ ys);

    // xor   : 2
    // add   : 1
    // total : 3

}


//
// Memoized version of simplex noise.
// Exploit the coherence that subsequent call of noise() has high probability
// of having same integer part for x and y.
//
void snoise2_memo(
    out vec value,
    vec x,
    vec y,
    out vec mxi,
    out vec myi,
    out vec mmask,
    out vec mh0,
    out vec mh1,
    out vec mh2)
{
    //vec base    = vec(61.0f);
    //vec invbase = vec(0.0163934f);       // 1 / base

    vec base    = vec(251.0f);
    vec invbase = vec(0.0039841);       // 1 / base

    vec F2      = 0.36603f;     // 0.5 * (sqrt(3) - 1)
    vec G2      = 0.21132f;     // (3 - sqrt(3)) / 6
    
    vec  s = (x + y) * F2;
    vec  i = trunc(x + s);
    vec  j = trunc(y + s);

    vec t  = (i + j) * G2;
    vec xt = i - t;
    vec yt = j - t;
    vec x0 = x - xt;
    vec y0 = y - yt;

    vec vone  = 1.0;
    vec vzero = 0.0;

    vec mask = x0 > y0;

    vec i1   = sel(vzero, vone, mask);
    vec j1   = sel(vone , vzero, mask);

    vec x1   = x0 - i1 + G2;
    vec y1   = y0 - j1 + G2;
    vec x2   = x0 - 1.0 + 2.0 * G2;
    vec y2   = y0 - 1.0 + 2.0 * G2;

    // -> up to here  : 29

    vec h0, h1, h2;
    vec n0, n1, n2;

    vec cond = (i == mxi) & (j == myi) & (mask == mmask);

    vec t0, t0mask, tt0, ttt0;
    vec t1, t1mask, tt1, ttt1;
    vec t2, t2mask, tt2, ttt2;

    if (all(cond)) {

        // -> logical : 5
        //    all     : 1,     total 25

        // fast path
        t0 = 0.5 - x0 * x0 - y0 * y0;
        t0mask = t0 > vec(0.0);

        tt0 = t0 * t0;
        ttt0 = tt0 * tt0 * grad2(mh0, x0, y0);

        n0 = sel(vzero, ttt0, t0mask);


        t1 = 0.5 - x1 * x1 - y1 * y1;
        t1mask = t1 > vec(0.0);

        tt1 = t1 * t1;
        ttt1 = tt1 * tt1 * grad2(mh1, x1, y1);

        n1 = sel(vzero, ttt1, t1mask);


        t2 = 0.5 - x2 * x2 - y2 * y2;
        t2mask = t2 > vec(0.0);

        tt2 = t2 * t2;
        ttt2 = tt2 * tt2 * grad2(mh2, x2, y2);

        n2 = sel(vzero, ttt2, t2mask);

        // -> add  : 3 x 1   => 3
        //    mul  : 3 x 6   => 18
        //    cmp  : 3 x 1   => 3
        //    grad : 3 x 1x8 => 24
        //    sel  : 3 x 1   => 3,        
        //    -----             51,   total : 76

        value =  70.0f * (n0 + n1 + n2);

        // -> add  : 2
        //    mul  : 1,    total 79

        return;

        // ====> 78 insts for fast path

    } else {

        // slow path

    }    


    h0 = hash(i + hash(j, base, invbase), base, invbase);
    h1 = hash(i + i1 + hash(j + j1, base, invbase), base, invbase);           // h1 can be optimized
    h2 = hash(i + 1.0 + hash(j + 1.0, base, invbase), base, invbase);


    t0 = 0.5 - x0 * x0 - y0 * y0;
    t0mask = t0 > vec(0.0);

    tt0 = t0 * t0;
    ttt0 = tt0 * tt0 * grad2(h0, x0, y0);

    n0 = sel(vzero, ttt0, t0mask);


    t1 = 0.5 - x1 * x1 - y1 * y1;
    t1mask = t1 > vec(0.0);

    tt1 = t1 * t1;
    ttt1 = tt1 * tt1 * grad2(h1, x1, y1);

    n1 = sel(vzero, ttt1, t1mask);


    t2 = 0.5 - x2 * x2 - y2 * y2;
    t2mask = t2 > vec(0.0);

    tt2 = t2 * t2;
    ttt2 = tt2 * tt2 * grad2(h2, x2, y2);

    n2 = sel(vzero, ttt2, t2mask);

    value =  70.0f * (n0 + n1 + n2);

    // update memo
    mxi   = i;
    myi   = i;
    mmask = mask;
    mh0   = h0;
    mh1   = h1;
    mh2   = h2;

    return;

}
