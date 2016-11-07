#include <stdio.h>
#include <xmmintrin.h>

#include "muda.h"

#include "layout.h"


int
main(int argc, char **argv)
{
    float val = 1.0;

    if (argc > 1) {
        val = atof(argv[1]);
    }

    mudavec ret;

    float val1 = val + 1.0f;
    float val2 = val + 2.0f;
    float val3 = val + 3.0f;

    ret = (mudavec)setup01(&val, &val1, &val2, &val3);

    mudaPrint4f(&ret);

    return 0;

}
