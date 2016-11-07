//
// MUDA version of Marc Olano's modified noise(direct calculation version).
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

void mnoise2(
    out vec value,
    vec x,
    vec y)
{
    //
    // Base for Blum-Blum-Shub(BBS) should be product of two primes.
    //
    //vec base    = vec(61.0f);
    //vec invbase = vec(0.0163934f);       // 1 / base

    vec base    = vec(221.0f);
    vec invbase = vec(0.0045249);       // 1 / base

    // pxi = integer part of x
    // pyi = integer part of y
    vec pxi = trunc(x);
    vec pyi = trunc(y);
	
    // -> trunc : 2,    total : 2

    // pxf = fractional part of x
    // pyf = fractional part of y
    vec pxf = x - pxi;
    vec pyf = y - pyi;

    // -> add : 2,      total : 4

    vec c0  = vec(1.0f);                 // 7 -> bootstrap factor
    vec one = vec(1.0f);

    vec y0 = (pyi      ) * c0;           // 7 *  y
    vec y1 = (pyi + one) * c0;           // 7 * (y + 1)

    vec x0 = (pxi      );                //  x
    vec x1 = (pxi + one);                // (x + 1)

    // -> add : 2, mul : 2,      total : 8

    vec hy0 = hash(y0, base, invbase);
    vec hy1 = hash(y1, base, invbase);

    vec h00 = hash(x0 + hy0, base, invbase);
    vec h10 = hash(x1 + hy0, base, invbase);
    vec h01 = hash(x0 + hy1, base, invbase);
    vec h11 = hash(x1 + hy1, base, invbase);

    // -> hash : 8 * 6  => 48
    //    add  :            4,   total : 60


    vec fx0 = pxf;
    vec fx1 = vec(-1.0f) + pxf;
    vec fy0 = pyf;
    vec fy1 = vec(-1.0f) + pyf;

    // -> add : 2         , total : 62

                                                  // x, y
    //vec g00 = grad(xs00, ys00, fx0, fy0);       // 0, 0
    //vec g10 = grad(xs10, ys10, fx1, fy0);       // 1, 0
    //vec g01 = grad(xs01, ys01, fx0, fy1);       // 0, 1
    //vec g11 = grad(xs11, ys11, fx1, fy1);       // 1, 1

                                                // x, y
	vec g00 = grad2(h00, fx0, fy0);             // 0, 1
	vec g10 = grad2(h10, fx1, fy0);             // 1, 0
	vec g01 = grad2(h01, fx0, fy1);             // 0, 1
	vec g11 = grad2(h11, fx1, fy1);             // 1, 1

    // -> grad2 : 4 * 8 => 32,  total : 94

    vec kx = fade(pxf);
    vec ky = fade(pyf);

    // -> fade : 2 * 7 => 14,  total : 108

    //
    // noise2(p) = flerp(pyf, flerp(pxf, grad(pi00, pf00),
    //                                   grad(pi10, pf10)     
    //                        flerp(pxf, grad(pi01, pf01),
    //                                   grad(pi11, pf11)     

    vec r = flerp(ky, flerp(kx, g00, g10),
                      flerp(kx, g01, g11));

    // -> flerp : 3 * 4 => 12,  total : 120


    //
    // ====> theoretical min execution cycle: 120 cycles for 4 noise values.
    //                                        30 cycles/noise


    value = 0.507f * r;
 
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
// Memoized version of modified noise.
// Exploit the coherence that subsequent call of noise() has high probability
// of having same integer part for x and y.
//
void mnoise2_memo(
    out vec value,
    vec x,
    vec y,
    out vec mxi,
    out vec myi,
    out vec mh00,
    out vec mh10,
    out vec mh01,
    out vec mh11)
{
    //
    // Base for Blum-Blum-Shub(BBS) should be product of two primes.
    //
    vec base    = vec(61.0f);
    vec invbase = vec(0.0163934f);       // 1 / base

    // pxi = integer part of x
    // pyi = integer part of y
    vec pxi = trunc(x);
    vec pyi = trunc(y);
	
    // -> trunc : 2,    total : 2

    // pxf = fractional part of x
    // pyf = fractional part of y
    vec pxf = x - pxi;
    vec pyf = y - pyi;

    // -> sub : 2,      total : 4

    vec kx = fade(pxf);
    vec ky = fade(pyf);

    // -> fade : 2 * 7 => 14,  total : 18

    vec fx0 = pxf;
    vec fx1 = vec(-1.0f) + pxf;
    vec fy0 = pyf;
    vec fy1 = vec(-1.0f) + pyf;

    // -> add : 2,             total : 20
	

	vec g00, g10, g01, g11;
	vec r;

	vec cond = ((pxi == mxi) & (pyi == myi));

     // -> eq  : 2
     //    and : 1,            total : 23

	if (all(cond)) {

        // -> gather : 1,      total : 24

		// fast path

        g00 = grad2(mh00, fx0, fy0);
        g10 = grad2(mh10, fx1, fy0);
        g01 = grad2(mh01, fx0, fy1);
        g11 = grad2(mh11, fx1, fy1);

        // -> grad2 : 4 * 8 => 32,  total : 56

        r = flerp(ky, flerp(kx, g00, g10),
                      flerp(kx, g01, g11));

        // -> flerp : 3 * 4 => 12,  total : 68

        value = 0.507f * r;
		return;

	} else {

        // slow path

	}



    vec c0  = vec(7.0f);                 // 7 -> bootstrap
    vec one = vec(1.0f);

    vec y0 = (pyi      ) * c0;           // 7 *  y
    vec y1 = (pyi + one) * c0;           // 7 * (y + 1)

    vec x0 = (pxi      );                //  x
    vec x1 = (pxi + one);                // (x + 1)

    vec hy0 = hash(y0, base, invbase);
    vec hy1 = hash(y1, base, invbase);

    vec h00 = hash(x0 + hy0, base, invbase);
    vec h10 = hash(x1 + hy0, base, invbase);
    vec h01 = hash(x0 + hy1, base, invbase);
    vec h11 = hash(x1 + hy1, base, invbase);

	g00 = grad2(h00, fx0, fy0);
	g10 = grad2(h10, fx1, fy0);
	g01 = grad2(h01, fx0, fy1);
	g11 = grad2(h11, fx1, fy1);

    r = flerp(ky, flerp(kx, g00, g10),
                  flerp(kx, g01, g11));

    // update memo
    mxi   = pxi;
    myi   = pyi;
    mh00 = h00;
    mh10 = h10;
    mh01 = h01;
    mh11 = h11;

    value = 0.507f * r;
 
}
