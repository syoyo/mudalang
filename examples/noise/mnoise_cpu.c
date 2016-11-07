#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

#include "mnoise.h"

void saveppm(const char *filename, unsigned char *img, int x, int y)
{
    FILE *fp;

    fp = fopen(filename, "wb");

    fprintf(fp, "P5\n");
    fprintf(fp, "%d %d\n", x, y);
    fprintf(fp, "255\n");

    fwrite(img, x * y * 3, 1, fp);

    fclose(fp);

}

unsigned char scale(float f)
{
    int i;

    i = (int)(255.5f * (f * 0.5f + 0.5f));
    if (i < 0) i = 0;
    if (i > 255) i = 255;

    return (unsigned char)i;
}

void
doit()
{
    int             w = 256;
    int             i, j, k;
    unsigned char  *image;
    float           c = 8.0f;
    float           x;
    float           y;
    float           f;

    image = (unsigned char *)malloc(w * w * 3);

    for (j = 0; j < w; j++) {

        y = c * j / (float)w;

        for (i = 0; i < w; i++) {

            x  = c * i / (float)w;
            
            f = mnoise2(x, y);

            image[j * w + i] = scale(f);

        }
    }


    saveppm("mnoisemap_cpu.ppm", image, w, w);

    free(image);
}

void
perf()
{
    int             w = 256;
    int             i, j, k;
    float          *image;
    float           b0, b1, b2, b3;
    float           c = 8.0f;
    float           x;
    float           y;
    float           f;
    float          *input[2];

    image = (float *)malloc(sizeof(float) * w * w);
    input[0] = (float *)malloc(sizeof(float) * w * w);
    input[1] = (float *)malloc(sizeof(float) * w * w);

    //
    // Setup input data
    // 
    for (j = 0; j < w; j++) {

        y =  c * j / (float)w;

        for (i = 0; i < w; i++) {

            x = c * i / (float)w;

            input[0][j * w + i] = x;
            input[1][j * w + i] = y;

        }

    }

    struct timeval s, e;

    int NLOOP = 1000;

    gettimeofday(&s, NULL);

    for (k = 0; k < NLOOP; k++) {
        for (j = 0; j < w; j++) {
            for (i = 0; i < w; i++) {
                f = mnoise2(input[0][j * w + i], input[1][j * w + i]);
                image[j * w + i] = f;
            }
        }
    }            

    gettimeofday(&e, NULL);

    double elap = (double)(e.tv_sec - s.tv_sec) +
        (double)(e.tv_usec - s.tv_usec) / (double)1.0e6;

    printf("[Modified noise CPU] time: %f sec(%f M mnoise2/sec)\n",
        elap, (NLOOP / elap) * w * w / (1000.0 * 1000.0));
}

int
main()
{
#ifdef PERF
    perf();
#else
    doit();
#endif
    return 0;
}
