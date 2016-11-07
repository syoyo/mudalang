Noise function optimized for MUDA
=================================

This is a MUDA implementation of Perlin noise, based on Olano's modified noise.

Measured Performance
---------------------

MUDA       , Core2 2.16GHz, Single core, 32bit :  39 M noise2/sec
MUDA + memo, Core2 2.16GHz, Single core, 32bit :  74 M noise2/sec
MUDA       , Core2 2.16GHz, Single core, 64bit :  50 M noise2/sec
MUDA + memo, Core2 2.16GHz, Single core, 64bit : 102 M nose2/sec

All compiled with llvm-gcc 2.2(gcc 4.2.1)


Theoretical peak
----------------

MUDA version of 2D noise function in 64bit mode is composed around 200 x86 instructions for 4 fp32 noise values on x86 SSE.
(50 instructions/noise).


Copyrights
----------

 noise1234.cpp, noise1234.h : Copyright 2003-2005, Stefan Gustavson
 
 The code is grabbed from,
 http://webstaff.itn.liu.se/~stegu/aqsis/aqsis-newnoise/ 
 

