//
// Classic Black-Scholes pricing
//

//
// add/sub  : 6
// mul      : 10
// div      : 1
// cmp      : 1
// abs      : 1
// exp      : 1
// sel      : 1
// ------------
// total    : 21
//
static always_inline vec cndMUDA(vec d)
{
	vec A1 = 0.31938153f;
	vec A2 = -0.356563782f;
	vec A3 = 1.781477937f;
	vec A4 = -1.821255978f;
	vec A5 = 1.330274429f;
	vec RSQRT2PI = 0.3989422804f;

	vec K = 1.0f /. (1.0f + 0.2316419f * abs(d));

	vec cnd = RSQRT2PI * exp(-0.5f * d * d) * (K * (A1 + K * (A2 + K * (A3 + K * (A4 + K * A5)))));

	vec one_minus_cnd = 1.0f - cnd;
	
	vec ret = sel(cnd, one_minus_cnd, d > 0.0f);

	return ret;
}

//
// Calculate Call & Put option price simulateniously.
//
// Reference performance:
//
//   4.7 GOpt/s was given for GeForce8800GTX
//   http://developer.download.nvidia.com/compute/cuda/1_1/Website/
//   projects/BlackScholes/doc/BlackScholes.pdf
//
//   G80 GTX has 345.6GFLOPS(Exclude SPU's flops)
//
//   345.6 GFLOPS / (4.7 Gopt / 2(callp&put)) = 147.06 cycles for
//   one BlackScholes function call.
//
//
// add/sub  : 7
// mul      : 13
// div      : 2
// exp      : 1
// log      : 1
// sqrt     : 1        
//                    -> up to here: 25
// cnd x 2  : 42
// -------------
// total    : 67
//

void BlackScholesMUDA(
	out vec retCall,
	out vec retPut,
	vec S,                  // Stock price
	vec X,                  // Option strike
	vec T,                  // Option years
	vec R,                  // Riskfree rate
	vec V)                  // Volatility rate
{

	vec sqrtT = sqrt(T);
	vec d1 = (log(S /. X) + (R + 0.5f * V * V) * T) /. (V * sqrtT);
	vec d2 = d1 - V * sqrtT;
	
	vec cnd_d1 = cndMUDA(d1);
	vec cnd_d2 = cndMUDA(d2);

	vec expRT = exp(-1.0f * R * T); 

	retCall = S * cnd_d1 - X * expRT * cnd_d2; 
	retPut  = X * expRT * (1.0f - cnd_d2) - S * (1.0f - cnd_d1);

}
