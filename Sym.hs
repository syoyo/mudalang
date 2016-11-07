-----------------------------------------------------------------------------
---- |
---- Module      :  Sym
---- Copyright   :  (c) Syoyo Fujita
---- License     :  BSD-style
----
---- Maintainer  :  syoyo@lucillerender.org
---- Stability   :  experimental
---- Portability :  GHC 6.6
----
---- Sym         : Symbol data module.
----
-------------------------------------------------------------------------------
module Sym where

-- import Control.Monad.Cont  -- import liftIO
import Control.Monad.State -- import State
import Debug.Trace
import Data.IORef
-- import Data.HashTable as HashTable
import System.IO.Unsafe ( unsafePerformIO )

-- import ErrM
import TypeMUDA
import NameSpace

data Kind = KindFunction 
          | KindVariable
          | KindFormalVariable
          | KindStruct
          | KindOther
            deriving (Eq, Ord, Show)

-- Unified way for function def and symbol(variable) def.
-- `argTypes' is used for function def only.
-- TODO: Separate data constructor for variable and function.

data Sym = Sym { typ      :: TypeMUDA.Typ
               , quals    :: [TypeMUDA.Qual]
               , kind     :: Kind
               , name     :: String
               , argTypes :: [TypeMUDA.Typ]     -- func args
               }

    deriving (Eq, Ord)


nilSym :: Sym
nilSym = Sym { typ = TypeMUDA.Var "nil", quals = [], kind = KindOther, name = "nil", argTypes = [] }

getName :: Sym -> String
getName sym = name sym

getType :: Sym -> TypeMUDA.Typ
getType sym = typ sym

getTypeString :: Sym -> String
getTypeString sym = show (getType sym)

getQuals :: Sym -> [TypeMUDA.Qual]
getQuals sym = quals sym

getQualsString :: Sym -> String
getQualsString sym = show (getQuals sym)

getKind :: Sym -> Kind
getKind sym = kind sym

getKindString :: Sym -> String
getKindString sym = show (getKind sym)

getArgTypes :: Sym -> [TypeMUDA.Typ]
getArgTypes sym = argTypes sym

getArgTypesString :: Sym -> String
getArgTypesString sym = show (getArgTypes sym)


instance Show Sym where
  show sym  = "`" ++ (getName sym) ++ "'"
          ++ "(type = " ++ (getTypeString sym) ++ ", qualifier = "
          ++ (getQualsString sym) ++ ", kind = " ++ (getKindString sym)
          ++ ", argTypes = " ++ (getArgTypesString sym) ++ ")"


--
-- Counter for creating temporal symbol name
--

theCounterGen :: IORef Int
theCounterGen = unsafePerformIO $ do newIORef 0

setCounterGen :: Int -> IO ()
setCounterGen n = writeIORef theCounterGen n

getCounterGen :: IO Int
getCounterGen = readIORef theCounterGen

getCounter :: IO Int
getCounter = do
    n <- getCounterGen
    let newN = n + 1
    setCounterGen newN
    return newN

--
-- Generate symbol name
--

genSymName :: TypeMUDA.Typ -> String
genSymName t = "t_" ++ (strOfType t) ++ (show $ unsafePerformIO getCounter)


genSym :: Typ -> [Qual] -> Kind -> Sym
genSym t qs k = Sym { typ = t, quals = qs, kind = k, name = genSymName t, argTypes = [] }


    

-- vim: set sw=2 ts=2 expandtab:


