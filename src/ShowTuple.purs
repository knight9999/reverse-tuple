module ShowTuple
( TProxy(..)
, class ToArrayString
, toArrayString
, TupleView(..)
) where

import Prelude (class Show, Unit, show, ($), (-), (<>))

import Data.Tuple (Tuple(..), fst)
import Data.Array (length, take, (:))
import Data.Foldable (intercalate)
import Data.Tuple.Nested (type (/\))

class ToArrayString t
  where
  toArrayString :: t -> Array String

instance toArrayStringUnit :: ToArrayString (TProxy Unit)
  where
  toArrayString _ = [ "Unit" ]
else instance toArrayStringInt ::
  ( ToArrayString (TProxy y)
  ) => ToArrayString (TProxy (Int/\y))
  where
  toArrayString _ = "Int" : (toArrayString (TProxy :: TProxy y))
else instance toArrayStringNumber ::
  ( ToArrayString (TProxy y)
  ) => ToArrayString (TProxy (Number/\y))
  where
  toArrayString _ = "Number" : (toArrayString (TProxy :: TProxy y))
else instance toArrayStringString ::
  ( ToArrayString (TProxy y)
  ) => ToArrayString (TProxy (String/\y))
  where
  toArrayString _ = "String" : (toArrayString (TProxy :: TProxy y))
else instance toArrayStringUnknown ::
  ( ToArrayString (TProxy y)
  ) => ToArrayString (TProxy (x/\y))
  where
  toArrayString _ = "Unknown" : (toArrayString (TProxy :: TProxy y))


data TProxy tupleType = TProxy

instance showTProxy :: 
  ( ToArrayString (TProxy tupleType)
  ) => Show (TProxy tupleType)
  where
    show _ = "(" 
          <> intercalate "," array'
          <> ")"
      where 
        array' = take ((length array)-1) array
        array = toArrayString (TProxy :: TProxy tupleType)


newtype TupleView a b = TupleView (Tuple a b)

instance toArrayTupleViewUnit ::
  ( Show a
  ) => ToArrayString (TupleView a Unit)
  where
    toArrayString (TupleView t) = [show $ fst t]
else instance toArrayTupleViewMore ::
  ( Show a
  , ToArrayString (TupleView x y)
  ) => ToArrayString (TupleView a (Tuple x y))
  where
    toArrayString (TupleView (Tuple z w)) = (show z) : (toArrayString (TupleView w))

instance showTuple ::
  ( ToArrayString (TupleView a b) 
  ) => Show (TupleView a b)
  where 
    show tuple = "(" 
                <> intercalate "," array
                <> ")"
      where 
        array = toArrayString tuple

