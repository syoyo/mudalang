#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "muda.h"

#if defined(__SSE__)
#include <xmmintrin.h>
#endif

//
// TODO:
//
//   - Should we consider endianness?
//


static inline ceil16(unsigned int val)
{
    return (val + 15) & (~15);
}


void
mudaPrint4f(const vec *v)
{

    printf("%f, %f, %f, %f\n",
        v->f[0], v->f[1], v->f[2], v->f[3]);
        
}

void
mudaSet4f(vec         *v,
          const float  f0,
          const float  f1,
          const float  f2,
          const float  f3)
{
    v->f[0] = f0;
    v->f[1] = f1;
    v->f[2] = f2;
    v->f[3] = f3;
}

#if 0
void
mudaSet4d(dvec         *v,
          const double  f0,
          const double  f1,
          const double  f2,
          const double  f3)
{
    v->f[0] = f0;
    v->f[1] = f1;
    v->f[2] = f2;
    v->f[3] = f3;
}
#endif

void
mudaSet1f(vec         *v,
          const float  f0)
{
    v->f[0] = f0;
    v->f[1] = f0;
    v->f[2] = f0;
    v->f[3] = f0;
}

#if 0
void
mudaSet1d(dvec         *v,
          const double  f0)
{
    v->f[0] = f0;
    v->f[1] = f0;
    v->f[2] = f0;
    v->f[3] = f0;
}
#endif


//
// TODO: Make our own memory manager?
//
void *mudaAlloc(size_t size, unsigned int align)
{

    int alignFixed;

    alignFixed = ceil16(align);
    if (alignFixed == 0) alignFixed = 16;

#ifdef __APPLE__

    void *p;
    int   ret;
    
    assert(alignFixed == 16);   // TODO: support align > 16
    p = malloc(size);

    if (p == 0) {
        fprintf(stderr, "[MUDA] alloc err. \n");
        exit(1);
    }

    return p;

#elif defined(__SSE__)

    void *p;
    int   ret;
    
    p = _mm_malloc(size, alignFixed);

    if (p == 0) {
        fprintf(stderr, "[MUDA] alloc err. \n");
        exit(1);
    }

    return p;

#elif defined(__GNUC__)

    void *p;
    int   ret;
    
    ret = posix_memalign(&p, alignFixed, size);

    if (ret != 0) {
        fprintf(stderr, "[MUDA] alloc err. code = %d\n", ret);
        exit(1);
    }

    return p;

#else

#error TODO

#endif

}

void
mudaGetTime(muda_timer_t *t)
{
#ifdef WIN32
	QueryPerformanceCounter(&t->time);
#else
	gettimeofday(&t->time, NULL);
#endif
}

double
mudaElapsedTimeInMSec(muda_timer_t *start, muda_timer_t *end)
{
	double elap;

#ifdef WIN32
	LARGE_INTEGER freq;

	QueryPerformanceFrequency(&freq);
	elap = ((double)end->time.QuadPart - (double)start->time.QuadPart) / (double)freq.QuadPart;
#else

    // in sec
	elap = (double)(end->time.tv_sec - start->time.tv_sec) + 
		(double)(end->time.tv_usec - start->time.tv_usec) / (double)1.0e6;

    // in msec
    elap = elap * 1000.0;
#endif

	return elap;
	
}
