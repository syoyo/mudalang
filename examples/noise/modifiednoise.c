#include "mudaintrin_sse.h"

MUDA_STATIC MUDA_ALWAYS_INLINE __m128 fade (const float * t) 
{
    const __m128 t_ld_1 = _mm_load_ps(t + 0) ;
    const __m128 t_vec2_1 = t_ld_1 ;
    const __m128 t_vec1_1 = t_ld_1 ;
    const __m128 t_vec3_1 = _mm_mul_ps(t_vec2_1, t_vec1_1) ;
    const __m128 t_vec4_1 = t_ld_1 ;
    const __m128 t_vec5_1 = _mm_mul_ps(t_vec3_1, t_vec4_1) ;
    const __m128 t_vec6_1 = t_ld_1 ;
    const float t_float8_1 = 6.0 ;
    const float t_float7_1 = t_float8_1 ;
    const __m128 t_vec9_1 = _mm_set_ps1(  t_float7_1  ) ;
    const __m128 t_vec10_1 = t_ld_1 ;
    const __m128 t_vec11_1 = _mm_mul_ps(t_vec9_1, t_vec10_1) ;
    const float t_float12_1 = 15.0 ;
    const float t_float13_1 = t_float12_1 ;
    const __m128 t_vec14_1 = _mm_set_ps1(  t_float13_1  ) ;
    const __m128 t_vec15_1 = _mm_sub_ps(t_vec11_1, t_vec14_1) ;
    const __m128 t_vec16_1 = _mm_mul_ps(t_vec6_1, t_vec15_1) ;
    const float t_float17_1 = 10.0 ;
    const float t_float18_1 = t_float17_1 ;
    const __m128 t_vec19_1 = _mm_set_ps1(  t_float18_1  ) ;
    const __m128 t_vec20_1 = _mm_add_ps(t_vec16_1, t_vec19_1) ;
    const __m128 t_vec21_1 = _mm_mul_ps(t_vec5_1, t_vec20_1) ;
    return t_vec21_1 ;
}

MUDA_STATIC MUDA_ALWAYS_INLINE __m128 flerp (const float * t, const float * a, const float * b) 
{
    const __m128 t_ld_1 = _mm_load_ps(t + 0) ;
    const __m128 a_ld_1 = _mm_load_ps(a + 0) ;
    const __m128 b_ld_1 = _mm_load_ps(b + 0) ;
    const float t_float23_1 = 1.0 ;
    const float t_float22_1 = t_float23_1 ;
    const __m128 t_vec25_1 = _mm_set_ps1(  t_float22_1  ) ;
    const __m128 t_vec24_1 = t_ld_1 ;
    const __m128 t_vec26_1 = _mm_sub_ps(t_vec25_1, t_vec24_1) ;
    const __m128 t_vec27_1 = a_ld_1 ;
    const __m128 t_vec28_1 = _mm_mul_ps(t_vec26_1, t_vec27_1) ;
    const __m128 t_vec29_1 = t_ld_1 ;
    const __m128 t_vec30_1 = b_ld_1 ;
    const __m128 t_vec31_1 = _mm_mul_ps(t_vec29_1, t_vec30_1) ;
    const __m128 t_vec32_1 = _mm_add_ps(t_vec28_1, t_vec31_1) ;
    return t_vec32_1 ;
}

MUDA_STATIC MUDA_ALWAYS_INLINE __m128 fastfloor (const float * x) 
{
    const __m128 x_ld_1 = _mm_load_ps(x + 0) ;
    const __m128 t_vec36_1 = x_ld_1 ;
    const float t_float34_1 = 0.0 ;
    const float t_float33_1 = t_float34_1 ;
    const __m128 t_vec35_1 = _mm_set_ps1(  t_float33_1  ) ;
    const __m128 t_vec37_1 = t_vec35_1 ;
    const __m128 t_vec38_1 = _mm_cmpgt_ps(t_vec36_1, t_vec37_1) ;
    __m128 s_1 = t_vec38_1 ;
    
    const __m128 t_vec39_1 = x_ld_1 ;
    const __m128 t_vec40_1 = _mm_cvtepi32_ps(_mm_cvttps_epi32( t_vec39_1 )) ;
    __m128 xi_1 = t_vec40_1 ;
    
    const __m128 t_vec41_1 = xi_1 ;
    const float t_float42_1 = 1.0 ;
    const float t_float43_1 = t_float42_1 ;
    const __m128 t_vec44_1 = _mm_set_ps1(  t_float43_1  ) ;
    const __m128 t_vec45_1 = t_vec44_1 ;
    const __m128 t_vec46_1 = _mm_sub_ps(t_vec41_1, t_vec45_1) ;
    __m128 x1_1 = t_vec46_1 ;
    
    const __m128 t_vec47_1 = x1_1 ;
    const __m128 t_vec48_1 = xi_1 ;
    const __m128 t_vec49_1 = s_1 ;
    const __m128 t_vec50_1 = muda_sel_ps (t_vec47_1, t_vec48_1, t_vec49_1) ;
    return t_vec50_1 ;
}

MUDA_STATIC MUDA_ALWAYS_INLINE __m128 hash (const float * x, const float * m, const float * invm) 
{
    const __m128 x_ld_1 = _mm_load_ps(x + 0) ;
    const __m128 m_ld_1 = _mm_load_ps(m + 0) ;
    const __m128 invm_ld_1 = _mm_load_ps(invm + 0) ;
    const __m128 t_vec52_1 = x_ld_1 ;
    const __m128 t_vec51_1 = x_ld_1 ;
    const __m128 t_vec53_1 = _mm_mul_ps(t_vec52_1, t_vec51_1) ;
    __m128 x2_1 = t_vec53_1 ;
    
    const __m128 t_vec54_1 = x2_1 ;
    const __m128 t_vec55_1 = x2_1 ;
    const __m128 t_vec56_1 = invm_ld_1 ;
    const __m128 t_vec57_1 = _mm_mul_ps(t_vec55_1, t_vec56_1) ;
    const __m128 t_vec58_1 = (__m128) fastfloor ((float *) &( t_vec57_1) ) ;
    const __m128 t_vec59_1 = m_ld_1 ;
    const __m128 t_vec60_1 = _mm_mul_ps(t_vec58_1, t_vec59_1) ;
    const __m128 t_vec61_1 = _mm_sub_ps(t_vec54_1, t_vec60_1) ;
    return t_vec61_1 ;
}

MUDA_STATIC MUDA_ALWAYS_INLINE __m128 grad2 (const float * h, const float * f0, const float * f1) 
{
    const __m128 h_ld_1 = _mm_load_ps(h + 0) ;
    const __m128 f0_ld_1 = _mm_load_ps(f0 + 0) ;
    const __m128 f1_ld_1 = _mm_load_ps(f1 + 0) ;
    const __m128 t_vec62_1 = h_ld_1 ;
    const __m128i t_ivec63_1 = (__m128i)_mm_cvttps_epi32( t_vec62_1) ;
    __m128i ih_1 = t_ivec63_1 ;
    
    const __m128i t_ivec64_1 = ih_1 ;
    const int t_int66_1 = 1 ;
    const int t_int65_1 = t_int66_1 ;
    const __m128i t_ivec67_1 = _mm_set1_epi32(  t_int65_1  ) ;
    const __m128i t_ivec68_1 = _mm_and_si128(t_ivec64_1, t_ivec67_1) ;
    const int t_int69_1 = 31 ;
    const int t_int70_1 = t_int69_1 ;
    const __m128i t_ivec72_1  =  _mm_slli_epi32((__m128i) t_ivec68_1 ,  t_int70_1) ;
    __m128i xs_1 = t_ivec72_1 ;
    
    const __m128i t_ivec73_1 = ih_1 ;
    const int t_int74_1 = 2 ;
    const int t_int75_1 = t_int74_1 ;
    const __m128i t_ivec76_1 = _mm_set1_epi32(  t_int75_1  ) ;
    const __m128i t_ivec77_1 = _mm_and_si128(t_ivec73_1, t_ivec76_1) ;
    const int t_int78_1 = 30 ;
    const int t_int79_1 = t_int78_1 ;
    const __m128i t_ivec81_1  =  _mm_slli_epi32((__m128i) t_ivec77_1 ,  t_int79_1) ;
    __m128i ys_1 = t_ivec81_1 ;
    
    const __m128 t_vec82_1 = f0_ld_1 ;
    const __m128i t_ivec83_1 = xs_1 ;
    const __m128 t_vec84_1 = (__m128)( t_ivec83_1) ;
    const __m128 t_vec85_1 = _mm_xor_ps(t_vec82_1, t_vec84_1) ;
    const __m128 t_vec86_1 = f1_ld_1 ;
    const __m128i t_ivec87_1 = ys_1 ;
    const __m128 t_vec88_1 = (__m128)( t_ivec87_1) ;
    const __m128 t_vec89_1 = _mm_xor_ps(t_vec86_1, t_vec88_1) ;
    const __m128 t_vec90_1 = _mm_add_ps(t_vec85_1, t_vec89_1) ;
    return t_vec90_1 ;
}

void mnoise2 (float * value, const float * x, const float * y) 
{
    const __m128 x_ld_1 = _mm_load_ps(x + 0) ;
    const __m128 y_ld_1 = _mm_load_ps(y + 0) ;
    const float t_float92_1 = 221.0 ;
    const float t_float91_1 = t_float92_1 ;
    const __m128 t_vec94_1 = _mm_set_ps1(  t_float91_1  ) ;
    const __m128 t_vec93_1 = t_vec94_1 ;
    __m128 base_1 = t_vec93_1 ;
    
    const float t_float95_1 = 4.5249e-3 ;
    const float t_float96_1 = t_float95_1 ;
    const __m128 t_vec97_1 = _mm_set_ps1(  t_float96_1  ) ;
    const __m128 t_vec98_1 = t_vec97_1 ;
    __m128 invbase_1 = t_vec98_1 ;
    
    const __m128 t_vec99_1 = x_ld_1 ;
    const __m128 t_vec100_1 = _mm_cvtepi32_ps(_mm_cvttps_epi32( t_vec99_1 )) ;
    __m128 pxi_1 = t_vec100_1 ;
    
    const __m128 t_vec101_1 = y_ld_1 ;
    const __m128 t_vec102_1 = _mm_cvtepi32_ps(_mm_cvttps_epi32( t_vec101_1 )) ;
    __m128 pyi_1 = t_vec102_1 ;
    
    const __m128 t_vec103_1 = x_ld_1 ;
    const __m128 t_vec104_1 = pxi_1 ;
    const __m128 t_vec105_1 = _mm_sub_ps(t_vec103_1, t_vec104_1) ;
    __m128 pxf_1 = t_vec105_1 ;
    
    const __m128 t_vec106_1 = y_ld_1 ;
    const __m128 t_vec107_1 = pyi_1 ;
    const __m128 t_vec108_1 = _mm_sub_ps(t_vec106_1, t_vec107_1) ;
    __m128 pyf_1 = t_vec108_1 ;
    
    const float t_float109_1 = 1.0 ;
    const float t_float110_1 = t_float109_1 ;
    const __m128 t_vec111_1 = _mm_set_ps1(  t_float110_1  ) ;
    const __m128 t_vec112_1 = t_vec111_1 ;
    __m128 c0_1 = t_vec112_1 ;
    
    const float t_float113_1 = 1.0 ;
    const float t_float114_1 = t_float113_1 ;
    const __m128 t_vec115_1 = _mm_set_ps1(  t_float114_1  ) ;
    const __m128 t_vec116_1 = t_vec115_1 ;
    __m128 one_1 = t_vec116_1 ;
    
    const __m128 t_vec117_1 = pyi_1 ;
    const __m128 t_vec118_1 = c0_1 ;
    const __m128 t_vec119_1 = _mm_mul_ps(t_vec117_1, t_vec118_1) ;
    __m128 y0_1 = t_vec119_1 ;
    
    const __m128 t_vec120_1 = pyi_1 ;
    const __m128 t_vec121_1 = one_1 ;
    const __m128 t_vec122_1 = _mm_add_ps(t_vec120_1, t_vec121_1) ;
    const __m128 t_vec123_1 = c0_1 ;
    const __m128 t_vec124_1 = _mm_mul_ps(t_vec122_1, t_vec123_1) ;
    __m128 y1_1 = t_vec124_1 ;
    
    const __m128 t_vec125_1 = pxi_1 ;
    __m128 x0_1 = t_vec125_1 ;
    
    const __m128 t_vec126_1 = pxi_1 ;
    const __m128 t_vec127_1 = one_1 ;
    const __m128 t_vec128_1 = _mm_add_ps(t_vec126_1, t_vec127_1) ;
    __m128 x1_1 = t_vec128_1 ;
    
    const __m128 t_vec129_1 = y0_1 ;
    const __m128 t_vec130_1 = base_1 ;
    const __m128 t_vec131_1 = invbase_1 ;
    const __m128 t_vec132_1 = (__m128) hash ((float *) &( t_vec129_1 ), (float *) &( t_vec130_1 ), (float *) &( t_vec131_1) ) ;
    __m128 hy0_1 = t_vec132_1 ;
    
    const __m128 t_vec133_1 = y1_1 ;
    const __m128 t_vec134_1 = base_1 ;
    const __m128 t_vec135_1 = invbase_1 ;
    const __m128 t_vec136_1 = (__m128) hash ((float *) &( t_vec133_1 ), (float *) &( t_vec134_1 ), (float *) &( t_vec135_1) ) ;
    __m128 hy1_1 = t_vec136_1 ;
    
    const __m128 t_vec137_1 = x0_1 ;
    const __m128 t_vec138_1 = hy0_1 ;
    const __m128 t_vec139_1 = _mm_add_ps(t_vec137_1, t_vec138_1) ;
    const __m128 t_vec140_1 = base_1 ;
    const __m128 t_vec141_1 = invbase_1 ;
    const __m128 t_vec142_1 = (__m128) hash ((float *) &( t_vec139_1 ), (float *) &( t_vec140_1 ), (float *) &( t_vec141_1) ) ;
    __m128 h00_1 = t_vec142_1 ;
    
    const __m128 t_vec143_1 = x1_1 ;
    const __m128 t_vec144_1 = hy0_1 ;
    const __m128 t_vec145_1 = _mm_add_ps(t_vec143_1, t_vec144_1) ;
    const __m128 t_vec146_1 = base_1 ;
    const __m128 t_vec147_1 = invbase_1 ;
    const __m128 t_vec148_1 = (__m128) hash ((float *) &( t_vec145_1 ), (float *) &( t_vec146_1 ), (float *) &( t_vec147_1) ) ;
    __m128 h10_1 = t_vec148_1 ;
    
    const __m128 t_vec149_1 = x0_1 ;
    const __m128 t_vec150_1 = hy1_1 ;
    const __m128 t_vec151_1 = _mm_add_ps(t_vec149_1, t_vec150_1) ;
    const __m128 t_vec152_1 = base_1 ;
    const __m128 t_vec153_1 = invbase_1 ;
    const __m128 t_vec154_1 = (__m128) hash ((float *) &( t_vec151_1 ), (float *) &( t_vec152_1 ), (float *) &( t_vec153_1) ) ;
    __m128 h01_1 = t_vec154_1 ;
    
    const __m128 t_vec155_1 = x1_1 ;
    const __m128 t_vec156_1 = hy1_1 ;
    const __m128 t_vec157_1 = _mm_add_ps(t_vec155_1, t_vec156_1) ;
    const __m128 t_vec158_1 = base_1 ;
    const __m128 t_vec159_1 = invbase_1 ;
    const __m128 t_vec160_1 = (__m128) hash ((float *) &( t_vec157_1 ), (float *) &( t_vec158_1 ), (float *) &( t_vec159_1) ) ;
    __m128 h11_1 = t_vec160_1 ;
    
    const __m128 t_vec161_1 = pxf_1 ;
    __m128 fx0_1 = t_vec161_1 ;
    
    const float t_float162_1 = -1.0 ;
    const float t_float163_1 = t_float162_1 ;
    const __m128 t_vec164_1 = _mm_set_ps1(  t_float163_1  ) ;
    const __m128 t_vec165_1 = t_vec164_1 ;
    const __m128 t_vec166_1 = pxf_1 ;
    const __m128 t_vec167_1 = _mm_add_ps(t_vec165_1, t_vec166_1) ;
    __m128 fx1_1 = t_vec167_1 ;
    
    const __m128 t_vec168_1 = pyf_1 ;
    __m128 fy0_1 = t_vec168_1 ;
    
    const float t_float169_1 = -1.0 ;
    const float t_float170_1 = t_float169_1 ;
    const __m128 t_vec171_1 = _mm_set_ps1(  t_float170_1  ) ;
    const __m128 t_vec172_1 = t_vec171_1 ;
    const __m128 t_vec173_1 = pyf_1 ;
    const __m128 t_vec174_1 = _mm_add_ps(t_vec172_1, t_vec173_1) ;
    __m128 fy1_1 = t_vec174_1 ;
    
    const __m128 t_vec175_1 = h00_1 ;
    const __m128 t_vec176_1 = fx0_1 ;
    const __m128 t_vec177_1 = fy0_1 ;
    const __m128 t_vec178_1 = (__m128) grad2 ((float *) &( t_vec175_1 ), (float *) &( t_vec176_1 ), (float *) &( t_vec177_1) ) ;
    __m128 g00_1 = t_vec178_1 ;
    
    const __m128 t_vec179_1 = h10_1 ;
    const __m128 t_vec180_1 = fx1_1 ;
    const __m128 t_vec181_1 = fy0_1 ;
    const __m128 t_vec182_1 = (__m128) grad2 ((float *) &( t_vec179_1 ), (float *) &( t_vec180_1 ), (float *) &( t_vec181_1) ) ;
    __m128 g10_1 = t_vec182_1 ;
    
    const __m128 t_vec183_1 = h01_1 ;
    const __m128 t_vec184_1 = fx0_1 ;
    const __m128 t_vec185_1 = fy1_1 ;
    const __m128 t_vec186_1 = (__m128) grad2 ((float *) &( t_vec183_1 ), (float *) &( t_vec184_1 ), (float *) &( t_vec185_1) ) ;
    __m128 g01_1 = t_vec186_1 ;
    
    const __m128 t_vec187_1 = h11_1 ;
    const __m128 t_vec188_1 = fx1_1 ;
    const __m128 t_vec189_1 = fy1_1 ;
    const __m128 t_vec190_1 = (__m128) grad2 ((float *) &( t_vec187_1 ), (float *) &( t_vec188_1 ), (float *) &( t_vec189_1) ) ;
    __m128 g11_1 = t_vec190_1 ;
    
    const __m128 t_vec191_1 = pxf_1 ;
    const __m128 t_vec192_1 = (__m128) fade ((float *) &( t_vec191_1) ) ;
    __m128 kx_1 = t_vec192_1 ;
    
    const __m128 t_vec193_1 = pyf_1 ;
    const __m128 t_vec194_1 = (__m128) fade ((float *) &( t_vec193_1) ) ;
    __m128 ky_1 = t_vec194_1 ;
    
    const __m128 t_vec195_1 = ky_1 ;
    const __m128 t_vec196_1 = kx_1 ;
    const __m128 t_vec197_1 = g00_1 ;
    const __m128 t_vec198_1 = g10_1 ;
    const __m128 t_vec199_1 = (__m128) flerp ((float *) &( t_vec196_1 ), (float *) &( t_vec197_1 ), (float *) &( t_vec198_1) ) ;
    const __m128 t_vec200_1 = kx_1 ;
    const __m128 t_vec201_1 = g01_1 ;
    const __m128 t_vec202_1 = g11_1 ;
    const __m128 t_vec203_1 = (__m128) flerp ((float *) &( t_vec200_1 ), (float *) &( t_vec201_1 ), (float *) &( t_vec202_1) ) ;
    const __m128 t_vec204_1 = (__m128) flerp ((float *) &( t_vec195_1 ), (float *) &( t_vec199_1 ), (float *) &( t_vec203_1) ) ;
    __m128 r_1 = t_vec204_1 ;
    
    const float t_float205_1 = 0.507 ;
    const float t_float206_1 = t_float205_1 ;
    const __m128 t_vec207_1 = _mm_set_ps1(  t_float206_1  ) ;
    const __m128 t_vec208_1 = r_1 ;
    const __m128 t_vec209_1 = _mm_mul_ps(t_vec207_1, t_vec208_1) ;
    (*((__m128 *)(value))) = t_vec209_1 ;
    
    return ;
}

MUDA_STATIC MUDA_ALWAYS_INLINE __m128 grad2_memo (const float * xs, const float * ys, const float * f0, const float * f1) 
{
    const __m128 xs_ld_1 = _mm_load_ps(xs + 0) ;
    const __m128 ys_ld_1 = _mm_load_ps(ys + 0) ;
    const __m128 f0_ld_1 = _mm_load_ps(f0 + 0) ;
    const __m128 f1_ld_1 = _mm_load_ps(f1 + 0) ;
    const __m128 t_vec211_1 = f0_ld_1 ;
    const __m128 t_vec210_1 = xs_ld_1 ;
    const __m128 t_vec212_1 = _mm_xor_ps(t_vec211_1, t_vec210_1) ;
    const __m128 t_vec213_1 = f1_ld_1 ;
    const __m128 t_vec214_1 = ys_ld_1 ;
    const __m128 t_vec215_1 = _mm_xor_ps(t_vec213_1, t_vec214_1) ;
    const __m128 t_vec216_1 = _mm_add_ps(t_vec212_1, t_vec215_1) ;
    return t_vec216_1 ;
}

void mnoise2_memo (float * value, const float * x, const float * y, float * mxi, float * myi, float * mh00, float * mh10, float * mh01, float * mh11) 
{
    const __m128 x_ld_1 = _mm_load_ps(x + 0) ;
    const __m128 y_ld_1 = _mm_load_ps(y + 0) ;
    const float t_float218_1 = 61.0 ;
    const float t_float217_1 = t_float218_1 ;
    const __m128 t_vec220_1 = _mm_set_ps1(  t_float217_1  ) ;
    const __m128 t_vec219_1 = t_vec220_1 ;
    __m128 base_1 = t_vec219_1 ;
    
    const float t_float221_1 = 1.63934e-2 ;
    const float t_float222_1 = t_float221_1 ;
    const __m128 t_vec223_1 = _mm_set_ps1(  t_float222_1  ) ;
    const __m128 t_vec224_1 = t_vec223_1 ;
    __m128 invbase_1 = t_vec224_1 ;
    
    const __m128 t_vec225_1 = x_ld_1 ;
    const __m128 t_vec226_1 = _mm_cvtepi32_ps(_mm_cvttps_epi32( t_vec225_1 )) ;
    __m128 pxi_1 = t_vec226_1 ;
    
    const __m128 t_vec227_1 = y_ld_1 ;
    const __m128 t_vec228_1 = _mm_cvtepi32_ps(_mm_cvttps_epi32( t_vec227_1 )) ;
    __m128 pyi_1 = t_vec228_1 ;
    
    const __m128 t_vec229_1 = x_ld_1 ;
    const __m128 t_vec230_1 = pxi_1 ;
    const __m128 t_vec231_1 = _mm_sub_ps(t_vec229_1, t_vec230_1) ;
    __m128 pxf_1 = t_vec231_1 ;
    
    const __m128 t_vec232_1 = y_ld_1 ;
    const __m128 t_vec233_1 = pyi_1 ;
    const __m128 t_vec234_1 = _mm_sub_ps(t_vec232_1, t_vec233_1) ;
    __m128 pyf_1 = t_vec234_1 ;
    
    const __m128 t_vec235_1 = pxf_1 ;
    const __m128 t_vec236_1 = (__m128) fade ((float *) &( t_vec235_1) ) ;
    __m128 kx_1 = t_vec236_1 ;
    
    const __m128 t_vec237_1 = pyf_1 ;
    const __m128 t_vec238_1 = (__m128) fade ((float *) &( t_vec237_1) ) ;
    __m128 ky_1 = t_vec238_1 ;
    
    const __m128 t_vec239_1 = pxf_1 ;
    __m128 fx0_1 = t_vec239_1 ;
    
    const float t_float240_1 = -1.0 ;
    const float t_float241_1 = t_float240_1 ;
    const __m128 t_vec242_1 = _mm_set_ps1(  t_float241_1  ) ;
    const __m128 t_vec243_1 = t_vec242_1 ;
    const __m128 t_vec244_1 = pxf_1 ;
    const __m128 t_vec245_1 = _mm_add_ps(t_vec243_1, t_vec244_1) ;
    __m128 fx1_1 = t_vec245_1 ;
    
    const __m128 t_vec246_1 = pyf_1 ;
    __m128 fy0_1 = t_vec246_1 ;
    
    const float t_float247_1 = -1.0 ;
    const float t_float248_1 = t_float247_1 ;
    const __m128 t_vec249_1 = _mm_set_ps1(  t_float248_1  ) ;
    const __m128 t_vec250_1 = t_vec249_1 ;
    const __m128 t_vec251_1 = pyf_1 ;
    const __m128 t_vec252_1 = _mm_add_ps(t_vec250_1, t_vec251_1) ;
    __m128 fy1_1 = t_vec252_1 ;
    
    __m128 g00_1 ;
    
    __m128 g10_1 ;
    
    __m128 g01_1 ;
    
    __m128 g11_1 ;
    
    __m128 r_1 ;
    
    const __m128 t_vec253_1 = pxi_1 ;
    const __m128 t_vec254_1 = (*((__m128 *)(mxi))) ;
    const __m128 t_vec255_1 = _mm_cmpeq_ps(t_vec253_1, t_vec254_1) ;
    const __m128 t_vec256_1 = pyi_1 ;
    const __m128 t_vec257_1 = (*((__m128 *)(myi))) ;
    const __m128 t_vec258_1 = _mm_cmpeq_ps(t_vec256_1, t_vec257_1) ;
    const __m128 t_vec259_1 = _mm_and_ps(t_vec255_1, t_vec258_1) ;
    __m128 cond_1 = t_vec259_1 ;
    
    const __m128 t_vec260_1 = cond_1 ;
    const __m128i t_ivec261_1 = _mm_cmpeq_epi32(_mm_set1_epi32(15), _mm_set1_epi32(_mm_movemask_ps( t_vec260_1 ))) ;
    int t_int262[4] ;
    _mm_storeu_si128 ((__m128i *) t_int262, t_ivec261_1) ;
    const int t_int263_1 = t_int262[0] ;
    if (t_int263_1) 
    {
        const __m128 t_vec264_1 = (*((__m128 *)(mh00))) ;
        const __m128 t_vec265_1 = fx0_1 ;
        const __m128 t_vec266_1 = fy0_1 ;
        const __m128 t_vec267_1 = (__m128) grad2 ((float *) &( t_vec264_1 ), (float *) &( t_vec265_1 ), (float *) &( t_vec266_1) ) ;
        g00_1 = t_vec267_1 ;
        
        const __m128 t_vec268_1 = (*((__m128 *)(mh10))) ;
        const __m128 t_vec269_1 = fx1_1 ;
        const __m128 t_vec270_1 = fy0_1 ;
        const __m128 t_vec271_1 = (__m128) grad2 ((float *) &( t_vec268_1 ), (float *) &( t_vec269_1 ), (float *) &( t_vec270_1) ) ;
        g10_1 = t_vec271_1 ;
        
        const __m128 t_vec272_1 = (*((__m128 *)(mh01))) ;
        const __m128 t_vec273_1 = fx0_1 ;
        const __m128 t_vec274_1 = fy1_1 ;
        const __m128 t_vec275_1 = (__m128) grad2 ((float *) &( t_vec272_1 ), (float *) &( t_vec273_1 ), (float *) &( t_vec274_1) ) ;
        g01_1 = t_vec275_1 ;
        
        const __m128 t_vec276_1 = (*((__m128 *)(mh11))) ;
        const __m128 t_vec277_1 = fx1_1 ;
        const __m128 t_vec278_1 = fy1_1 ;
        const __m128 t_vec279_1 = (__m128) grad2 ((float *) &( t_vec276_1 ), (float *) &( t_vec277_1 ), (float *) &( t_vec278_1) ) ;
        g11_1 = t_vec279_1 ;
        
        const __m128 t_vec280_1 = ky_1 ;
        const __m128 t_vec281_1 = kx_1 ;
        const __m128 t_vec282_1 = g00_1 ;
        const __m128 t_vec283_1 = g10_1 ;
        const __m128 t_vec284_1 = (__m128) flerp ((float *) &( t_vec281_1 ), (float *) &( t_vec282_1 ), (float *) &( t_vec283_1) ) ;
        const __m128 t_vec285_1 = kx_1 ;
        const __m128 t_vec286_1 = g01_1 ;
        const __m128 t_vec287_1 = g11_1 ;
        const __m128 t_vec288_1 = (__m128) flerp ((float *) &( t_vec285_1 ), (float *) &( t_vec286_1 ), (float *) &( t_vec287_1) ) ;
        const __m128 t_vec289_1 = (__m128) flerp ((float *) &( t_vec280_1 ), (float *) &( t_vec284_1 ), (float *) &( t_vec288_1) ) ;
        r_1 = t_vec289_1 ;
        
        const float t_float290_1 = 0.507 ;
        const float t_float291_1 = t_float290_1 ;
        const __m128 t_vec292_1 = _mm_set_ps1(  t_float291_1  ) ;
        const __m128 t_vec293_1 = r_1 ;
        const __m128 t_vec294_1 = _mm_mul_ps(t_vec292_1, t_vec293_1) ;
        (*((__m128 *)(value))) = t_vec294_1 ;
        
        return ;
    }
    else 
    {
        
    }
    
    const float t_float295_1 = 7.0 ;
    const float t_float296_1 = t_float295_1 ;
    const __m128 t_vec297_1 = _mm_set_ps1(  t_float296_1  ) ;
    const __m128 t_vec298_1 = t_vec297_1 ;
    __m128 c0_1 = t_vec298_1 ;
    
    const float t_float299_1 = 1.0 ;
    const float t_float300_1 = t_float299_1 ;
    const __m128 t_vec301_1 = _mm_set_ps1(  t_float300_1  ) ;
    const __m128 t_vec302_1 = t_vec301_1 ;
    __m128 one_1 = t_vec302_1 ;
    
    const __m128 t_vec303_1 = pyi_1 ;
    const __m128 t_vec304_1 = c0_1 ;
    const __m128 t_vec305_1 = _mm_mul_ps(t_vec303_1, t_vec304_1) ;
    __m128 y0_1 = t_vec305_1 ;
    
    const __m128 t_vec306_1 = pyi_1 ;
    const __m128 t_vec307_1 = one_1 ;
    const __m128 t_vec308_1 = _mm_add_ps(t_vec306_1, t_vec307_1) ;
    const __m128 t_vec309_1 = c0_1 ;
    const __m128 t_vec310_1 = _mm_mul_ps(t_vec308_1, t_vec309_1) ;
    __m128 y1_1 = t_vec310_1 ;
    
    const __m128 t_vec311_1 = pxi_1 ;
    __m128 x0_1 = t_vec311_1 ;
    
    const __m128 t_vec312_1 = pxi_1 ;
    const __m128 t_vec313_1 = one_1 ;
    const __m128 t_vec314_1 = _mm_add_ps(t_vec312_1, t_vec313_1) ;
    __m128 x1_1 = t_vec314_1 ;
    
    const __m128 t_vec315_1 = y0_1 ;
    const __m128 t_vec316_1 = base_1 ;
    const __m128 t_vec317_1 = invbase_1 ;
    const __m128 t_vec318_1 = (__m128) hash ((float *) &( t_vec315_1 ), (float *) &( t_vec316_1 ), (float *) &( t_vec317_1) ) ;
    __m128 hy0_1 = t_vec318_1 ;
    
    const __m128 t_vec319_1 = y1_1 ;
    const __m128 t_vec320_1 = base_1 ;
    const __m128 t_vec321_1 = invbase_1 ;
    const __m128 t_vec322_1 = (__m128) hash ((float *) &( t_vec319_1 ), (float *) &( t_vec320_1 ), (float *) &( t_vec321_1) ) ;
    __m128 hy1_1 = t_vec322_1 ;
    
    const __m128 t_vec323_1 = x0_1 ;
    const __m128 t_vec324_1 = hy0_1 ;
    const __m128 t_vec325_1 = _mm_add_ps(t_vec323_1, t_vec324_1) ;
    const __m128 t_vec326_1 = base_1 ;
    const __m128 t_vec327_1 = invbase_1 ;
    const __m128 t_vec328_1 = (__m128) hash ((float *) &( t_vec325_1 ), (float *) &( t_vec326_1 ), (float *) &( t_vec327_1) ) ;
    __m128 h00_1 = t_vec328_1 ;
    
    const __m128 t_vec329_1 = x1_1 ;
    const __m128 t_vec330_1 = hy0_1 ;
    const __m128 t_vec331_1 = _mm_add_ps(t_vec329_1, t_vec330_1) ;
    const __m128 t_vec332_1 = base_1 ;
    const __m128 t_vec333_1 = invbase_1 ;
    const __m128 t_vec334_1 = (__m128) hash ((float *) &( t_vec331_1 ), (float *) &( t_vec332_1 ), (float *) &( t_vec333_1) ) ;
    __m128 h10_1 = t_vec334_1 ;
    
    const __m128 t_vec335_1 = x0_1 ;
    const __m128 t_vec336_1 = hy1_1 ;
    const __m128 t_vec337_1 = _mm_add_ps(t_vec335_1, t_vec336_1) ;
    const __m128 t_vec338_1 = base_1 ;
    const __m128 t_vec339_1 = invbase_1 ;
    const __m128 t_vec340_1 = (__m128) hash ((float *) &( t_vec337_1 ), (float *) &( t_vec338_1 ), (float *) &( t_vec339_1) ) ;
    __m128 h01_1 = t_vec340_1 ;
    
    const __m128 t_vec341_1 = x1_1 ;
    const __m128 t_vec342_1 = hy1_1 ;
    const __m128 t_vec343_1 = _mm_add_ps(t_vec341_1, t_vec342_1) ;
    const __m128 t_vec344_1 = base_1 ;
    const __m128 t_vec345_1 = invbase_1 ;
    const __m128 t_vec346_1 = (__m128) hash ((float *) &( t_vec343_1 ), (float *) &( t_vec344_1 ), (float *) &( t_vec345_1) ) ;
    __m128 h11_1 = t_vec346_1 ;
    
    const __m128 t_vec347_1 = h00_1 ;
    const __m128 t_vec348_1 = fx0_1 ;
    const __m128 t_vec349_1 = fy0_1 ;
    const __m128 t_vec350_1 = (__m128) grad2 ((float *) &( t_vec347_1 ), (float *) &( t_vec348_1 ), (float *) &( t_vec349_1) ) ;
    g00_1 = t_vec350_1 ;
    
    const __m128 t_vec351_1 = h10_1 ;
    const __m128 t_vec352_1 = fx1_1 ;
    const __m128 t_vec353_1 = fy0_1 ;
    const __m128 t_vec354_1 = (__m128) grad2 ((float *) &( t_vec351_1 ), (float *) &( t_vec352_1 ), (float *) &( t_vec353_1) ) ;
    g10_1 = t_vec354_1 ;
    
    const __m128 t_vec355_1 = h01_1 ;
    const __m128 t_vec356_1 = fx0_1 ;
    const __m128 t_vec357_1 = fy1_1 ;
    const __m128 t_vec358_1 = (__m128) grad2 ((float *) &( t_vec355_1 ), (float *) &( t_vec356_1 ), (float *) &( t_vec357_1) ) ;
    g01_1 = t_vec358_1 ;
    
    const __m128 t_vec359_1 = h11_1 ;
    const __m128 t_vec360_1 = fx1_1 ;
    const __m128 t_vec361_1 = fy1_1 ;
    const __m128 t_vec362_1 = (__m128) grad2 ((float *) &( t_vec359_1 ), (float *) &( t_vec360_1 ), (float *) &( t_vec361_1) ) ;
    g11_1 = t_vec362_1 ;
    
    const __m128 t_vec363_1 = ky_1 ;
    const __m128 t_vec364_1 = kx_1 ;
    const __m128 t_vec365_1 = g00_1 ;
    const __m128 t_vec366_1 = g10_1 ;
    const __m128 t_vec367_1 = (__m128) flerp ((float *) &( t_vec364_1 ), (float *) &( t_vec365_1 ), (float *) &( t_vec366_1) ) ;
    const __m128 t_vec368_1 = kx_1 ;
    const __m128 t_vec369_1 = g01_1 ;
    const __m128 t_vec370_1 = g11_1 ;
    const __m128 t_vec371_1 = (__m128) flerp ((float *) &( t_vec368_1 ), (float *) &( t_vec369_1 ), (float *) &( t_vec370_1) ) ;
    const __m128 t_vec372_1 = (__m128) flerp ((float *) &( t_vec363_1 ), (float *) &( t_vec367_1 ), (float *) &( t_vec371_1) ) ;
    r_1 = t_vec372_1 ;
    
    const __m128 t_vec373_1 = pxi_1 ;
    (*((__m128 *)(mxi))) = t_vec373_1 ;
    
    const __m128 t_vec374_1 = pyi_1 ;
    (*((__m128 *)(myi))) = t_vec374_1 ;
    
    const __m128 t_vec375_1 = h00_1 ;
    (*((__m128 *)(mh00))) = t_vec375_1 ;
    
    const __m128 t_vec376_1 = h10_1 ;
    (*((__m128 *)(mh10))) = t_vec376_1 ;
    
    const __m128 t_vec377_1 = h01_1 ;
    (*((__m128 *)(mh01))) = t_vec377_1 ;
    
    const __m128 t_vec378_1 = h11_1 ;
    (*((__m128 *)(mh11))) = t_vec378_1 ;
    
    const float t_float379_1 = 0.507 ;
    const float t_float380_1 = t_float379_1 ;
    const __m128 t_vec381_1 = _mm_set_ps1(  t_float380_1  ) ;
    const __m128 t_vec382_1 = r_1 ;
    const __m128 t_vec383_1 = _mm_mul_ps(t_vec381_1, t_vec382_1) ;
    (*((__m128 *)(value))) = t_vec383_1 ;
    
    return ;
}


