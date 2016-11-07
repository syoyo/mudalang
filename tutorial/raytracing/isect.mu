//
// SIMD Ray-triangle intersection code.
//

struct ray4
{

    vec rox;
    vec roy;
    vec roz;

    vec rdx;
    vec rdy;
    vec rdz;

};   // DO NOT forget to add ";" after struct definition!

struct tri4
{

    vec v0x;
    vec v0y;
    vec v0z;

    // e1 = v1 - v0
    vec e1x;
    vec e1y;
    vec e1z;

    // e2 = v2 - v0
    vec e2x;
    vec e2y;
    vec e2z;

};


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

void setupRay4(
    out ray4    ray,
    vec rox,
    vec roy,
    vec roz,
    vec rdx,
    vec rdy,
    vec rdz)
{

    ray.rox = rox;
    ray.roy = roy;
    ray.roz = roz;

    ray.rdx = rdx;
    ray.rdy = rdy;
    ray.rdz = rdz;

}

void setupTri4(
    out tri4 tri,
    float v0x,
    float v0y,
    float v0z,
    float v1x,
    float v1y,
    float v1z,
    float v2x,
    float v2y,
    float v2z)
{

    tri.v0x = v0x; 
    tri.v0y = v0y; 
    tri.v0z = v0z; 

    tri.e1x = v1x - v0x; 
    tri.e1y = v1y - v0y; 
    tri.e1z = v1z - v0z; 

    tri.e2x = v2x - v0x; 
    tri.e2y = v2y - v0y; 
    tri.e2z = v2z - v0z; 

}

//
// 1 ray - 4 triangles intersection.
// Assume that, for ray data, same value is copied over 4 elements. 
//
vec
isect(ray4 ray,
      tri4 tri,
      inout vec retT,
      inout vec retU,
      inout vec retV)
{
	vec px, py, pz;

	// p = d x e2
	px = cross4(tri.e2z, tri.e2y, ray.rdy, ray.rdz);
	py = cross4(tri.e2x, tri.e2z, ray.rdz, ray.rdx);
	pz = cross4(tri.e2y, tri.e2x, ray.rdx, ray.rdy);

	vec sx, sy, sz;

	sx = ray.rox - tri.v0x;
	sy = ray.roy - tri.v0y;
	sz = ray.roz - tri.v0z;

	vec qx, qy, qz;

	vec vone  = vec(1.0);
	vec vzero = vec(0.0);
	vec a     = dot4(px, py, pz, tri.e1x, tri.e1y, tri.e1z);

	// `slash dot' operator means approximate division if possible.
	vec rpa   = vone /. a;


	// q = s x e1
	qx = cross4(tri.e1z, tri.e1y, sy, sz);
	qy = cross4(tri.e1x, tri.e1z, sz, sx);
	qz = cross4(tri.e1y, tri.e1x, sx, sy);

	vec u, v, t;

	u = dot4(sx, sy, sz, px, py, pz) * rpa;
	v = dot4(ray.rdx, ray.rdy, ray.rdz, qx, qy, qz) * rpa;
	t = dot4(tri.e2x, tri.e2y, tri.e2z, qx, qy, qz) * rpa;

	vec eps;

	eps = vec(0.00001);

	vec mask0;

	mask0 = (((a * a) > eps) & ((u + v) < vone)) & ((u > vzero) & (v > vzero));

	vec mask;

	//
	// final mask
	//
	mask = mask0 & (t < retT);

	retT = sel(retT, t, mask);
	retU = sel(retU, u, mask);
	retV = sel(retV, v, mask);

	return mask;

}
