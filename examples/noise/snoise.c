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

void snoise2 (float * value, const float * x, const float * y) 
{
    const __m128 x_ld_1 = _mm_load_ps(x + 0) ;
    const __m128 y_ld_1 = _mm_load_ps(y + 0) ;
    const float t_float92_1 = 251.0 ;
    const float t_float91_1 = t_float92_1 ;
    const __m128 t_vec94_1 = _mm_set_ps1(  t_float91_1  ) ;
    const __m128 t_vec93_1 = t_vec94_1 ;
    __m128 base_1 = t_vec93_1 ;
    
    const float t_float95_1 = 3.9841e-3 ;
    const float t_float96_1 = t_float95_1 ;
    const __m128 t_vec97_1 = _mm_set_ps1(  t_float96_1  ) ;
    const __m128 t_vec98_1 = t_vec97_1 ;
    __m128 invbase_1 = t_vec98_1 ;
    
    const float t_float99_1 = 0.36603 ;
    const float t_float100_1 = t_float99_1 ;
    const __m128 t_vec101_1 = _mm_set_ps1(  t_float100_1  ) ;
    __m128 F2_1 = t_vec101_1 ;
    
    const float t_float102_1 = 0.21132 ;
    const float t_float103_1 = t_float102_1 ;
    const __m128 t_vec104_1 = _mm_set_ps1(  t_float103_1  ) ;
    __m128 G2_1 = t_vec104_1 ;
    
    const __m128 t_vec105_1 = x_ld_1 ;
    const __m128 t_vec106_1 = y_ld_1 ;
    const __m128 t_vec107_1 = _mm_add_ps(t_vec105_1, t_vec106_1) ;
    const __m128 t_vec108_1 = F2_1 ;
    const __m128 t_vec109_1 = _mm_mul_ps(t_vec107_1, t_vec108_1) ;
    __m128 s_1 = t_vec109_1 ;
    
    const __m128 t_vec110_1 = x_ld_1 ;
    const __m128 t_vec111_1 = s_1 ;
    const __m128 t_vec112_1 = _mm_add_ps(t_vec110_1, t_vec111_1) ;
    const __m128 t_vec113_1 = _mm_cvtepi32_ps(_mm_cvttps_epi32( t_vec112_1 )) ;
    __m128 i_1 = t_vec113_1 ;
    
    const __m128 t_vec114_1 = y_ld_1 ;
    const __m128 t_vec115_1 = s_1 ;
    const __m128 t_vec116_1 = _mm_add_ps(t_vec114_1, t_vec115_1) ;
    const __m128 t_vec117_1 = _mm_cvtepi32_ps(_mm_cvttps_epi32( t_vec116_1 )) ;
    __m128 j_1 = t_vec117_1 ;
    
    const __m128 t_vec118_1 = i_1 ;
    const __m128 t_vec119_1 = j_1 ;
    const __m128 t_vec120_1 = _mm_add_ps(t_vec118_1, t_vec119_1) ;
    const __m128 t_vec121_1 = G2_1 ;
    const __m128 t_vec122_1 = _mm_mul_ps(t_vec120_1, t_vec121_1) ;
    __m128 t_1 = t_vec122_1 ;
    
    const __m128 t_vec123_1 = i_1 ;
    const __m128 t_vec124_1 = t_1 ;
    const __m128 t_vec125_1 = _mm_sub_ps(t_vec123_1, t_vec124_1) ;
    __m128 xt_1 = t_vec125_1 ;
    
    const __m128 t_vec126_1 = j_1 ;
    const __m128 t_vec127_1 = t_1 ;
    const __m128 t_vec128_1 = _mm_sub_ps(t_vec126_1, t_vec127_1) ;
    __m128 yt_1 = t_vec128_1 ;
    
    const __m128 t_vec129_1 = x_ld_1 ;
    const __m128 t_vec130_1 = xt_1 ;
    const __m128 t_vec131_1 = _mm_sub_ps(t_vec129_1, t_vec130_1) ;
    __m128 x0_1 = t_vec131_1 ;
    
    const __m128 t_vec132_1 = y_ld_1 ;
    const __m128 t_vec133_1 = yt_1 ;
    const __m128 t_vec134_1 = _mm_sub_ps(t_vec132_1, t_vec133_1) ;
    __m128 y0_1 = t_vec134_1 ;
    
    const float t_float135_1 = 1.0 ;
    const float t_float136_1 = t_float135_1 ;
    const __m128 t_vec137_1 = _mm_set_ps1(  t_float136_1  ) ;
    __m128 vone_1 = t_vec137_1 ;
    
    const float t_float138_1 = 0.0 ;
    const float t_float139_1 = t_float138_1 ;
    const __m128 t_vec140_1 = _mm_set_ps1(  t_float139_1  ) ;
    __m128 vzero_1 = t_vec140_1 ;
    
    const __m128 t_vec141_1 = x0_1 ;
    const __m128 t_vec142_1 = y0_1 ;
    const __m128 t_vec143_1 = _mm_cmpgt_ps(t_vec141_1, t_vec142_1) ;
    __m128 mask_1 = t_vec143_1 ;
    
    const __m128 t_vec144_1 = vzero_1 ;
    const __m128 t_vec145_1 = vone_1 ;
    const __m128 t_vec146_1 = mask_1 ;
    const __m128 t_vec147_1 = muda_sel_ps (t_vec144_1, t_vec145_1, t_vec146_1) ;
    __m128 i1_1 = t_vec147_1 ;
    
    const __m128 t_vec148_1 = vone_1 ;
    const __m128 t_vec149_1 = vzero_1 ;
    const __m128 t_vec150_1 = mask_1 ;
    const __m128 t_vec151_1 = muda_sel_ps (t_vec148_1, t_vec149_1, t_vec150_1) ;
    __m128 j1_1 = t_vec151_1 ;
    
    const __m128 t_vec152_1 = x0_1 ;
    const __m128 t_vec153_1 = i1_1 ;
    const __m128 t_vec154_1 = _mm_sub_ps(t_vec152_1, t_vec153_1) ;
    const __m128 t_vec155_1 = G2_1 ;
    const __m128 t_vec156_1 = _mm_add_ps(t_vec154_1, t_vec155_1) ;
    __m128 x1_1 = t_vec156_1 ;
    
    const __m128 t_vec157_1 = y0_1 ;
    const __m128 t_vec158_1 = j1_1 ;
    const __m128 t_vec159_1 = _mm_sub_ps(t_vec157_1, t_vec158_1) ;
    const __m128 t_vec160_1 = G2_1 ;
    const __m128 t_vec161_1 = _mm_add_ps(t_vec159_1, t_vec160_1) ;
    __m128 y1_1 = t_vec161_1 ;
    
    const __m128 t_vec162_1 = x0_1 ;
    const float t_float163_1 = 1.0 ;
    const float t_float164_1 = t_float163_1 ;
    const __m128 t_vec165_1 = _mm_set_ps1(  t_float164_1  ) ;
    const __m128 t_vec166_1 = _mm_sub_ps(t_vec162_1, t_vec165_1) ;
    const float t_float167_1 = 2.0 ;
    const float t_float168_1 = t_float167_1 ;
    const __m128 t_vec169_1 = _mm_set_ps1(  t_float168_1  ) ;
    const __m128 t_vec170_1 = G2_1 ;
    const __m128 t_vec171_1 = _mm_mul_ps(t_vec169_1, t_vec170_1) ;
    const __m128 t_vec172_1 = _mm_add_ps(t_vec166_1, t_vec171_1) ;
    __m128 x2_1 = t_vec172_1 ;
    
    const __m128 t_vec173_1 = y0_1 ;
    const float t_float174_1 = 1.0 ;
    const float t_float175_1 = t_float174_1 ;
    const __m128 t_vec176_1 = _mm_set_ps1(  t_float175_1  ) ;
    const __m128 t_vec177_1 = _mm_sub_ps(t_vec173_1, t_vec176_1) ;
    const float t_float178_1 = 2.0 ;
    const float t_float179_1 = t_float178_1 ;
    const __m128 t_vec180_1 = _mm_set_ps1(  t_float179_1  ) ;
    const __m128 t_vec181_1 = G2_1 ;
    const __m128 t_vec182_1 = _mm_mul_ps(t_vec180_1, t_vec181_1) ;
    const __m128 t_vec183_1 = _mm_add_ps(t_vec177_1, t_vec182_1) ;
    __m128 y2_1 = t_vec183_1 ;
    
    __m128 h0_1 ;
    
    __m128 h1_1 ;
    
    __m128 h2_1 ;
    
    const __m128 t_vec184_1 = i_1 ;
    const __m128 t_vec185_1 = j_1 ;
    const __m128 t_vec186_1 = base_1 ;
    const __m128 t_vec187_1 = invbase_1 ;
    const __m128 t_vec188_1 = (__m128) hash ((float *) &( t_vec185_1 ), (float *) &( t_vec186_1 ), (float *) &( t_vec187_1) ) ;
    const __m128 t_vec189_1 = _mm_add_ps(t_vec184_1, t_vec188_1) ;
    const __m128 t_vec190_1 = base_1 ;
    const __m128 t_vec191_1 = invbase_1 ;
    const __m128 t_vec192_1 = (__m128) hash ((float *) &( t_vec189_1 ), (float *) &( t_vec190_1 ), (float *) &( t_vec191_1) ) ;
    h0_1 = t_vec192_1 ;
    
    const __m128 t_vec193_1 = i_1 ;
    const __m128 t_vec194_1 = i1_1 ;
    const __m128 t_vec195_1 = _mm_add_ps(t_vec193_1, t_vec194_1) ;
    const __m128 t_vec196_1 = j_1 ;
    const __m128 t_vec197_1 = j1_1 ;
    const __m128 t_vec198_1 = _mm_add_ps(t_vec196_1, t_vec197_1) ;
    const __m128 t_vec199_1 = base_1 ;
    const __m128 t_vec200_1 = invbase_1 ;
    const __m128 t_vec201_1 = (__m128) hash ((float *) &( t_vec198_1 ), (float *) &( t_vec199_1 ), (float *) &( t_vec200_1) ) ;
    const __m128 t_vec202_1 = _mm_add_ps(t_vec195_1, t_vec201_1) ;
    const __m128 t_vec203_1 = base_1 ;
    const __m128 t_vec204_1 = invbase_1 ;
    const __m128 t_vec205_1 = (__m128) hash ((float *) &( t_vec202_1 ), (float *) &( t_vec203_1 ), (float *) &( t_vec204_1) ) ;
    h1_1 = t_vec205_1 ;
    
    const __m128 t_vec206_1 = i_1 ;
    const float t_float207_1 = 1.0 ;
    const float t_float208_1 = t_float207_1 ;
    const __m128 t_vec209_1 = _mm_set_ps1(  t_float208_1  ) ;
    const __m128 t_vec210_1 = _mm_add_ps(t_vec206_1, t_vec209_1) ;
    const __m128 t_vec211_1 = j_1 ;
    const float t_float212_1 = 1.0 ;
    const float t_float213_1 = t_float212_1 ;
    const __m128 t_vec214_1 = _mm_set_ps1(  t_float213_1  ) ;
    const __m128 t_vec215_1 = _mm_add_ps(t_vec211_1, t_vec214_1) ;
    const __m128 t_vec216_1 = base_1 ;
    const __m128 t_vec217_1 = invbase_1 ;
    const __m128 t_vec218_1 = (__m128) hash ((float *) &( t_vec215_1 ), (float *) &( t_vec216_1 ), (float *) &( t_vec217_1) ) ;
    const __m128 t_vec219_1 = _mm_add_ps(t_vec210_1, t_vec218_1) ;
    const __m128 t_vec220_1 = base_1 ;
    const __m128 t_vec221_1 = invbase_1 ;
    const __m128 t_vec222_1 = (__m128) hash ((float *) &( t_vec219_1 ), (float *) &( t_vec220_1 ), (float *) &( t_vec221_1) ) ;
    h2_1 = t_vec222_1 ;
    
    __m128 n0_1 ;
    
    __m128 n1_1 ;
    
    __m128 n2_1 ;
    
    const float t_float223_1 = 0.5 ;
    const float t_float224_1 = t_float223_1 ;
    const __m128 t_vec225_1 = _mm_set_ps1(  t_float224_1  ) ;
    const __m128 t_vec226_1 = x0_1 ;
    const __m128 t_vec227_1 = x0_1 ;
    const __m128 t_vec228_1 = _mm_mul_ps(t_vec226_1, t_vec227_1) ;
    const __m128 t_vec229_1 = _mm_sub_ps(t_vec225_1, t_vec228_1) ;
    const __m128 t_vec230_1 = y0_1 ;
    const __m128 t_vec231_1 = y0_1 ;
    const __m128 t_vec232_1 = _mm_mul_ps(t_vec230_1, t_vec231_1) ;
    const __m128 t_vec233_1 = _mm_sub_ps(t_vec229_1, t_vec232_1) ;
    __m128 t0_1 = t_vec233_1 ;
    
    const __m128 t_vec234_1 = t0_1 ;
    const float t_float235_1 = 0.0 ;
    const float t_float236_1 = t_float235_1 ;
    const __m128 t_vec237_1 = _mm_set_ps1(  t_float236_1  ) ;
    const __m128 t_vec238_1 = t_vec237_1 ;
    const __m128 t_vec239_1 = _mm_cmpgt_ps(t_vec234_1, t_vec238_1) ;
    __m128 t0mask_1 = t_vec239_1 ;
    
    const __m128 t_vec240_1 = t0_1 ;
    const __m128 t_vec241_1 = t0_1 ;
    const __m128 t_vec242_1 = _mm_mul_ps(t_vec240_1, t_vec241_1) ;
    __m128 tt0_1 = t_vec242_1 ;
    
    const __m128 t_vec243_1 = tt0_1 ;
    const __m128 t_vec244_1 = tt0_1 ;
    const __m128 t_vec245_1 = _mm_mul_ps(t_vec243_1, t_vec244_1) ;
    const __m128 t_vec246_1 = h0_1 ;
    const __m128 t_vec247_1 = x0_1 ;
    const __m128 t_vec248_1 = y0_1 ;
    const __m128 t_vec249_1 = (__m128) grad2 ((float *) &( t_vec246_1 ), (float *) &( t_vec247_1 ), (float *) &( t_vec248_1) ) ;
    const __m128 t_vec250_1 = _mm_mul_ps(t_vec245_1, t_vec249_1) ;
    __m128 ttt0_1 = t_vec250_1 ;
    
    const __m128 t_vec251_1 = vzero_1 ;
    const __m128 t_vec252_1 = ttt0_1 ;
    const __m128 t_vec253_1 = t0mask_1 ;
    const __m128 t_vec254_1 = muda_sel_ps (t_vec251_1, t_vec252_1, t_vec253_1) ;
    n0_1 = t_vec254_1 ;
    
    const float t_float255_1 = 0.5 ;
    const float t_float256_1 = t_float255_1 ;
    const __m128 t_vec257_1 = _mm_set_ps1(  t_float256_1  ) ;
    const __m128 t_vec258_1 = x1_1 ;
    const __m128 t_vec259_1 = x1_1 ;
    const __m128 t_vec260_1 = _mm_mul_ps(t_vec258_1, t_vec259_1) ;
    const __m128 t_vec261_1 = _mm_sub_ps(t_vec257_1, t_vec260_1) ;
    const __m128 t_vec262_1 = y1_1 ;
    const __m128 t_vec263_1 = y1_1 ;
    const __m128 t_vec264_1 = _mm_mul_ps(t_vec262_1, t_vec263_1) ;
    const __m128 t_vec265_1 = _mm_sub_ps(t_vec261_1, t_vec264_1) ;
    __m128 t1_1 = t_vec265_1 ;
    
    const __m128 t_vec266_1 = t1_1 ;
    const float t_float267_1 = 0.0 ;
    const float t_float268_1 = t_float267_1 ;
    const __m128 t_vec269_1 = _mm_set_ps1(  t_float268_1  ) ;
    const __m128 t_vec270_1 = t_vec269_1 ;
    const __m128 t_vec271_1 = _mm_cmpgt_ps(t_vec266_1, t_vec270_1) ;
    __m128 t1mask_1 = t_vec271_1 ;
    
    const __m128 t_vec272_1 = t1_1 ;
    const __m128 t_vec273_1 = t1_1 ;
    const __m128 t_vec274_1 = _mm_mul_ps(t_vec272_1, t_vec273_1) ;
    __m128 tt1_1 = t_vec274_1 ;
    
    const __m128 t_vec275_1 = tt1_1 ;
    const __m128 t_vec276_1 = tt1_1 ;
    const __m128 t_vec277_1 = _mm_mul_ps(t_vec275_1, t_vec276_1) ;
    const __m128 t_vec278_1 = h1_1 ;
    const __m128 t_vec279_1 = x1_1 ;
    const __m128 t_vec280_1 = y1_1 ;
    const __m128 t_vec281_1 = (__m128) grad2 ((float *) &( t_vec278_1 ), (float *) &( t_vec279_1 ), (float *) &( t_vec280_1) ) ;
    const __m128 t_vec282_1 = _mm_mul_ps(t_vec277_1, t_vec281_1) ;
    __m128 ttt1_1 = t_vec282_1 ;
    
    const __m128 t_vec283_1 = vzero_1 ;
    const __m128 t_vec284_1 = ttt1_1 ;
    const __m128 t_vec285_1 = t1mask_1 ;
    const __m128 t_vec286_1 = muda_sel_ps (t_vec283_1, t_vec284_1, t_vec285_1) ;
    n1_1 = t_vec286_1 ;
    
    const float t_float287_1 = 0.5 ;
    const float t_float288_1 = t_float287_1 ;
    const __m128 t_vec289_1 = _mm_set_ps1(  t_float288_1  ) ;
    const __m128 t_vec290_1 = x2_1 ;
    const __m128 t_vec291_1 = x2_1 ;
    const __m128 t_vec292_1 = _mm_mul_ps(t_vec290_1, t_vec291_1) ;
    const __m128 t_vec293_1 = _mm_sub_ps(t_vec289_1, t_vec292_1) ;
    const __m128 t_vec294_1 = y2_1 ;
    const __m128 t_vec295_1 = y2_1 ;
    const __m128 t_vec296_1 = _mm_mul_ps(t_vec294_1, t_vec295_1) ;
    const __m128 t_vec297_1 = _mm_sub_ps(t_vec293_1, t_vec296_1) ;
    __m128 t2_1 = t_vec297_1 ;
    
    const __m128 t_vec298_1 = t2_1 ;
    const float t_float299_1 = 0.0 ;
    const float t_float300_1 = t_float299_1 ;
    const __m128 t_vec301_1 = _mm_set_ps1(  t_float300_1  ) ;
    const __m128 t_vec302_1 = t_vec301_1 ;
    const __m128 t_vec303_1 = _mm_cmpgt_ps(t_vec298_1, t_vec302_1) ;
    __m128 t2mask_1 = t_vec303_1 ;
    
    const __m128 t_vec304_1 = t2_1 ;
    const __m128 t_vec305_1 = t2_1 ;
    const __m128 t_vec306_1 = _mm_mul_ps(t_vec304_1, t_vec305_1) ;
    __m128 tt2_1 = t_vec306_1 ;
    
    const __m128 t_vec307_1 = tt2_1 ;
    const __m128 t_vec308_1 = tt2_1 ;
    const __m128 t_vec309_1 = _mm_mul_ps(t_vec307_1, t_vec308_1) ;
    const __m128 t_vec310_1 = h2_1 ;
    const __m128 t_vec311_1 = x2_1 ;
    const __m128 t_vec312_1 = y2_1 ;
    const __m128 t_vec313_1 = (__m128) grad2 ((float *) &( t_vec310_1 ), (float *) &( t_vec311_1 ), (float *) &( t_vec312_1) ) ;
    const __m128 t_vec314_1 = _mm_mul_ps(t_vec309_1, t_vec313_1) ;
    __m128 ttt2_1 = t_vec314_1 ;
    
    const __m128 t_vec315_1 = vzero_1 ;
    const __m128 t_vec316_1 = ttt2_1 ;
    const __m128 t_vec317_1 = t2mask_1 ;
    const __m128 t_vec318_1 = muda_sel_ps (t_vec315_1, t_vec316_1, t_vec317_1) ;
    n2_1 = t_vec318_1 ;
    
    const float t_float319_1 = 70.0 ;
    const float t_float320_1 = t_float319_1 ;
    const __m128 t_vec321_1 = _mm_set_ps1(  t_float320_1  ) ;
    const __m128 t_vec322_1 = n0_1 ;
    const __m128 t_vec323_1 = n1_1 ;
    const __m128 t_vec324_1 = _mm_add_ps(t_vec322_1, t_vec323_1) ;
    const __m128 t_vec325_1 = n2_1 ;
    const __m128 t_vec326_1 = _mm_add_ps(t_vec324_1, t_vec325_1) ;
    const __m128 t_vec327_1 = _mm_mul_ps(t_vec321_1, t_vec326_1) ;
    (*((__m128 *)(value))) = t_vec327_1 ;
    
    return ;
}

MUDA_STATIC MUDA_ALWAYS_INLINE __m128 grad2_memo (const float * xs, const float * ys, const float * f0, const float * f1) 
{
    const __m128 xs_ld_1 = _mm_load_ps(xs + 0) ;
    const __m128 ys_ld_1 = _mm_load_ps(ys + 0) ;
    const __m128 f0_ld_1 = _mm_load_ps(f0 + 0) ;
    const __m128 f1_ld_1 = _mm_load_ps(f1 + 0) ;
    const __m128 t_vec329_1 = f0_ld_1 ;
    const __m128 t_vec328_1 = xs_ld_1 ;
    const __m128 t_vec330_1 = _mm_xor_ps(t_vec329_1, t_vec328_1) ;
    const __m128 t_vec331_1 = f1_ld_1 ;
    const __m128 t_vec332_1 = ys_ld_1 ;
    const __m128 t_vec333_1 = _mm_xor_ps(t_vec331_1, t_vec332_1) ;
    const __m128 t_vec334_1 = _mm_add_ps(t_vec330_1, t_vec333_1) ;
    return t_vec334_1 ;
}

void snoise2_memo (float * value, const float * x, const float * y, float * mxi, float * myi, float * mmask, float * mh0, float * mh1, float * mh2) 
{
    const __m128 x_ld_1 = _mm_load_ps(x + 0) ;
    const __m128 y_ld_1 = _mm_load_ps(y + 0) ;
    const float t_float336_1 = 251.0 ;
    const float t_float335_1 = t_float336_1 ;
    const __m128 t_vec338_1 = _mm_set_ps1(  t_float335_1  ) ;
    const __m128 t_vec337_1 = t_vec338_1 ;
    __m128 base_1 = t_vec337_1 ;
    
    const float t_float339_1 = 3.9841e-3 ;
    const float t_float340_1 = t_float339_1 ;
    const __m128 t_vec341_1 = _mm_set_ps1(  t_float340_1  ) ;
    const __m128 t_vec342_1 = t_vec341_1 ;
    __m128 invbase_1 = t_vec342_1 ;
    
    const float t_float343_1 = 0.36603 ;
    const float t_float344_1 = t_float343_1 ;
    const __m128 t_vec345_1 = _mm_set_ps1(  t_float344_1  ) ;
    __m128 F2_1 = t_vec345_1 ;
    
    const float t_float346_1 = 0.21132 ;
    const float t_float347_1 = t_float346_1 ;
    const __m128 t_vec348_1 = _mm_set_ps1(  t_float347_1  ) ;
    __m128 G2_1 = t_vec348_1 ;
    
    const __m128 t_vec349_1 = x_ld_1 ;
    const __m128 t_vec350_1 = y_ld_1 ;
    const __m128 t_vec351_1 = _mm_add_ps(t_vec349_1, t_vec350_1) ;
    const __m128 t_vec352_1 = F2_1 ;
    const __m128 t_vec353_1 = _mm_mul_ps(t_vec351_1, t_vec352_1) ;
    __m128 s_1 = t_vec353_1 ;
    
    const __m128 t_vec354_1 = x_ld_1 ;
    const __m128 t_vec355_1 = s_1 ;
    const __m128 t_vec356_1 = _mm_add_ps(t_vec354_1, t_vec355_1) ;
    const __m128 t_vec357_1 = _mm_cvtepi32_ps(_mm_cvttps_epi32( t_vec356_1 )) ;
    __m128 i_1 = t_vec357_1 ;
    
    const __m128 t_vec358_1 = y_ld_1 ;
    const __m128 t_vec359_1 = s_1 ;
    const __m128 t_vec360_1 = _mm_add_ps(t_vec358_1, t_vec359_1) ;
    const __m128 t_vec361_1 = _mm_cvtepi32_ps(_mm_cvttps_epi32( t_vec360_1 )) ;
    __m128 j_1 = t_vec361_1 ;
    
    const __m128 t_vec362_1 = i_1 ;
    const __m128 t_vec363_1 = j_1 ;
    const __m128 t_vec364_1 = _mm_add_ps(t_vec362_1, t_vec363_1) ;
    const __m128 t_vec365_1 = G2_1 ;
    const __m128 t_vec366_1 = _mm_mul_ps(t_vec364_1, t_vec365_1) ;
    __m128 t_1 = t_vec366_1 ;
    
    const __m128 t_vec367_1 = i_1 ;
    const __m128 t_vec368_1 = t_1 ;
    const __m128 t_vec369_1 = _mm_sub_ps(t_vec367_1, t_vec368_1) ;
    __m128 xt_1 = t_vec369_1 ;
    
    const __m128 t_vec370_1 = j_1 ;
    const __m128 t_vec371_1 = t_1 ;
    const __m128 t_vec372_1 = _mm_sub_ps(t_vec370_1, t_vec371_1) ;
    __m128 yt_1 = t_vec372_1 ;
    
    const __m128 t_vec373_1 = x_ld_1 ;
    const __m128 t_vec374_1 = xt_1 ;
    const __m128 t_vec375_1 = _mm_sub_ps(t_vec373_1, t_vec374_1) ;
    __m128 x0_1 = t_vec375_1 ;
    
    const __m128 t_vec376_1 = y_ld_1 ;
    const __m128 t_vec377_1 = yt_1 ;
    const __m128 t_vec378_1 = _mm_sub_ps(t_vec376_1, t_vec377_1) ;
    __m128 y0_1 = t_vec378_1 ;
    
    const float t_float379_1 = 1.0 ;
    const float t_float380_1 = t_float379_1 ;
    const __m128 t_vec381_1 = _mm_set_ps1(  t_float380_1  ) ;
    __m128 vone_1 = t_vec381_1 ;
    
    const float t_float382_1 = 0.0 ;
    const float t_float383_1 = t_float382_1 ;
    const __m128 t_vec384_1 = _mm_set_ps1(  t_float383_1  ) ;
    __m128 vzero_1 = t_vec384_1 ;
    
    const __m128 t_vec385_1 = x0_1 ;
    const __m128 t_vec386_1 = y0_1 ;
    const __m128 t_vec387_1 = _mm_cmpgt_ps(t_vec385_1, t_vec386_1) ;
    __m128 mask_1 = t_vec387_1 ;
    
    const __m128 t_vec388_1 = vzero_1 ;
    const __m128 t_vec389_1 = vone_1 ;
    const __m128 t_vec390_1 = mask_1 ;
    const __m128 t_vec391_1 = muda_sel_ps (t_vec388_1, t_vec389_1, t_vec390_1) ;
    __m128 i1_1 = t_vec391_1 ;
    
    const __m128 t_vec392_1 = vone_1 ;
    const __m128 t_vec393_1 = vzero_1 ;
    const __m128 t_vec394_1 = mask_1 ;
    const __m128 t_vec395_1 = muda_sel_ps (t_vec392_1, t_vec393_1, t_vec394_1) ;
    __m128 j1_1 = t_vec395_1 ;
    
    const __m128 t_vec396_1 = x0_1 ;
    const __m128 t_vec397_1 = i1_1 ;
    const __m128 t_vec398_1 = _mm_sub_ps(t_vec396_1, t_vec397_1) ;
    const __m128 t_vec399_1 = G2_1 ;
    const __m128 t_vec400_1 = _mm_add_ps(t_vec398_1, t_vec399_1) ;
    __m128 x1_1 = t_vec400_1 ;
    
    const __m128 t_vec401_1 = y0_1 ;
    const __m128 t_vec402_1 = j1_1 ;
    const __m128 t_vec403_1 = _mm_sub_ps(t_vec401_1, t_vec402_1) ;
    const __m128 t_vec404_1 = G2_1 ;
    const __m128 t_vec405_1 = _mm_add_ps(t_vec403_1, t_vec404_1) ;
    __m128 y1_1 = t_vec405_1 ;
    
    const __m128 t_vec406_1 = x0_1 ;
    const float t_float407_1 = 1.0 ;
    const float t_float408_1 = t_float407_1 ;
    const __m128 t_vec409_1 = _mm_set_ps1(  t_float408_1  ) ;
    const __m128 t_vec410_1 = _mm_sub_ps(t_vec406_1, t_vec409_1) ;
    const float t_float411_1 = 2.0 ;
    const float t_float412_1 = t_float411_1 ;
    const __m128 t_vec413_1 = _mm_set_ps1(  t_float412_1  ) ;
    const __m128 t_vec414_1 = G2_1 ;
    const __m128 t_vec415_1 = _mm_mul_ps(t_vec413_1, t_vec414_1) ;
    const __m128 t_vec416_1 = _mm_add_ps(t_vec410_1, t_vec415_1) ;
    __m128 x2_1 = t_vec416_1 ;
    
    const __m128 t_vec417_1 = y0_1 ;
    const float t_float418_1 = 1.0 ;
    const float t_float419_1 = t_float418_1 ;
    const __m128 t_vec420_1 = _mm_set_ps1(  t_float419_1  ) ;
    const __m128 t_vec421_1 = _mm_sub_ps(t_vec417_1, t_vec420_1) ;
    const float t_float422_1 = 2.0 ;
    const float t_float423_1 = t_float422_1 ;
    const __m128 t_vec424_1 = _mm_set_ps1(  t_float423_1  ) ;
    const __m128 t_vec425_1 = G2_1 ;
    const __m128 t_vec426_1 = _mm_mul_ps(t_vec424_1, t_vec425_1) ;
    const __m128 t_vec427_1 = _mm_add_ps(t_vec421_1, t_vec426_1) ;
    __m128 y2_1 = t_vec427_1 ;
    
    __m128 h0_1 ;
    
    __m128 h1_1 ;
    
    __m128 h2_1 ;
    
    __m128 n0_1 ;
    
    __m128 n1_1 ;
    
    __m128 n2_1 ;
    
    const __m128 t_vec428_1 = i_1 ;
    const __m128 t_vec429_1 = (*((__m128 *)(mxi))) ;
    const __m128 t_vec430_1 = _mm_cmpeq_ps(t_vec428_1, t_vec429_1) ;
    const __m128 t_vec431_1 = j_1 ;
    const __m128 t_vec432_1 = (*((__m128 *)(myi))) ;
    const __m128 t_vec433_1 = _mm_cmpeq_ps(t_vec431_1, t_vec432_1) ;
    const __m128 t_vec434_1 = _mm_and_ps(t_vec430_1, t_vec433_1) ;
    const __m128 t_vec435_1 = mask_1 ;
    const __m128 t_vec436_1 = (*((__m128 *)(mmask))) ;
    const __m128 t_vec437_1 = _mm_cmpeq_ps(t_vec435_1, t_vec436_1) ;
    const __m128 t_vec438_1 = _mm_and_ps(t_vec434_1, t_vec437_1) ;
    __m128 cond_1 = t_vec438_1 ;
    
    __m128 t0_1 ;
    
    __m128 t0mask_1 ;
    
    __m128 tt0_1 ;
    
    __m128 ttt0_1 ;
    
    __m128 t1_1 ;
    
    __m128 t1mask_1 ;
    
    __m128 tt1_1 ;
    
    __m128 ttt1_1 ;
    
    __m128 t2_1 ;
    
    __m128 t2mask_1 ;
    
    __m128 tt2_1 ;
    
    __m128 ttt2_1 ;
    
    const __m128 t_vec439_1 = cond_1 ;
    const __m128i t_ivec440_1 = _mm_cmpeq_epi32(_mm_set1_epi32(15), _mm_set1_epi32(_mm_movemask_ps( t_vec439_1 ))) ;
    int t_int441[4] ;
    _mm_storeu_si128 ((__m128i *) t_int441, t_ivec440_1) ;
    const int t_int442_1 = t_int441[0] ;
    if (t_int442_1) 
    {
        const float t_float443_1 = 0.5 ;
        const float t_float444_1 = t_float443_1 ;
        const __m128 t_vec445_1 = _mm_set_ps1(  t_float444_1  ) ;
        const __m128 t_vec446_1 = x0_1 ;
        const __m128 t_vec447_1 = x0_1 ;
        const __m128 t_vec448_1 = _mm_mul_ps(t_vec446_1, t_vec447_1) ;
        const __m128 t_vec449_1 = _mm_sub_ps(t_vec445_1, t_vec448_1) ;
        const __m128 t_vec450_1 = y0_1 ;
        const __m128 t_vec451_1 = y0_1 ;
        const __m128 t_vec452_1 = _mm_mul_ps(t_vec450_1, t_vec451_1) ;
        const __m128 t_vec453_1 = _mm_sub_ps(t_vec449_1, t_vec452_1) ;
        t0_1 = t_vec453_1 ;
        
        const __m128 t_vec454_1 = t0_1 ;
        const float t_float455_1 = 0.0 ;
        const float t_float456_1 = t_float455_1 ;
        const __m128 t_vec457_1 = _mm_set_ps1(  t_float456_1  ) ;
        const __m128 t_vec458_1 = t_vec457_1 ;
        const __m128 t_vec459_1 = _mm_cmpgt_ps(t_vec454_1, t_vec458_1) ;
        t0mask_1 = t_vec459_1 ;
        
        const __m128 t_vec460_1 = t0_1 ;
        const __m128 t_vec461_1 = t0_1 ;
        const __m128 t_vec462_1 = _mm_mul_ps(t_vec460_1, t_vec461_1) ;
        tt0_1 = t_vec462_1 ;
        
        const __m128 t_vec463_1 = tt0_1 ;
        const __m128 t_vec464_1 = tt0_1 ;
        const __m128 t_vec465_1 = _mm_mul_ps(t_vec463_1, t_vec464_1) ;
        const __m128 t_vec466_1 = (*((__m128 *)(mh0))) ;
        const __m128 t_vec467_1 = x0_1 ;
        const __m128 t_vec468_1 = y0_1 ;
        const __m128 t_vec469_1 = (__m128) grad2 ((float *) &( t_vec466_1 ), (float *) &( t_vec467_1 ), (float *) &( t_vec468_1) ) ;
        const __m128 t_vec470_1 = _mm_mul_ps(t_vec465_1, t_vec469_1) ;
        ttt0_1 = t_vec470_1 ;
        
        const __m128 t_vec471_1 = vzero_1 ;
        const __m128 t_vec472_1 = ttt0_1 ;
        const __m128 t_vec473_1 = t0mask_1 ;
        const __m128 t_vec474_1 = muda_sel_ps (t_vec471_1, t_vec472_1, t_vec473_1) ;
        n0_1 = t_vec474_1 ;
        
        const float t_float475_1 = 0.5 ;
        const float t_float476_1 = t_float475_1 ;
        const __m128 t_vec477_1 = _mm_set_ps1(  t_float476_1  ) ;
        const __m128 t_vec478_1 = x1_1 ;
        const __m128 t_vec479_1 = x1_1 ;
        const __m128 t_vec480_1 = _mm_mul_ps(t_vec478_1, t_vec479_1) ;
        const __m128 t_vec481_1 = _mm_sub_ps(t_vec477_1, t_vec480_1) ;
        const __m128 t_vec482_1 = y1_1 ;
        const __m128 t_vec483_1 = y1_1 ;
        const __m128 t_vec484_1 = _mm_mul_ps(t_vec482_1, t_vec483_1) ;
        const __m128 t_vec485_1 = _mm_sub_ps(t_vec481_1, t_vec484_1) ;
        t1_1 = t_vec485_1 ;
        
        const __m128 t_vec486_1 = t1_1 ;
        const float t_float487_1 = 0.0 ;
        const float t_float488_1 = t_float487_1 ;
        const __m128 t_vec489_1 = _mm_set_ps1(  t_float488_1  ) ;
        const __m128 t_vec490_1 = t_vec489_1 ;
        const __m128 t_vec491_1 = _mm_cmpgt_ps(t_vec486_1, t_vec490_1) ;
        t1mask_1 = t_vec491_1 ;
        
        const __m128 t_vec492_1 = t1_1 ;
        const __m128 t_vec493_1 = t1_1 ;
        const __m128 t_vec494_1 = _mm_mul_ps(t_vec492_1, t_vec493_1) ;
        tt1_1 = t_vec494_1 ;
        
        const __m128 t_vec495_1 = tt1_1 ;
        const __m128 t_vec496_1 = tt1_1 ;
        const __m128 t_vec497_1 = _mm_mul_ps(t_vec495_1, t_vec496_1) ;
        const __m128 t_vec498_1 = (*((__m128 *)(mh1))) ;
        const __m128 t_vec499_1 = x1_1 ;
        const __m128 t_vec500_1 = y1_1 ;
        const __m128 t_vec501_1 = (__m128) grad2 ((float *) &( t_vec498_1 ), (float *) &( t_vec499_1 ), (float *) &( t_vec500_1) ) ;
        const __m128 t_vec502_1 = _mm_mul_ps(t_vec497_1, t_vec501_1) ;
        ttt1_1 = t_vec502_1 ;
        
        const __m128 t_vec503_1 = vzero_1 ;
        const __m128 t_vec504_1 = ttt1_1 ;
        const __m128 t_vec505_1 = t1mask_1 ;
        const __m128 t_vec506_1 = muda_sel_ps (t_vec503_1, t_vec504_1, t_vec505_1) ;
        n1_1 = t_vec506_1 ;
        
        const float t_float507_1 = 0.5 ;
        const float t_float508_1 = t_float507_1 ;
        const __m128 t_vec509_1 = _mm_set_ps1(  t_float508_1  ) ;
        const __m128 t_vec510_1 = x2_1 ;
        const __m128 t_vec511_1 = x2_1 ;
        const __m128 t_vec512_1 = _mm_mul_ps(t_vec510_1, t_vec511_1) ;
        const __m128 t_vec513_1 = _mm_sub_ps(t_vec509_1, t_vec512_1) ;
        const __m128 t_vec514_1 = y2_1 ;
        const __m128 t_vec515_1 = y2_1 ;
        const __m128 t_vec516_1 = _mm_mul_ps(t_vec514_1, t_vec515_1) ;
        const __m128 t_vec517_1 = _mm_sub_ps(t_vec513_1, t_vec516_1) ;
        t2_1 = t_vec517_1 ;
        
        const __m128 t_vec518_1 = t2_1 ;
        const float t_float519_1 = 0.0 ;
        const float t_float520_1 = t_float519_1 ;
        const __m128 t_vec521_1 = _mm_set_ps1(  t_float520_1  ) ;
        const __m128 t_vec522_1 = t_vec521_1 ;
        const __m128 t_vec523_1 = _mm_cmpgt_ps(t_vec518_1, t_vec522_1) ;
        t2mask_1 = t_vec523_1 ;
        
        const __m128 t_vec524_1 = t2_1 ;
        const __m128 t_vec525_1 = t2_1 ;
        const __m128 t_vec526_1 = _mm_mul_ps(t_vec524_1, t_vec525_1) ;
        tt2_1 = t_vec526_1 ;
        
        const __m128 t_vec527_1 = tt2_1 ;
        const __m128 t_vec528_1 = tt2_1 ;
        const __m128 t_vec529_1 = _mm_mul_ps(t_vec527_1, t_vec528_1) ;
        const __m128 t_vec530_1 = (*((__m128 *)(mh2))) ;
        const __m128 t_vec531_1 = x2_1 ;
        const __m128 t_vec532_1 = y2_1 ;
        const __m128 t_vec533_1 = (__m128) grad2 ((float *) &( t_vec530_1 ), (float *) &( t_vec531_1 ), (float *) &( t_vec532_1) ) ;
        const __m128 t_vec534_1 = _mm_mul_ps(t_vec529_1, t_vec533_1) ;
        ttt2_1 = t_vec534_1 ;
        
        const __m128 t_vec535_1 = vzero_1 ;
        const __m128 t_vec536_1 = ttt2_1 ;
        const __m128 t_vec537_1 = t2mask_1 ;
        const __m128 t_vec538_1 = muda_sel_ps (t_vec535_1, t_vec536_1, t_vec537_1) ;
        n2_1 = t_vec538_1 ;
        
        const float t_float539_1 = 70.0 ;
        const float t_float540_1 = t_float539_1 ;
        const __m128 t_vec541_1 = _mm_set_ps1(  t_float540_1  ) ;
        const __m128 t_vec542_1 = n0_1 ;
        const __m128 t_vec543_1 = n1_1 ;
        const __m128 t_vec544_1 = _mm_add_ps(t_vec542_1, t_vec543_1) ;
        const __m128 t_vec545_1 = n2_1 ;
        const __m128 t_vec546_1 = _mm_add_ps(t_vec544_1, t_vec545_1) ;
        const __m128 t_vec547_1 = _mm_mul_ps(t_vec541_1, t_vec546_1) ;
        (*((__m128 *)(value))) = t_vec547_1 ;
        
        return ;
    }
    else 
    {
        
    }
    
    const __m128 t_vec548_1 = i_1 ;
    const __m128 t_vec549_1 = j_1 ;
    const __m128 t_vec550_1 = base_1 ;
    const __m128 t_vec551_1 = invbase_1 ;
    const __m128 t_vec552_1 = (__m128) hash ((float *) &( t_vec549_1 ), (float *) &( t_vec550_1 ), (float *) &( t_vec551_1) ) ;
    const __m128 t_vec553_1 = _mm_add_ps(t_vec548_1, t_vec552_1) ;
    const __m128 t_vec554_1 = base_1 ;
    const __m128 t_vec555_1 = invbase_1 ;
    const __m128 t_vec556_1 = (__m128) hash ((float *) &( t_vec553_1 ), (float *) &( t_vec554_1 ), (float *) &( t_vec555_1) ) ;
    h0_1 = t_vec556_1 ;
    
    const __m128 t_vec557_1 = i_1 ;
    const __m128 t_vec558_1 = i1_1 ;
    const __m128 t_vec559_1 = _mm_add_ps(t_vec557_1, t_vec558_1) ;
    const __m128 t_vec560_1 = j_1 ;
    const __m128 t_vec561_1 = j1_1 ;
    const __m128 t_vec562_1 = _mm_add_ps(t_vec560_1, t_vec561_1) ;
    const __m128 t_vec563_1 = base_1 ;
    const __m128 t_vec564_1 = invbase_1 ;
    const __m128 t_vec565_1 = (__m128) hash ((float *) &( t_vec562_1 ), (float *) &( t_vec563_1 ), (float *) &( t_vec564_1) ) ;
    const __m128 t_vec566_1 = _mm_add_ps(t_vec559_1, t_vec565_1) ;
    const __m128 t_vec567_1 = base_1 ;
    const __m128 t_vec568_1 = invbase_1 ;
    const __m128 t_vec569_1 = (__m128) hash ((float *) &( t_vec566_1 ), (float *) &( t_vec567_1 ), (float *) &( t_vec568_1) ) ;
    h1_1 = t_vec569_1 ;
    
    const __m128 t_vec570_1 = i_1 ;
    const float t_float571_1 = 1.0 ;
    const float t_float572_1 = t_float571_1 ;
    const __m128 t_vec573_1 = _mm_set_ps1(  t_float572_1  ) ;
    const __m128 t_vec574_1 = _mm_add_ps(t_vec570_1, t_vec573_1) ;
    const __m128 t_vec575_1 = j_1 ;
    const float t_float576_1 = 1.0 ;
    const float t_float577_1 = t_float576_1 ;
    const __m128 t_vec578_1 = _mm_set_ps1(  t_float577_1  ) ;
    const __m128 t_vec579_1 = _mm_add_ps(t_vec575_1, t_vec578_1) ;
    const __m128 t_vec580_1 = base_1 ;
    const __m128 t_vec581_1 = invbase_1 ;
    const __m128 t_vec582_1 = (__m128) hash ((float *) &( t_vec579_1 ), (float *) &( t_vec580_1 ), (float *) &( t_vec581_1) ) ;
    const __m128 t_vec583_1 = _mm_add_ps(t_vec574_1, t_vec582_1) ;
    const __m128 t_vec584_1 = base_1 ;
    const __m128 t_vec585_1 = invbase_1 ;
    const __m128 t_vec586_1 = (__m128) hash ((float *) &( t_vec583_1 ), (float *) &( t_vec584_1 ), (float *) &( t_vec585_1) ) ;
    h2_1 = t_vec586_1 ;
    
    const float t_float587_1 = 0.5 ;
    const float t_float588_1 = t_float587_1 ;
    const __m128 t_vec589_1 = _mm_set_ps1(  t_float588_1  ) ;
    const __m128 t_vec590_1 = x0_1 ;
    const __m128 t_vec591_1 = x0_1 ;
    const __m128 t_vec592_1 = _mm_mul_ps(t_vec590_1, t_vec591_1) ;
    const __m128 t_vec593_1 = _mm_sub_ps(t_vec589_1, t_vec592_1) ;
    const __m128 t_vec594_1 = y0_1 ;
    const __m128 t_vec595_1 = y0_1 ;
    const __m128 t_vec596_1 = _mm_mul_ps(t_vec594_1, t_vec595_1) ;
    const __m128 t_vec597_1 = _mm_sub_ps(t_vec593_1, t_vec596_1) ;
    t0_1 = t_vec597_1 ;
    
    const __m128 t_vec598_1 = t0_1 ;
    const float t_float599_1 = 0.0 ;
    const float t_float600_1 = t_float599_1 ;
    const __m128 t_vec601_1 = _mm_set_ps1(  t_float600_1  ) ;
    const __m128 t_vec602_1 = t_vec601_1 ;
    const __m128 t_vec603_1 = _mm_cmpgt_ps(t_vec598_1, t_vec602_1) ;
    t0mask_1 = t_vec603_1 ;
    
    const __m128 t_vec604_1 = t0_1 ;
    const __m128 t_vec605_1 = t0_1 ;
    const __m128 t_vec606_1 = _mm_mul_ps(t_vec604_1, t_vec605_1) ;
    tt0_1 = t_vec606_1 ;
    
    const __m128 t_vec607_1 = tt0_1 ;
    const __m128 t_vec608_1 = tt0_1 ;
    const __m128 t_vec609_1 = _mm_mul_ps(t_vec607_1, t_vec608_1) ;
    const __m128 t_vec610_1 = h0_1 ;
    const __m128 t_vec611_1 = x0_1 ;
    const __m128 t_vec612_1 = y0_1 ;
    const __m128 t_vec613_1 = (__m128) grad2 ((float *) &( t_vec610_1 ), (float *) &( t_vec611_1 ), (float *) &( t_vec612_1) ) ;
    const __m128 t_vec614_1 = _mm_mul_ps(t_vec609_1, t_vec613_1) ;
    ttt0_1 = t_vec614_1 ;
    
    const __m128 t_vec615_1 = vzero_1 ;
    const __m128 t_vec616_1 = ttt0_1 ;
    const __m128 t_vec617_1 = t0mask_1 ;
    const __m128 t_vec618_1 = muda_sel_ps (t_vec615_1, t_vec616_1, t_vec617_1) ;
    n0_1 = t_vec618_1 ;
    
    const float t_float619_1 = 0.5 ;
    const float t_float620_1 = t_float619_1 ;
    const __m128 t_vec621_1 = _mm_set_ps1(  t_float620_1  ) ;
    const __m128 t_vec622_1 = x1_1 ;
    const __m128 t_vec623_1 = x1_1 ;
    const __m128 t_vec624_1 = _mm_mul_ps(t_vec622_1, t_vec623_1) ;
    const __m128 t_vec625_1 = _mm_sub_ps(t_vec621_1, t_vec624_1) ;
    const __m128 t_vec626_1 = y1_1 ;
    const __m128 t_vec627_1 = y1_1 ;
    const __m128 t_vec628_1 = _mm_mul_ps(t_vec626_1, t_vec627_1) ;
    const __m128 t_vec629_1 = _mm_sub_ps(t_vec625_1, t_vec628_1) ;
    t1_1 = t_vec629_1 ;
    
    const __m128 t_vec630_1 = t1_1 ;
    const float t_float631_1 = 0.0 ;
    const float t_float632_1 = t_float631_1 ;
    const __m128 t_vec633_1 = _mm_set_ps1(  t_float632_1  ) ;
    const __m128 t_vec634_1 = t_vec633_1 ;
    const __m128 t_vec635_1 = _mm_cmpgt_ps(t_vec630_1, t_vec634_1) ;
    t1mask_1 = t_vec635_1 ;
    
    const __m128 t_vec636_1 = t1_1 ;
    const __m128 t_vec637_1 = t1_1 ;
    const __m128 t_vec638_1 = _mm_mul_ps(t_vec636_1, t_vec637_1) ;
    tt1_1 = t_vec638_1 ;
    
    const __m128 t_vec639_1 = tt1_1 ;
    const __m128 t_vec640_1 = tt1_1 ;
    const __m128 t_vec641_1 = _mm_mul_ps(t_vec639_1, t_vec640_1) ;
    const __m128 t_vec642_1 = h1_1 ;
    const __m128 t_vec643_1 = x1_1 ;
    const __m128 t_vec644_1 = y1_1 ;
    const __m128 t_vec645_1 = (__m128) grad2 ((float *) &( t_vec642_1 ), (float *) &( t_vec643_1 ), (float *) &( t_vec644_1) ) ;
    const __m128 t_vec646_1 = _mm_mul_ps(t_vec641_1, t_vec645_1) ;
    ttt1_1 = t_vec646_1 ;
    
    const __m128 t_vec647_1 = vzero_1 ;
    const __m128 t_vec648_1 = ttt1_1 ;
    const __m128 t_vec649_1 = t1mask_1 ;
    const __m128 t_vec650_1 = muda_sel_ps (t_vec647_1, t_vec648_1, t_vec649_1) ;
    n1_1 = t_vec650_1 ;
    
    const float t_float651_1 = 0.5 ;
    const float t_float652_1 = t_float651_1 ;
    const __m128 t_vec653_1 = _mm_set_ps1(  t_float652_1  ) ;
    const __m128 t_vec654_1 = x2_1 ;
    const __m128 t_vec655_1 = x2_1 ;
    const __m128 t_vec656_1 = _mm_mul_ps(t_vec654_1, t_vec655_1) ;
    const __m128 t_vec657_1 = _mm_sub_ps(t_vec653_1, t_vec656_1) ;
    const __m128 t_vec658_1 = y2_1 ;
    const __m128 t_vec659_1 = y2_1 ;
    const __m128 t_vec660_1 = _mm_mul_ps(t_vec658_1, t_vec659_1) ;
    const __m128 t_vec661_1 = _mm_sub_ps(t_vec657_1, t_vec660_1) ;
    t2_1 = t_vec661_1 ;
    
    const __m128 t_vec662_1 = t2_1 ;
    const float t_float663_1 = 0.0 ;
    const float t_float664_1 = t_float663_1 ;
    const __m128 t_vec665_1 = _mm_set_ps1(  t_float664_1  ) ;
    const __m128 t_vec666_1 = t_vec665_1 ;
    const __m128 t_vec667_1 = _mm_cmpgt_ps(t_vec662_1, t_vec666_1) ;
    t2mask_1 = t_vec667_1 ;
    
    const __m128 t_vec668_1 = t2_1 ;
    const __m128 t_vec669_1 = t2_1 ;
    const __m128 t_vec670_1 = _mm_mul_ps(t_vec668_1, t_vec669_1) ;
    tt2_1 = t_vec670_1 ;
    
    const __m128 t_vec671_1 = tt2_1 ;
    const __m128 t_vec672_1 = tt2_1 ;
    const __m128 t_vec673_1 = _mm_mul_ps(t_vec671_1, t_vec672_1) ;
    const __m128 t_vec674_1 = h2_1 ;
    const __m128 t_vec675_1 = x2_1 ;
    const __m128 t_vec676_1 = y2_1 ;
    const __m128 t_vec677_1 = (__m128) grad2 ((float *) &( t_vec674_1 ), (float *) &( t_vec675_1 ), (float *) &( t_vec676_1) ) ;
    const __m128 t_vec678_1 = _mm_mul_ps(t_vec673_1, t_vec677_1) ;
    ttt2_1 = t_vec678_1 ;
    
    const __m128 t_vec679_1 = vzero_1 ;
    const __m128 t_vec680_1 = ttt2_1 ;
    const __m128 t_vec681_1 = t2mask_1 ;
    const __m128 t_vec682_1 = muda_sel_ps (t_vec679_1, t_vec680_1, t_vec681_1) ;
    n2_1 = t_vec682_1 ;
    
    const float t_float683_1 = 70.0 ;
    const float t_float684_1 = t_float683_1 ;
    const __m128 t_vec685_1 = _mm_set_ps1(  t_float684_1  ) ;
    const __m128 t_vec686_1 = n0_1 ;
    const __m128 t_vec687_1 = n1_1 ;
    const __m128 t_vec688_1 = _mm_add_ps(t_vec686_1, t_vec687_1) ;
    const __m128 t_vec689_1 = n2_1 ;
    const __m128 t_vec690_1 = _mm_add_ps(t_vec688_1, t_vec689_1) ;
    const __m128 t_vec691_1 = _mm_mul_ps(t_vec685_1, t_vec690_1) ;
    (*((__m128 *)(value))) = t_vec691_1 ;
    
    const __m128 t_vec692_1 = i_1 ;
    (*((__m128 *)(mxi))) = t_vec692_1 ;
    
    const __m128 t_vec693_1 = i_1 ;
    (*((__m128 *)(myi))) = t_vec693_1 ;
    
    const __m128 t_vec694_1 = mask_1 ;
    (*((__m128 *)(mmask))) = t_vec694_1 ;
    
    const __m128 t_vec695_1 = h0_1 ;
    (*((__m128 *)(mh0))) = t_vec695_1 ;
    
    const __m128 t_vec696_1 = h1_1 ;
    (*((__m128 *)(mh1))) = t_vec696_1 ;
    
    const __m128 t_vec697_1 = h2_1 ;
    (*((__m128 *)(mh2))) = t_vec697_1 ;
    
    return ;
}


