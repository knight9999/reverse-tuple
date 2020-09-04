module Main where

import Prelude (Unit, unit, discard, ($), class Show, show, (<>))

import Effect (Effect)
import Effect.Console (log)
import Data.Tuple
import Data.Tuple.Nested (type (/\), (/\))

import ShowTuple (TProxy(..), showTupleType, TupleView(..))
import ReverseTuple (class GoThrough, class Reverse)



main :: Effect Unit
main = do
  log "--- Type Go Through ---"
  log $ showTupleType (TProxy :: forall m. (GoThrough (Int /\ String /\ Number /\ Unit) m) => TProxy m)

  log "--- Type Reverse ---"
  log $ showTupleType (TProxy :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => TProxy m)

  log "--- Value ---"
  let tuple3 = (3.14 /\ "ABC" /\ 10 /\ unit) -- :: (forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => m)
  log $ show $ TupleView tuple3
