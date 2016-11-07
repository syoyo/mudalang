{-# OPTIONS -fno-warn-incomplete-patterns #-}
module PrintMUDA where

-- pretty-printer generated by the BNF converter

import AbsMUDA
import Char

-- the top-level printing method
printTree :: Print a => a -> String
printTree = render . prt 0

type Doc = [ShowS] -> [ShowS]

doc :: ShowS -> Doc
doc = (:)

render :: Doc -> String
render d = rend 0 (map ($ "") $ d []) "" where
  rend i ss = case ss of
    "["      :ts -> showChar '[' . rend i ts
    "("      :ts -> showChar '(' . rend i ts
    "{"      :ts -> showChar '{' . new (i+1) . rend (i+1) ts
    "}" : ";":ts -> new (i-1) . space "}" . showChar ';' . new (i-1) . rend (i-1) ts
    "}"      :ts -> new (i-1) . showChar '}' . new (i-1) . rend (i-1) ts
    ";"      :ts -> showChar ';' . new i . rend i ts
    t  : "," :ts -> showString t . space "," . rend i ts
    t  : ")" :ts -> showString t . showChar ')' . rend i ts
    t  : "]" :ts -> showString t . showChar ']' . rend i ts
    t        :ts -> space t . rend i ts
    _            -> id
  new i   = showChar '\n' . replicateS (2*i) (showChar ' ') . dropWhile isSpace
  space t = showString t . (\s -> if null s then "" else (' ':s))

parenth :: Doc -> Doc
parenth ss = doc (showChar '(') . ss . doc (showChar ')')

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

concatD :: [Doc] -> Doc
concatD = foldr (.) id

replicateS :: Int -> ShowS -> ShowS
replicateS n f = concatS (replicate n f)

-- the printer class does the job
class Print a where
  prt :: Int -> a -> Doc
  prtList :: [a] -> Doc
  prtList = concatD . map (prt 0)

instance Print a => Print [a] where
  prt _ = prtList

instance Print Char where
  prt _ s = doc (showChar '\'' . mkEsc '\'' s . showChar '\'')
  prtList s = doc (showChar '"' . concatS (map (mkEsc '"') s) . showChar '"')

mkEsc :: Char -> Char -> ShowS
mkEsc q s = case s of
  _ | s == q -> showChar '\\' . showChar s
  '\\'-> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  _ -> showChar s

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j = if j<i then parenth else id


instance Print Integer where
  prt _ x = doc (shows x)


instance Print Double where
  prt _ x = doc (shows x)


instance Print Ident where
  prt _ (Ident i) = doc (showString i)


instance Print CFloat where
  prt _ (CFloat i) = doc (showString i)


instance Print CDouble where
  prt _ (CDouble i) = doc (showString i)


instance Print Hexadecimal where
  prt _ (Hexadecimal i) = doc (showString i)



instance Print Prog where
  prt i e = case e of
   Program strucs funcs -> prPrec i 0 (concatD [prt 0 strucs , prt 0 funcs])


instance Print Struc where
  prt i e = case e of
   Struct id mdecs -> prPrec i 0 (concatD [doc (showString "struct") , prt 0 id , doc (showString "{") , prt 0 mdecs , doc (showString "}") , doc (showString ";")])

  prtList es = case es of
   [] -> (concatD [])
   x:xs -> (concatD [prt 0 x , prt 0 xs])

instance Print MDec where
  prt i e = case e of
   MDecl typ id -> prPrec i 0 (concatD [prt 0 typ , prt 0 id , doc (showString ";")])

  prtList es = case es of
   [x] -> (concatD [prt 0 x])
   x:xs -> (concatD [prt 0 x , prt 0 xs])

instance Print Func where
  prt i e = case e of
   Fun funcspecs typ id formaldecs stms -> prPrec i 0 (concatD [prt 0 funcspecs , prt 0 typ , prt 0 id , doc (showString "(") , prt 0 formaldecs , doc (showString ")") , doc (showString "{") , prt 0 stms , doc (showString "}")])

  prtList es = case es of
   [] -> (concatD [])
   x:xs -> (concatD [prt 0 x , prt 0 xs])

instance Print FuncSpec where
  prt i e = case e of
   InlineFuncSpec  -> prPrec i 0 (concatD [doc (showString "inline")])
   ForceInlineFuncSpec  -> prPrec i 0 (concatD [doc (showString "force_inline")])
   AlwaysInlineFuncSpec  -> prPrec i 0 (concatD [doc (showString "always_inline")])
   StaticFuncSpec  -> prPrec i 0 (concatD [doc (showString "static")])

  prtList es = case es of
   [] -> (concatD [])
   x:xs -> (concatD [prt 0 x , prt 0 xs])

instance Print FormalDec where
  prt i e = case e of
   FormalDecl quals typ id -> prPrec i 0 (concatD [prt 0 quals , prt 0 typ , prt 0 id])

  prtList es = case es of
   [] -> (concatD [])
   [x] -> (concatD [prt 0 x])
   x:xs -> (concatD [prt 0 x , doc (showString ",") , prt 0 xs])

instance Print DecInit where
  prt i e = case e of
   DeclInit id decinitexps -> prPrec i 0 (concatD [prt 0 id , prt 0 decinitexps])

  prtList es = case es of
   [x] -> (concatD [prt 0 x])
   x:xs -> (concatD [prt 0 x , doc (showString ",") , prt 0 xs])

instance Print DecInitExp where
  prt i e = case e of
   DExp exp -> prPrec i 0 (concatD [doc (showString "=") , prt 0 exp])

  prtList es = case es of
   [] -> (concatD [])
   [x] -> (concatD [prt 0 x])

instance Print Qual where
  prt i e = case e of
   InputQual  -> prPrec i 0 (concatD [doc (showString "in")])
   OutputQual  -> prPrec i 0 (concatD [doc (showString "out")])
   InOutQual  -> prPrec i 0 (concatD [doc (showString "inout")])
   ArrayQual  -> prPrec i 0 (concatD [doc (showString "array")])

  prtList es = case es of
   [] -> (concatD [])
   x:xs -> (concatD [prt 0 x , prt 0 xs])

instance Print Stm where
  prt i e = case e of
   SDecl typ decinits -> prPrec i 0 (concatD [prt 0 typ , prt 0 decinits , doc (showString ";")])
   SAssign id exp -> prPrec i 0 (concatD [prt 0 id , doc (showString "=") , prt 0 exp , doc (showString ";")])
   SAssignWithField id fields exp -> prPrec i 0 (concatD [prt 0 id , doc (showString ".") , prt 0 fields , doc (showString "=") , prt 0 exp , doc (showString ";")])
   SAssignWithArray id exp0 exp -> prPrec i 0 (concatD [prt 0 id , doc (showString "[") , prt 0 exp0 , doc (showString "]") , doc (showString "=") , prt 0 exp , doc (showString ";")])
   SExp exp -> prPrec i 0 (concatD [prt 0 exp , doc (showString ";")])
   SBlock stms -> prPrec i 0 (concatD [doc (showString "{") , prt 0 stms , doc (showString "}")])
   SWhile exp stm -> prPrec i 0 (concatD [doc (showString "while") , doc (showString "(") , prt 0 exp , doc (showString ")") , prt 0 stm])
   SIf exp stms0 stms -> prPrec i 0 (concatD [doc (showString "if") , doc (showString "(") , prt 0 exp , doc (showString ")") , doc (showString "{") , prt 0 stms0 , doc (showString "}") , doc (showString "else") , doc (showString "{") , prt 0 stms , doc (showString "}")])
   SReturn exp -> prPrec i 0 (concatD [doc (showString "return") , prt 0 exp , doc (showString ";")])
   SReturnVoid  -> prPrec i 0 (concatD [doc (showString "return") , doc (showString ";")])
   SNew id n -> prPrec i 0 (concatD [prt 0 id , doc (showString "=") , doc (showString "new") , prt 0 n , doc (showString ";")])

  prtList es = case es of
   [] -> (concatD [])
   x:xs -> (concatD [prt 0 x , prt 0 xs])

instance Print Exp where
  prt i e = case e of
   EAnd exp0 exp -> prPrec i 0 (concatD [prt 0 exp0 , doc (showString "&") , prt 1 exp])
   EOr exp0 exp -> prPrec i 0 (concatD [prt 0 exp0 , doc (showString "|") , prt 1 exp])
   EXor exp0 exp -> prPrec i 0 (concatD [prt 0 exp0 , doc (showString "^") , prt 1 exp])
   ENot exp0 exp -> prPrec i 0 (concatD [prt 0 exp0 , doc (showString "~") , prt 1 exp])
   EEq exp0 exp -> prPrec i 1 (concatD [prt 1 exp0 , doc (showString "==") , prt 2 exp])
   ENeq exp0 exp -> prPrec i 1 (concatD [prt 1 exp0 , doc (showString "!=") , prt 2 exp])
   EGt exp0 exp -> prPrec i 2 (concatD [prt 2 exp0 , doc (showString ">") , prt 3 exp])
   EGte exp0 exp -> prPrec i 2 (concatD [prt 2 exp0 , doc (showString ">=") , prt 3 exp])
   ELt exp0 exp -> prPrec i 2 (concatD [prt 2 exp0 , doc (showString "<") , prt 3 exp])
   ELte exp0 exp -> prPrec i 2 (concatD [prt 2 exp0 , doc (showString "<=") , prt 3 exp])
   ESlElemWise exp0 exp -> prPrec i 3 (concatD [prt 3 exp0 , doc (showString "<<") , prt 4 exp])
   ESrElemWise exp0 exp -> prPrec i 3 (concatD [prt 3 exp0 , doc (showString ">>") , prt 4 exp])
   ESlaElemWise exp0 exp -> prPrec i 3 (concatD [prt 3 exp0 , doc (showString "<<<") , prt 4 exp])
   ESraElemWise exp0 exp -> prPrec i 3 (concatD [prt 3 exp0 , doc (showString ">>>") , prt 4 exp])
   ESlQWord exp0 exp -> prPrec i 3 (concatD [prt 3 exp0 , doc (showString "<<|") , prt 4 exp])
   ESrQWord exp0 exp -> prPrec i 3 (concatD [prt 3 exp0 , doc (showString ">>|") , prt 4 exp])
   ESlaQWord exp0 exp -> prPrec i 3 (concatD [prt 3 exp0 , doc (showString "<<<|") , prt 4 exp])
   ESraQWord exp0 exp -> prPrec i 3 (concatD [prt 3 exp0 , doc (showString ">>>|") , prt 4 exp])
   EAdd exp0 exp -> prPrec i 4 (concatD [prt 4 exp0 , doc (showString "+") , prt 5 exp])
   ESub exp0 exp -> prPrec i 4 (concatD [prt 4 exp0 , doc (showString "-") , prt 5 exp])
   EMul exp0 exp -> prPrec i 5 (concatD [prt 5 exp0 , doc (showString "*") , prt 6 exp])
   EDiv exp0 exp -> prPrec i 5 (concatD [prt 5 exp0 , doc (showString "/") , prt 6 exp])
   EDivApprox exp0 exp -> prPrec i 5 (concatD [prt 5 exp0 , doc (showString "/.") , prt 6 exp])
   ENeg exp -> prPrec i 6 (concatD [doc (showString "-") , prt 7 exp])
   EFieldSelect exp fields -> prPrec i 7 (concatD [prt 6 exp , doc (showString ".") , prt 0 fields])
   EArray exp0 exp -> prPrec i 8 (concatD [prt 8 exp0 , doc (showString "[") , prt 0 exp , doc (showString "]")])
   EFunc id funcargss -> prPrec i 8 (concatD [prt 0 id , doc (showString "(") , prt 0 funcargss , doc (showString ")")])
   EIdent id -> prPrec i 9 (concatD [prt 0 id])
   EInt n -> prPrec i 9 (concatD [prt 0 n])
   EDouble d -> prPrec i 9 (concatD [prt 0 d])
   ECFloat cfloat -> prPrec i 9 (concatD [prt 0 cfloat])
   EHexadec hexadecimal -> prPrec i 9 (concatD [prt 0 hexadecimal])

  prtList es = case es of
   [] -> (concatD [])
   x:xs -> (concatD [prt 0 x , prt 0 xs])

instance Print FuncArgs where
  prt i e = case e of
   EArg exp -> prPrec i 0 (concatD [prt 1 exp])

  prtList es = case es of
   [] -> (concatD [])
   [x] -> (concatD [prt 0 x])
   x:xs -> (concatD [prt 0 x , doc (showString ",") , prt 0 xs])

instance Print Field where
  prt i e = case e of
   EField id -> prPrec i 0 (concatD [prt 0 id])

  prtList es = case es of
   [x] -> (concatD [prt 0 x])
   x:xs -> (concatD [prt 0 x , doc (showString ".") , prt 0 xs])

instance Print Typ where
  prt i e = case e of
   TName id -> prPrec i 0 (concatD [prt 0 id])



