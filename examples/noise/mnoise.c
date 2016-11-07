#define BASE 61

static inline int hash(int x)
{
    return (x * x) % 61;
}

static inline float fade(float t)
{
    return t * t * t * (t * (6.0f * t - 15.0f) + 10.0f);
}

static inline float flerp(float t, float a, float b)
{
    return (1.0f - t) * a + t * b;
}

static inline int fastfloor(float x)
{
    return (x > 0.0) ? (int)x : (int)x - 1;
}

static inline float grad(int h, float fx, float fy)
{
    float gx = ((h & 0x00000001) == 0) ? -1.0f : 1.0f;
    float gy = (((h >> 1) & 0x00000001) == 0) ? -1.0f : 1.0f;

    return gx * fx + gy * fy;
}

float mnoise2(float x, float y)
{
    int pxi = (int)x;
    int pyi = (int)y;

    float pxf = x - (float)pxi;
    float pyf = y - (float)pyi;

    int y0 = pyi * 7;
    int y1 = (pyi + 1) * 7;

    int x0 = pxi;
    int x1 = pxi + 1;

    int hy0 = hash(y0);
    int hy1 = hash(y1);

    int h00 = hash(x0 + hy0);
    int h10 = hash(x1 + hy0);
    int h01 = hash(x0 + hy1);
    int h11 = hash(x1 + hy1);

    float fx0 = pxf;
    float fx1 = pxf - 1.0f;
    float fy0 = pyf;
    float fy1 = pyf - 1.0f;

    float g00 = grad(h00, fx0, fy0);
    float g10 = grad(h10, fx1, fy0);
    float g01 = grad(h01, fx0, fy1);
    float g11 = grad(h11, fx1, fy1);

    float kx = fade(pxf);
    float ky = fade(pyf);

    return 0.507f * flerp(ky, flerp(kx, g00, g10), flerp(kx, g01, g11));

}
