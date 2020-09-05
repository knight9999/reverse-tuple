module Test.Main where

import Prelude

import Test.Unit (suite, test)
import Test.Unit.Main (runTest)
import Test.Unit.Assert as Assert

import Effect (Effect)
import Effect.Class.Console (log)

import Data.Tuple.Nested (type (/\), (/\))

import ShowTuple (TProxy(..), TupleView(..))
import ReverseTuple (class GoThrough, class Reverse)

main :: Effect Unit
main = do
  log "🍝🍝🍝 Hello Testing 🍝🍝🍝"
  runTest do
    suite "Value / Type Test" do
      test "Tuple Value Test" do
        Assert.assert "Tuple (3.14, \"ABC\", 10) " (
          show (TupleView (3.14 /\ "ABC" /\ 10 /\ unit))
          ==
          "(3.14,\"ABC\",10)"
        ) 
        Assert.assert "Tuple (3.14, \"ABC\", 10) guarded by class type constraints" (
          show (TupleView $ (identity :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => m -> m)
                 (3.14 /\ "ABC" /\ 10 /\ unit)
               )
          ==
          "(3.14,\"ABC\",10)"
        ) 
    suite "Class Test" do
      test "GoThrough Class Test" do
        Assert.assert "GoThrough (Int /\\ String /\\ Number /\\ Unit) ==> (String /\\ Number /\\ Int /\\ Unit)" (
          (show (TProxy :: forall m. (GoThrough (Int /\ String /\ Number /\ Unit) m) => TProxy m))
          ==
          (show (TProxy :: TProxy (String /\ Number /\ Int /\ Unit)))
        )
        Assert.assertFalse "GoThrough (Int /\\ String /\\ Number /\\ Unit) /=> (String /\\ Int /\\ Number /\\ Unit)" (
          (show (TProxy :: forall m. (GoThrough (Int /\ String /\ Number /\ Unit) m) => TProxy m))
          ==
          (show (TProxy :: TProxy (String /\ Int /\ Number /\ Unit)))
        )
      test "Reverse Class Test" do
        Assert.assert "Reverse (Int /\\ String /\\ Number /\\ Unit) ==> (Number /\\ String /\\ Number /\\ Unit)" (
          (show (TProxy :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => TProxy m))
          ==
          (show (TProxy :: TProxy (Number /\ String /\ Int /\ Unit)))
        )
        Assert.assert "Reverse (Int /\\ String /\\ Number /\\ Unit) ==> \"(Number,String,Int)\"" (
          (show (TProxy :: forall m. (Reverse (Int /\ String /\ Number /\ Unit) m) => TProxy m))
          ==
          "(Number,String,Int)"
        )