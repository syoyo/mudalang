-------------------------------------------------------------------------------
---- |
---- Module      :  Simplify
---- Copyright   :  (c) Syoyo Fujita
---- License     :  BSD-style
----
---- Maintainer  :  syoyo@lighttransport.com
---- Stability   :  experimental
---- Portability :  GHC 7.6
----
---- Simplify    :  Do simplify AST. Remove redundant nodes.
----                Called after Simplify fixing, before CodeGen.
----
-------------------------------------------------------------------------------

module Simplify where

import Debug.Trace

--
-- MUDA local modules
--
import qualified IR
import qualified TypeMUDA as T
import qualified Sym
import qualified NameSpace

class Simplify a where
  simplify :: a -> a 


instance Simplify IR.FormalDec where
  simplify d = d


instance Simplify IR.Exp where
  simplify e = case e of

    (IR.EIVtoI _ (IR.EItoIV _ exp)) -> exp
    (IR.EVtoF  _ (IR.EFtoV  _ exp)) -> exp

    _ -> e


instance Simplify IR.DecInitExp where
  simplify e = case e of
    IR.DExp sym exp
      -> (IR.DExp sym (simplify exp))


instance Simplify IR.Stm where
  simplify s = case s of
    IR.SDecl sym ty declInit@(IR.DeclInit id initExp)
      -> (IR.SDecl sym ty (IR.DeclInit id (map simplify initExp)))

    IR.SAssign sym id exp
      -> (IR.SAssign sym id (simplify exp))

    IR.SAssignWithField sym id fields exp
      -> (IR.SAssignWithField sym id fields (simplify exp))

    IR.SAssignWithArray sym id idxExp exp
      -> (IR.SAssignWithArray sym id (simplify idxExp) (simplify exp))

    IR.SAssignWithSwizzle sym id swizIdx exp
      -> (IR.SAssignWithSwizzle sym id swizIdx (simplify exp))

    IR.SBlock stms
      -> (IR.SBlock (map simplify stms))

    IR.SWhile exp stms
      -> (IR.SWhile (simplify exp) (map simplify stms))

    IR.SIf exp stms0 stms1
      -> (IR.SIf (simplify exp) (map simplify stms0) (map simplify stms1))

    IR.SReturnVoid
      -> (IR.SReturnVoid)

    IR.SReturn exp
      -> (IR.SReturn (simplify exp))

    IR.SExp exp
      -> (IR.SExp (simplify exp))


instance Simplify IR.Func where
  simplify f = case f of
    IR.Fun specs ty id formaldecs stms
      ->  (IR.Fun specs ty id formaldecs (map simplify stms) ) 


instance Simplify IR.MDec where
  simplify d = d


instance Simplify IR.Struc where
  simplify s = s
  

instance Simplify IR.Prog where
  simplify p = case p of
    IR.Program structs funcs
      -> (IR.Program structs (map simplify funcs))


simplifyTree :: IR.Prog -> IR.Prog
simplifyTree p = simplify p



-- vim: set sw=2 ts=2 expandtab:
