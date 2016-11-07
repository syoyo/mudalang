static inline ivec partby2(ivec nn)
{
	ivec n = nn;
	n = (n ^ (n << 16)) & as_ivec(0xff0000ff);
	n = (n ^ (n <<  8)) & as_ivec(0x0300f00f);
	n = (n ^ (n <<  4)) & as_ivec(0x030c30c3);
	n = (n ^ (n <<  2)) & as_ivec(0x09249249);

	return n;
}

void get_motion_code(
	out ivec ret,
	ivec     x,
	ivec     y,
	ivec     z)
{
	ivec result = (partby2(x) << 2) | (partby2(y) << 1) | partby2(z);
}

