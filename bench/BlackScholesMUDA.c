#include "mudaintrin_sse.h"

static MUDA_ALWAYS_INLINE __m128 cndMUDA (const float * d) 
{
    const __m128 d_ld_1 = _mm_load_ps(d + 0) ;
    const float t_float2_1 = 0.31938153 ;
    const float t_float1_1 = t_float2_1 ;
    const __m128 t_vec3_1 = _mm_set_ps1(  t_float1_1  ) ;
    __m128 A1_1 = t_vec3_1 ;
    
    const float t_float4_1 = -0.356563782 ;
    const float t_float5_1 = t_float4_1 ;
    const __m128 t_vec6_1 = _mm_set_ps1(  t_float5_1  ) ;
    __m128 A2_1 = t_vec6_1 ;
    
    const float t_float7_1 = 1.781477937 ;
    const float t_float8_1 = t_float7_1 ;
    const __m128 t_vec9_1 = _mm_set_ps1(  t_float8_1  ) ;
    __m128 A3_1 = t_vec9_1 ;
    
    const float t_float10_1 = -1.821255978 ;
    const float t_float11_1 = t_float10_1 ;
    const __m128 t_vec12_1 = _mm_set_ps1(  t_float11_1  ) ;
    __m128 A4_1 = t_vec12_1 ;
    
    const float t_float13_1 = 1.330274429 ;
    const float t_float14_1 = t_float13_1 ;
    const __m128 t_vec15_1 = _mm_set_ps1(  t_float14_1  ) ;
    __m128 A5_1 = t_vec15_1 ;
    
    const float t_float16_1 = 0.3989422804 ;
    const float t_float17_1 = t_float16_1 ;
    const __m128 t_vec18_1 = _mm_set_ps1(  t_float17_1  ) ;
    __m128 RSQRT2PI_1 = t_vec18_1 ;
    
    const float t_float19_1 = 1.0 ;
    const float t_float20_1 = t_float19_1 ;
    const __m128 t_vec21_1 = _mm_set_ps1(  t_float20_1  ) ;
    const float t_float22_1 = 1.0 ;
    const float t_float23_1 = t_float22_1 ;
    const __m128 t_vec24_1 = _mm_set_ps1(  t_float23_1  ) ;
    const float t_float25_1 = 0.2316419 ;
    const float t_float26_1 = t_float25_1 ;
    const __m128 t_vec27_1 = _mm_set_ps1(  t_float26_1  ) ;
    const __m128 t_vec28_1 = d_ld_1 ;
    const __m128 t_vec29_1 = muda_abs_ps( t_vec28_1) ;
    const __m128 t_vec30_1 = _mm_mul_ps(t_vec27_1, t_vec29_1) ;
    const __m128 t_vec31_1 = _mm_add_ps(t_vec24_1, t_vec30_1) ;
    const __m128 Vect_vec31_rcp  =  _mm_rcp_ps( t_vec31_1) ;
    const __m128 Vect_vec31_rcp_tmp  =  _mm_sub_ps(_mm_add_ps(Vect_vec31_rcp, Vect_vec31_rcp), _mm_mul_ps(_mm_mul_ps(Vect_vec31_rcp, Vect_vec31_rcp),  t_vec31_1 )) ;
    const __m128 t_vec32_1  =  _mm_mul_ps( t_vec21_1, Vect_vec31_rcp_tmp) ;
    __m128 K_1 = t_vec32_1 ;
    
    const __m128 t_vec33_1 = RSQRT2PI_1 ;
    const float t_float34_1 = -0.5 ;
    const float t_float35_1 = t_float34_1 ;
    const __m128 t_vec36_1 = _mm_set_ps1(  t_float35_1  ) ;
    const __m128 t_vec37_1 = d_ld_1 ;
    const __m128 t_vec38_1 = _mm_mul_ps(t_vec36_1, t_vec37_1) ;
    const __m128 t_vec39_1 = d_ld_1 ;
    const __m128 t_vec40_1 = _mm_mul_ps(t_vec38_1, t_vec39_1) ;
    const __m128 t_vec41_1 = expmu( (float *) &( t_vec40_1) ) ;
    const __m128 t_vec42_1 = _mm_mul_ps(t_vec33_1, t_vec41_1) ;
    const __m128 t_vec43_1 = K_1 ;
    const __m128 t_vec44_1 = A1_1 ;
    const __m128 t_vec45_1 = K_1 ;
    const __m128 t_vec46_1 = A2_1 ;
    const __m128 t_vec47_1 = K_1 ;
    const __m128 t_vec48_1 = A3_1 ;
    const __m128 t_vec49_1 = K_1 ;
    const __m128 t_vec50_1 = A4_1 ;
    const __m128 t_vec51_1 = K_1 ;
    const __m128 t_vec52_1 = A5_1 ;
    const __m128 t_vec53_1 = _mm_mul_ps(t_vec51_1, t_vec52_1) ;
    const __m128 t_vec54_1 = _mm_add_ps(t_vec50_1, t_vec53_1) ;
    const __m128 t_vec55_1 = _mm_mul_ps(t_vec49_1, t_vec54_1) ;
    const __m128 t_vec56_1 = _mm_add_ps(t_vec48_1, t_vec55_1) ;
    const __m128 t_vec57_1 = _mm_mul_ps(t_vec47_1, t_vec56_1) ;
    const __m128 t_vec58_1 = _mm_add_ps(t_vec46_1, t_vec57_1) ;
    const __m128 t_vec59_1 = _mm_mul_ps(t_vec45_1, t_vec58_1) ;
    const __m128 t_vec60_1 = _mm_add_ps(t_vec44_1, t_vec59_1) ;
    const __m128 t_vec61_1 = _mm_mul_ps(t_vec43_1, t_vec60_1) ;
    const __m128 t_vec62_1 = _mm_mul_ps(t_vec42_1, t_vec61_1) ;
    __m128 cnd_1 = t_vec62_1 ;
    
    const float t_float63_1 = 1.0 ;
    const float t_float64_1 = t_float63_1 ;
    const __m128 t_vec65_1 = _mm_set_ps1(  t_float64_1  ) ;
    const __m128 t_vec66_1 = cnd_1 ;
    const __m128 t_vec67_1 = _mm_sub_ps(t_vec65_1, t_vec66_1) ;
    __m128 one_minus_cnd_1 = t_vec67_1 ;
    
    const __m128 t_vec68_1 = cnd_1 ;
    const __m128 t_vec69_1 = one_minus_cnd_1 ;
    const __m128 t_vec70_1 = d_ld_1 ;
    const float t_float71_1 = 0.0 ;
    const float t_float72_1 = t_float71_1 ;
    const __m128 t_vec73_1 = _mm_set_ps1(  t_float72_1  ) ;
    const __m128 t_vec74_1 = _mm_cmpgt_ps(t_vec70_1, t_vec73_1) ;
    const __m128 t_vec75_1 = muda_sel_ps (t_vec68_1, t_vec69_1, t_vec74_1) ;
    __m128 ret_1 = t_vec75_1 ;
    
    const __m128 t_vec76_1 = ret_1 ;
    return t_vec76_1 ;
}

void BlackScholesMUDA (float * retCall, float * retPut, const float * S, const float * X, const float * T, const float * R, const float * V) 
{
    const __m128 S_ld_1 = _mm_load_ps(S + 0) ;
    const __m128 X_ld_1 = _mm_load_ps(X + 0) ;
    const __m128 T_ld_1 = _mm_load_ps(T + 0) ;
    const __m128 R_ld_1 = _mm_load_ps(R + 0) ;
    const __m128 V_ld_1 = _mm_load_ps(V + 0) ;
    const __m128 t_vec78_1 = T_ld_1 ;
    const __m128 t_vec77_1 = sqrtmu( (float *) &( t_vec78_1) ) ;
    __m128 sqrtT_1 = t_vec77_1 ;
    
    const __m128 t_vec79_1 = S_ld_1 ;
    const __m128 t_vec80_1 = X_ld_1 ;
    const __m128 Vect_vec80_rcp  =  _mm_rcp_ps( t_vec80_1) ;
    const __m128 Vect_vec80_rcp_tmp  =  _mm_sub_ps(_mm_add_ps(Vect_vec80_rcp, Vect_vec80_rcp), _mm_mul_ps(_mm_mul_ps(Vect_vec80_rcp, Vect_vec80_rcp),  t_vec80_1 )) ;
    const __m128 t_vec81_1  =  _mm_mul_ps( t_vec79_1, Vect_vec80_rcp_tmp) ;
    const __m128 t_vec82_1 = logmu( (float *) &( t_vec81_1) ) ;
    const __m128 t_vec83_1 = R_ld_1 ;
    const float t_float85_1 = 0.5 ;
    const float t_float84_1 = t_float85_1 ;
    const __m128 t_vec86_1 = _mm_set_ps1(  t_float84_1  ) ;
    const __m128 t_vec87_1 = V_ld_1 ;
    const __m128 t_vec88_1 = _mm_mul_ps(t_vec86_1, t_vec87_1) ;
    const __m128 t_vec89_1 = V_ld_1 ;
    const __m128 t_vec90_1 = _mm_mul_ps(t_vec88_1, t_vec89_1) ;
    const __m128 t_vec91_1 = _mm_add_ps(t_vec83_1, t_vec90_1) ;
    const __m128 t_vec92_1 = T_ld_1 ;
    const __m128 t_vec93_1 = _mm_mul_ps(t_vec91_1, t_vec92_1) ;
    const __m128 t_vec94_1 = _mm_add_ps(t_vec82_1, t_vec93_1) ;
    const __m128 t_vec95_1 = V_ld_1 ;
    const __m128 t_vec96_1 = sqrtT_1 ;
    const __m128 t_vec97_1 = _mm_mul_ps(t_vec95_1, t_vec96_1) ;
    const __m128 Vect_vec97_rcp  =  _mm_rcp_ps( t_vec97_1) ;
    const __m128 Vect_vec97_rcp_tmp  =  _mm_sub_ps(_mm_add_ps(Vect_vec97_rcp, Vect_vec97_rcp), _mm_mul_ps(_mm_mul_ps(Vect_vec97_rcp, Vect_vec97_rcp),  t_vec97_1 )) ;
    const __m128 t_vec98_1  =  _mm_mul_ps( t_vec94_1, Vect_vec97_rcp_tmp) ;
    __m128 d1_1 = t_vec98_1 ;
    
    const __m128 t_vec99_1 = d1_1 ;
    const __m128 t_vec100_1 = V_ld_1 ;
    const __m128 t_vec101_1 = sqrtT_1 ;
    const __m128 t_vec102_1 = _mm_mul_ps(t_vec100_1, t_vec101_1) ;
    const __m128 t_vec103_1 = _mm_sub_ps(t_vec99_1, t_vec102_1) ;
    __m128 d2_1 = t_vec103_1 ;
    
    const __m128 t_vec104_1 = d1_1 ;
    const __m128 t_vec105_1 = (__m128) cndMUDA ((float *) &( t_vec104_1) ) ;
    __m128 cnd_d1_1 = t_vec105_1 ;
    
    const __m128 t_vec106_1 = d2_1 ;
    const __m128 t_vec107_1 = (__m128) cndMUDA ((float *) &( t_vec106_1) ) ;
    __m128 cnd_d2_1 = t_vec107_1 ;
    
    const float t_float108_1 = -1.0 ;
    const float t_float109_1 = t_float108_1 ;
    const __m128 t_vec110_1 = _mm_set_ps1(  t_float109_1  ) ;
    const __m128 t_vec111_1 = R_ld_1 ;
    const __m128 t_vec112_1 = _mm_mul_ps(t_vec110_1, t_vec111_1) ;
    const __m128 t_vec113_1 = T_ld_1 ;
    const __m128 t_vec114_1 = _mm_mul_ps(t_vec112_1, t_vec113_1) ;
    const __m128 t_vec115_1 = expmu( (float *) &( t_vec114_1) ) ;
    __m128 expRT_1 = t_vec115_1 ;
    
    const __m128 t_vec116_1 = S_ld_1 ;
    const __m128 t_vec117_1 = cnd_d1_1 ;
    const __m128 t_vec118_1 = _mm_mul_ps(t_vec116_1, t_vec117_1) ;
    const __m128 t_vec119_1 = X_ld_1 ;
    const __m128 t_vec120_1 = expRT_1 ;
    const __m128 t_vec121_1 = _mm_mul_ps(t_vec119_1, t_vec120_1) ;
    const __m128 t_vec122_1 = cnd_d2_1 ;
    const __m128 t_vec123_1 = _mm_mul_ps(t_vec121_1, t_vec122_1) ;
    const __m128 t_vec124_1 = _mm_sub_ps(t_vec118_1, t_vec123_1) ;
    (*((__m128 *)(retCall))) = t_vec124_1 ;
    
    const __m128 t_vec125_1 = X_ld_1 ;
    const __m128 t_vec126_1 = expRT_1 ;
    const __m128 t_vec127_1 = _mm_mul_ps(t_vec125_1, t_vec126_1) ;
    const float t_float128_1 = 1.0 ;
    const float t_float129_1 = t_float128_1 ;
    const __m128 t_vec130_1 = _mm_set_ps1(  t_float129_1  ) ;
    const __m128 t_vec131_1 = cnd_d2_1 ;
    const __m128 t_vec132_1 = _mm_sub_ps(t_vec130_1, t_vec131_1) ;
    const __m128 t_vec133_1 = _mm_mul_ps(t_vec127_1, t_vec132_1) ;
    const __m128 t_vec134_1 = S_ld_1 ;
    const float t_float135_1 = 1.0 ;
    const float t_float136_1 = t_float135_1 ;
    const __m128 t_vec137_1 = _mm_set_ps1(  t_float136_1  ) ;
    const __m128 t_vec138_1 = cnd_d1_1 ;
    const __m128 t_vec139_1 = _mm_sub_ps(t_vec137_1, t_vec138_1) ;
    const __m128 t_vec140_1 = _mm_mul_ps(t_vec134_1, t_vec139_1) ;
    const __m128 t_vec141_1 = _mm_sub_ps(t_vec133_1, t_vec140_1) ;
    (*((__m128 *)(retPut))) = t_vec141_1 ;
}


