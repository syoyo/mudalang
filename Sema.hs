-------------------------------------------------------------------------------
---- |
---- Module      :  Sema
---- Copyright   :  (c) Syoyo Fujita
---- License     :  BSD-style
----
---- Maintainer  :  syoyo@lucillerender.org
---- Stability   :  experimental
---- Portability :  GHC 6.6
----
---- Sema        :  Do some semantic analysis.
----
-------------------------------------------------------------------------------

module Sema where

import Debug.Trace

--
-- MUDA local modules
--
import qualified IR
import qualified TypeMUDA as T
import qualified Sym
import qualified NameSpace


isReturnStmt :: IR.Stm -> Bool
isReturnStmt stm = case stm of
  IR.SReturnVoid -> True
  IR.SReturn _   -> True
  _              -> False

hasRetrunStmt :: [IR.Stm] -> Bool
hasRetrunStmt stms = any (True ==) (map isReturnStmt stms)
 
--
-- Insert SReturnVoid if there's no return statement in the toplevel body of
-- the function.
--
insertReturnIfNeeded :: IR.Func -> IR.Func
insertReturnIfNeeded f@(IR.Fun specs ty ident formals stms) = case (hasRetrunStmt stms) of
  True  -> f
  False -> IR.Fun specs ty ident formals (stms ++ [IR.SReturnVoid])    -- Append to last.


-- vim: set sw=2 ts=2 expandtab:
