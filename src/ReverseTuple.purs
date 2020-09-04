module ReverseTuple
( class GoThrough
, class Reverse
) where

import Prelude (Unit)
import Data.Tuple.Nested (type (/\))

class GoThrough a b | a -> b

instance goThroughTwo :: GoThrough (x /\ y /\ Unit) (y /\ x /\ Unit)
else instance goThroughMany :: 
  ( GoThrough (y /\ r) z
  ) => GoThrough (y /\ x /\ r) (x /\ z) 

class Reverse a b | a -> b

instance reverseTwo :: Reverse (x /\ y /\ Unit) (y /\ x /\ Unit)
else instance reverseMany ::
  ( Reverse r r'
  , GoThrough (a /\ r') z
  ) => Reverse (a /\ r) z
