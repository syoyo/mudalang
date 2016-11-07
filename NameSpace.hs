module NameSpace where

import Data.Map as Map
import Debug.Trace
  

--
-- | NameSpace manages symbol table.
--
--
data NameSpace a = NameSpace (Map String a)    -- global scope
                             [[(String, a)]]   -- stack of local scopes
                   
                    
--
-- | Create a name space
--
emptyNameSpace :: NameSpace a
emptyNameSpace  = NameSpace Map.empty []


pushScope :: NameSpace a -> NameSpace a
pushScope (NameSpace gs lss)  = NameSpace gs ([]:lss)


--
-- | NameSpace is used only for IR -> Syntax checking phase.
-- thus, no need to hold entire information of NameSpace until
-- IR tree is parsed.
-- popScope discards(returns) current information of symbols 
-- stacked onto the topmost stack.
--
popScope :: NameSpace a -> (NameSpace a, [(String, a)])
popScope (NameSpace gs []      )  = error "pop err"
popScope (NameSpace gs (ls:lss))  = (NameSpace gs lss, ls)


defGlobal :: NameSpace a -> String -> a -> (NameSpace a, Maybe a)
defGlobal (NameSpace gs lss) id def = (NameSpace (Map.insert id def gs) lss,
                                       Map.lookup id gs)

--
-- | Get current element in local scope. `Current' is defined as last element
--   of the list lss.
--
getCurrentLocal :: NameSpace a -> [(String, a)]
getCurrentLocal (NameSpace _ lss) = last lss


--
-- | If there is a registered symbol having same name already,
-- returns Just, else Nothing.
--
defLocal :: NameSpace a -> String -> a -> (NameSpace a, Maybe a)
defLocal ns@(NameSpace gs []      ) id def = defGlobal ns id def
defLocal    (NameSpace gs (ls:lss)) id def = 
  (NameSpace gs (((id, def):ls):lss), lookup ls)
  where
    lookup []                              = Nothing
    lookup ((id', def):ls) | id == id'     = Just def
                           | otherwise     = lookup ls


find :: NameSpace a -> String -> Maybe a
find (NameSpace gs lss) id = case (lookup lss) of
  Nothing  -> Map.lookup id gs    -- find from global scope
  Just def -> Just def

  where

    lookup [] = Nothing
    lookup (ls:lss) = case (lookup' ls) of
      Nothing  -> lookup lss
      Just def -> Just def

    lookup' [] = Nothing
    lookup' ((id', def):ls) | id' == id = Just def
                            | otherwise = lookup' ls    
  
  
