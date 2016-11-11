#ifndef MUDA_H
#define MUDA_H

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __GNUC__
#define ATTRIB_ALIGN(x) __attribute__((aligned((x))))
#elif defined(_MSC_VER)
#define ATTRIB_ALIGN(x)
#else
#error "Unsupported compiler"
#endif

#include <stdlib.h>

#ifdef WIN32
#include <windows.h>
#else
#include <sys/time.h>
#endif

#ifdef __SSE2__
#include <emmintrin.h>
#endif

#ifdef __ARM_NEON__
#include "SSE2NEON.h"
//#include <arm_neon.h>
#endif

typedef union
{
#ifdef __SSE__
	__m128  v;
	__m128i vi;
#elif defined(__ARM_NEON__)
	float32x4_t v;
	int32x4_t vi;
#endif

	float f[4];

} vec;

typedef union
{
#ifdef __SSE__
	struct { __m128d  v[2]; };
#elif defined(__ARM_NEON__)
	struct { float64x2_t v[2]; };
#endif

	double f[4];

} dvec ATTRIB_ALIGN(16);


typedef struct _mytimer_t
{
#ifdef WIN32
	LARGE_INTEGER  time;	
#else
	struct timeval time;
#endif
} muda_timer_t;


// Allocate memory.
// Align must be a multiple of 16.
extern void *mudaAlloc  ( size_t size, unsigned int align );

extern void  mudaPrint4f( const vec  *v );
extern void  mudaPrint4d( const dvec *v );

extern void  mudaSet1f  ( vec            *v,                   // [out]
                           const float    f0 );

static inline void mudaSet1d  ( dvec           *v,                   // [out]
                          const double    d0 )
{
    v->f[0] = d0;
    v->f[1] = d0;
    v->f[2] = d0;
    v->f[3] = d0;
}

extern void  mudaSet4f  ( vec            *v,                   // [out]
                          const float    f0,  
                          const float    f1,  
                          const float    f2,  
                          const float    f3 );  

static inline void mudaSet4d  ( dvec           *v,                   // [out]
                          const double    d0,  
                          const double    d1,  
                          const double    d2,  
                          const double    d3 )
{
    v->f[0] = d0;
    v->f[1] = d1;
    v->f[2] = d2;
    v->f[3] = d3;
}


void   mudaGetTime(muda_timer_t *t);
double mudaElapsedTimeInMSec(muda_timer_t *start, muda_timer_t *end);



#ifdef __cplusplus
}
#endif

#endif // MUDA_H
