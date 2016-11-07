This directory contains math functions for MUDA.

Design policies are

  - fast but accurate as many as possible.
  - low latency.
  - no denormals
  - assume round-to-nearest rounding mode.
  - Handle +/-0, +/-Inf, +/-NaN input correctly.


References:

  - fdlibm
    Freely Distributable libm by SUN.
    http://www.netlib.org/fdlibm/

  - simdvecmath
    SIMD math package.
    http://bullet.svn.sourceforge.net/viewvc/bullet/trunk/Extras/simdmathlibrary 
    This code cannot be used directly for MUDA, because their implementation is
    optimized for PPE/SPE, especially HW having FMA(Fused-Multiply Add)
    instruction.  

    When I ported their implementation into x86/SSE, I observed catastrophic
    error at range reduction calculation. 
 
  - cr-libm
    A library of correctly rounded elementary functions in double-precision.

  - newlib
