module SkelMUDA where

-- Haskell module generated by the BNF converter

import AbsMUDA
import ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transIdent :: Ident -> Result
transIdent x = case x of
  Ident string -> failure x
transCFloat :: CFloat -> Result
transCFloat x = case x of
  CFloat string -> failure x
transCDouble :: CDouble -> Result
transCDouble x = case x of
  CDouble string -> failure x
transHexadecimal :: Hexadecimal -> Result
transHexadecimal x = case x of
  Hexadecimal string -> failure x
transProg :: Prog -> Result
transProg x = case x of
  Program strucs funcs -> failure x
transStruc :: Struc -> Result
transStruc x = case x of
  Struct ident mdecs -> failure x
transMDec :: MDec -> Result
transMDec x = case x of
  MDecl typ ident -> failure x
transFunc :: Func -> Result
transFunc x = case x of
  Fun funcspecs typ ident formaldecs stms -> failure x
transFuncSpec :: FuncSpec -> Result
transFuncSpec x = case x of
  InlineFuncSpec -> failure x
  ForceInlineFuncSpec -> failure x
  AlwaysInlineFuncSpec -> failure x
  StaticFuncSpec -> failure x
transFormalDec :: FormalDec -> Result
transFormalDec x = case x of
  FormalDecl quals typ ident -> failure x
transDecInit :: DecInit -> Result
transDecInit x = case x of
  DeclInit ident decinitexps -> failure x
transDecInitExp :: DecInitExp -> Result
transDecInitExp x = case x of
  DExp exp -> failure x
transQual :: Qual -> Result
transQual x = case x of
  InputQual -> failure x
  OutputQual -> failure x
  InOutQual -> failure x
  ArrayQual -> failure x
transStm :: Stm -> Result
transStm x = case x of
  SDecl typ decinits -> failure x
  SAssign ident exp -> failure x
  SAssignWithField ident fields exp -> failure x
  SAssignWithArray ident exp1 exp2 -> failure x
  SExp exp -> failure x
  SBlock stms -> failure x
  SWhile exp stm -> failure x
  SIf exp stms1 stms2 -> failure x
  SReturn exp -> failure x
  SReturnVoid -> failure x
  SNew ident integer -> failure x
transExp :: Exp -> Result
transExp x = case x of
  EAnd exp1 exp2 -> failure x
  EOr exp1 exp2 -> failure x
  EXor exp1 exp2 -> failure x
  ENot exp1 exp2 -> failure x
  EEq exp1 exp2 -> failure x
  ENeq exp1 exp2 -> failure x
  EGt exp1 exp2 -> failure x
  EGte exp1 exp2 -> failure x
  ELt exp1 exp2 -> failure x
  ELte exp1 exp2 -> failure x
  ESlElemWise exp1 exp2 -> failure x
  ESrElemWise exp1 exp2 -> failure x
  ESlaElemWise exp1 exp2 -> failure x
  ESraElemWise exp1 exp2 -> failure x
  ESlQWord exp1 exp2 -> failure x
  ESrQWord exp1 exp2 -> failure x
  ESlaQWord exp1 exp2 -> failure x
  ESraQWord exp1 exp2 -> failure x
  EAdd exp1 exp2 -> failure x
  ESub exp1 exp2 -> failure x
  EMul exp1 exp2 -> failure x
  EDiv exp1 exp2 -> failure x
  EDivApprox exp1 exp2 -> failure x
  ENeg exp -> failure x
  EFieldSelect exp fields -> failure x
  EArray exp1 exp2 -> failure x
  EFunc ident funcargss -> failure x
  EIdent ident -> failure x
  EInt integer -> failure x
  EDouble double -> failure x
  ECFloat cfloat -> failure x
  EHexadec hexadecimal -> failure x
transFuncArgs :: FuncArgs -> Result
transFuncArgs x = case x of
  EArg exp -> failure x
transField :: Field -> Result
transField x = case x of
  EField ident -> failure x
transTyp :: Typ -> Result
transTyp x = case x of
  TName ident -> failure x

