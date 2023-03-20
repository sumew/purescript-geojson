module Test.Main where


import Prelude

import Control.Monad.Reader (ReaderT, ask, local, runReaderT)
import Data.Monoid (power)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Exception (throw)
import Test.Assert as Assert
import Test.Point (mesbah, urby)


type Test = ReaderT Int Effect Unit

suite :: String -> Test -> Test
suite = test


test :: String -> Test -> Test
test name run = do
  indent <- ask
  log (mkIndent indent <> name)
  local (_ + 2) run

mkIndent :: Int -> String
mkIndent = power " "


assertEqual :: forall a. Eq a => Show a => { actual :: a, expected :: a } -> Test
assertEqual = liftEffect <<< Assert.assertEqual

failure :: String -> Test
failure = liftEffect <<< throw

main :: Effect Unit
main = do
--  log "🍝"
  urby 
  mesbah
