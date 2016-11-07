.. highlightlang:: c

.. _xref_download:

========
Download
========


Snapshot
========

So far, MUDA has no official releases because its in very early development phase.
You can download development source tree from svn repository. 

::

  $ svn co https://lucille.svn.sourceforge.net/svnroot/lucille/angelina/haskellmuda muda

**NOTE** You may use ``**http**`` instead of https.

Requirements
============

MUDA compiler **mudah** is written totally in Haskell.

To build MUDA compiler, You'll need Haskell compiler, especially GHC.

http://www.haskell.org/ghc/

Supported platform
==================

MUDA compiler may work any platform where Haskell compiler GHC works(e.g. Linux, Win32, Mac OS X, BSD, etc).

MUDA genrated SIMD-C code may be compiled on following platforms.

* x86/SSE backend

  - HW: CPUs which supports SSE2.
  - Compilers:
  
    - gcc, which supports **-msse2** compiler option.

* LLVM IR backend

  - LLVM 2.3 or later

* PPC/AltiVec backend

  - TODO


Build
=====

After checking out MUDA source tree from svn repository, type following to build MUDA compiler.

::

  $ cd muda
  $ make

  # MUDA compiler named 'mudah' will be built at top directory.

  $ make test  <- this is optional
  

Let's try!
==========

If you success to build MUDA compiler, go :ref:`xref_tutorial` to quickly learn MUDA language.



