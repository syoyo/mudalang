
// SIMD cross product
static inline dvec cross4(dvec a, dvec b, dvec c, dvec d)
{
    return ((a * c) - (b * d));
}

// SIMD dot product
static inline dvec dot4(dvec ax, dvec ay, dvec az, dvec bx, dvec by, dvec bz)
{
    return (ax * bx + ay * by + az * bz);
}

//
// 1 ray - 4 triangles or 4 rays - 1 triangle intersection.
// In 1 ray - 4 triangles case, assume ro* and rd* has same value for each
// element.
// In 4 rays - 1 triangle case, assume v0*, e1* and e2* has same value for each
// element.
//
void
isect(dvec rox, dvec roy, dvec roz,
      dvec rdx, dvec rdy, dvec rdz,
      dvec v0x, dvec v0y, dvec v0z,
      dvec e1x, dvec e1y, dvec e1z,
      dvec e2x, dvec e2y, dvec e2z,
      out dvec inoutMask,
      out dvec inoutT,
      out dvec inoutU,
      out dvec inoutV)
{
    dvec px, py, pz;

    // p = d x e2
    px = cross4(e2z, e2y, rdy, rdz);
    py = cross4(e2x, e2z, rdz, rdx);
    pz = cross4(e2y, e2x, rdx, rdy);

    // add 3, mul 6,  total 9

    dvec sx, sy, sz;

    sx = rox - v0x;
    sy = roy - v0y;
    sz = roz - v0z;

    // add 3,  total 12

    dvec qx, qy, qz;

    dvec vone  = dvec(1.0);
    dvec vzero = dvec(0.0);
    dvec a     = dot4(px, py, pz, e1x, e1y, e1z);
    dvec rpa   = vone /. a;

    // add 2, mul 2, total 16

    // q = s x e1
    qx = cross4(e1z, e1y, sy, sz);
    qy = cross4(e1x, e1z, sz, sx);
    qz = cross4(e1y, e1x, sx, sy);

    // add 3, mul 6, total 25

    dvec u, v, t;

    u = dot4(sx, sy, sz, px, py, pz) * rpa;
    v = dot4(rdx, rdy, rdz, qx, qy, qz) * rpa;
    t = dot4(e2x, e2y, e2z, qx, qy, qz) * rpa;

    // add 6, mul 16, total 47

    dvec eps;

    eps = dvec(0.00001);

    dvec mask0;

    mask0 = (((a * a) > eps) & ((u + v) < vone))
          & ((u > vzero) & (v > vzero));

    // cmp 4, logical 3, add 1, mul 1, total 56

    dvec mask;

    //
    // final mask
    //
    mask = mask0 & (t > vzero) & (t < inoutT);

    inoutT      = sel(inoutT, t, mask);
    inoutU      = sel(inoutU, u, mask);
    inoutV      = sel(inoutV, v, mask);
    inoutMask   = mask | inoutMask;

    // sel 3, logical 3, cmp 2, total 63
    // Theoretical peak: 63 instructions.

}
