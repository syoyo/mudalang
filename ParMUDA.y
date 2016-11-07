-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParMUDA where
import AbsMUDA
import LexMUDA
import ErrM
}

%name pProg Prog

-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype { Token }

%token 
 '{' { PT _ (TS "{") }
 '}' { PT _ (TS "}") }
 ';' { PT _ (TS ";") }
 '(' { PT _ (TS "(") }
 ')' { PT _ (TS ")") }
 ',' { PT _ (TS ",") }
 '=' { PT _ (TS "=") }
 '.' { PT _ (TS ".") }
 '[' { PT _ (TS "[") }
 ']' { PT _ (TS "]") }
 '&' { PT _ (TS "&") }
 '|' { PT _ (TS "|") }
 '^' { PT _ (TS "^") }
 '~' { PT _ (TS "~") }
 '==' { PT _ (TS "==") }
 '!=' { PT _ (TS "!=") }
 '>' { PT _ (TS ">") }
 '>=' { PT _ (TS ">=") }
 '<' { PT _ (TS "<") }
 '<=' { PT _ (TS "<=") }
 '<<' { PT _ (TS "<<") }
 '>>' { PT _ (TS ">>") }
 '<<<' { PT _ (TS "<<<") }
 '>>>' { PT _ (TS ">>>") }
 '<<|' { PT _ (TS "<<|") }
 '>>|' { PT _ (TS ">>|") }
 '<<<|' { PT _ (TS "<<<|") }
 '>>>|' { PT _ (TS ">>>|") }
 '+' { PT _ (TS "+") }
 '-' { PT _ (TS "-") }
 '*' { PT _ (TS "*") }
 '/' { PT _ (TS "/") }
 '/.' { PT _ (TS "/.") }
 'always_inline' { PT _ (TS "always_inline") }
 'array' { PT _ (TS "array") }
 'else' { PT _ (TS "else") }
 'force_inline' { PT _ (TS "force_inline") }
 'if' { PT _ (TS "if") }
 'in' { PT _ (TS "in") }
 'inline' { PT _ (TS "inline") }
 'inout' { PT _ (TS "inout") }
 'new' { PT _ (TS "new") }
 'out' { PT _ (TS "out") }
 'return' { PT _ (TS "return") }
 'static' { PT _ (TS "static") }
 'struct' { PT _ (TS "struct") }
 'while' { PT _ (TS "while") }

L_ident  { PT _ (TV $$) }
L_integ  { PT _ (TI $$) }
L_doubl  { PT _ (TD $$) }
L_CFloat { PT _ (T_CFloat $$) }
L_CDouble { PT _ (T_CDouble $$) }
L_Hexadecimal { PT _ (T_Hexadecimal $$) }
L_err    { _ }


%%

Ident   :: { Ident }   : L_ident  { Ident $1 }
Integer :: { Integer } : L_integ  { (read $1) :: Integer }
Double  :: { Double }  : L_doubl  { (read $1) :: Double }
CFloat    :: { CFloat} : L_CFloat { CFloat ($1)}
CDouble    :: { CDouble} : L_CDouble { CDouble ($1)}
Hexadecimal    :: { Hexadecimal} : L_Hexadecimal { Hexadecimal ($1)}

Prog :: { Prog }
Prog : ListStruc ListFunc { Program (reverse $1) (reverse $2) } 


ListStruc :: { [Struc] }
ListStruc : {- empty -} { [] } 
  | ListStruc Struc { flip (:) $1 $2 }


Struc :: { Struc }
Struc : 'struct' Ident '{' ListMDec '}' ';' { Struct $2 $4 } 


ListMDec :: { [MDec] }
ListMDec : MDec { (:[]) $1 } 
  | MDec ListMDec { (:) $1 $2 }


MDec :: { MDec }
MDec : Typ Ident ';' { MDecl $1 $2 } 


ListFunc :: { [Func] }
ListFunc : {- empty -} { [] } 
  | ListFunc Func { flip (:) $1 $2 }


Func :: { Func }
Func : ListFuncSpec Typ Ident '(' ListFormalDec ')' '{' ListStm '}' { Fun (reverse $1) $2 $3 $5 (reverse $8) } 


ListFuncSpec :: { [FuncSpec] }
ListFuncSpec : {- empty -} { [] } 
  | ListFuncSpec FuncSpec { flip (:) $1 $2 }


FuncSpec :: { FuncSpec }
FuncSpec : 'inline' { InlineFuncSpec } 
  | 'force_inline' { ForceInlineFuncSpec }
  | 'always_inline' { AlwaysInlineFuncSpec }
  | 'static' { StaticFuncSpec }


FormalDec :: { FormalDec }
FormalDec : ListQual Typ Ident { FormalDecl (reverse $1) $2 $3 } 


ListFormalDec :: { [FormalDec] }
ListFormalDec : {- empty -} { [] } 
  | FormalDec { (:[]) $1 }
  | FormalDec ',' ListFormalDec { (:) $1 $3 }


ListDecInit :: { [DecInit] }
ListDecInit : DecInit { (:[]) $1 } 
  | DecInit ',' ListDecInit { (:) $1 $3 }


DecInit :: { DecInit }
DecInit : Ident ListDecInitExp { DeclInit $1 $2 } 


ListDecInitExp :: { [DecInitExp] }
ListDecInitExp : {- empty -} { [] } 
  | DecInitExp { (:[]) $1 }


DecInitExp :: { DecInitExp }
DecInitExp : '=' Exp { DExp $2 } 


Qual :: { Qual }
Qual : 'in' { InputQual } 
  | 'out' { OutputQual }
  | 'inout' { InOutQual }
  | 'array' { ArrayQual }


ListQual :: { [Qual] }
ListQual : {- empty -} { [] } 
  | ListQual Qual { flip (:) $1 $2 }


Stm :: { Stm }
Stm : Typ ListDecInit ';' { SDecl $1 $2 } 
  | Ident '=' Exp ';' { SAssign $1 $3 }
  | Ident '.' ListField '=' Exp ';' { SAssignWithField $1 $3 $5 }
  | Ident '[' Exp ']' '=' Exp ';' { SAssignWithArray $1 $3 $6 }
  | Exp ';' { SExp $1 }
  | '{' ListStm '}' { SBlock (reverse $2) }
  | 'while' '(' Exp ')' Stm { SWhile $3 $5 }
  | 'if' '(' Exp ')' '{' ListStm '}' 'else' '{' ListStm '}' { SIf $3 (reverse $6) (reverse $10) }
  | 'return' Exp ';' { SReturn $2 }
  | 'return' ';' { SReturnVoid }
  | Ident '=' 'new' Integer ';' { SNew $1 $4 }
  | Stm ';' { $1 }


ListStm :: { [Stm] }
ListStm : {- empty -} { [] } 
  | ListStm Stm { flip (:) $1 $2 }


ListExp :: { [Exp] }
ListExp : {- empty -} { [] } 
  | ListExp Exp { flip (:) $1 $2 }


Exp :: { Exp }
Exp : Exp '&' Exp1 { EAnd $1 $3 } 
  | Exp '|' Exp1 { EOr $1 $3 }
  | Exp '^' Exp1 { EXor $1 $3 }
  | Exp '~' Exp1 { ENot $1 $3 }
  | Exp1 { $1 }


Exp1 :: { Exp }
Exp1 : Exp1 '==' Exp2 { EEq $1 $3 } 
  | Exp1 '!=' Exp2 { ENeq $1 $3 }
  | Exp2 { $1 }


Exp2 :: { Exp }
Exp2 : Exp2 '>' Exp3 { EGt $1 $3 } 
  | Exp2 '>=' Exp3 { EGte $1 $3 }
  | Exp2 '<' Exp3 { ELt $1 $3 }
  | Exp2 '<=' Exp3 { ELte $1 $3 }
  | Exp3 { $1 }


Exp3 :: { Exp }
Exp3 : Exp3 '<<' Exp4 { ESlElemWise $1 $3 } 
  | Exp3 '>>' Exp4 { ESrElemWise $1 $3 }
  | Exp3 '<<<' Exp4 { ESlaElemWise $1 $3 }
  | Exp3 '>>>' Exp4 { ESraElemWise $1 $3 }
  | Exp3 '<<|' Exp4 { ESlQWord $1 $3 }
  | Exp3 '>>|' Exp4 { ESrQWord $1 $3 }
  | Exp3 '<<<|' Exp4 { ESlaQWord $1 $3 }
  | Exp3 '>>>|' Exp4 { ESraQWord $1 $3 }
  | Exp4 { $1 }


Exp4 :: { Exp }
Exp4 : Exp4 '+' Exp5 { EAdd $1 $3 } 
  | Exp4 '-' Exp5 { ESub $1 $3 }
  | Exp5 { $1 }


Exp5 :: { Exp }
Exp5 : Exp5 '*' Exp6 { EMul $1 $3 } 
  | Exp5 '/' Exp6 { EDiv $1 $3 }
  | Exp5 '/.' Exp6 { EDivApprox $1 $3 }
  | Exp6 { $1 }


Exp6 :: { Exp }
Exp6 : '-' Exp7 { ENeg $2 } 
  | Exp7 { $1 }


Exp7 :: { Exp }
Exp7 : Exp6 '.' ListField { EFieldSelect $1 $3 } 
  | Exp8 { $1 }


Exp8 :: { Exp }
Exp8 : Exp8 '[' Exp ']' { EArray $1 $3 } 
  | Ident '(' ListFuncArgs ')' { EFunc $1 $3 }
  | Exp9 { $1 }


Exp9 :: { Exp }
Exp9 : Ident { EIdent $1 } 
  | Integer { EInt $1 }
  | Double { EDouble $1 }
  | CFloat { ECFloat $1 }
  | Hexadecimal { EHexadec $1 }
  | '(' Exp ')' { $2 }


ListFuncArgs :: { [FuncArgs] }
ListFuncArgs : {- empty -} { [] } 
  | FuncArgs { (:[]) $1 }
  | FuncArgs ',' ListFuncArgs { (:) $1 $3 }


FuncArgs :: { FuncArgs }
FuncArgs : Exp1 { EArg $1 } 


ListField :: { [Field] }
ListField : Field { (:[]) $1 } 
  | Field '.' ListField { (:) $1 $3 }


Field :: { Field }
Field : Ident { EField $1 } 


Typ :: { Typ }
Typ : Ident { TName $1 } 



{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map prToken (take 4 ts))

myLexer = tokens
}

