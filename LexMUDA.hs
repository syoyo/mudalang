{-# OPTIONS -cpp #-}
{-# LINE 3 "LexMUDA.x" #-}
{-# OPTIONS -fno-warn-incomplete-patterns #-}
module LexMUDA where



#if __GLASGOW_HASKELL__ >= 603
#include "ghcconfig.h"
#else
#include "config.h"
#endif
#if __GLASGOW_HASKELL__ >= 503
import Data.Array
import Data.Char (ord)
import Data.Array.Base (unsafeAt)
#else
import Array
import Char (ord)
#endif
alex_base :: Array Int Int
alex_base = listArray (0,48) [1,19,57,58,22,28,29,0,30,31,34,37,71,0,24,25,38,133,132,-36,-35,56,66,39,0,0,148,158,182,216,239,249,272,304,329,358,282,383,398,314,408,418,442,452,0,473,496,551,759]

alex_table :: Array Int Int
alex_table = listArray (0,1014) [0,-1,-1,-1,-1,-1,-1,-1,-1,-1,12,12,12,12,12,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,12,23,-1,-1,-1,-1,13,-1,13,13,13,21,13,21,22,5,33,34,34,34,34,34,34,34,34,34,-1,13,16,14,15,-1,-1,4,-1,-1,2,10,9,9,8,13,2,9,6,7,9,12,12,12,12,12,13,13,18,13,13,0,0,13,-1,13,13,-1,-1,17,13,13,0,36,12,35,35,35,35,35,35,35,35,35,35,30,30,30,30,30,30,30,30,30,30,13,13,13,13,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,19,20,0,28,28,28,28,28,28,28,28,28,28,29,29,29,29,29,29,29,29,29,29,-1,37,25,0,0,0,0,0,0,0,0,37,25,0,28,28,28,28,28,28,28,28,28,28,0,0,0,0,0,0,0,0,-1,37,25,37,25,0,0,0,13,13,0,37,25,0,0,0,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,37,25,37,25,30,30,30,30,30,30,30,30,30,30,31,31,31,31,31,31,31,31,31,31,0,37,25,0,0,0,0,0,0,0,38,25,25,32,32,32,32,32,32,32,32,32,32,30,30,30,30,30,30,30,30,30,30,37,25,25,0,0,0,0,0,0,0,27,25,34,34,34,34,34,34,34,34,34,34,31,31,31,31,31,31,31,31,31,31,0,42,25,27,0,34,34,34,34,34,34,34,34,34,34,0,0,0,0,0,46,0,0,0,0,0,42,0,0,0,0,0,26,42,35,35,35,35,35,35,35,35,35,35,0,0,0,0,0,0,0,0,46,0,39,0,39,0,42,31,31,31,31,31,31,31,31,31,31,39,0,40,0,0,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,41,41,41,41,41,41,41,41,41,41,0,0,0,0,0,0,0,0,0,43,44,43,24,0,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,41,0,0,0,0,0,0,0,0,44,0,24,45,45,45,45,45,45,45,45,45,45,0,0,0,0,0,0,0,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,0,0,0,0,0,0,0,45,45,45,45,45,45,0,0,0,45,45,45,45,45,45,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,0,45,45,45,45,45,45,48,48,48,48,48,48,48,48,48,48,0,0,0,0,0,0,0,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,0,0,0,0,48,0,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,0,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,0,0,0,0,0,0,0,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,0,0,0,0,48,0,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,0,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,0,48,48,48,48,48,48,48,48]

alex_check :: Array Int Int
alex_check = listArray (0,1014) [-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,47,10,10,47,42,42,42,42,46,47,42,47,47,42,9,10,11,12,13,61,61,62,124,124,-1,-1,91,92,93,94,95,96,60,61,61,-1,46,32,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,60,62,-1,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,215,69,70,-1,-1,-1,-1,-1,-1,-1,-1,69,70,-1,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,-1,-1,-1,247,101,102,69,70,-1,-1,-1,124,124,-1,101,102,-1,-1,-1,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,-1,-1,-1,-1,101,102,69,70,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,-1,69,70,-1,-1,-1,-1,-1,-1,-1,101,102,70,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,101,102,70,-1,-1,-1,-1,-1,-1,-1,46,102,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,-1,69,102,46,-1,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,88,-1,-1,-1,-1,-1,69,-1,-1,-1,-1,-1,46,101,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,-1,-1,-1,120,-1,43,-1,45,-1,101,48,49,50,51,52,53,54,55,56,57,43,-1,45,-1,-1,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,-1,-1,-1,-1,43,68,45,70,-1,48,49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,-1,-1,-1,100,-1,102,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,-1,-1,65,66,67,68,69,70,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,-1,-1,65,66,67,68,69,70,-1,-1,-1,97,98,99,100,101,102,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,39,-1,-1,97,98,99,100,101,102,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,-1,-1,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,-1,-1,-1,-1,95,-1,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,-1,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,39,248,249,250,251,252,253,254,255,48,49,50,51,52,53,54,55,56,57,-1,-1,-1,-1,-1,-1,-1,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,-1,-1,-1,-1,95,-1,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,-1,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,-1,248,249,250,251,252,253,254,255]

alex_deflt :: Array Int Int
alex_deflt = listArray (0,48) [47,-1,3,3,-1,-1,11,-1,11,11,11,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]

alex_accept = listArray (0::Int,48) [[],[],[(AlexAccSkip)],[(AlexAccSkip)],[],[(AlexAcc (alex_action_3))],[(AlexAccSkip)],[(AlexAccSkip)],[],[],[],[],[(AlexAccSkip)],[(AlexAcc (alex_action_3))],[(AlexAcc (alex_action_3))],[(AlexAcc (alex_action_3))],[(AlexAcc (alex_action_3))],[(AlexAcc (alex_action_3))],[(AlexAcc (alex_action_3))],[(AlexAcc (alex_action_3))],[(AlexAcc (alex_action_3))],[(AlexAcc (alex_action_3))],[(AlexAcc (alex_action_3))],[],[(AlexAcc (alex_action_4))],[(AlexAcc (alex_action_4))],[],[],[],[(AlexAcc (alex_action_9))],[],[],[(AlexAcc (alex_action_9))],[(AlexAcc (alex_action_8))],[(AlexAcc (alex_action_8))],[],[],[],[],[],[],[],[],[],[(AlexAcc (alex_action_5))],[(AlexAcc (alex_action_6))],[],[(AlexAcc (alex_action_7))],[(AlexAcc (alex_action_7))]]
{-# LINE 37 "LexMUDA.x" #-}

tok f p s = f p s

share :: String -> String
share = id

data Tok =
   TS !String     -- reserved words and symbols
 | TL !String     -- string literals
 | TI !String     -- integer literals
 | TV !String     -- identifiers
 | TD !String     -- double precision float literals
 | TC !String     -- character literals
 | T_CFloat !String
 | T_CDouble !String
 | T_Hexadecimal !String

 deriving (Eq,Show,Ord)

data Token = 
   PT  Posn Tok
 | Err Posn
  deriving (Eq,Show,Ord)

tokenPos (PT (Pn _ l _) _ :_) = "line " ++ show l
tokenPos (Err (Pn _ l _) :_) = "line " ++ show l
tokenPos _ = "end of file"

posLineCol (Pn _ l c) = (l,c)
mkPosToken t@(PT p _) = (posLineCol p, prToken t)

prToken t = case t of
  PT _ (TS s) -> s
  PT _ (TI s) -> s
  PT _ (TV s) -> s
  PT _ (TD s) -> s
  PT _ (TC s) -> s
  PT _ (T_CFloat s) -> s
  PT _ (T_CDouble s) -> s
  PT _ (T_Hexadecimal s) -> s

  _ -> show t

data BTree = N | B String Tok BTree BTree deriving (Show)

eitherResIdent :: (String -> Tok) -> String -> Tok
eitherResIdent tv s = treeFind resWords
  where
  treeFind N = tv s
  treeFind (B a t left right) | s < a  = treeFind left
                              | s > a  = treeFind right
                              | s == a = t

resWords = b "inout" (b "force_inline" (b "array" (b "always_inline" N N) (b "else" N N)) (b "in" (b "if" N N) (b "inline" N N))) (b "static" (b "out" (b "new" N N) (b "return" N N)) (b "while" (b "struct" N N) N))
   where b s = B s (TS s)

unescapeInitTail :: String -> String
unescapeInitTail = unesc . tail where
  unesc s = case s of
    '\\':c:cs | elem c ['\"', '\\', '\''] -> c : unesc cs
    '\\':'n':cs  -> '\n' : unesc cs
    '\\':'t':cs  -> '\t' : unesc cs
    '"':[]    -> []
    c:cs      -> c : unesc cs
    _         -> []

-------------------------------------------------------------------
-- Alex wrapper code.
-- A modified "posn" wrapper.
-------------------------------------------------------------------

data Posn = Pn !Int !Int !Int
      deriving (Eq, Show,Ord)

alexStartPos :: Posn
alexStartPos = Pn 0 1 1

alexMove :: Posn -> Char -> Posn
alexMove (Pn a l c) '\t' = Pn (a+1)  l     (((c+7) `div` 8)*8+1)
alexMove (Pn a l c) '\n' = Pn (a+1) (l+1)   1
alexMove (Pn a l c) _    = Pn (a+1)  l     (c+1)

type AlexInput = (Posn, -- current position,
		  Char,	-- previous char
		  String)	-- current input string

tokens :: String -> [Token]
tokens str = go (alexStartPos, '\n', str)
    where
      go :: (Posn, Char, String) -> [Token]
      go inp@(pos, _, str) =
    	  case alexScan inp 0 of
    	    AlexEOF                -> []
    	    AlexError (pos, _, _)  -> [Err pos]
    	    AlexSkip  inp' len     -> go inp'
    	    AlexToken inp' len act -> act pos (take len str) : (go inp')

alexGetChar :: AlexInput -> Maybe (Char,AlexInput)
alexGetChar (p, c, [])    = Nothing
alexGetChar (p, _, (c:s)) =
    let p' = alexMove p c
     in p' `seq` Just (c, (p', c, s))

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar (p, c, s) = c

alex_action_3 = tok (\p s -> PT p (TS $ share s)) 
alex_action_4 = tok (\p s -> PT p (eitherResIdent (T_CFloat . share) s)) 
alex_action_5 = tok (\p s -> PT p (eitherResIdent (T_CDouble . share) s)) 
alex_action_6 = tok (\p s -> PT p (eitherResIdent (T_Hexadecimal . share) s)) 
alex_action_7 = tok (\p s -> PT p (eitherResIdent (TV . share) s)) 
alex_action_8 = tok (\p s -> PT p (TI $ share s))    
alex_action_9 = tok (\p s -> PT p (TD $ share s)) 
{-# LINE 1 "GenericTemplate.hs" #-}
{-# LINE 1 "GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command line>" #-}
{-# LINE 1 "GenericTemplate.hs" #-}
-- -----------------------------------------------------------------------------
-- ALEX TEMPLATE
--
-- This code is in the PUBLIC DOMAIN; you may copy it freely and use
-- it for any purpose whatsoever.

-- -----------------------------------------------------------------------------
-- INTERNALS and main scanner engine

{-# LINE 35 "GenericTemplate.hs" #-}

{-# LINE 45 "GenericTemplate.hs" #-}

{-# LINE 66 "GenericTemplate.hs" #-}
alexIndexInt16OffAddr arr off = arr ! off


{-# LINE 87 "GenericTemplate.hs" #-}
alexIndexInt32OffAddr arr off = arr ! off


{-# LINE 98 "GenericTemplate.hs" #-}
quickIndex arr i = arr ! i


-- -----------------------------------------------------------------------------
-- Main lexing routines

data AlexReturn a
  = AlexEOF
  | AlexError  !AlexInput
  | AlexSkip   !AlexInput !Int
  | AlexToken  !AlexInput !Int a

-- alexScan :: AlexInput -> StartCode -> AlexReturn a
alexScan input (sc)
  = alexScanUser undefined input (sc)

alexScanUser user input (sc)
  = case alex_scan_tkn user input (0) input sc AlexNone of
	(AlexNone, input') ->
		case alexGetChar input of
			Nothing -> 



				   AlexEOF
			Just _ ->



				   AlexError input'

	(AlexLastSkip input len, _) ->



		AlexSkip input len

	(AlexLastAcc k input len, _) ->



		AlexToken input len k


-- Push the input through the DFA, remembering the most recent accepting
-- state it encountered.

alex_scan_tkn user orig_input len input s last_acc =
  input `seq` -- strict in the input
  let 
	new_acc = check_accs (alex_accept `quickIndex` (s))
  in
  new_acc `seq`
  case alexGetChar input of
     Nothing -> (new_acc, input)
     Just (c, new_input) -> 



	let
		base   = alexIndexInt32OffAddr alex_base s
		(ord_c) = ord c
		offset = (base + ord_c)
		check  = alexIndexInt16OffAddr alex_check offset
		
		new_s = if (offset >= (0)) && (check == ord_c)
			  then alexIndexInt16OffAddr alex_table offset
			  else alexIndexInt16OffAddr alex_deflt s
	in
	case new_s of 
	    (-1) -> (new_acc, input)
		-- on an error, we want to keep the input *before* the
		-- character that failed, not after.
    	    _ -> alex_scan_tkn user orig_input (len + (1)) 
			new_input new_s new_acc

  where
	check_accs [] = last_acc
	check_accs (AlexAcc a : _) = AlexLastAcc a input (len)
	check_accs (AlexAccSkip : _)  = AlexLastSkip  input (len)
	check_accs (AlexAccPred a pred : rest)
	   | pred user orig_input (len) input
	   = AlexLastAcc a input (len)
	check_accs (AlexAccSkipPred pred : rest)
	   | pred user orig_input (len) input
	   = AlexLastSkip input (len)
	check_accs (_ : rest) = check_accs rest

data AlexLastAcc a
  = AlexNone
  | AlexLastAcc a !AlexInput !Int
  | AlexLastSkip  !AlexInput !Int

data AlexAcc a user
  = AlexAcc a
  | AlexAccSkip
  | AlexAccPred a (AlexAccPred user)
  | AlexAccSkipPred (AlexAccPred user)

type AlexAccPred user = user -> AlexInput -> Int -> AlexInput -> Bool

-- -----------------------------------------------------------------------------
-- Predicates on a rule

alexAndPred p1 p2 user in1 len in2
  = p1 user in1 len in2 && p2 user in1 len in2

--alexPrevCharIsPred :: Char -> AlexAccPred _ 
alexPrevCharIs c _ input _ _ = c == alexInputPrevChar input

--alexPrevCharIsOneOfPred :: Array Char Bool -> AlexAccPred _ 
alexPrevCharIsOneOf arr _ input _ _ = arr ! alexInputPrevChar input

--alexRightContext :: Int -> AlexAccPred _
alexRightContext (sc) user _ _ input = 
     case alex_scan_tkn user input (0) input sc AlexNone of
	  (AlexNone, _) -> False
	  _ -> True
	-- TODO: there's no need to find the longest
	-- match when checking the right context, just
	-- the first match will do.

-- used by wrappers
iUnbox (i) = i
