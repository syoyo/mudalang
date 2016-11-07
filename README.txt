=================================================
MUDA(MUltiple Data Accelerator) language compiler
=================================================

:Author: Syoyo Fujita
:Date: $Date: 2008-10-25 23:59:26 +0900 (Sat, 25 Oct 2008) $
:Note: This document is written in reStructuredText format.

.. contentes:


Introduction
============

This is an MUDA language compiler written in Haskell.

MUDA compiler generates a poratable C code with SIMD instrinsics, from MUDA vector language which is simlar to GLSL(OpenGL Shading Language).

For now, x86/SSE2 and VMX(W.I.P) code generation is supported.


Requirements
============

First, you'll need Haskell compiler.
  
* GHC(tested on GHC 7.6)
  http://www.haskell.org/ghc/

Optionally, if you want to modify the MUDA compiler, you'll need
following tools.

* BNF Converter
  http://www.cs.chalmers.se/~markus/BNFC/

* Alex
  http://www.haskell.org/alex/

* Happy 
  http://www.haskell.org/happy/


Install via cabal.

    $ cabal install alex
    $ cabal install happy
    $ cabal install bnfc

Then, regenerate parser codes by

    $ make gen


How to compile
==============

There are two ways to compile MUDA compiler.

1. Use Makefile(Recommended)

::

  $ make 

**mudah**(MUDA High performance compiler) will be built.
The name of binary executable is same(*mudah*)

2. Use CABAL(Recommended)

::

  $ runhaskell Setup.lhs configure
  $ runhaskell Setup.lhs build
  $ cp dist/build/mudah/mudah .


Optional
--------

After the success of compilation for MUDA compiler,
You can run test for MUDA compiler by typing,
  
::

  $ cd t
  $ python tester.py
    (You'll need python) 


Example
=======

  See examples/ directory.


License
=======

  Modified-BSD


Refernces
=========
  
Here is the valuable references to write a compiler in Haskell.

  - A Compiler Toolkit in Haskell.
    http://www.cse.unsw.edu.au/~chak/haskell/ctk/ö 

  - MinCaml, the compiler for a subset of ML.
    http://min-caml.sourceforge.net/index-e.html

  - Engineearing a compiler.
    Keith Cooper, Linda Torczon
    ISBN 155860698X

  - Pugs, perl6 interpreter writtein in Haskell.
    http://search.cpan.org/dist/Perl6-Pugs/

  - Optimizing compilers for modern architectures
    Randy Allen and Ken Kennedy
