#ifndef BLACKSCHOLES_GOLD_H
#define BLACKSCHOLES_GOLD_H

extern "C" void BlackScholesCPU(
    float *h_CallResult,
    float *h_PutResult,
    float *h_StockPrice,
    float *h_OptionStrike,
    float *h_OptionYears,
    float Riskfree,
    float Volatility,
    int optN
);


#endif	// BLACKSCHOLES_GOLD_H
