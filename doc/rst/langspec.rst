.. highlightlang:: c
.. _xref_langspec:

===========================
MUDA language specification
===========================

Syntax
======

Intrinsic data type
-------------------

MUDA supports following primitive data type.

========  =============================================
  Name    Description
========  =============================================
  vec     floating point 4 component vector(float x 4)
  dvec    floating point 4 component vector(double x 4)
  ivec    integer 4 component vector(32bit x 4)
  lvec    integer 4 component vector(64bit x 4)
  float   scalar single precision floating point value
  double  scalar double precision floating point value
  int     scalar integer value(32bit).
========  =============================================

In MUDA, almost all computation is done in floating point. thus **vec** and **float** are used as a primary data type. **ivec** and **int** are secondary data type and used where floating point is not suitable(e.g. amount of shifting, shuffle index, array index).

Floating point is mainly represented by single precision. Fully supporting double precision is **TODO**.

Structure
---------

**Note that this is not yet implemented**. MUDA will support user defined structure.

Comment
-------

MUDA supports both C style comment and C++ style line comment.

::

  /*
   * this is a comment
   */

  // this is also a comment


Vector and scalar conversion
----------------------------

Swizzling
~~~~~~~~~

Each element in the vector variable can be accessed by swizzling.
You can use a letter *x* , *y* , *z* and *w* to specify element in the vector variable.

If just one swizzle letter was specified, the returned value is considered as scalar variable.

In case of 2 or 3 swizzle letters, last letter will be repeated to match 4 component vector length(there's no float2 or float3 type in MUDA).::

  vec a, b, c, d, e, f;
  float z;

  a = vec(1.0, 2.0, 3.0, 4.0);

  b = a.xyzw;          // b = (1.0, 2.0, 3.0, 4.0)
  c = b.xxxx;          // c = (1.0, 1.0, 1.0, 1.0)
  z = b.y;             // z = 2.0
  d = b.xy;            // d = b.xyyy = (1.0, 2.0, 2.0, 2.0)

You can also use swizzle letter for left hand side(variable assign)::

  vec a, b, c;

  a = vec(1.0, 2.0, 3.0, 4.0);

  b = a.wzyx;          // b = (4.0, 3.0, 2.0, 1.0)

  // partially update z component of variable b.
  b.z = a.w;           // b = (4.0, 3.0, 4.0, 1.0)

  c      = vec(0.0);
  // This is OK. Update z component only.
  c.zzzz = a;          // c = (0.0, 0.0, 4.0, 0.0)


Arithmetic operation
--------------------

MUDA has following 5 basic arithmetic operation.

::

  +, -, *, /, /.(approximate division)

/.(slash dot) is something unique for MUDA.

This op lets the compiler try to use approximate division if possible.
If the computation core of your program contains division,
but if you do not require precise precision for division,
use approximate division instead of usual division for faster execution.

In x86/SSE2 backend implementation, approximate division op will be mapped to reciprocal estimate(**rcpps** instruction) and one round of Newton-Raphson, where division will be mapped to **divps** instruction.


Compare
-------

MUDA supports following compare operation.

::

  <, <=, >, >=, ==, !=


Returned value from compare op are either all 1's(true) or all 0's(false) for each element. This is true for floating point variable. You can use results of compare op for logical op, shift op or condition, but you **should not** use it for arithmetic op.

::

  // example

  vec a = vec(1.0, 0.0, 2.0, 3.0);
  vec b = vec(1.0, 1.0, 1.0, 1.0);

  vec ret = a > b;    // ret = (0x00000000, 0x00000000, 0xffffffff, 0xffffffff)
  

Shift and rotate
----------------

**TODO: This feature is not yet implemented.**
**NOTE: x86/SSE up to SSE2 does not support arbitrary bitwise shift and rotate. Thus this operation cannot be accelerated fully**

MUDA will support shift and rotate operation.

::

  << (quad word bit-wise shift left)
  >> (quad word bit-wise shift right)
  <<| (element-wise bit shift left)
  >>| (element-wise bit shift right)

  <<< (quad word bit-wise arithmetic shift left)
  >>> (quad word bit-wise arithmetic shift right)
  <<<| (element-wise bit arithmetic shift left)
  >>>| (element-wise bit arithmetic shift right)

  <<@ (quad word bit-wise rotate left)
  >>@ (quad word bit-wise rotate right)
  <<|@ (element-wise bit rotate left)
  >>|@ (element-wise bit rotate right)


Logical
-------

MUDA supports following logical expression.

::

  &(and), |(or), ^(xor), ~(not)

Logical expression can be applied to floating point vector or scalar value. In this case, floating point value is treated as a array of bit.


Condition
---------

MUDA supports following conditional expression.

::

  if, while


**if** expression must be followed by **else** keyword, and then statement and else statement should have parenthesis. **while** should have parenthesis.

::

  // -- OK

  if (a < 1.0) {

    b = 1.0;

  } else {

    // do nothing.

  }


  // -- Bad. no parenthesis

  if (a < 1.0) b = 1.0 else b = 2.0;


  // -- Bad. no else-statement

  if (a < 1.0) {

     b = 1.0;

  }

  // -- OK
  while (a > 1.0) {
    a = a - 0.1;
  }

  // -- Bad. no parenthesis
  while (a > 1.0) a = a - 0.1;


Function
--------

MUDA can define a function, almost same for C-function declaration.

::

  void              myfunc() { ... };
  static vec        myfunc() { ... };
  static inline vec myfunc() { ... };

return type
~~~~~~~~~~~

MUDA does not permit vector type as return type for external fuctions(function without **static** or **inline** spec). But this restriction is not applied to internal functions.

argument
~~~~~~~~

MUDA doesn't support pointer, but you can return the value through
function argument using output argument specifier **out**.

::

  void func(out vec ret) {

    ret = 1.0;	// return value.

  }

On the counter part of **out**, MUDA provides input argument specifier **in**.
But this is default and usually you don't need to express it.

::

  // Explicitly specify argument `a' is input argument. 
  float func(in vec a) {

    return a.x;

  }


inline
~~~~~~

==============  ============================================
 Name           Description
==============  ============================================
 inline         Usual inline.
 force_inline   Tell compiler to inline the function always.
 always_inline  Same as force_inline.
==============  ============================================

TODO: remove **always_inline** keyword.


Builtin function
================

List of builtin functions.

================  =============================================================
 function name    Description
================  =============================================================
 vec(a)           Returns vector value replicated with *a*. *a* must be scalar.
 vec(a, b, c, d)  Returns vector value constructed from 4 scalar values.
                  *a*, *b*, *c*, *d* are scalar.
 sel(a, b, mask)  Take *b* if mask is true, *a* if false. Do it in
                  element-wise.  *a*, *b* and *mask* are type of **vec**.
 extract(a, i)    Extract *i*'th element from vector *a*. *i* must be immediate
                  value and should be 0(preferred element), 1, 2 or 3.
 bit(a)           Directly specify bitfield for floating point value.
                  *a* must be hex value and returned value is floating point
                  vector.
 more to come     Be patient :-)
================  =============================================================

Math function
-------------

This is TODO. MUDA will support fast, approximate but as accurate as possible SIMD-optimized math functions.


================  =======================================  ====================
 function name    Input Range                              Maximum error in ulp
================  =======================================  ====================
 log2(x)          x in [0.0 .. +Inf)                       2
 sqrt(x)          x in [0.0 .. +Inf)                       2
 exp(x)           TBD                                      TBD
 more to come     Be patient :-)                           -
================  =======================================  ====================

endOfFile
