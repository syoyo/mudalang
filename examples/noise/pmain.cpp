#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

#include "noise1234.h"

#ifdef USE_SDL
#include <SDL.h>

#ifdef __APPLE__
#include <OpenGL/GL.h>
#else
#include <GL.h>
#endif

SDL_Surface *surface;
unsigned char *image;
#endif

int WIDTH = 512;

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
            
            f = Noise1234::noise(x, y);

            if (j < 10) printf("%f\n", f);

            image[j * w + i] = scale(f);

        }
    }


    saveppm("pnoisemap.ppm", image, w, w);

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
                f = Noise1234::noise(input[0][j * w + i], input[1][j * w + i]);
                image[j * w + i] = f;
            }
        }
    }            

    gettimeofday(&e, NULL);

    double elap = (double)(e.tv_sec - s.tv_sec) +
        (double)(e.tv_usec - s.tv_usec) / (double)1.0e6;

    printf("[Perlin CPU] time: %f sec(%f M mnoise2/sec)\n",
        elap, (NLOOP / elap) * w * w / (1000.0 * 1000.0));
}

#ifdef USE_SDL

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
    int             noctave = 5;
    int             w = WIDTH;
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

            float p = 1.0f;
            float pinv = 1.0f;

            float sum = 0.0f;

            for (k = 0; k < noctave; k++) {

                y = p * (c * j * invw + o * invw);
                x = p * c * i * invw;

                f = Noise1234::noise(x, y);

                sum += f * pinv;

                p    *= 2.0f;
                pinv *= 0.5f;
            }

            image[4 * (j * w + i) + 0] = scale(sum);
            image[4 * (j * w + i) + 1] = scale(sum);
            image[4 * (j * w + i) + 2] = scale(sum);
            image[4 * (j * w + i) + 3] = scale(sum);

        }
    }            

    gettimeofday(&e, NULL);

    elap = (double)(e.tv_sec - s.tv_sec) +
        (double)(e.tv_usec - s.tv_usec) / (double)1.0e6;

    accum_time += elap;

    evaled += noctave * w * w;

    // print each 1 sec.
    if (accum_time > 1.0) {
        printf("[Perlin noise] %f M noise2/sec\n", evaled / (1000.0f * 1000.0f));
        accum_time = 0.0;
        evaled = 0.0;
    }

}

void
display()
{
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

    image = (unsigned char *)malloc(WIDTH * WIDTH * 4);

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
#else
    doit();
#endif
    return 0;
}
