#ifndef BLACKSCHOLES_REFERENCE_H
#define BLACKSCHOLES_REFERENCE_H

#ifdef __cplusplus
extern "C" {
#endif

extern void BlackScholesCPU(
    float *h_CallResult,
    float *h_PutResult,
    float *h_StockPrice,
    float *h_OptionStrike,
    float *h_OptionYears,
    float Riskfree,
    float Volatility,
    int optN
);

#ifdef __cplusplus
}
#endif

#endif	// BLACKSCHOLES_REFERENCE_H
