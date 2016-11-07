#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <xmmintrin.h>

// MUDA codes
#include "muda.h"
#include "isect.h"

static void savePPM(unsigned char *img, int width, int height);

static unsigned char clamp(float f)
{
    int val;

    val = (int)(f * 255.5f);
    if (val > 255) val = 255;

    return (unsigned char)val;

}

void
render(int width, int height)
{
    int x, y;
    int widthOver4 = width / 4;

    unsigned char *framebuf;

    framebuf = malloc(width * height * 3);
    if (!framebuf) exit(-1);
    memset(framebuf, 0, width * height * 3);

    ray4 r;
    tri4 tri;

    mudavec rox, roy, roz;
    mudavec rdx, rdy, rdz;
    mudavec t, u, v;
    mudavec ret;

    float dx[4], dy;

    //
    // Common origin
    //
    mudaSet1f(&roz, -1.0f);

    // parallel
    mudaSet1f(&rdx, 0.0f);
    mudaSet1f(&rdy, 0.0f);
    mudaSet1f(&rdz, 1.0f);

    float tridata[][3] = {
        {-1.0f,  1.0f, 1.0f},
        { 1.0f,  1.0f, 1.0f},
        { 1.0f, -1.0f, 1.0f},
    };

    setupTri4(&tri,
        &tridata[0][0],
        &tridata[0][1],
        &tridata[0][2],
        &tridata[1][0],
        &tridata[1][1],
        &tridata[1][2],
        &tridata[2][0],
        &tridata[2][1],
        &tridata[2][2]);
        
    for (y = 0; y < width; y++) {

        dy = ((float)height - (float)(2 * y)) / (float)height;

        mudaSet4f(&roy, dy, dy, dy, dy);

        //
        // Process 4 pixels simulateneously with SIMD.
        //
        for (x = 0; x < widthOver4; x++) {

            dx[0] = ((float)(2 * (4 * x + 0)) - (float)width)  / (float)width;
            dx[1] = ((float)(2 * (4 * x + 1)) - (float)width)  / (float)width;
            dx[2] = ((float)(2 * (4 * x + 2)) - (float)width)  / (float)width;
            dx[3] = ((float)(2 * (4 * x + 3)) - (float)width)  / (float)width;
        
            mudaSet4f(&rox, dx[0], dx[1], dx[2], dx[3]);
            
            // isect

            setupRay4(&r, (const __m128 *)&rox, (const __m128 *)&roy, (const __m128 *)&roz, (const __m128 *)&rdx, (const __m128 *)&rdy, (const __m128 *)&rdz);


            mudaSet1f(&t, 1.0e+30f);

            ret = (mudavec)isect(&r, &tri, (__m128 *)&t, (__m128 *)&u, (__m128 *)&v);

            int k;
            for (k = 0; k < 4; k++) {

                if (ret.f[k]) {
                    framebuf[3 * (y * width + 4 * x + k) + 0] = clamp(u.f[k]);
                    framebuf[3 * (y * width + 4 * x + k) + 1] = clamp(v.f[k]);
                }

            }

        }

    } 


    savePPM(framebuf, width, height);

}

void
savePPM(unsigned char *img, int width, int height)
{
    int x;
    int y;

    FILE *fp;

    fp = fopen("output.ppm", "wb");
    if (!fp) exit(-1);

    fprintf(fp, "P6\n");
    fprintf(fp, "%d %d\n", width, height);
    fprintf(fp, "255\n");

    fwrite(img, 3 * width * height, 1, fp);

    fclose(fp);

}

int
main(int argc, char **argv)
{
    render(128, 128);

    return 0;
}
