#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <float.h>

#include "muda.h"
#include "isect.h"

#define WIDTH  256
#define HEIGHT 256

double *rox, *roy, *roz;
double *rdx, *rdy, *rdz;

double *v0x, *v0y, *v0z;
double *e1x, *e1y, *e1z;
double *e2x, *e2y, *e2z;
double *mask, *t, *u, *v;

unsigned char *image;

void
saveppm(const char *filename, unsigned char *img, int x, int y)
{
    FILE *fp;
    
    fp = fopen(filename, "wb");

    fprintf(fp, "P6\n");
    fprintf(fp, "%d %d\n", x, y);
    fprintf(fp, "255\n");

    fwrite(img, x * y * 3, 1, fp);

    fclose(fp);

}

unsigned char
scale(float f)
{
    int i;

    i = (int)(255.5f * (f * 0.5f + 0.5f));
    if (i < 0) i = 0;
    if (i > 255) i = 255;

    return (unsigned char)i;
}


void
init()
{
    image  = (unsigned char *)mudaAlloc(WIDTH * HEIGHT * 3, 32);
    memset(image, 0, WIDTH * HEIGHT * 3);

    rox  = (double *)mudaAlloc(sizeof(dvec), 32);
    roy  = (double *)mudaAlloc(sizeof(dvec), 32);
    roz  = (double *)mudaAlloc(sizeof(dvec), 32);

    rdx  = (double *)mudaAlloc(sizeof(dvec), 32);
    rdy  = (double *)mudaAlloc(sizeof(dvec), 32);
    rdz  = (double *)mudaAlloc(sizeof(dvec), 32);

    v0x  = (double *)mudaAlloc(sizeof(dvec), 32);
    v0y  = (double *)mudaAlloc(sizeof(dvec), 32);
    v0z  = (double *)mudaAlloc(sizeof(dvec), 32);
    e1x  = (double *)mudaAlloc(sizeof(dvec), 32);
    e1y  = (double *)mudaAlloc(sizeof(dvec), 32);
    e1z  = (double *)mudaAlloc(sizeof(dvec), 32);
    e2x  = (double *)mudaAlloc(sizeof(dvec), 32);
    e2y  = (double *)mudaAlloc(sizeof(dvec), 32);
    e2z  = (double *)mudaAlloc(sizeof(dvec), 32);
    mask = (double *)mudaAlloc(sizeof(dvec), 32);
    t    = (double *)mudaAlloc(sizeof(dvec), 32);
    u    = (double *)mudaAlloc(sizeof(dvec), 32);
    v    = (double *)mudaAlloc(sizeof(dvec), 32);

    double tri[3][3] = {
        { -0.5, -0.5 , -1.0 },
        {  0.1,  0.75, -1.0 },
        {  0.5, -0.75, -1.0 }
    };

    mudaSet1d((dvec *)v0x, tri[0][0]);
    mudaSet1d((dvec *)v0y, tri[0][1]);
    mudaSet1d((dvec *)v0z, tri[0][2]);
    mudaSet1d((dvec *)e1x, tri[1][0] - tri[0][0]);
    mudaSet1d((dvec *)e1y, tri[1][1] - tri[0][1]);
    mudaSet1d((dvec *)e1z, tri[1][2] - tri[0][2]);
    mudaSet1d((dvec *)e2x, tri[2][0] - tri[0][0]);
    mudaSet1d((dvec *)e2y, tri[2][1] - tri[0][1]);
    mudaSet1d((dvec *)e2z, tri[2][2] - tri[0][2]);

}


void
render(int n)
{
    int i, j, k;
    int l;

    mudaSet1d((dvec *)rdx, 0.0);
    mudaSet1d((dvec *)rdy, 0.0);
    mudaSet1d((dvec *)rdz, -1.0);

    double x, y;
    double step = 1.0 / (WIDTH * 0.5);

    for (j = 0; j < HEIGHT; j++) {
        for (i = 0; i < WIDTH; i += 4) {

            x = (i - (WIDTH * 0.5)) / (WIDTH * 0.5);
            y = (j - (HEIGHT * 0.5)) / (HEIGHT * 0.5);

            mudaSet4d((dvec *)rox, x, x + step, x + 2 * step, x + 3 * step);
            mudaSet1d((dvec *)roy, y);
            mudaSet1d((dvec *)roz, 0.0);

            // printf("rox = %f\n", rox[0]);
            // printf("roy = %f\n", roy[0]);
            // printf("roz = %f\n", roz[0]);

            // MUDA accelerated interesection calculation.
		for (l = 0; l < n; l++) {
            mudaSet1d((dvec *)t, DBL_MAX);
            mudaSet1d((dvec *)mask, 0.0);

		    isect(rox, roy, roz, rdx, rdy, rdz,
			  v0x, v0y, v0z, e1x, e1y, e1z, e2x, e2y, e2z,
			  mask, t, u, v);
		}		


            for (k = 0; k < 4; k++) {
                if (mask[k]) {
                    image[3 * (j * WIDTH + i + k) + 0] = scale(u[k]);
                    image[3 * (j * WIDTH + i + k) + 1] = scale(v[k]);
                    image[3 * (j * WIDTH + i + k) + 2] = 255;
                }
            }
        }
    }

}

int
main(int argc, char **argv)
{
    init();

    printf("BEGIN render\n");
    muda_timer_t st, et;
    mudaGetTime(&st);
    render(10000);
    mudaGetTime(&et);
    printf("elapsed = %f msec\n", mudaElapsedTimeInMSec(&st, &et));
    printf("END render\n");

    saveppm("render.ppm", image, WIDTH, HEIGHT);
    printf("Saved image [ render.ppm ]\n");

    return 0;
}

