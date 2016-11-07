#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

#ifdef USE_SDL
#include <SDL.h>

#ifdef __APPLE__
#include <OpenGL/GL.h>
#else
#include <GL.h>
#endif
#endif

#include "muda.h"

#include "snoise.h"
#include "snoise_cpu.h"

#define WIDTH 512

#ifdef USE_SDL
SDL_Surface *surface;
unsigned char *image;
#endif

void saveppm(const char *filename, unsigned char *img, int x, int y)
{
    FILE *fp;

    fp = fopen(filename, "wb");

    fprintf(fp, "P6\n");
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
    int             w = WIDTH;
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

            x = c * (i + 0.0f) / (float)w;
            
            // memoized version.
            f = snoise2_cpu(x, y);

            image[3 * (j * w + i) + 0] = scale(f);
            image[3 * (j * w + i) + 1] = scale(f);
            image[3 * (j * w + i) + 2] = scale(f);

        }
    }


    saveppm("snoisemap.ppm", image, w, w);

    free(image);
}

void
doit_muda()
{
    int             w = WIDTH;
    int             i, j, k;
    unsigned char  *image;
    float           c = 8.0f;
    vec             x;
    vec             y;
    vec             f;

    image = (unsigned char *)malloc(w * w * 3);

    for (j = 0; j < w; j++) {

        mudaSet1f(&y, c * j / (float)w);

        for (i = 0; i < w; i += 4) {

            x.f[0] = c * (i + 0.0f) / (float)w;
            x.f[1] = c * (i + 1.0f) / (float)w;
            x.f[2] = c * (i + 2.0f) / (float)w;
            x.f[3] = c * (i + 3.0f) / (float)w;
            
            // memoized version.
            snoise2(&f, &x, &y);

            for (k = 0; k < 4; k++) {
                image[3 * (j * w + i + k) + 0] = scale(f.f[k]);
                image[3 * (j * w + i + k) + 1] = scale(f.f[k]);
                image[3 * (j * w + i + k) + 2] = scale(f.f[k]);
            }

        }
    }


    saveppm("snoisemap_muda.ppm", image, w, w);

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
                f = snoise2_cpu(input[0][j * w + i], input[1][j * w + i]);
                image[j * w + i] = f;
            }
        }
    }            

    gettimeofday(&e, NULL);

    double elap = (double)(e.tv_sec - s.tv_sec) +
        (double)(e.tv_usec - s.tv_usec) / (double)1.0e6;

    printf("[Simplex noise CPU] time: %f sec(%f M mnoise2/sec)\n",
        elap, (NLOOP / elap) * w * w / (1000.0 * 1000.0));
}

void
perf_mu()
{
    int             w = 256;
    int             i, j, k;
    float          *image;
    float           b0, b1, b2, b3;
    float           c = 4.0f;
    float           invw = 1.0f / (float)w;;
    vec             x;
    vec             y;
    vec             f;
    float          *input[2];

    image = (float *)mudaAlloc(sizeof(float) * w * w, 16);
    input[0] = (float *)mudaAlloc(sizeof(float) * w * w, 16);
    input[1] = (float *)mudaAlloc(sizeof(float) * w * w, 16);

    assert((uintptr_t)input[0] % 16 == 0);
    assert((uintptr_t)input[1] % 16 == 0);

    //
    // Setup input data
    // 
    for (j = 0; j < w; j++) {

        mudaSet1f(&y, c * j * invw);

        for (i = 0; i < w; i+=4) {

            b0 = c * (i + 0.0f) * invw;
            b1 = c * (i + 1.0f) * invw;
            b2 = c * (i + 2.0f) * invw;
            b3 = c * (i + 3.0f) * invw;

            input[0][j * w + i + 0] = b0;
            input[0][j * w + i + 1] = b1;
            input[0][j * w + i + 2] = b2;
            input[0][j * w + i + 3] = b3;
            input[1][j * w + i + 0] = y.f[0];
            input[1][j * w + i + 1] = y.f[1];
            input[1][j * w + i + 2] = y.f[2];
            input[1][j * w + i + 3] = y.f[3];

        }

    }

    struct timeval s, e;

    int NLOOP = 1000;

    gettimeofday(&s, NULL);

    for (k = 0; k < NLOOP; k++) {
        for (j = 0; j < w; j++) {
            for (i = 0; i < w; i+=4) {
                snoise2(&f, &input[0][j * w + i], &input[1][j * w + i]);
                image[j * w + i + 0] = f.f[0];
                image[j * w + i + 1] = f.f[1];
                image[j * w + i + 2] = f.f[2];
                image[j * w + i + 3] = f.f[3];
            }
        }
    }            

    gettimeofday(&e, NULL);

    double elap = (double)(e.tv_sec - s.tv_sec) +
        (double)(e.tv_usec - s.tv_usec) / (double)1.0e6;

    printf("[MUDA] time: %f sec(%f M snoise2/sec)\n",
        elap, (NLOOP / elap) * w * w / (1000.0 * 1000.0));

#if 1
    //
    // Memoized version.
    //

    // Buffers for memoization.
    vec             xi, yi, mask;
    vec             h0, h1, h2;

    gettimeofday(&s, NULL);

    mudaSet1f(&xi, -100000.0f);
    mudaSet1f(&yi, -100000.0f);         // Invalidate memo
    mudaSet1f(&mask, -100000.0f);       // Invalidate memo

    for (k = 0; k < NLOOP; k++) {
        for (j = 0; j < w; j++) {
            for (i = 0; i < w; i+=4) {
                snoise2_memo(&f, &input[0][j * w + i], &input[1][j * w + i],
                             &xi, &yi, &mask,
                             &h0, &h1, &h2);
                image[j * w + i + 0] = f.f[0];
                image[j * w + i + 1] = f.f[1];
                image[j * w + i + 2] = f.f[2];
                image[j * w + i + 3] = f.f[3];
            }
        }
    }            

    gettimeofday(&e, NULL);

    elap = (double)(e.tv_sec - s.tv_sec) +
        (double)(e.tv_usec - s.tv_usec) / (double)1.0e6;

    printf("[MUDA, memoized ver] time: %f sec(%f M mnoise2/sec)\n",
        elap, (NLOOP / elap) * w * w / (1000.0 * 1000.0));
#endif
}

#ifdef USE_SDL

//
// x86 only hack :)
//
// [-1.0, 1.0] x 4 -> [0, 256) x 16
void float4tobyte16(vec f, unsigned char *dst)
{
    vec fx, fy, fz, fw;
    
    __m128 k127  = _mm_set1_ps(127.75f);
    __m128 kone  = _mm_set1_ps(1.0f);
    __m128 khalf = _mm_set1_ps(0.5f);

    // [-1.0, 1.0] => [0, 256)
    __m128i i4 = _mm_cvttps_epi32(_mm_mul_ps(_mm_add_ps(kone, f.v), k127));

    // x y z w => xxxx, yyyy, zzzz, wwww
    __m128i ix = _mm_shuffle_epi32(i4, _MM_SHUFFLE(0, 0, 0, 0));
    __m128i iy = _mm_shuffle_epi32(i4, _MM_SHUFFLE(1, 1, 1, 1));
    __m128i iz = _mm_shuffle_epi32(i4, _MM_SHUFFLE(2, 2, 2, 2));
    __m128i iw = _mm_shuffle_epi32(i4, _MM_SHUFFLE(3, 3, 3, 3));

    // i32 -> i16 -> u8
    __m128i ix16 = _mm_packs_epi32(ix, ix);
    __m128i ux8  = _mm_packus_epi16(ix16, ix16);
    __m128i iy16 = _mm_packs_epi32(iy, iy);
    __m128i uy8  = _mm_packus_epi16(iy16, iy16);
    __m128i iz16 = _mm_packs_epi32(iz, iz);
    __m128i uz8  = _mm_packus_epi16(iz16, iz16);
    __m128i iw16 = _mm_packs_epi32(iw, iw);
    __m128i uw8  = _mm_packus_epi16(iw16, iw16);

    // xxxx, yyyy, zzzz, wwww => xxxxyyyyzzzzzwwwww

    __m128i final = _mm_unpackhi_epi32(_mm_unpackhi_epi32(ux8, uz8),
                                       _mm_unpackhi_epi32(uy8, uw8));


    _mm_storeu_si128((__m128i *)dst, final);
    
}

void
render_cpu()
{
    static float    cinc = 0.1f;
    static float    c    = 1.0f;
    static float    oinc = 50.0f;
    static float    o    = 0.0f;
    static double   accum_time = 0.0f;
    static double   evaled = 0.0;

    int             i, j, k;
    int             w = WIDTH;
    int             noctave = 5;
    float           invw = 1.0f / (double)WIDTH;
    float           f;
    float           x, y;

    struct timeval  s, e;
    double          elap;

    // animation
    c += cinc;
    if (c > 40.0f) cinc = -cinc;
    if (c < 1.0f) cinc = -cinc;

    o += oinc;
    if (o > 400000.0f) oinc = -oinc;
    if (o < 0.0f) oinc = -oinc;

    gettimeofday(&s, NULL);

    for (j = 0; j < w; j++) {

        for (i = 0; i < w; i++) {

            float p    = 1.0f;
            float pinv = 1.0f;

            float sum;

            sum = 0.0f;

            for (k = 0; k < noctave; k++) {

                y = p * (c * j * invw + o * invw);

                x = p * c * ((i + 0.0f) * invw);

                f = snoise2_cpu(x, y);

                sum += f * pinv;

                p    *= 2.0f;
                pinv *= 0.5f;
            }

            image[4 * (j * w + i) + 0] = scale(sum);
            image[4 * (j * w + i) + 1] = scale(sum);
            image[4 * (j * w + i) + 2] = scale(sum);
            image[4 * (j * w + i) + 3] = 255;

        }
    }            

    gettimeofday(&e, NULL);

    elap = (double)(e.tv_sec - s.tv_sec) +
        (double)(e.tv_usec - s.tv_usec) / (double)1.0e6;

    accum_time += elap;

    evaled += noctave * w * w;

    // print each 1 sec.
    if (accum_time > 1.0) {
        printf("[CPU] %f M noise2/sec\n", evaled / (1000.0f * 1000.0f));
        accum_time = 0.0;
        evaled = 0.0;
    }

}

void
render()
{
    static float    cinc = 0.1f;
    static float    c    = 1.0f;
    static float    oinc = 50.0f;
    static float    o    = 0.0f;
    static double   accum_time = 0.0f;
    static double   evaled = 0.0;

    int             i, j, k;
    int             w = WIDTH;
    int             noctave = 5;
    float           invw = 1.0f / (double)WIDTH;
    vec             f[8];
    vec             x[8], y[8];

    struct timeval  s, e;
    double          elap;

    // animation
    c += cinc;
    if (c > 40.0f) cinc = -cinc;
    if (c < 1.0f) cinc = -cinc;

    o += oinc;
    if (o > 400000.0f) oinc = -oinc;
    if (o < 0.0f) oinc = -oinc;

    gettimeofday(&s, NULL);

    for (j = 0; j < w; j++) {

        for (i = 0; i < w; i+=4) {

            float p    = 1.0f;
            float pinv = 1.0f;

            vec sum;

            // hack
            sum.v = _mm_setzero_ps();

            for (k = 0; k < noctave; k++) {

                mudaSet1f(&y[k], p * (c * j * invw + o * invw));

                x[k].f[0] = p * c * ((i + 0.0f) * invw);
                x[k].f[1] = p * c * ((i + 1.0f) * invw);
                x[k].f[2] = p * c * ((i + 2.0f) * invw);
                x[k].f[3] = p * c * ((i + 3.0f) * invw);

                snoise2(&f[k], &x[k], &y[k]);

                // hack
                // f[k].v = _mm_mul_ps(_mm_set1_ps(p), (__m128)_mm_srli_epi32(_mm_slli_epi32( (__m128i)f[k].v, 1), 1)); // p * fabs(x)
                f[k].v = _mm_mul_ps(_mm_set1_ps(pinv), f[k].v);

                sum.v = _mm_add_ps(sum.v, f[k].v);

                p    *= 2.0f;
                pinv *= 0.5f;
            }

            /* This code is very slow
            for (k = 0; k < 4; k++) {
                image[4 * (j * w + i + k) + 0] = scale(f.f[k]);
                image[4 * (j * w + i + k) + 1] = scale(f.f[k]);
                image[4 * (j * w + i + k) + 2] = scale(f.f[k]);
                image[4 * (j * w + i + k) + 3] = scale(f.f[k]);
            }
            */

            /* faster code */
            //float4tobyte16(f, &image[4 * (j * w + i)]);
            float4tobyte16(sum, &image[4 * (j * w + i)]);
        
        }
    }            

    gettimeofday(&e, NULL);

    elap = (double)(e.tv_sec - s.tv_sec) +
        (double)(e.tv_usec - s.tv_usec) / (double)1.0e6;

    accum_time += elap;

    evaled += noctave * w * w;

    // print each 1 sec.
    if (accum_time > 1.0) {
        printf("[MUDA] %f M noise2/sec\n", evaled / (1000.0f * 1000.0f));
        accum_time = 0.0;
        evaled = 0.0;
    }

}

void
display()
{
    //render_cpu();
    render();

    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glDrawPixels(WIDTH, WIDTH, GL_RGBA, GL_UNSIGNED_BYTE, image);

    SDL_GL_SwapBuffers();
}


void
loop_sdl()
{
    SDL_Event event;
    SDL_Init(SDL_INIT_VIDEO);

    SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
    surface = SDL_SetVideoMode(WIDTH, WIDTH, 32, SDL_OPENGL);

    image = malloc(WIDTH * WIDTH * 4);

    while (1) {
        while (SDL_PollEvent(&event)) {

            if ((event.type == SDL_QUIT) ||
                 (event.type == SDL_KEYUP) &&
                 (((event.key.keysym.sym == SDLK_ESCAPE) ||
                   (event.key.keysym.sym == SDLK_q)))) {
                goto quit_app;
            }
        }

        display();
        SDL_Delay(0);
    }

quit_app:

    SDL_Quit();

}
#endif

int
main(int argc, char **argv)
{
#ifdef USE_SDL
    loop_sdl();
#elif PERF
    perf();
    perf_mu();
#else
    doit();
    doit_muda();
#endif
    return 0;
}
