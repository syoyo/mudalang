
// SIMD cross product
static inline vec cross4(vec a, vec b, vec c, vec d)
{
	return ((a * c) - (b * d));
}

// SIMD dot product
static inline vec dot4(vec ax, vec ay, vec az, vec bx, vec by, vec bz)
{
	return (ax * bx + ay * by + az * bz);
}

//
// 1 ray - 4 triangles intersection.
// Assume that, for ray data, same value is copied over 4 elements. 
//
static inline vec
isect(vec rox, vec roy, vec roz,
      vec rdx, vec rdy, vec rdz,
      vec v0x, vec v0y, vec v0z,
      vec e1x, vec e1y, vec e1z,
      vec e2x, vec e2y, vec e2z,
      out vec outT, out vec outU, out vec outV, vec prevT)
{
	vec px, py, pz;

	// p = d x e2
	px = cross4(e2z, e2y, rdy, rdz);
	py = cross4(e2x, e2z, rdz, rdx);
	pz = cross4(e2y, e2x, rdx, rdy);

	vec sx, sy, sz;

	sx = rox - v0x;
	sy = roy - v0y;
	sz = roz - v0z;

	vec qx, qy, qz;

	vec vone  = vec(1.0);
	vec vzero = vec(0.0);
	vec a     = dot4(px, py, pz, e1x, e1y, e1z);

	// `slash dot' operator means approximate division if possible.
	vec rpa   = vone /. a;

	// q = s x e1
	qx = cross4(e1z, e1y, sy, sz);
	qy = cross4(e1x, e1z, sz, sx);
	qz = cross4(e1y, e1x, sx, sy);

	vec u, v, t;

	u = dot4(sx, sy, sz, px, py, pz) * rpa;
	v = dot4(rdx, rdy, rdz, qx, qy, qz) * rpa;
	t = dot4(e2x, e2y, e2z, qx, qy, qz) * rpa;

	vec eps;

	eps = vec(0.00001);

	vec mask0;

	mask0 = (((a * a) > eps) & ((u + v) < vone))
          & ((u > vzero) & (v > vzero));

	vec mask;

	//
	// final mask
	//
	mask = (mask0 & t) & (t < prevT);

	outT = sel(outT, t, mask);
	outU = sel(outU, t, mask);
	outV = sel(outV, t, mask);

	return mask;
	

}
