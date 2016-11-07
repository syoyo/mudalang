#include <stdio.h>
#include "prof.h"
#include <math.h>


int
main()
{
	unsigned long long s, e;
	unsigned long long diff;
    unsigned long long basecost;

    float in = 0.1;
    float ret;

    // This may cause cache misses, thus don't use this measurement.
	s = getcycle();
	e = getcycle();

    // measure exec cost of rdtsc
	s = getcycle();
	e = getcycle();
    basecost = e -s;
    

    // This also cause cache misses, thus just discard it.
	s = getcycle();
    ret = log2f(in);
	e = getcycle();
    
    // Actual measurement
	s = getcycle();
    ret = log2f(in);
	e = getcycle();

    diff = e - s;

	printf("%lld, %lld, diff = %lld, cycles = %lld(diff-basecost), basecost = %lld\n", s, e, diff, diff-basecost, basecost);

	return 0;
}
