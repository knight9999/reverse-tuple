module Main where

import Prelude (Unit, unit, discard, ($), class Show, show, identity)

import Effect (Effect)
import Effect.Console (log)
import Data.Tuple (Tuple)
import Data.Tuple.Nested (type (/\), (/\))

import ShowTuple (TProxy(..), TupleView(..))
import ReverseTuple (class GoThrough, class Reverse)

main :: Effect Unit
main = do
  log "--- Type Go Through ---"
  log $ show (TProxy :: forall m. (GoThrough (Int /\ String /\ Number /\ Unit) m) => TProxy m)

  log "--- Type Reverse ---"
  log $ show (TProxy :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => TProxy m)

  log "--- Type Normal ---"
  log $ show (TProxy :: TProxy (Number /\ String /\ Int /\ Unit))

  log "--- Value ---"
  let tuple3 = (3.14 /\ "ABC" /\ 10 /\ unit) 
  log $ show $ TupleView tuple3

  log "--- Value Type Gaurd ---"
  let tuple4 = (identity :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => m -> m)
               $ 3.14 /\ "ABC" /\ 10 /\ unit
  log $ show $ TupleView tuple4

  log "--- Use showTuple Function ---"
  log $ showTuple tuple3
  log $ showTuple tuple4


-- showTuple Function --
showTuple :: forall a b. (Show (TupleView a b)) 
                => (Reverse (Int /\ String /\ Number /\ Unit) (Tuple a b)) 
                => Tuple a b -> String
showTuple a = show (TupleView a) 

