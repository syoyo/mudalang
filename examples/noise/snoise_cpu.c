/*
 * Simplex noise
 */

//#define BASE (61)
#define BASE (251)

static int hash(int x)
{
    return (x * x) % BASE;
}

static float grad2(int h, float x, float y)
{
    float s, t;

    s = ((h & 0x1) > 0) ? -x : x;
    t = ((h & 0x2) > 0) ? -y : y;

    return s + t;
}

float snoise2_cpu(float x, float y)
{

    const float F2 = 0.36603f; // 0.5 * (sqrt(3) - 1)
    
    float s = (x + y) * F2;
    int i = (int)(x + s);
    int j = (int)(y + s);

    const float G2 = 0.21132f;   // (3 - sqrt(3)) / 6
    float t = (i + j) * G2;
    float xt = i - t;
    float yt = j - t;
    float x0 = x - xt;
    float y0 = y - yt;

    int i1, j1;

    if (x0 > y0) {
        i1 = 1; j1 = 0;
    } else {
        i1 = 0; j1 = 1;
    }

    float x1 = x0 - i1 + G2;
    float y1 = y0 - j1 + G2;
    float x2 = x0 - 1.0f + 2.0f * G2;
    float y2 = y0 - 1.0f + 2.0f * G2;

    int h0, h1, h2;

    h0 = hash(i + hash(j));
    h1 = hash(i + i1 + hash(j + j1));
    h2 = hash(i + 1 + hash(j + 1));
    
    float n0, n1, n2;

    float t0 = 0.5f - x0 * x0 - y0 * y0;
    if (t0 < 0.0f) {
        n0 = 0.0f;
    } else {
        t0 *= t0;
        n0 = t0 * t0 * grad2(h0, x0, y0);
    }

    float t1 = 0.5f - x1 * x1 - y1 * y1;
    if (t1 < 0.0f) {
        n1 = 0.0f;
    } else {
        t1 *= t1;
        n1 = t1 * t1 * grad2(h1, x1, y1);
    }

    float t2 = 0.5f - x2 * x2 - y2 * y2;
    if (t2 < 0.0f) {
        n2 = 0.0f;
    } else {
        t2 *= t2;
        n2 = t2 * t2 * grad2(h2, x2, y2);
    }

    return 70.0f * (n0 + n1 + n2);
}
