module TypeMUDA where

------------------------------------------------------------------------------
--
-- Types for MUDA.
--
------------------------------------------------------------------------------

data Typ =
    I                 -- Integer
  | L                 -- Long(64bit)
  | F                 -- Float
  | D                 -- Double
  | Vec               -- Float Vec
  | DVec              -- Double Vec
  | IVec              -- Integer Vec
  | LVec              -- Long(64bit) Vec
  | Void              -- Void type(for function)
  | Var String        -- User def type(e.g. structure)
  deriving (Eq, Ord, Show)


data Qual =
    NoneQual
  | InputQual
  | OutputQual
  | InOutQual
  | ArrayQual
  deriving (Eq, Ord, Show)

data VecFieldElem =
    E                 -- Empty
  | X
  | Y
  | Z
  | W
  | R
  | G
  | B
  | A
  | O                 -- Other
  deriving(Eq, Ord, Show)

data VecField = VecField VecFieldElem VecFieldElem VecFieldElem VecFieldElem
  deriving(Eq, Ord, Show)
    

strOfType :: Typ -> String
strOfType t = case t of
  I     -> "int"
  L     -> "long"
  F     -> "float"
  D     -> "double"
  Vec   -> "vec"
  DVec  -> "dvec"
  IVec  -> "ivec"
  LVec  -> "lvec"
  Void  -> "void"
  Var s -> s

typeFromString :: String -> Typ
typeFromString str = case str of
  "int"    -> I
  "long"   -> L
  "float"  -> F
  "double" -> D
  "vec"    -> Vec
  "dvec"   -> DVec
  "ivec"   -> IVec
  "lvec"   -> LVec
  "void"   -> Void
  _        -> Var str


--
-- size of type in bytes.
-- TODO: Support single and double precision for float type.
--
getSize :: Typ -> Int
getSize t = case t of
  I       -> 4
  L       -> 8
  F       -> 4
  D       -> 8
  Vec     -> 16
  DVec    -> 32
  IVec    -> 16
  LVec    -> 32
  Void    -> error "???"
  Var s   -> error "TODO"

isPrimitive :: Typ -> Bool
isPrimitive t = case t of
  I       -> True
  L       -> True
  F       -> True
  D       -> True
  Void    -> True
  _       -> False


-- vim: set sw=2 ts=2 expandtab:

