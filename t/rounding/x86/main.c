#include "tmpfuncmu.c"

void
testbody(float f, float *out_ceil, float *out_floor, float *out_trunc)
{
    __m128 mceil, mfloor, mtrunc; 
    __m128 in = _mm_set1_ps(f);
    float ceilval[4], floorval[4], truncval[4];

    mceil  = muda_ceil_ps(in);
    _mm_storeu_ps(ceilval, mceil);
    mfloor = muda_floor_ps(in);
    _mm_storeu_ps(floorval, mfloor);
    mtrunc = muda_trunc_ps(in);
    _mm_storeu_ps(truncval, mtrunc);

    printf("# in = %f, ceil = %f, floor = %f, trunc = %f\n", 
        f, ceilval[0], floorval[0], truncval[0]);

    (*out_ceil)  = ceilval[0];
    (*out_floor) = floorval[0];
    (*out_trunc) = truncval[0];

}

void
test()
{
    float ceilval, floorval, truncval;

    testbody(0.5f, &ceilval, &floorval, &truncval);
    testbody(1.0f, &ceilval, &floorval, &truncval);
    testbody(1.5f, &ceilval, &floorval, &truncval);
    testbody(2.0f, &ceilval, &floorval, &truncval);
    testbody(2.5f, &ceilval, &floorval, &truncval);

}

int
main(int argc, char **argv)
{
    test();
}
