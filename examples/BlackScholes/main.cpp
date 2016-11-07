#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "muda.h"

extern "C" {
#include "BlackScholesMUDA.h"
}

#include "BlackScholes_gold.h"

float RandFloat(float low, float high){
    float t = (float)rand() / (float)RAND_MAX;
    return (1.0f - t) * low + t * high;
}

const int   OPT_N          = 400000;   
const int   OPT_N4         = 100000;   // 1/4
const int   NUM_ITERATIONS = 10;
const int   OPT_SZ         = OPT_N * sizeof(float);
const float RISKFREE       = 0.02f;
const float VOLATILITY     = 0.30f;
//const float RISKFREE4[]    = {0.02f, 0.02f, 0.02f, 0.02f};
//const float VOLATILITY4[]  = {0.30f, 0.30f, 0.30f, 0.30f};
float *RISKFREE4;
float *VOLATILITY4;

float *h_CallResultCPU,
      *h_PutResultCPU,
      *h_CallResultMUDA,
      *h_PutResultMUDA,
      *h_StockPrice,
      *h_OptionStrike,
      *h_OptionYears,
      *h_InDataMUDA;


void
setup()
{
    int i, j;

    printf("[Setup] Generating input data ...\n");

    h_CallResultCPU  = (float *)mudaAlloc(OPT_SZ, 16);
    h_PutResultCPU   = (float *)mudaAlloc(OPT_SZ, 16);
    h_CallResultMUDA = (float *)mudaAlloc(OPT_SZ, 16);
    h_PutResultMUDA  = (float *)mudaAlloc(OPT_SZ, 16);
    h_StockPrice     = (float *)mudaAlloc(OPT_SZ, 16);
    h_OptionStrike   = (float *)mudaAlloc(OPT_SZ, 16);
    h_OptionYears    = (float *)mudaAlloc(OPT_SZ, 16);
    h_InDataMUDA     = (float *)mudaAlloc(OPT_SZ * 5, 16);

    RISKFREE4        = (float *)mudaAlloc(16, 16);
    VOLATILITY4      = (float *)mudaAlloc(16, 16);

    srand(5347);

    RISKFREE4[0] = RISKFREE;
    RISKFREE4[1] = RISKFREE;
    RISKFREE4[2] = RISKFREE;
    RISKFREE4[3] = RISKFREE;
    VOLATILITY4[0] = VOLATILITY;
    VOLATILITY4[1] = VOLATILITY;
    VOLATILITY4[2] = VOLATILITY;
    VOLATILITY4[3] = VOLATILITY;

    for(i = 0; i < OPT_N; i++){
        h_CallResultCPU[i]  = 0.0f;
        h_PutResultCPU[i]   = -1.0f;
        h_CallResultMUDA[i] = 0.0f;
        h_PutResultMUDA[i]  = -1.0f;
        h_StockPrice[i]     = RandFloat(5.0f, 30.0f);
        h_OptionStrike[i]   = RandFloat(1.0f, 100.0f);
        h_OptionYears[i]    = RandFloat(0.25f, 10.0f);

    }

    for(i = 0; i < OPT_N4; i++){
        for(j = 0; j < 4; j++){
            h_InDataMUDA[20 * i + 4 * 0 + j] = 0.0f;
            h_InDataMUDA[20 * i + 4 * 1 + j] = -1.0f;
            h_InDataMUDA[20 * i + 4 * 2 + j] = RandFloat(5.0f, 30.0f);
            h_InDataMUDA[20 * i + 4 * 3 + j] = RandFloat(1.0f, 100.0f);
            h_InDataMUDA[20 * i + 4 * 4 + j] = RandFloat(0.25f, 10.0f);
        }
    }

    printf("[Setup] Generating input data ... DONE\n");


}

void
doIt()
{
    muda_timer_t cpu_begin, cpu_end;
    muda_timer_t muda_begin, muda_end;

    //
    // Calculate reference.
    //
    printf("[Measure] Computing reference ... \n");
    mudaGetTime(&cpu_begin);
    BlackScholesCPU(
        h_CallResultCPU,
        h_PutResultCPU,
        h_StockPrice,
        h_OptionStrike,
        h_OptionYears,
        RISKFREE,
        VOLATILITY,
        OPT_N
    );
    mudaGetTime(&cpu_end);
    printf("[Measure] Computing reference ... DONE\n");

    //
    // Calculate with muda.
    // muda vesion computes 4 (put&call pair) options simulateniously,
    // thus loop iteration is divided by 4.
    //
    printf("[Measure] Computing with MUDA ... \n");

    mudaGetTime(&muda_begin);
    for (int n = 0; n < NUM_ITERATIONS; n++) {
        for(int opt = 0; opt < OPT_N4; opt++)
            BlackScholesMUDA(
                &h_CallResultMUDA[4 * opt],
                &h_PutResultMUDA[4 * opt],
                (const float *)&h_StockPrice[4 * opt],
                (const float *)&h_OptionStrike[4 * opt],
                (const float *)&h_OptionYears[4 * opt],
                // &h_InDataMUDA[(20 * opt) +  0],
                // &h_InDataMUDA[(20 * opt) +  4],
                // (const float *)&h_InDataMUDA[(20 * opt) +  8],
                // (const float *)&h_InDataMUDA[(20 * opt) + 12],
                // (const float *)&h_InDataMUDA[(20 * opt) + 16],
                (const float *)RISKFREE4,
                (const float *)VOLATILITY4
            );
    }
    mudaGetTime(&muda_end);

    printf("[Measure] Computing with MUDA ... DONE\n");

    
    //
    // Show perf.
    //
    double cpu_elapsed, muda_elapsed;

    cpu_elapsed  = mudaElapsedTimeInMSec(&cpu_begin, &cpu_end);
    muda_elapsed = mudaElapsedTimeInMSec(&muda_begin, &muda_end);

    double cpu_ops, muda_ops;

    // 2 = Put & Call
    cpu_ops  = 2 * (OPT_N / 1.0e+6) * (1000.0 / cpu_elapsed);
    muda_ops = 2 * (NUM_ITERATIONS * OPT_N / 1.0e+6) * (1000.0 / muda_elapsed);
    printf("[Perf] CPU  = %f (msec)  %f MOps/sec\n", cpu_elapsed, cpu_ops);
    printf("[Perf] MUDA = %f (msec)  %f MOps/sec\n", muda_elapsed / (NUM_ITERATIONS), muda_ops);
    
    // print first 10 options for debug
    // int i;
    // for (i = 0; i < 10; i++) {
    //     printf("Reference Call[%d] = %f\n", i, h_CallResultCPU[i]);
    //     printf("MUDA      Call[%d] = %f\n", i, h_CallResultMUDA[i]);
    //     printf("Reference Put[%d]  = %f\n", i, h_PutResultCPU[i]);
    //     printf("MUDA      Put[%d]  = %f\n", i, h_PutResultMUDA[i]);
    // }

    //
    // Compute diff
    //
    double delta, ref, sum_delta, sum_ref, max_delta, L1norm;

    sum_delta = 0;
    sum_ref   = 0;
    max_delta = 0; 

    for(int i = 0; i < OPT_N; i++){
        ref   = h_CallResultCPU[i];
        delta = fabs(h_CallResultCPU[i] - h_CallResultMUDA[i]);
        if(delta > max_delta) max_delta = delta;
        sum_delta += delta;
        sum_ref   += fabs(ref);
    }
    L1norm = sum_delta / sum_ref;
    printf("L1 norm: %E\n", L1norm);
    printf("Max absolute error: %E\n", max_delta);
    printf((L1norm < 1e-6) ? "TEST PASSED\n" : "TEST FAILED\n");



}

void
tearDown()
{
}

int
main(int argc, char **argv)
{
    setup();
    doIt();
    tearDown();

    return 0;
}
