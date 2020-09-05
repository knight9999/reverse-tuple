module Main where

import Prelude (Unit, unit, discard, ($), class Show, show, identity)

import Effect (Effect)
import Effect.Console (log)
import Data.Tuple (Tuple)
import Data.Tuple.Nested (type (/\), (/\))

import ShowTuple (TProxy(..), TupleView(..))
import ReverseTuple (class Reverse)

main :: Effect Unit
main = do
  log "--- Tuple (Int,String,Number) ---"
  log $ show (TProxy :: TProxy (Int /\ String /\ Number /\ Unit))

  log "--- Reverse Tuple (Int,String,Number) ==> Tuple (Number,String,Int) ---"
  log $ show (TProxy :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => TProxy m)

  log "--- Value (3.14,\"ABC\",10) ---"
  let tuple3 = (3.14 /\ "ABC" /\ 10 /\ unit) 
  log $ show $ TupleView tuple3

  log "--- Value (3.14,\"ABC\",10) guarded by Reverse Tuple (Int,String,Number) ---"
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

