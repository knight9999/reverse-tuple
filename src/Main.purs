module Main where

import Prelude (Unit, unit, discard, ($), class Show, show, (<>), (<<<), identity)

import Effect (Effect)
import Effect.Console (log)
import Data.Tuple
import Data.Tuple.Nested (type (/\), (/\))

import ShowTuple (TProxy(..), toArrayString, TupleView(..))
import ReverseTuple (class GoThrough, class Reverse)

import Data.Array
import Data.Identity

main :: Effect Unit
main = do
  log "--- Type Go Through ---"
  log $ show (TProxy :: forall m. (GoThrough (Int /\ String /\ Number /\ Unit) m) => TProxy m)

  log "--- Type Reverse ---"
  log $ show (TProxy :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => TProxy m)

  log "--- Type Normal ---"
  log $ show (TProxy :: TProxy (Number /\ String /\ Int /\ Unit))

  log "--- Value ---"
  let tuple3 = (3.14 /\ "ABC" /\ 10 /\ unit) -- :: (forall m. Reverse (Int /\ String /\ Number /\ Unit) m => m)
  log $ show $ TupleView tuple3
  log $ hoge1 hoge1_



hoge1 :: forall a b. (Show (TupleView a b)) 
                => (Reverse (Int /\ String /\ Number /\ Unit) (Tuple a b)) 
                => Tuple a b -> String
hoge1 a = show (TupleView a)
 
hoge1_ = 3.14 /\ "ABC" /\ 10 /\ unit



def :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => m -> m
def = identity

hoge2_ = def hoge1_

