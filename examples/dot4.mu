// SIMD dot product
static inline vec dot4(vec ax, vec ay, vec az, vec bx, vec by, vec bz)
{
	return (ax * bx + ay * by + az * bz);
}

