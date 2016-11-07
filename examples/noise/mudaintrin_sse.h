//
// The following code is generated by MUDA compiler
//
#ifndef MUDAINTRIN_SSE_H
#define MUDAINTRIN_SSE_H

#include <xmmintrin.h>

#ifdef __GNUC__
#ifndef MUDA_INLINE
#define MUDA_INLINE        inline
#endif
#ifndef MUDA_ALWAYS_INLINE
#define MUDA_ALWAYS_INLINE __inline__ __attribute__((always_inline))
#endif
#ifndef MUDA_STATIC
#define MUDA_STATIC        static
#endif
#else
#define MUDA_INLINE        __inline
#define MUDA_ALWAYS_INLINE __inline
#define MUDA_STATIC        static
#endif // __GNUC_

#include "muda.h"
#include "muda_sse.h"

#ifdef __64bit__
    #error "64bit env is not yet supported"
#else
#endif


#ifdef __GNUC__
MUDA_STATIC MUDA_INLINE void *muda_aligned_addr16(void *addr) {
    return (void *)((((unsigned int)addr) + 15UL) & ~(15UL));
}
#endif

#ifdef __GNUC__
    #define MUDA_ATTRIB_ALIGN __attribute__((aligned(16)))
    #define MUDA_DECL_ALIGN
#elif defined(_MSC_VER)
    #define MUDA_ATTRIB_ALIGN
    #define MUDA_DECL_ALIGN __declspec(align(16))
#else
    #error "Sorry, MUDA doesn't support your compiler"
#endif


MUDA_STATIC MUDA_ALWAYS_INLINE __m128 muda_sel_ps( const __m128 a, const __m128 b, const __m128 mask )
{
#ifdef __SSE41__
    return _mm_blend_ps(a, b, mask);
#else
    const __m128 tmp0 = _mm_and_ps( b, mask );
    const __m128 tmp1 = _mm_andnot_ps( mask, a);
    return _mm_or_ps( tmp1, tmp0 );
#endif
}

// from AltiVec/SSE migration guide
// this can be replaced with cvttps2pi?
MUDA_STATIC MUDA_ALWAYS_INLINE __m128 muda_trunc_ps( const __m128 x )
{
    const __m128 twoTo23 = (__m128)_mm_set1_epi32(0x4b000000); // 2**23
    const __m128 b = (__m128)_mm_srli_epi32(_mm_slli_epi32( (__m128i)x, 1), 1); // fabs(x) 
    const __m128 d = _mm_sub_ps(_mm_add_ps( b, twoTo23), twoTo23);
    const __m128 largeMaskE = _mm_cmpgt_ps( b, twoTo23); // -1 if x>= 2**23
    const __m128 g = _mm_cmplt_ps( b, d );
    const __m128 h = _mm_cvtepi32_ps( (__m128i)g ); // -1.0 or 0.0
    const __m128 t = _mm_add_ps( d, h );
    const __m128 sign = (__m128)_mm_slli_epi32( _mm_srli_epi32( (__m128i)x, 31), 31);
    const __m128 tt = _mm_or_ps( t, sign );
    const __m128 vv = _mm_and_ps( x, largeMaskE );
    const __m128 ttt = _mm_andnot_ps( largeMaskE, tt );
    return _mm_or_ps( ttt, vv );
}

// If we fix rounding mode, the code can be simplified more.
MUDA_STATIC MUDA_ALWAYS_INLINE __m128 muda_floor_ps( const __m128 x )
{
    const __m128 twoTo23 = (__m128)_mm_set1_epi32(0x4b000000); // 2**23
    const __m128 b = (__m128)_mm_srli_epi32(_mm_slli_epi32( (__m128i)x, 1), 1); // fabs(x) 
    const __m128 d = _mm_sub_ps(_mm_add_ps(_mm_add_ps(_mm_sub_ps( x, twoTo23), twoTo23), twoTo23), twoTo23); // the meat of floor
    const __m128 largeMaskE = _mm_cmpgt_ps( b, twoTo23); // -1 if x>= 2**23
    const __m128 g = _mm_cmplt_ps( b, d );
    const __m128 h = _mm_cvtepi32_ps( (__m128i)g );
    const __m128 t = _mm_add_ps( d, h );
    const __m128 sign = (__m128)_mm_slli_epi32( _mm_srli_epi32( (__m128i)x, 31), 31);
    const __m128 tt = _mm_or_ps( t, sign );
    const __m128 vv = _mm_and_ps( x, largeMaskE );
    const __m128 ttt = _mm_andnot_ps( largeMaskE, tt );
    return _mm_or_ps( ttt, vv );
}


MUDA_STATIC MUDA_ALWAYS_INLINE __m128 muda_ceil_ps( const __m128 x )
{
    const __m128 twoTo23 = (__m128)_mm_set1_epi32(0x4b000000); // 2**23
    const __m128 one = _mm_set1_ps(1.0f);
    const __m128 b = (__m128)_mm_srli_epi32(_mm_slli_epi32( (__m128i)x, 1), 1); // fabs(x) 
    const __m128 d = _mm_sub_ps(_mm_add_ps(_mm_add_ps(_mm_sub_ps( x, twoTo23), twoTo23), twoTo23), twoTo23); // the meat of ceil
    const __m128 largeMaskE = _mm_cmpgt_ps( b, twoTo23); // -1 if x>= 2**23
    const __m128 g = _mm_cmpgt_ps( b, d );
    const __m128 h = _mm_cvtepi32_ps( (__m128i)g );
    const __m128 t = _mm_sub_ps( d, h );
    const __m128 sign = (__m128)_mm_slli_epi32( _mm_srli_epi32( (__m128i)x, 31), 31);
    const __m128 tt = _mm_or_ps( t, sign );
    const __m128 vv = _mm_and_ps( x, largeMaskE );
    const __m128 ttt = _mm_andnot_ps( largeMaskE, tt );
    return _mm_or_ps( ttt, vv );
}

// TODO: Using and is faster than 2 shift ops?
MUDA_STATIC MUDA_ALWAYS_INLINE __m128 muda_abs_ps( const __m128 x )
{
    const __m128 b = (__m128)_mm_srli_epi32(_mm_slli_epi32( (__m128i)x, 1), 1); // fabs(x) 
    return b;
}

// C99 compatible round() function.
// i.e., Round to nearest integer value. If the input value lies
// exactly halfway between two integer value, round away from zero.
//
// TODO: Handle NaN case?
MUDA_STATIC MUDA_ALWAYS_INLINE __m128 muda_round_ps( const __m128 x )
{
    const __m128 b = (__m128)_mm_srli_epi32(_mm_slli_epi32( (__m128i)x, 1), 1); // fabs(x) 
    const __m128 t = muda_ceil_ps( b );
    const __m128 mask = _mm_cmpgt_ps(_mm_sub_ps( t, x ), _mm_set1_ps( 0.5f ));
    const __m128 tt = muda_sel_ps( t, _mm_sub_ps( t, _mm_set1_ps(1.0f) ), mask); // if (t - x > 0.5) t -= 1.0
    const __m128 sign = (__m128)_mm_slli_epi32( _mm_srli_epi32( (__m128i)x, 31), 31);
    return _mm_xor_ps( tt, sign ); // if (x < 0.0) -t else t
}

#include "mudamath_sse.h"

#endif // MUDAINTRIN_SSE_H