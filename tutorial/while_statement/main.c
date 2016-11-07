#include <stdio.h>
#include <stdlib.h>

#include <xmmintrin.h>

#include "muda.h"

#include "loop.h"


int
main(int argc, char **argv)
{
    mudavec a, ret;

    mudaSet4f(&a, 1.0f, 2.0f, 3.0f, 4.0f);
    
    // Hmm.. I have to think calling convention for MUDA function.
    ret = (mudavec)loop_func((const __m128 *)&a);

    mudaPrint4f(&ret);

    return 0;
}
