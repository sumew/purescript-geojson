module Test.Main where


import Prelude
import Test.Fixtures

import Control.Monad.Reader (ReaderT, ask, local, runReaderT)
import Data.Argonaut (class DecodeJson, class EncodeJson, Json, decodeJson, encodeJson, stringify)
import Data.Either (Either(..))
import Data.Foldable (for_)
import Data.LineString (LineString)
import Data.Monoid (power)
import Data.MultiLineString (MultiLineString)
import Data.MultiPoint (MultiPoint)
import Data.MultiPolygon (MultiPolygon(..))
import Data.Point (Point)
import Data.Polygon (Polygon(..))
import Data.Tuple.Nested (type (/\), (/\))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Exception (throw)
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

_multilinestring :: Proxy MultiLineString
_multilinestring = Proxy

_polygon :: Proxy Polygon
_polygon = Proxy

_multipolygon :: Proxy MultiPolygon
_multipolygon = Proxy


failure :: String -> Test
failure = liftEffect <<< throw

points:: Proxy Point /\ (Array Json)
points =  _point /\ [point_,pointbbox_, point3d_]

multipoints :: Proxy MultiPoint /\ Array Json
multipoints = _multiPoint /\ [multipoint_, multipointbbox_, multipoint3d_ ]

linestrings :: Proxy LineString /\ Array Json
linestrings = _lineString /\ [linestring_, linestringbbox_, linestring3d_]

multilinestrings :: Proxy MultiLineString /\ Array Json
multilinestrings = _multilinestring /\ [ multilinestring_, multilinestringbbox_, multilinestring3d_]

polygons :: Proxy Polygon /\ Array Json
polygons = _polygon /\ [polygon_, polygonbbox_, polygon3d_ ]
 
multipolygons :: Proxy MultiPolygon /\ Array Json
multipolygons = _multipolygon /\ [multipolygon_, multipolygonbbox_, multipolygon3d_]

testGeometry :: forall a. DecodeJson a => EncodeJson a => Show a => String -> Proxy a /\ Array Json ->  Test
testGeometry name (_ /\ fixtures) = do
       test ("Testing " <> name) do
         for_ fixtures \value ->
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
  testGeometry "Point" points 
  testGeometry "MultiPoint" multipoints
  testGeometry "LineString" linestrings
  testGeometry "MultiLineString" multilinestrings
  testGeometry "Polygon" polygons
  testGeometry "MultiPolygon" multipolygons

