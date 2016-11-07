.. MUDA Document documentation master file, created by sphinx-quickstart on Fri Apr  4 20:39:54 2008.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.


================================
MUDA : A vector language for CPU
================================

Contents:

.. toctree::
   :maxdepth: 1

   download
   tutorial
   example
   langspec
   devnote


What is MUDA?
=============

**MUDA(MUltiple Data Accelerator) language** is a short-vector SIMD language. MUDA's syntax is almost like GLSL(OpenGL Shading Language), but the compiled code runs on **CPU**, because MUDA compiler outputs plain portable SIMD-C code.

::

  // SSE code                               // MUDA code
  __m128 func(__m128 a, __m128 b) {         vec func(vec a, vec b) {
      
      return _mm_add_ps(                        return a * a + b;
                 _mm_mul_ps(a, a), b);

  }                                         }

MUDA is designed to accelerate your performance oriented program by using CPU's SIMD instruction.

If your program is floating point compute-intensive, it would be worth to use MUDA language. MUDA compiler emits a SIMD-C code, thus you can easily bind MUDA code and your C/C++ code.

Here is an application area. 

* offline/online graphics
* quantitative finance
* simulation
* data mining

Download
========

Get MUDA releases.  :ref:`xref_download`


Blog
====

See what is going on this project: MUDA development blog. 
http://mudadev.blogspot.com/

Slides
======

* MUDA project proposal http://www.slideshare.net/syoyo/muda-proposal/

Language Specification
======================

* MUDA language specification: :ref:`xref_langspec`

Development note
================

* Some useful documentation for SIMD compiler developers: :ref:`xref_devnote`

NEWS
====

* 17 Dec, 2007: Added new MUDA author!
* 10 Dec, 2007: Initial MUDA site opens!


TODOs
=====

* LLVM IR backend(work in progress)
* x86 SSE: Support for SSE3/4/5, Intel AVX
* Automatic optimizer combined with AMD codeanalyst, HW performance counter, etc. 
* Automatic cache optimization.
* Automatic memory access optimization.
* Automatic parallelization(by DSWP?).
* Some annotation techniques(testing, precision control, debugging, etc)

MUDA Authors
============

* Syoyo Fujita : http://lucille.atso-net.jp/blog/
* Luca Barbato : http://dev.gentoo.org/~lu_zero/
