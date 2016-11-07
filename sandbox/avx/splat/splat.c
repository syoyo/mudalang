#include <stdio.h>
#include <gmmintrin.h>

// x4 ~ x0 must have either value 0 or 1.
#define MM256_SHUFFLE(x3, x2, x1, x0) \
    ((x3 << 3) | (x2 << 2) | (x1 << 1) | (x0))

void
test()
{
    __m256d v;
    __m256d v2;
    __m256d w;

    double buf[4];

    // v.xxxx :
    //
    // +---+---+---+---+
    // | x | ? | ? | ? |  = v
    // +---+---+---+---+
    //
    // +---+---+---+---+
    // | x | x | ? | ? |  = _mm256_shuffle_pd(v, v, SHUFFLE(0, 0, 0, 0)) = v'
    // +---+---+---+---+
    //
    // +---+---+---+---+
    // | x | x | x | x |  = _mm256_permute2_f128(v', v', CONTROL(0, 0))
    // +---+---+---+---+
    //

    v  = _mm256_set_pd(4.0, 3.0, 2.0, 1.0);
    _mm256_storeu_pd(buf, v);
    printf("v = %f, %f, %f, %f\n", buf[0], buf[1], buf[2], buf[3]);

    v2 = _mm256_shuffle_pd(v, v, MM256_SHUFFLE(0, 0, 0, 0));
    w  = _mm256_permute2f128_pd(v2, v2, 0x00);
    _mm256_storeu_pd(buf, w);
    printf("v.xxxx = %f, %f, %f, %f\n", buf[0], buf[1], buf[2], buf[3]);
    

    // v.yyyy :
    //
    // +---+---+---+---+
    // | ? | y | ? | ? |  = v
    // +---+---+---+---+
    //
    // +---+---+---+---+
    // | y | y | ? | ? |  = _mm256_shuffle_pd(v, v, SHUFFLE(1, 1, 0, 0)) = v'
    // +---+---+---+---+
    //
    // +---+---+---+---+
    // | y | y | y | y |  = _mm256_permute2_f128(v', v', CONTROL(0, 0))
    // +---+---+---+---+

    v  = _mm256_set_pd(4.0, 3.0, 2.0, 1.0);
    v2 = _mm256_shuffle_pd(v, v, MM256_SHUFFLE(1, 1, 1, 1));
    w  = _mm256_permute2f128_pd(v2, v2, 0x00);
    _mm256_storeu_pd(buf, w);
    printf("v.yyyy = %f, %f, %f, %f\n", buf[0], buf[1], buf[2], buf[3]);

    // v.zzzz :
    //
    // +---+---+---+---+
    // | ? | ? | z | ? |  = v
    // +---+---+---+---+
    //
    // +---+---+---+---+
    // | ? | ? | z | z |  = _mm256_shuffle_pd(v, v, SHUFFLE(0, 0, 0, 0)) = v'
    // +---+---+---+---+
    //
    // +---+---+---+---+
    // | z | z | z | z |  = _mm256_permute2_f128(v', v', CONTROL(1, 1))
    // +---+---+---+---+

    v  = _mm256_set_pd(4.0, 3.0, 2.0, 1.0);
    v2 = _mm256_shuffle_pd(v, v, MM256_SHUFFLE(0, 0, 0, 0));
    w  = _mm256_permute2f128_pd(v2, v2, 0x11);
    _mm256_storeu_pd(buf, w);
    printf("v.zzzz = %f, %f, %f, %f\n", buf[0], buf[1], buf[2], buf[3]);

    // v.wwww :
    //
    // +---+---+---+---+
    // | ? | ? | ? | w |  = v
    // +---+---+---+---+
    //
    // +---+---+---+---+
    // | ? | ? | w | w |  = _mm256_shuffle_pd(v, v, SHUFFLE(0, 0, 1, 1)) = v'
    // +---+---+---+---+
    //
    // +---+---+---+---+
    // | w | w | w | w |  = _mm256_permute2_f128(v', v', CONTROL(1, 1))
    // +---+---+---+---+

    v  = _mm256_set_pd(4.0, 3.0, 2.0, 1.0);
    v2 = _mm256_shuffle_pd(v, v, MM256_SHUFFLE(1, 1, 1, 1));
    w  = _mm256_permute2f128_pd(v2, v2, 0x11);
    _mm256_storeu_pd(buf, w);
    printf("v.wwww = %f, %f, %f, %f\n", buf[0], buf[1], buf[2], buf[3]);

}

int
main()
{
    test();
}
