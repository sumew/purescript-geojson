module Test.Main where


import Prelude

import Control.Monad.Reader (ReaderT, ask, local, runReaderT)
import Data.Argonaut (class DecodeJson, class EncodeJson, Json, decodeJson, encodeJson, stringify)
import Data.Either (Either(..))
import Data.Foldable (class Foldable, for_)
import Data.LineString (LineString(..))
import Data.Map (Map)
import Data.Map as Map
import Data.Monoid (power)
import Data.MultiPoint (MultiPoint(..))
import Data.Point (Point(..))
import Data.Tuple.Nested (type (/\), (/\))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Exception (throw)
import Test.Fixtures (linestring3d_, linestring_, linestringbbox_, multipoint3d_, multipoint_, multipointbbox_, point3d_, point_, pointbbox_)
import Type.Prelude (Proxy(..))


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

_point :: Proxy Point
_point = Proxy

_multiPoint :: Proxy MultiPoint
_multiPoint = Proxy

_lineString :: Proxy LineString
_lineString = Proxy

failure :: String -> Test
failure = liftEffect <<< throw

points:: Proxy Point /\ (Array Json)
points =  _point /\ [point_,pointbbox_, point3d_]

multipoints :: Proxy MultiPoint /\ Array Json
multipoints = _multiPoint /\ [multipoint_, multipointbbox_, multipoint3d_ ]

linestrings :: Proxy LineString /\ Array Json
linestrings = _lineString /\ [linestring_, linestringbbox_, linestring3d_]


testa :: forall a. DecodeJson a => EncodeJson a => Show a => String -> Proxy a /\ Array Json ->  Test
testa name (_ /\ fixtures) = do
     for_ fixtures \value ->
       test ("Testing " <> name) do
         case decodeJson value of
             Right (decoded :: a) ->
               let encoded = encodeJson decoded
               in
                 if encoded == value 
                 then pure unit
                 else failure (
                   "decoded value " <> show decoded <> 
                   "\n encoded value: " <> stringify encoded <> " doesn't match " <> stringify value 
                   )
             _ -> failure ("Failed to properly decode JSON string: " <> stringify value)
main :: Effect Unit
main = flip runReaderT 0 do 
  log "🍝"
  testa "Point" points 
  testa "MultiPoint" multipoints
  testa "LineString" linestrings
