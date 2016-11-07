-----------------------------------------------------------------------------
---- |
---- Module      :  Syntax
---- Copyright   :  (c) Syoyo Fujita
---- License     :  BSD-style
----
---- Maintainer  :  syoyo@lighttransport.com
---- Stability   :  experimental
---- Portability :  GHC 7.6
----
---- SyntaxChecker: Do type checking, syntax checking, temporal symbol
----                assignment and symbol management during syntax processing.
----                Symbol table management is implemented with State Monad.
----
-------------------------------------------------------------------------------

module Syntax where

import Control.Monad.State
import Debug.Trace

--
-- MUDA local modules
--
import qualified IR
import qualified TypeMUDA as T
import qualified Sym
import qualified NameSpace
import qualified Sema

type SymbolTable = NameSpace.NameSpace Sym.Sym

-- length = 1 or 4
type SwizzleIndex = [Int]

class Syntax a where
  proc :: a -> State SymbolTable a 


--
-- Some utility functions
--
getTypeOfExp :: IR.Exp -> T.Typ
getTypeOfExp = Sym.getType . IR.getSymFromExp

-- instance Syntax IR.Exp where

instance Syntax IR.FormalDec where
  proc d = case d of
    IR.FormalDecl sym quals ty id
      ->  do
              declSym <- defSym s
              return (IR.FormalDecl declSym quals ty id) 

          where

            s :: Sym.Sym
            s = mkSym ty quals Sym.KindFormalVariable id


genSymAndExpFromExp :: IR.Exp -> State SymbolTable (Sym.Sym, IR.Exp)
genSymAndExpFromExp e0 = do

  -- Cook `exp' first
  e0' <- proc e0

  let e0Sym   = IR.getSymFromExp e0'
      ty      = Sym.getType e0Sym

  let newSym = Sym.genSym ty [] Sym.KindVariable 

  sym' <- defSym newSym
  return (sym', e0')


genSymAndExpsFromExp2 :: IR.Exp -> IR.Exp -> State SymbolTable (Sym.Sym, IR.Exp, IR.Exp)
genSymAndExpsFromExp2 e0 e1 = do

  -- Cook `exp' first
  e0' <- proc e0
  e1' <- proc e1

  let e0Sym   = IR.getSymFromExp e0'
      e1Sym   = IR.getSymFromExp e1'

      ty      = if eqTypeOfSym e0Sym e1Sym then
                  (Sym.getType e0Sym)
                else
                  error ("genSymAndExpsFromExp2" ++ errMsgTypeMismatch e0Sym e1Sym)

  let newSym = Sym.genSym ty [] Sym.KindVariable 

  sym' <- defSym newSym
  return (sym', e0', e1')

--
-- e0 assumes vector, e1 assumes int
--
genSymAndExpsForShiftOp :: IR.Exp -> IR.Exp -> State SymbolTable (Sym.Sym, IR.Exp, IR.Exp)
genSymAndExpsForShiftOp e0 e1 = do

  -- Cook `exp' first
  e0' <- proc e0
  e1' <- proc e1

  let e0Sym   = IR.getSymFromExp e0'
      e1Sym   = IR.getSymFromExp e1'

      -- ty      = if ((Sym.getType e0Sym) == T.Vec &&
      --               (Sym.getType e1Sym) == T.IVec) then
      --             (Sym.getType e0Sym)
      --           else
      --             error (errMsgTypeMismatch e0Sym e1Sym)

      ty = case ((Sym.getType e0Sym), (Sym.getType e1Sym)) of
        
        (T.Vec,  T.IVec) -> T.Vec
        (T.IVec, T.IVec) -> T.IVec
        _                -> error (errMsgTypeMismatch e0Sym e1Sym)

  let newSym = Sym.genSym ty [] Sym.KindVariable 

  sym' <- defSym newSym
  return (sym', e0', e1')

insertFtoD :: IR.Exp -> State SymbolTable IR.Exp
insertFtoD exp = do
  let newSym = Sym.genSym T.D [] Sym.KindVariable 

  sym' <- defSym newSym

  return (IR.EFtoD sym' exp)

insertVtoDV :: IR.Exp -> State SymbolTable IR.Exp
insertVtoDV exp = do
  let newSym = Sym.genSym T.DVec [] Sym.KindVariable 

  sym' <- defSym newSym

  return (IR.EVtoDV sym' exp)

insertVtoF :: IR.Exp -> State SymbolTable IR.Exp
insertVtoF exp = do
  let newSym = Sym.genSym T.F [] Sym.KindVariable 

  sym' <- defSym newSym

  return (IR.EVtoF sym' exp)

insertDVtoD :: IR.Exp -> State SymbolTable IR.Exp
insertDVtoD exp = do
  let newSym = Sym.genSym T.D [] Sym.KindVariable 

  sym' <- defSym newSym

  return (IR.EDVtoD sym' exp)

insertIVtoI :: IR.Exp -> State SymbolTable IR.Exp
insertIVtoI exp = do
  let newSym = Sym.genSym T.I [] Sym.KindVariable 

  sym' <- defSym newSym

  return (IR.EIVtoI sym' exp)

insertFtoI :: IR.Exp -> State SymbolTable IR.Exp
insertFtoI exp = do
  let newSym = Sym.genSym T.I [] Sym.KindVariable 

  sym' <- defSym newSym

  return (IR.EFtoI sym' [exp])

insertFtoV :: IR.Exp -> State SymbolTable IR.Exp
insertFtoV exp = do
  let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

  sym' <- defSym newSym

  return (IR.EFtoV sym' exp)

insertItoIV :: IR.Exp -> State SymbolTable IR.Exp
insertItoIV exp = do
  let newSym = Sym.genSym T.IVec [] Sym.KindVariable 

  sym' <- defSym newSym

  return (IR.EItoIV sym' exp)
  
--
-- | Insert VtoF to match func arg type, if nessesary
--
fixFuncArgExps :: [T.Typ] -> [IR.Exp] -> State SymbolTable [IR.Exp]
fixFuncArgExps types exps = mapM fixType $ zip types exps
  where
    fixType :: (T.Typ, IR.Exp) -> State SymbolTable IR.Exp
    fixType (ty, exp)
      | ty == (Sym.getType (IR.getSymFromExp exp)) = return exp
      | otherwise = insertVtoF exp
  

scalarizeExp :: IR.Exp -> State SymbolTable IR.Exp
scalarizeExp exp = case (Sym.getType (IR.getSymFromExp exp)) of
  T.Vec  -> insertVtoF exp  
  T.DVec -> insertDVtoD exp  
  T.IVec -> insertIVtoI exp  
  _      -> return exp


vectorizeExp :: IR.Exp -> State SymbolTable IR.Exp
vectorizeExp exp = case (Sym.getType (IR.getSymFromExp exp)) of
  T.F   -> insertFtoV  exp  
  T.I   -> insertItoIV exp  
  _     -> return exp

upcastToDoubleExp :: IR.Exp -> State SymbolTable IR.Exp
upcastToDoubleExp exp = case (Sym.getType (IR.getSymFromExp exp)) of
  T.F    -> insertFtoD exp
  T.Vec  -> insertVtoDV exp
  T.D    -> return exp
  T.DVec -> return exp
  _      -> error $ "[Syntax] TODO: upcastToDoubleExp" ++ show exp


--
-- Ensure exp is a integer & scalar expression.
--
mkScalarIntegerExpr :: IR.Exp -> State SymbolTable IR.Exp
mkScalarIntegerExpr (IR.EItoIV _ exp) =
  return exp    -- exp should be IR.EInt.
                -- It does not need to vectorize expression. 

mkScalarIntegerExpr exp = case (getTypeOfExp exp) of
  T.Vec  -> insertVtoF exp >>= insertFtoI
  T.IVec -> insertIVtoI exp
  T.F    -> insertFtoI exp
  T.I    -> return exp
  _      -> error $ "[Syntax] at EArray: TODO:" ++ show exp

instance Syntax IR.Exp where
  proc e = case e of

              
    --
    -- EFloat -> ELoad (EFloat val)
    -- 
    IR.EFloat sym val
      -> do
              let newSym = Sym.genSym T.F [] Sym.KindVariable 

              sym'   <- defSym newSym

              -- Insert ELoad

              let ldSym = Sym.genSym T.F [] Sym.KindVariable 

              ldSym' <- defSym ldSym

              return (IR.ELoad ldSym' (IR.EFloat sym' val))

    --
    -- EDouble -> ELoad (EDouble val)
    -- 
    IR.EDouble sym val
      -> do
              let newSym = Sym.genSym T.D [] Sym.KindVariable 

              sym'   <- defSym newSym

              -- Insert ELoad

              let ldSym = Sym.genSym T.D [] Sym.KindVariable 

              ldSym' <- defSym ldSym

              return (IR.ELoad ldSym' (IR.EDouble sym' val))

    --
    -- EInt -> ELoad (EInt val)
    -- 
    IR.EInt sym val
      -> do
              let newSym = Sym.genSym T.I [] Sym.KindVariable 

              sym'   <- defSym newSym

              -- Insert ELoad

              let ldSym = Sym.genSym T.I [] Sym.KindVariable 

              ldSym' <- defSym ldSym

              return (IR.ELoad ldSym (IR.EInt sym' val))

    --
    -- EIdent -> ELoad (EIdent id)
    -- 
    IR.EIdent sym id
      -> do
              table <- get

              let idSym = findSym table (stringFromIdent id)

                  exp   = (IR.EIdent idSym id)

              -- Insert ELoad
             
              let ldSym = Sym.genSym (getTypeOfExp exp) [] Sym.KindVariable 

              ldSym' <- defSym ldSym
                  

              let exp'   = IR.ELoad ldSym' exp

                  -- Promote type if needed

                  syn    = case (Sym.getType idSym) of
                            T.F -> IR.EFtoV (Sym.genSym T.Vec [] Sym.KindVariable) exp'
                            T.I -> IR.EItoIV (Sym.genSym T.IVec [] Sym.KindVariable) exp'
                            _   -> exp'

              return syn

    IR.EFtoV sym exp
      -> do
              exp' <- proc exp

              let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EFtoV sym' exp')

    IR.EDtoDV sym exp
      -> do
              exp' <- proc exp

              let newSym = Sym.genSym T.DVec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EDtoDV sym' exp')

    IR.EItoIV sym exp
      -> do
              exp' <- proc exp

              let newSym = Sym.genSym T.IVec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EItoIV sym' exp')
              

    {- :: TODO
    IR.EIdentWithField sym id fields
      -> do
              table <- get

              let idSym = findSym table (stringFromIdent id)

              newExp <- proc $ convertExpByType idSym (getFieldStr $ fields !! 0) (IR.EIdent Sym.nilSym id) 

              return newExp

              where

                getFieldStr :: IR.Field -> String
                getFieldStr (IR.EField (IR.Ident str)) = str
    

                --
                -- If type == struct, convert exp to EFieldSelect
                -- ESwizzle otherwise
                --
                convertExpByType :: Sym.Sym -> String -> IR.Exp -> IR.Exp
                convertExpByType idSym fieldStr exp = case (Sym.getType idSym) of
                  T.Var structId -> IR.EFieldSelect Sym.nilSym (IR.Ident fieldStr) exp
                  _              -> swizzleExp fieldStr exp

                
                --
                -- Always vectorize expression.
                -- a.x is mapped to a.xxxx
                --
                swizzleExp str exp
                  | isSwizzle str = IR.ESwizzle Sym.nilSym (swizzleIndexFromString4 str) exp 
                  | otherwise     = error $ "Not a swizzle letter: " ++ str

    -}

    IR.ESwizzle sym swizzleIndex exp
      -> do 
              exp' <- proc exp

              let newSym = Sym.genSym (getTy exp') [] Sym.KindVariable 

              sym' <- defSym newSym
              
              return (IR.ESwizzle sym' swizzleIndex exp')

              where 

                getTy e = case (getTypeOfExp e) of
                  T.Vec  -> T.Vec
                  T.DVec -> T.DVec
                  ty@_   -> error ("Unsupported type for abs()" ++ (show ty))



    IR.EAnd sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EAnd sym' e0' e1')

    IR.EOr  sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EOr sym' e0' e1')

    IR.EXor  sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EXor sym' e0' e1')

    IR.ENot  sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.ENot sym' e0' e1')

    IR.EEq  sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EEq sym' e0' e1')

    IR.ENeq  sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.ENeq sym' e0' e1')

    IR.EGt   sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EGt sym' e0' e1')

    IR.EGte  sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EGte sym' e0' e1')

    IR.ELt   sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.ELt sym' e0' e1')

    IR.ELte  sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.ELte sym' e0' e1')

    --
    -- TODO: For all shift op.
    --       Do type checking. Type of e1 must be int and should be scalar. 
    --
    IR.ESlElemWise sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsForShiftOp e0 e1
            return (IR.ESlElemWise sym' e0' e1')


    IR.ESrElemWise sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsForShiftOp e0 e1
            return (IR.ESrElemWise sym' e0' e1')


    IR.ESlQWord sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsForShiftOp e0 e1
            return (IR.ESlQWord sym' e0' e1')

    IR.ESrQWord sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsForShiftOp e0 e1
            return (IR.ESrQWord sym' e0' e1')

    IR.EAdd sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EAdd sym' e0' e1')

    IR.ESub sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.ESub sym' e0' e1')

    IR.EMul sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EMul sym' e0' e1')

    IR.EDiv sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EDiv sym' e0' e1')

    IR.EDivApprox sym e0 e1
      -> do (sym', e0', e1') <- genSymAndExpsFromExp2 e0 e1
            return (IR.EDivApprox sym' e0' e1')

    IR.ENeg sym e0 
      -> do (sym', e0') <- genSymAndExpFromExp e0 
            return (IR.ENeg sym' e0')

    --
    -- Array lookup expression. exp[idxExp]
    --
    IR.EArray sym exp idxExp
      -> do

            exp'    <- proc exp
            idxExp' <- proc idxExp >>= mkScalarIntegerExpr

            let newSym = Sym.genSym (getTypeOfExp exp') [] Sym.KindVariable

            sym'    <- defSym newSym

            return (IR.EArray sym' exp' idxExp')


    IR.EFunc sym id exps
      -> do 
            exps' <- mapM proc exps 

            table <- get

            -- Inferrior type of this function from symbol table.
            let funSym = findFuncSym table (IR.stringFromIdent id)
                newSym = Sym.genSym (Sym.getType funSym) [] Sym.KindVariable 

            sym' <- defSym newSym

            exps'' <- fixFuncArgExps (Sym.getArgTypes funSym) exps'

            return (IR.EFunc sym' id exps'')


    IR.EVecInit sym [exp]

      -- One argument. In this case. exp is already vectorized.

      -> do 

            exp'  <- proc exp

            table <- get

            let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

            sym' <- defSym newSym

            return (IR.EVecInit sym' [exp'])

    IR.EVecInit sym exps

      -- Multiple arguments(length of exps should be 4)
      -- If the type of exp is vector, convert it to scalar.

      -> do 

            exps' <- mapM (\e -> proc e >>= scalarizeExp) exps 

            table <- get

            let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

            sym' <- defSym newSym

            return (IR.EVecInit sym' exps')


    IR.EDVecInit sym [exp]

      -- One argument. In this case. exp is already vectorized.

      -> do 


            exp'  <- proc exp >>= upcastToDoubleExp

            table <- get

            let newSym = Sym.genSym T.DVec [] Sym.KindVariable 

            sym' <- defSym newSym

            return (IR.EDVecInit sym' [exp'])

    IR.EDVecInit sym exps

      -- Multiple arguments(length of exps should be 4)
      -- If the type of exp is vector, convert it to scalar.

      -> do 

            exps' <- mapM (\e -> proc e >>= scalarizeExp) exps 

            table <- get

            let newSym = Sym.genSym T.DVec [] Sym.KindVariable 

            sym' <- defSym newSym

            return (IR.EDVecInit sym' exps')

    --
    -- TODO: type check for exps.
    --       Do type checking in a common way for intrinsic functions.
    --
    --
    IR.ESel sym exps

      | ((length exps) == 3) == False
        -> error ("sel() must take just 3 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do
              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym (Sym.getType $ IR.getSymFromExp (head exps')) [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.ESel sym' exps')

    --
    -- extract() must take immediate int value for the second argument.
    -- this limitation will be unleashed in the future.
    --
    IR.EExtract sym exps
      | ((length exps) == 2) == False
        -> error ("extract() must take just 2 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> case exps of
          (e0:[(IR.EItoIV _ (IR.EInt _ _))])
            -> do
                  exps' <- mapM proc exps

                  table <- get

                  let newSym = Sym.genSym (Sym.getType $ IR.getSymFromExp (head exps')) [] Sym.KindVariable 

                  sym' <- defSym newSym

                  return (IR.EExtract sym' exps')


          _ -> error "second arg of extract() should be immediate int value"

    --
    -- bit(). Directly specify bit field for floating-point value.
    -- Argument must be immediate integer value.
    -- e.g. vec a = bit(0x3f000000);  // a = (1.0, 1.0, 1.0, 1.0)
    --
    IR.EBit sym exps
      | ((length exps) == 1) == False
        -> error ("extract() must take just 1 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> case exps of
          [e0@(IR.EItoIV _ (IR.EInt _ val))]
            -> do

                  exp' <- proc e0

                  table <- get

                  let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

                  sym' <- defSym newSym

                  let bitSym = Sym.genSym T.I [] Sym.KindVariable 

                  bitSym' <- defSym bitSym

                  return (IR.EBtoV sym' (IR.EInt bitSym' val))

          _ -> do

                  exp' <- proc (exps !! 0)

                  table <- get

                  let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

                  sym' <- defSym newSym

                  return (IR.EBtoV sym' exp')

    --
    -- itof(). convert int vector to float vector.
    --
    IR.EItoF sym exps
      | ((length exps) == 1) == False
        -> error ("itof() must take just 1 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exp' <- proc (exps !! 0)

              table <- get

              let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EItoF sym' [exp'])

    --
    -- ftoi(). convert float vector to int vector.
    --
    IR.EFtoI sym exps
      | ((length exps) == 1) == False
        -> error ("ftoi() must take just 1 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exp' <- proc (exps !! 0)

              table <- get

              let newSym = Sym.genSym T.IVec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EFtoI sym' [exp'])

    --
    -- rsqrt(). recprocal of sqrt.
    --
    IR.ERsqrt sym exps
      | ((length exps) == 1) == False
        -> error ("rsqrt() must take just 1 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
         -> do

                exps' <- mapM proc exps

                table <- get

                let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

                sym' <- defSym newSym

                return (IR.ERsqrt sym' exps')

    --
    -- frac().
    --
    IR.EFrac sym exps
      | ((length exps) == 1) == False
        -> error ("frac() must take just 1 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
         -> do

                exps' <- mapM proc exps

                table <- get

                let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

                sym' <- defSym newSym

                return (IR.EFrac sym' exps')

    --
    -- ceil().
    --
    IR.ECeil sym exps
      | ((length exps) == 1) == False
        -> error ("ceil() must take just 1 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
         -> do

                exps' <- mapM proc exps

                table <- get

                let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

                sym' <- defSym newSym

                return (IR.ECeil sym' exps')

    --
    -- floor().
    --
    IR.EFloor sym exps
      | ((length exps) == 1) == False
        -> error ("trunc() must take just 1 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
         -> do

                exps' <- mapM proc exps

                table <- get

                let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

                sym' <- defSym newSym

                return (IR.EFloor sym' exps')

    --
    -- trunc().
    --
    IR.ETrunc sym exps
      | ((length exps) == 1) == False
        -> error ("trunc() must take just 1 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
         -> do

                exps' <- mapM proc exps

                table <- get

                let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

                sym' <- defSym newSym

                return (IR.ETrunc sym' exps')

    --
    -- round().
    -- Rounding mode is defined in backend.
    --
    IR.ERound sym exps
      | ((length exps) == 1) == False
        -> error ("round() must take just 1 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
         -> do

                exps' <- mapM proc exps

                table <- get

                let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

                sym' <- defSym newSym

                return (IR.ERound sym' exps')

    --
    -- min()
    --
    IR.EMin sym exps
      | ((length exps) == 2) == False
        -> error ("min() must take 2 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym (getTy $ exps' !! 0) [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EMin sym' exps')

              where

                getTy e = case (getTypeOfExp e) of
                  T.Vec  -> T.Vec
                  T.DVec -> T.DVec
                  ty@_   -> error ("Unsupported type for abs()" ++ (show ty))

    --
    -- max()
    --
    IR.EMax sym exps
      | ((length exps) == 2) == False
        -> error ("max() must take 2 args, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym (getTy $ exps' !! 0) [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EMax sym' exps')

              where

                getTy e = case (getTypeOfExp e) of
                  T.Vec  -> T.Vec
                  T.DVec -> T.DVec
                  ty@_   -> error ("Unsupported type for abs()" ++ (show ty))

    --
    -- gather()
    --
    IR.EGather sym exps
      | ((length exps) == 1) == False
        -> error ("gather() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.I [] Sym.KindVariable 

              sym' <- defSym newSym

              -- return (IR.EGather sym' exps')
              vectorizeExp (IR.EGather sym' exps')

    --
    -- all() return type is integer vector
    --
    IR.EAll sym exps
      | ((length exps) == 1) == False
        -> error ("all() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.IVec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EAll sym' exps')

    --
    -- any()
    --
    IR.EAny sym exps
      | ((length exps) == 1) == False
        -> error ("any() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.IVec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EAny sym' exps')

    --
    -- abs()
    --
    IR.EAbs sym exps
      | ((length exps) == 1) == False
        -> error ("abs() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do
              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym (getTy (exps' !! 0)) [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EAbs sym' exps')

              where
                
                getTy e = case (getTypeOfExp e) of
                  T.Vec  -> T.Vec
                  T.DVec -> T.DVec
                  ty@_   -> error ("Unsupported type for abs()" ++ (show ty))

    --
    -- exp()
    --
    IR.EExp sym exps
      | ((length exps) == 1) == False
        -> error ("exp() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym (getTy (exps' !! 0)) [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EExp sym' exps')

              where
                
                getTy e = case (getTypeOfExp e) of
                  T.Vec  -> T.Vec
                  T.DVec -> T.DVec
                  ty@_   -> error ("Unsupported type for exp()" ++ (show ty))

    --
    -- log()
    --
    IR.ELog sym exps
      | ((length exps) == 1) == False
        -> error ("log() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.ELog sym' exps')

    --
    -- log2()
    --
    IR.ELog2 sym exps
      | ((length exps) == 1) == False
        -> error ("log2() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.ELog2 sym' exps')

    --
    -- fastexp()
    --
    IR.EFastExp sym exps
      | ((length exps) == 1) == False
        -> error ("fastexp() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EFastExp sym' exps')

    --
    -- fastlog()
    --
    IR.EFastLog sym exps
      | ((length exps) == 1) == False
        -> error ("fastlog() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EFastLog sym' exps')

    --
    -- fastlog2()
    --
    IR.EFastLog2 sym exps
      | ((length exps) == 1) == False
        -> error ("fastlog2() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EFastLog2 sym' exps')

    --
    -- sqrt()
    --
    IR.ESqrt sym exps
      | ((length exps) == 1) == False
        -> error ("sqrt() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.ESqrt sym' exps')

    --
    -- as_vec()
    --
    IR.EAsVec sym exps
      | ((length exps) == 1) == False
        -> error ("as_vec() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.Vec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EAsVec sym' exps')

    --
    -- as_ivec()
    --
    IR.EAsIVec sym exps
      | ((length exps) == 1) == False
        -> error ("as_vec() must take 1 arg, but " ++ 
                  (show $ length exps) ++
                  " is provided")

      | otherwise
        -> do

              exps' <- mapM proc exps

              table <- get

              let newSym = Sym.genSym T.IVec [] Sym.KindVariable 

              sym' <- defSym newSym

              return (IR.EAsIVec sym' exps')

    --
    -- field selector
    --
    -- Pattern of field selection.
    --
    --   1.  Swizzle of vector type.
    --       "exp" is vector type and "fieldId" is swizzle string.
    --       
    --       e.g., a.x; a.xxxx; a.xyzw; 
    --             (a + b).xyz;
    --             c[3].xyz;
    --
    --
    --   2.  Struct field selection.
    --       "exp" is struct type and "fieldId" is field of structure.
    --
    --       e.g., m.v; n[3].v; // m and n are struct 
    --
    IR.EFieldSelect sym fieldId exp
      -> do
              exp' <- proc exp

              case (getTypeOfExp exp', isSwizzle (stringFromIdent fieldId)) of

                (T.Var structStr, _  ) ->

                  do

                      table <- get

                      let structSym  = checkArraySyntax $ IR.getSymFromExp exp'
                          structSym' = findSym table (Sym.getName structSym)
                          newSym     = Sym.genSym (Sym.getType $ findStructFieldSym table structSym' (stringFromIdent fieldId)) [] Sym.KindVariable 

                      sym' <- defSym newSym

                      --
                      -- vectorizeExp includes return
                      -- 
                      vectorizeExp (IR.EFieldSelect sym' fieldId exp')


                      where

                        checkArraySyntax :: Sym.Sym -> Sym.Sym
                        checkArraySyntax sym =

                          if containsArrayQual (Sym.getQuals sym) == False
                            then sym
                            else if (isArrayExp exp') == True then sym else error ("[Syntax] Syntax err: Trying to access array variable without array index: " ++ show e)

                        containsArrayQual :: [T.Qual] -> Bool
                        containsArrayQual qs = 
                          if length (filter (\q -> q == T.ArrayQual) qs) == 0
                            then False
                            else True

                        isArrayExp :: IR.Exp -> Bool
                        isArrayExp aexp@(IR.EArray _ _ _) = True
                        isArrayExp _                    = False
                          

                (T.Vec,          True) ->

                  do

                      newExp <- proc (IR.ESwizzle Sym.nilSym (swizzleIndexFromString4 (stringFromIdent fieldId)) exp)

                      return newExp


                (T.DVec,         True) ->

                  do

                      newExp <- proc (IR.ESwizzle Sym.nilSym (swizzleIndexFromString4 (stringFromIdent fieldId)) exp)

                      return newExp


                (T.IVec,         True) ->

                  do

                      newExp <- proc (IR.ESwizzle Sym.nilSym (swizzleIndexFromString4 (stringFromIdent fieldId)) exp)

                      return newExp

                _                      -> error $ "[Syntax] at EFieldSelect: TODO:" ++ show e

                
      -- -> case exp of

      --   -- Array look up

      --   (IR.EIdent _ structId)

      --     --
      --     --
      --     --

      --     -> do

      --           exp'      <- proc exp

      --           table <- get


      --           let structSym = findSym table (stringFromIdent structId)
      --               newSym    = Sym.genSym (Sym.getType $ findStructFieldSym table structSym (stringFromIdent fieldId)) [] Sym.KindVariable 

      --           sym' <- defSym newSym

      --           vectorizeExp (IR.EFieldSelect sym' exp' fieldId) -- includes return

      --   _ -> error "FieldSelector specified for non identifier"

    _ -> error ("[Syntax] Unknown syntax: " ++ show e)


convertAssign :: Sym.Sym -> IR.Ident -> String -> IR.Exp -> State SymbolTable IR.Stm
convertAssign sym id fieldStr exp
  = case (Sym.getType sym, isSwizzle fieldStr) of
    (T.Var structId, _    ) ->
      do

          table <- get

          let expSym    = IR.getSymFromExp exp
              newSym    = Sym.genSym (Sym.getType $ findStructFieldSym table sym fieldStr) [] Sym.KindVariable 
            
          exp' <- convExpType (Sym.getType newSym) (Sym.getType expSym) exp

          return (IR.SAssignWithField sym id [IR.EField (IR.Ident fieldStr)] exp')


    (T.Vec         , True ) -> return $ IR.SAssignWithSwizzle sym id (swizzleIndexFromString fieldStr) exp
    (T.Vec         , False) -> error $ "Not a wizzle pattern : " ++ show fieldStr
    _                       -> error $ "Syntax err" ++ show sym ++ "," ++ show fieldStr



            


instance Syntax IR.DecInitExp where
  proc e = case e of
    IR.DExp sym exp
      -> do

            -- sym is not used?

            exp' <- proc exp

            return (IR.DExp sym exp') 


instance Syntax IR.Stm where
  proc s = case s of
    IR.SDecl sym ty declInit@(IR.DeclInit id initExp)
      ->  do
              -- Cook 'initExps' first
              -- TODO: initExps takes either 0 or 1 arg.

              exp' <- mapM proc initExp
              declSym <- defSym s    


              let decInit' = IR.DeclInit 
              -- let exp'' = case exp' of
              --          []     -> []
              --          [dexp] -> IR.DExp Sym.nilSym (convDExpType (Sym.getType declSym) (Sym.getType $ IR.getSymFromDExp dexp) dexp)

              case exp' of
                []     -> return (IR.SDecl declSym ty (IR.DeclInit id []))
                [dexp] -> do dexp' <- convDExpType (Sym.getType declSym) (Sym.getType $ IR.getSymFromDExp dexp) dexp
                             return (IR.SDecl declSym ty (IR.DeclInit id [(IR.DExp Sym.nilSym dexp')]))
              
          where

          s :: Sym.Sym
          s = mkSym ty [] Sym.KindVariable id


    IR.SAssign sym id exp
      ->  do

              -- Cook `exp' first
              exp' <- proc exp

              table <- get

              -- Get symbol info from symbol table.
              let declSym = findSym table (stringFromIdent id)
                  expSym  = IR.getSymFromExp exp'

              --  let sym' = if eqTypeOfSym declSym expSym then
              --                declSym
              --             else
              --                error (errMsgTypeMismatch declSym expSym)

              exp'' <- convExpType (Sym.getType declSym) (Sym.getType expSym) exp'

              return (IR.SAssign declSym id exp'')

    --
    -- assignment with field selector.
    --
    -- e.g.  val.f = 3.0 + x;
    --
    IR.SAssignWithField sym id fields exp
      ->  do

              -- Cook `exp' first
              exp' <- proc exp

              table <- get

              -- Get symbol info from symbol table.
              let structSym = findSym table (stringFromIdent id)
                  expSym    = IR.getSymFromExp exp'
                  fieldStr  = getFieldName $ fields !! 0

              convertAssign structSym id fieldStr exp'

              where

                getFieldName :: IR.Field -> String
                getFieldName (IR.EField (IR.Ident idStr)) = idStr


    --
    -- assignment for array.
    --
    -- e.g.  val[idxExp] = exp;
    --
    IR.SAssignWithArray sym id idxExp exp
      ->  do

              -- Cook `exp' first
              exp'    <- proc exp

              -- indexer must be a scalar & interger.
              idxExp' <- proc idxExp >>= mkScalarIntegerExpr


              table <- get

              -- Get symbol info from symbol table.
              let arrSym = findSym table (stringFromIdent id)
                  expSym    = IR.getSymFromExp exp'


              exp'' <- convExpType (Sym.getType arrSym) (Sym.getType expSym) exp'

              return (IR.SAssignWithArray arrSym id idxExp' exp'')


    --
    -- Compound statement
    --
    IR.SBlock stms
      ->  do
              --
              -- push scope
              --
              table <- get
              let newTable = NameSpace.pushScope table
              put newTable

              stms' <- mapM proc stms

              --
              -- pop scope
              --
              tablePost <- get
              let (newTablePost, ls) = NameSpace.popScope tablePost
              put newTablePost

              return (IR.SBlock stms')

    IR.SWhile exp stms
      ->  do
              -- root of `exp' should have scalar expression.
              -- TODO: Type check for exp
              exp'  <- proc exp >>= scalarizeExp
              stms' <- mapM proc stms

              return (IR.SWhile exp' stms')

    IR.SIf exp stms0 stms1
      ->  do

              -- Cook `exp' first
              -- root of `exp' should have scalar expression.
              exp' <- proc exp >>= scalarizeExp

              -- Then cook `stms0' and `stms1'
              stms0' <- mapM proc stms0
              stms1' <- mapM proc stms1

              return (IR.SIf exp' stms0' stms1')


    --
    -- TODO: validate that the function has void return type.
    --
    IR.SReturnVoid

      -> do { return (IR.SReturnVoid) }


    IR.SReturn exp

      -> do

            -- Cook `exp' first

            exp' <- proc exp

            -- Inferrior type of this function from symbol table.

            table <- get
            let funSym         = getCurrentFuncSym table

            exp'' <- convExpType (Sym.getType funSym) (Sym.getType $ IR.getSymFromExp exp') exp'

            return (IR.SReturn exp'')

    IR.SExp exp

      -> do

            -- Cook `exp' first

            exp' <- proc exp

            return (IR.SExp exp')



 

--
-- Do scalarize expression or vectorize expression, depends on
-- lhs type and rhs type.
--
convExpType :: T.Typ -> T.Typ -> IR.Exp -> State SymbolTable IR.Exp
convExpType lExpType rExpType exp = case (lExpType, rExpType) of 
  (T.IVec ,  T.I    ) -> vectorizeExp exp
  (T.I    ,  T.IVec ) -> scalarizeExp exp
  (T.IVec ,  T.IVec ) -> return exp

  (T.Vec  ,  T.Vec  ) -> return exp
  (T.F    ,  T.Vec  ) -> scalarizeExp exp
  (T.Vec  ,  T.F    ) -> vectorizeExp exp

  (T.DVec ,  T.DVec ) -> return exp
  (T.D    ,  T.DVec ) -> scalarizeExp exp
  (T.DVec ,  T.D    ) -> vectorizeExp exp

  (T.I    ,  T.Vec  ) -> scalarizeExp exp >>= insertFtoI
  (T.Var x,  T.Var y) -> if x == y then return exp
                                  else error $ "Struct type mismatch" 
  _                  -> error $ "[Syntax] convExpType: Not yet implemented: lExpType = " ++ show lExpType ++ ", rExpTyle = " ++ show rExpType ++ ", exp = " ++ show exp

convDExpType :: T.Typ -> T.Typ -> IR.DecInitExp -> State SymbolTable IR.Exp
convDExpType lExpType rExpType (IR.DExp dsym dexp) = case (lExpType, rExpType) of 
  (T.Vec,  T.Vec  ) -> return dexp
  (T.F  ,  T.Vec  ) -> scalarizeExp dexp
  (T.Vec,  T.F    ) -> vectorizeExp dexp

  (T.DVec, T.DVec ) -> return dexp

  (T.IVec, T.I    ) -> vectorizeExp dexp
  (T.I,    T.IVec ) -> scalarizeExp dexp
  (T.IVec, T.Vec  ) -> return dexp
  (T.IVec, T.IVec ) -> return dexp
  _                -> error $ "[Syntax] convDExpType: Not yet implemented: lExpType = " ++ show lExpType ++ ", rExpTyle = " ++ show rExpType ++ ", exp = " ++ show dexp

mkArgTypeArray :: [IR.FormalDec] -> [T.Typ]
mkArgTypeArray decls = map (\(IR.FormalDecl s qs ty id) -> IR.convTypeMUDA ty) decls

instance Syntax IR.Func where
  proc f = case f of
    IR.Fun specs ty id formaldecs stms
      ->  do  
              funsym <- defSym s -- define function in the global scope

              --
              -- Make the scope for this function and enters it
              --
              table <- get
              let newTable = NameSpace.pushScope table
              put newTable

              let ty'      = checkReturnType specs ty

              defSym s   -- also define function in the local scope

              --
              -- formal decls are defined in the function scope
              -- 
              formaldecs' <- mapM proc formaldecs

              stms' <- mapM proc stms

              --
              -- Leave scope
              --
              tablePost <- get
              let (newTablePost, ls) = NameSpace.popScope tablePost
              put newTablePost
            
              -- return (IR.Fun specs ty' (IR.Ident (Sym.getName funsym)) formaldecs' stms')
              return (Sema.insertReturnIfNeeded (IR.Fun specs ty' (IR.Ident (Sym.getName funsym)) formaldecs' stms'))

        where

        s :: Sym.Sym
        s = mkFuncSym ty [] id (mkArgTypeArray formaldecs)


        -- If external function has non native type for its return type,
        -- return err.
        checkReturnType :: [IR.FuncSpec] -> IR.Typ -> IR.Typ
        checkReturnType specs ty = case (specs, T.isPrimitive (getType ty)) of
          ([], True ) -> ty
          ([], False) -> error $ "[Syntax] Non primitive type as return type is not supported yet: type (" ++ show (getType ty) ++ ") specified for function " ++ show id
          (_ , False) -> ty
          (_ , True ) -> ty
    


--
-- 
--
instance Syntax IR.MDec where
  proc d = case d of
    IR.MDecl ty id structId
      ->  do
              defSym s    -- define the field element of structure
                          -- in the global scope
              return (IR.MDecl ty id structId) 

          where

            --
            -- make symbol name as "name of struct"_"name of field"
            -- 
            s :: Sym.Sym
            s = mkSym ty [] Sym.KindVariable (mkNewID id)

            mkNewID :: IR.Ident -> IR.Ident
            mkNewID id = IR.Ident $ (stringFromIdent structId) ++ "_" ++ (stringFromIdent id)

instance Syntax IR.Struc where
  proc s = case s of
    IR.Struct id mdecs
      ->  do  
              -- structSym <- defSym s -- define struct name in the global scope
              defSym s -- define struct name in the global scope

              mdecs' <- mapM proc mdecs

              return (IR.Struct id mdecs')

        where

        s :: Sym.Sym
        s = mkStructSym [] id
  
instance Syntax IR.Prog where
  proc p = case p of
    IR.Program structs funcs
      -> do
            structs' <- mapM proc structs
            funcs'   <- mapM proc funcs
            return (IR.Program structs' funcs')

checkSyntax :: IR.Prog -> IR.Prog
checkSyntax p = evalState (proc p) NameSpace.emptyNameSpace


--
-- Err messages
--
errMsgTypeMismatch :: Sym.Sym -> Sym.Sym -> String
errMsgTypeMismatch s0 s1 =
  "[Syntax] Type mismatch: " ++ (show s0) ++ " and " ++ (show s1)


--
-- Utility functions
--
--

defSym :: Sym.Sym -> State SymbolTable Sym.Sym
-- defSym sym = trace ("// [DBG] define" ++ show sym) $ 
defSym sym = 
  do  table <- get
      let (table', v)        = NameSpace.defLocal table (Sym.getName sym) sym
          (newTable, newSym) = case v of
                               Nothing  -> (table', sym)
                               Just regsym -> error (errMsg regsym) 
      put newTable
      return newSym

  where

    errMsg :: Sym.Sym -> String
    errMsg regsym = "Symbol " ++ show sym ++ " is already defined as" ++ show regsym


findSym :: SymbolTable -> String -> Sym.Sym
findSym table str = case NameSpace.find table str of
  Nothing  -> error ("[Syntax:findSym] Unknown symbol `" ++ str ++ "'")
  Just sym -> sym

findFuncSym :: SymbolTable -> String -> Sym.Sym
findFuncSym table str = case NameSpace.find table str of
  Nothing  -> error ("[Syntax] Unknown function `" ++ str ++ "'")
  Just sym | (Sym.getKind sym) == Sym.KindFunction -> sym
           | otherwise -> error ("Undefined function `" ++ str ++ "'")

findStructFieldSym :: SymbolTable -> Sym.Sym -> String -> Sym.Sym
findStructFieldSym table structSym fieldStr = case NameSpace.find table s of
  Nothing  -> error ("[Syntax:findStructFieldSym] Unknown symbol `" ++ fieldStr ++ "'")
  Just sym -> sym

  where

    s :: String
    s = (getStructTypeStr structSym) ++ "_" ++ fieldStr

    getStructTypeStr :: Sym.Sym -> String
    getStructTypeStr sym = case (Sym.getType sym) of
      T.Var str -> str
      _         -> error $ "[Syntax] ??? : symbol [" ++ show sym ++ "] is not a structure"

--
-- Current function is stored in the last element of the current scope.
--
getCurrentFuncSym :: SymbolTable -> Sym.Sym
getCurrentFuncSym table = case (last (NameSpace.getCurrentLocal table)) of
  (_, sym) | (Sym.getKind sym) == Sym.KindFunction -> sym
           | otherwise                             -> error ("Parse err?: Head of symbol stack : `" ++ show sym ++ "'")

--
-- All scalar leaf node is converted to vector node at IR construction phase,
-- thus no `exp = (int x)' node.
--
isConstantIntExp :: IR.Exp -> Bool
isConstantIntExp exp = case exp of
  (IR.EItoIV _ (IR.EInt _ _)) -> True
  _                         -> False

  


--
-- Check if both symbols have same type.
--
eqTypeOfSym :: Sym.Sym -> Sym.Sym -> Bool
eqTypeOfSym sym0 sym1 | (Sym.getType sym0) == (Sym.getType sym1) = True
                      | otherwise                                = False

eqTypeOfSym3 :: Sym.Sym -> Sym.Sym -> Sym.Sym -> Bool
eqTypeOfSym3 sym0 sym1 sym2
  | ((Sym.getType sym0) == (Sym.getType sym1)) && ((Sym.getType sym1) == (Sym.getType sym2)) = True
  | otherwise = False
    
stringFromIdent :: IR.Ident -> String
stringFromIdent (IR.Ident str) = str

getType :: IR.Typ -> T.Typ 
getType t = case t of
    (IR.TName (IR.Ident str)) -> T.typeFromString str

getQual :: [IR.Qual] -> T.Qual
getQual q = case q of
    []      -> T.NoneQual
    [q]     -> IR.convQualMUDA q
    (q:qs)  -> IR.convQualMUDA q     -- take head's one only.

getQuals :: [IR.Qual] -> [T.Qual]
getQuals q = case q of
    []      -> []
    [q]     -> [IR.convQualMUDA q]
    (q:qs)  -> (IR.convQualMUDA q) : (getQuals qs)

mkSym :: IR.Typ -> [IR.Qual] -> Sym.Kind -> IR.Ident -> Sym.Sym
mkSym ty quals kind id = Sym.Sym { Sym.typ      = getType ty,
                                   Sym.quals    = getQuals quals,
                                   Sym.kind     = kind,
                                   Sym.name     = stringFromIdent id,
                                   Sym.argTypes = [] }

mkFuncSym :: IR.Typ -> [IR.Qual] -> IR.Ident -> [T.Typ] -> Sym.Sym
mkFuncSym ty quals id types = Sym.Sym {  Sym.typ  = getType ty
                                      ,  Sym.quals    = getQuals quals
                                      ,  Sym.kind  = Sym.KindFunction
                                      ,  Sym.name  = stringFromIdent id
                                      ,  Sym.argTypes = types
                                      }

mkStructSym :: [IR.Qual] -> IR.Ident -> Sym.Sym
mkStructSym quals id = Sym.Sym {  Sym.typ      = T.Var (stringFromIdent id)
                               ,  Sym.quals    = getQuals quals
                               ,  Sym.kind     = Sym.KindStruct
                               ,  Sym.name     = stringFromIdent id
                               ,  Sym.argTypes = []
                               }

--
-- Parse swizzle pattern
--

--
-- Swizzle pattern. 
--
-- length(str) must be 1 or 4.
--
-- each letter should have oneof "xyzwrgba"
--
isSwizzle :: String -> Bool
isSwizzle str 
  | ((length str) == 1) /= True && ((length str) /= 4) == True = False 
  | otherwise = if length (filter (\x -> x == False) (map isSwizzleLetter str)) > 0 then False else True
    
  where

    isSwizzleLetter :: Char -> Bool
    isSwizzleLetter c 
      | c == 'x' || c == 'y' || c == 'z' || c == 'w' = True
      | c == 'r' || c == 'g' || c == 'b' || c == 'a' = True
      | otherwise                                    = False
      

swizzleIndexFromString:: String -> SwizzleIndex
swizzleIndexFromString str =

    map toIndex str

    where

      toIndex :: Char -> Int
      toIndex c = case c of
        'x' -> 0
        'y' -> 1
        'z' -> 2
        'w' -> 3
        'r' -> 0
        'g' -> 1
        'b' -> 2
        'a' -> 3
        _   -> 0

--
-- If length str == 1, replicate swizzle letter 4 times.
-- e.g. val.x -> val.xxxx
--
swizzleIndexFromString4:: String -> SwizzleIndex
swizzleIndexFromString4 str 
  | (length str) == 1 = swizzleIndexFromString $ replicate 4 (str !! 0)
  | otherwise =
    map toIndex str

    where

      toIndex :: Char -> Int
      toIndex c = case c of
        'x' -> 0
        'y' -> 1
        'z' -> 2
        'w' -> 3
        'r' -> 0
        'g' -> 1
        'b' -> 2
        'a' -> 3
        _   -> 0

-- vim: set sw=2 ts=2 expandtab:



