
// SIMD cross product
static inline vec cross4(vec a, vec b, vec c, vec d)
{
	return ((a * b) - (c * d));
}

