module ShowTuple
( TProxy(..)
, class ShowTupleType
, showTupleType
, TupleView(..)
) where

import Prelude -- (Unit, (<>))

import Data.Tuple

import Data.Tuple.Nested (type (/\), (/\))
import Prim.Boolean (kind Boolean, True, False)
import Prim.TypeError (class Fail, Text)

data TProxy tupleType = TProxy

class ShowTupleType tupleType
  where
  showTupleType :: TProxy tupleType -> String

instance showTupleUnit :: ShowTupleType Unit
  where
  showTupleType _ = "Unit"
else instance showTupleConsInt ::
  ( ShowTupleType y
  ) => ShowTupleType (Int/\y)
  where
  showTupleType _ = "Int /\\ " <> (showTupleType (TProxy :: TProxy y))
else instance showTupleConsNumber ::
  ( ShowTupleType y
  ) => ShowTupleType (Number/\y)
  where
  showTupleType _ = "Number /\\ " <> (showTupleType (TProxy :: TProxy y))
else instance showTupleConsString ::
  ( ShowTupleType y
  ) => ShowTupleType (String/\y)
  where
  showTupleType _ = "String /\\ " <> (showTupleType (TProxy :: TProxy y))
else instance showTupleConsOther ::
  ( ShowTupleType y
  ) => ShowTupleType (x/\y)
  where
  showTupleType _ = "Unknown" <> (showTupleType (TProxy :: TProxy y))


newtype TupleView a b = TupleView (Tuple a b)

instance showTuple1 :: 
  ( Show a
  ) => Show (TupleView a Unit)
  where 
    show (TupleView t) = (show $ fst t) <> " /\\ unit"
else instance showTupleMore ::
  ( Show a
  , Show (TupleView x y)
  ) => Show (TupleView a (Tuple x y))
  where
    show (TupleView (Tuple z w)) = (show z) <> " /\\ " <> (show (TupleView w))
else instance showTupleOther :: 
  ( Fail (Text "i don't know how to show")
  ) => Show (TupleView any any')
  where
    show _ = "Unknown"