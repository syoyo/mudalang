#include "mudaintrin_avx.h"

MUDA_STATIC MUDA_INLINE __m256d cross4 (const double * a, const double * b, const double * c, const double * d) 
{
    const __m256d a_ld_1 = _mm256_load_pd(a + 0) ;
    const __m256d b_ld_1 = _mm256_load_pd(b + 0) ;
    const __m256d c_ld_1 = _mm256_load_pd(c + 0) ;
    const __m256d d_ld_1 = _mm256_load_pd(d + 0) ;
    const __m256d t_dvec2_1 = a_ld_1 ;
    const __m256d t_dvec1_1 = c_ld_1 ;
    const __m256d t_dvec3_1 = _mm256_mul_pd(t_dvec2_1, t_dvec1_1) ;
    const __m256d t_dvec4_1 = b_ld_1 ;
    const __m256d t_dvec5_1 = d_ld_1 ;
    const __m256d t_dvec6_1 = _mm256_mul_pd(t_dvec4_1, t_dvec5_1) ;
    const __m256d t_dvec7_1 = _mm256_sub_pd(t_dvec3_1, t_dvec6_1) ;
    return t_dvec7_1 ;
}

MUDA_STATIC MUDA_INLINE __m256d dot4 (const double * ax, const double * ay, const double * az, const double * bx, const double * by, const double * bz) 
{
    const __m256d ax_ld_1 = _mm256_load_pd(ax + 0) ;
    const __m256d ay_ld_1 = _mm256_load_pd(ay + 0) ;
    const __m256d az_ld_1 = _mm256_load_pd(az + 0) ;
    const __m256d bx_ld_1 = _mm256_load_pd(bx + 0) ;
    const __m256d by_ld_1 = _mm256_load_pd(by + 0) ;
    const __m256d bz_ld_1 = _mm256_load_pd(bz + 0) ;
    const __m256d t_dvec9_1 = ax_ld_1 ;
    const __m256d t_dvec8_1 = bx_ld_1 ;
    const __m256d t_dvec10_1 = _mm256_mul_pd(t_dvec9_1, t_dvec8_1) ;
    const __m256d t_dvec11_1 = ay_ld_1 ;
    const __m256d t_dvec12_1 = by_ld_1 ;
    const __m256d t_dvec13_1 = _mm256_mul_pd(t_dvec11_1, t_dvec12_1) ;
    const __m256d t_dvec14_1 = _mm256_add_pd(t_dvec10_1, t_dvec13_1) ;
    const __m256d t_dvec15_1 = az_ld_1 ;
    const __m256d t_dvec16_1 = bz_ld_1 ;
    const __m256d t_dvec17_1 = _mm256_mul_pd(t_dvec15_1, t_dvec16_1) ;
    const __m256d t_dvec18_1 = _mm256_add_pd(t_dvec14_1, t_dvec17_1) ;
    return t_dvec18_1 ;
}

void isect (const double * rox, const double * roy, const double * roz, const double * rdx, const double * rdy, const double * rdz, const double * v0x, const double * v0y, const double * v0z, const double * e1x, const double * e1y, const double * e1z, const double * e2x, const double * e2y, const double * e2z, double * inoutMask, double * inoutT, double * inoutU, double * inoutV) 
{
    const __m256d rox_ld_1 = _mm256_load_pd(rox + 0) ;
    const __m256d roy_ld_1 = _mm256_load_pd(roy + 0) ;
    const __m256d roz_ld_1 = _mm256_load_pd(roz + 0) ;
    const __m256d rdx_ld_1 = _mm256_load_pd(rdx + 0) ;
    const __m256d rdy_ld_1 = _mm256_load_pd(rdy + 0) ;
    const __m256d rdz_ld_1 = _mm256_load_pd(rdz + 0) ;
    const __m256d v0x_ld_1 = _mm256_load_pd(v0x + 0) ;
    const __m256d v0y_ld_1 = _mm256_load_pd(v0y + 0) ;
    const __m256d v0z_ld_1 = _mm256_load_pd(v0z + 0) ;
    const __m256d e1x_ld_1 = _mm256_load_pd(e1x + 0) ;
    const __m256d e1y_ld_1 = _mm256_load_pd(e1y + 0) ;
    const __m256d e1z_ld_1 = _mm256_load_pd(e1z + 0) ;
    const __m256d e2x_ld_1 = _mm256_load_pd(e2x + 0) ;
    const __m256d e2y_ld_1 = _mm256_load_pd(e2y + 0) ;
    const __m256d e2z_ld_1 = _mm256_load_pd(e2z + 0) ;
    __m256d px_1 ;
    
    __m256d py_1 ;
    
    __m256d pz_1 ;
    
    const __m256d t_dvec20_1 = e2z_ld_1 ;
    const __m256d t_dvec19_1 = e2y_ld_1 ;
    const __m256d t_dvec21_1 = rdy_ld_1 ;
    const __m256d t_dvec22_1 = rdz_ld_1 ;
    const __m256d t_dvec23_1 = (__m256d) cross4 ((double *) &( t_dvec20_1 ), (double *) &( t_dvec19_1 ), (double *) &( t_dvec21_1 ), (double *) &( t_dvec22_1) ) ;
    px_1 = t_dvec23_1 ;
    
    const __m256d t_dvec24_1 = e2x_ld_1 ;
    const __m256d t_dvec25_1 = e2z_ld_1 ;
    const __m256d t_dvec26_1 = rdz_ld_1 ;
    const __m256d t_dvec27_1 = rdx_ld_1 ;
    const __m256d t_dvec28_1 = (__m256d) cross4 ((double *) &( t_dvec24_1 ), (double *) &( t_dvec25_1 ), (double *) &( t_dvec26_1 ), (double *) &( t_dvec27_1) ) ;
    py_1 = t_dvec28_1 ;
    
    const __m256d t_dvec29_1 = e2y_ld_1 ;
    const __m256d t_dvec30_1 = e2x_ld_1 ;
    const __m256d t_dvec31_1 = rdx_ld_1 ;
    const __m256d t_dvec32_1 = rdy_ld_1 ;
    const __m256d t_dvec33_1 = (__m256d) cross4 ((double *) &( t_dvec29_1 ), (double *) &( t_dvec30_1 ), (double *) &( t_dvec31_1 ), (double *) &( t_dvec32_1) ) ;
    pz_1 = t_dvec33_1 ;
    
    __m256d sx_1 ;
    
    __m256d sy_1 ;
    
    __m256d sz_1 ;
    
    const __m256d t_dvec34_1 = rox_ld_1 ;
    const __m256d t_dvec35_1 = v0x_ld_1 ;
    const __m256d t_dvec36_1 = _mm256_sub_pd(t_dvec34_1, t_dvec35_1) ;
    sx_1 = t_dvec36_1 ;
    
    const __m256d t_dvec37_1 = roy_ld_1 ;
    const __m256d t_dvec38_1 = v0y_ld_1 ;
    const __m256d t_dvec39_1 = _mm256_sub_pd(t_dvec37_1, t_dvec38_1) ;
    sy_1 = t_dvec39_1 ;
    
    const __m256d t_dvec40_1 = roz_ld_1 ;
    const __m256d t_dvec41_1 = v0z_ld_1 ;
    const __m256d t_dvec42_1 = _mm256_sub_pd(t_dvec40_1, t_dvec41_1) ;
    sz_1 = t_dvec42_1 ;
    
    __m256d qx_1 ;
    
    __m256d qy_1 ;
    
    __m256d qz_1 ;
    
    const double t_double44_1 = 1.0 ;
    const double t_double43_1 = t_double44_1 ;
    const __m256d t_dvec45_1 = _mm256_set_pd(  t_double43_1, t_double43_1, t_double43_1, t_double43_1  ) ;
    const __m256d t_dvec46_1 = t_dvec45_1 ;
    __m256d vone_1 = t_dvec46_1 ;
    
    const double t_double47_1 = 0.0 ;
    const double t_double48_1 = t_double47_1 ;
    const __m256d t_dvec49_1 = _mm256_set_pd(  t_double48_1, t_double48_1, t_double48_1, t_double48_1  ) ;
    const __m256d t_dvec50_1 = t_dvec49_1 ;
    __m256d vzero_1 = t_dvec50_1 ;
    
    const __m256d t_dvec51_1 = px_1 ;
    const __m256d t_dvec52_1 = py_1 ;
    const __m256d t_dvec53_1 = pz_1 ;
    const __m256d t_dvec54_1 = e1x_ld_1 ;
    const __m256d t_dvec55_1 = e1y_ld_1 ;
    const __m256d t_dvec56_1 = e1z_ld_1 ;
    const __m256d t_dvec57_1 = (__m256d) dot4 ((double *) &( t_dvec51_1 ), (double *) &( t_dvec52_1 ), (double *) &( t_dvec53_1 ), (double *) &( t_dvec54_1 ), (double *) &( t_dvec55_1 ), (double *) &( t_dvec56_1) ) ;
    __m256d a_1 = t_dvec57_1 ;
    
    const __m256d t_dvec58_1 = vone_1 ;
    const __m256d t_dvec59_1 = a_1 ;
    const __m256d t_dvec60_1 = muda_divapprox_pd(t_dvec58_1, t_dvec59_1) ;
    __m256d rpa_1 = t_dvec60_1 ;
    
    const __m256d t_dvec61_1 = e1z_ld_1 ;
    const __m256d t_dvec62_1 = e1y_ld_1 ;
    const __m256d t_dvec63_1 = sy_1 ;
    const __m256d t_dvec64_1 = sz_1 ;
    const __m256d t_dvec65_1 = (__m256d) cross4 ((double *) &( t_dvec61_1 ), (double *) &( t_dvec62_1 ), (double *) &( t_dvec63_1 ), (double *) &( t_dvec64_1) ) ;
    qx_1 = t_dvec65_1 ;
    
    const __m256d t_dvec66_1 = e1x_ld_1 ;
    const __m256d t_dvec67_1 = e1z_ld_1 ;
    const __m256d t_dvec68_1 = sz_1 ;
    const __m256d t_dvec69_1 = sx_1 ;
    const __m256d t_dvec70_1 = (__m256d) cross4 ((double *) &( t_dvec66_1 ), (double *) &( t_dvec67_1 ), (double *) &( t_dvec68_1 ), (double *) &( t_dvec69_1) ) ;
    qy_1 = t_dvec70_1 ;
    
    const __m256d t_dvec71_1 = e1y_ld_1 ;
    const __m256d t_dvec72_1 = e1x_ld_1 ;
    const __m256d t_dvec73_1 = sx_1 ;
    const __m256d t_dvec74_1 = sy_1 ;
    const __m256d t_dvec75_1 = (__m256d) cross4 ((double *) &( t_dvec71_1 ), (double *) &( t_dvec72_1 ), (double *) &( t_dvec73_1 ), (double *) &( t_dvec74_1) ) ;
    qz_1 = t_dvec75_1 ;
    
    __m256d u_1 ;
    
    __m256d v_1 ;
    
    __m256d t_1 ;
    
    const __m256d t_dvec76_1 = sx_1 ;
    const __m256d t_dvec77_1 = sy_1 ;
    const __m256d t_dvec78_1 = sz_1 ;
    const __m256d t_dvec79_1 = px_1 ;
    const __m256d t_dvec80_1 = py_1 ;
    const __m256d t_dvec81_1 = pz_1 ;
    const __m256d t_dvec82_1 = (__m256d) dot4 ((double *) &( t_dvec76_1 ), (double *) &( t_dvec77_1 ), (double *) &( t_dvec78_1 ), (double *) &( t_dvec79_1 ), (double *) &( t_dvec80_1 ), (double *) &( t_dvec81_1) ) ;
    const __m256d t_dvec83_1 = rpa_1 ;
    const __m256d t_dvec84_1 = _mm256_mul_pd(t_dvec82_1, t_dvec83_1) ;
    u_1 = t_dvec84_1 ;
    
    const __m256d t_dvec85_1 = rdx_ld_1 ;
    const __m256d t_dvec86_1 = rdy_ld_1 ;
    const __m256d t_dvec87_1 = rdz_ld_1 ;
    const __m256d t_dvec88_1 = qx_1 ;
    const __m256d t_dvec89_1 = qy_1 ;
    const __m256d t_dvec90_1 = qz_1 ;
    const __m256d t_dvec91_1 = (__m256d) dot4 ((double *) &( t_dvec85_1 ), (double *) &( t_dvec86_1 ), (double *) &( t_dvec87_1 ), (double *) &( t_dvec88_1 ), (double *) &( t_dvec89_1 ), (double *) &( t_dvec90_1) ) ;
    const __m256d t_dvec92_1 = rpa_1 ;
    const __m256d t_dvec93_1 = _mm256_mul_pd(t_dvec91_1, t_dvec92_1) ;
    v_1 = t_dvec93_1 ;
    
    const __m256d t_dvec94_1 = e2x_ld_1 ;
    const __m256d t_dvec95_1 = e2y_ld_1 ;
    const __m256d t_dvec96_1 = e2z_ld_1 ;
    const __m256d t_dvec97_1 = qx_1 ;
    const __m256d t_dvec98_1 = qy_1 ;
    const __m256d t_dvec99_1 = qz_1 ;
    const __m256d t_dvec100_1 = (__m256d) dot4 ((double *) &( t_dvec94_1 ), (double *) &( t_dvec95_1 ), (double *) &( t_dvec96_1 ), (double *) &( t_dvec97_1 ), (double *) &( t_dvec98_1 ), (double *) &( t_dvec99_1) ) ;
    const __m256d t_dvec101_1 = rpa_1 ;
    const __m256d t_dvec102_1 = _mm256_mul_pd(t_dvec100_1, t_dvec101_1) ;
    t_1 = t_dvec102_1 ;
    
    __m256d eps_1 ;
    
    const double t_double103_1 = 1.0e-5 ;
    const double t_double104_1 = t_double103_1 ;
    const __m256d t_dvec105_1 = _mm256_set_pd(  t_double104_1, t_double104_1, t_double104_1, t_double104_1  ) ;
    const __m256d t_dvec106_1 = t_dvec105_1 ;
    eps_1 = t_dvec106_1 ;
    
    __m256d mask0_1 ;
    
    const __m256d t_dvec107_1 = a_1 ;
    const __m256d t_dvec108_1 = a_1 ;
    const __m256d t_dvec109_1 = _mm256_mul_pd(t_dvec107_1, t_dvec108_1) ;
    const __m256d t_dvec110_1 = eps_1 ;
    const __m256d t_dvec111_1  =  _mm256_cmp_pd( t_dvec109_1 ,  t_dvec110_1 ,  _CMP_GT_OQ  ) ;
    const __m256d t_dvec112_1 = u_1 ;
    const __m256d t_dvec113_1 = v_1 ;
    const __m256d t_dvec114_1 = _mm256_add_pd(t_dvec112_1, t_dvec113_1) ;
    const __m256d t_dvec115_1 = vone_1 ;
    const __m256d t_dvec116_1  =  _mm256_cmp_pd( t_dvec114_1 ,  t_dvec115_1 ,  _CMP_LT_OQ  ) ;
    const __m256d t_dvec117_1 = _mm256_and_pd(t_dvec111_1, t_dvec116_1) ;
    const __m256d t_dvec118_1 = u_1 ;
    const __m256d t_dvec119_1 = vzero_1 ;
    const __m256d t_dvec120_1  =  _mm256_cmp_pd( t_dvec118_1 ,  t_dvec119_1 ,  _CMP_GT_OQ  ) ;
    const __m256d t_dvec121_1 = v_1 ;
    const __m256d t_dvec122_1 = vzero_1 ;
    const __m256d t_dvec123_1  =  _mm256_cmp_pd( t_dvec121_1 ,  t_dvec122_1 ,  _CMP_GT_OQ  ) ;
    const __m256d t_dvec124_1 = _mm256_and_pd(t_dvec120_1, t_dvec123_1) ;
    const __m256d t_dvec125_1 = _mm256_and_pd(t_dvec117_1, t_dvec124_1) ;
    mask0_1 = t_dvec125_1 ;
    
    __m256d mask_1 ;
    
    const __m256d t_dvec126_1 = mask0_1 ;
    const __m256d t_dvec127_1 = t_1 ;
    const __m256d t_dvec128_1 = vzero_1 ;
    const __m256d t_dvec129_1  =  _mm256_cmp_pd( t_dvec127_1 ,  t_dvec128_1 ,  _CMP_GT_OQ  ) ;
    const __m256d t_dvec130_1 = _mm256_and_pd(t_dvec126_1, t_dvec129_1) ;
    const __m256d t_dvec131_1 = t_1 ;
    const __m256d t_dvec132_1 = (*((__m256d *)(inoutT))) ;
    const __m256d t_dvec133_1  =  _mm256_cmp_pd( t_dvec131_1 ,  t_dvec132_1 ,  _CMP_LT_OQ  ) ;
    const __m256d t_dvec134_1 = _mm256_and_pd(t_dvec130_1, t_dvec133_1) ;
    mask_1 = t_dvec134_1 ;
    
    const __m256d t_dvec135_1 = (*((__m256d *)(inoutT))) ;
    const __m256d t_dvec136_1 = t_1 ;
    const __m256d t_dvec137_1 = mask_1 ;
    const __m256d t_dvec138_1 = _mm256_blendv_pd (t_dvec135_1, t_dvec136_1, t_dvec137_1) ;
    (*((__m256d *)(inoutT))) = t_dvec138_1 ;
    
    const __m256d t_dvec139_1 = (*((__m256d *)(inoutU))) ;
    const __m256d t_dvec140_1 = u_1 ;
    const __m256d t_dvec141_1 = mask_1 ;
    const __m256d t_dvec142_1 = _mm256_blendv_pd (t_dvec139_1, t_dvec140_1, t_dvec141_1) ;
    (*((__m256d *)(inoutU))) = t_dvec142_1 ;
    
    const __m256d t_dvec143_1 = (*((__m256d *)(inoutV))) ;
    const __m256d t_dvec144_1 = v_1 ;
    const __m256d t_dvec145_1 = mask_1 ;
    const __m256d t_dvec146_1 = _mm256_blendv_pd (t_dvec143_1, t_dvec144_1, t_dvec145_1) ;
    (*((__m256d *)(inoutV))) = t_dvec146_1 ;
    
    const __m256d t_dvec147_1 = mask_1 ;
    const __m256d t_dvec148_1 = (*((__m256d *)(inoutMask))) ;
    const __m256d t_dvec149_1 = _mm256_or_pd(t_dvec147_1, t_dvec148_1) ;
    (*((__m256d *)(inoutMask))) = t_dvec149_1 ;
    
    return ;
}


