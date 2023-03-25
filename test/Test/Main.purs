module Test.Main where


import Prelude
import Test.Fixtures

import Control.Monad.Reader (ReaderT, ask, local, runReaderT)
import Data.Argonaut (class DecodeJson, class EncodeJson, Json, JsonDecodeError, decodeJson, encodeJson, stringify, (.:), (.:?))
import Data.Basic.PointCoordinates (PointCoordinates(..))
import Data.Either (Either(..))
import Data.Foldable (for_)
import Data.Geometry (Geometry(..), GeometryCollection'(..))
import Data.LineString (LineString')
import Data.Maybe (Maybe(..))
import Data.Monoid (power)
import Data.MultiLineString (MultiLineString')
import Data.MultiPoint (MultiPoint'(..))
import Data.MultiPolygon (MultiPolygon'(..))
import Data.Point (Point'(..))
import Data.Polygon (Polygon'(..))
import Data.Tuple.Nested (type (/\), (/\))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Exception (throw)
import Foreign.Object (Object)
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

_point :: Proxy Point'
_point = Proxy

_multiPoint :: Proxy MultiPoint'
_multiPoint = Proxy

_lineString :: Proxy LineString'
_lineString = Proxy

_multilinestring :: Proxy MultiLineString'
_multilinestring = Proxy

_polygon :: Proxy Polygon'
_polygon = Proxy

_multipolygon :: Proxy MultiPolygon'
_multipolygon = Proxy

_geometrycollection :: Proxy GeometryCollection'
_geometrycollection = Proxy

failure :: String -> Test
failure = liftEffect <<< throw

points:: Proxy Point' /\ (Array Json)
points =  _point /\ [point_,pointbbox_, point3d_]

multipoints :: Proxy MultiPoint' /\ Array Json
multipoints = _multiPoint /\ [multipoint_, multipointbbox_, multipoint3d_ ]

linestrings :: Proxy LineString' /\ Array Json
linestrings = _lineString /\ [linestring_, linestringbbox_, linestring3d_]

multilinestrings :: Proxy MultiLineString' /\ Array Json
multilinestrings = _multilinestring /\ [ multilinestring_, multilinestringbbox_, multilinestring3d_]

polygons :: Proxy Polygon' /\ Array Json
polygons = _polygon /\ [polygona_, polygon_, polygonbbox_, polygon3d_ ]
 
multipolygons :: Proxy MultiPolygon' /\ Array Json
multipolygons = _multipolygon /\ [multipolygon_, multipolygonbbox_, multipolygon3d_]

geometrycollections :: Proxy GeometryCollection' /\ Array Json
geometrycollections = _geometrycollection /\ [geometryCollection_, geometryCollectionbbox_, geometryCollection3d_]

main :: Effect Unit
main = flip runReaderT 0 do 
  log "🍝"
  decenc "Point" points 
  decenc "MultiPoint" multipoints
  decenc "LineString" linestrings
  decenc "MultiLineString" multilinestrings
  decenc "Polygon" polygons
  decenc "MultiPolygon" multipolygons
  decenc "GeometryCollection" geometrycollections
  enc kaka



enc :: forall a. EncodeJson a => Show a => a -> Test
enc value = do
  test "Encoding" do
     let 
         encoded = encodeJson value 
     log $ stringify encoded

dec :: forall a. DecodeJson a => Show a => Proxy a -> Json -> Test 
dec _ json  =  do
  test "Decoding" do  
    case decodeJson json of 
      Right (decoded :: a) -> log $ show decoded
      Left err -> log $ show err
      

kaka :: GeometryCollection'
kaka = GeometryCollection'
  { geometries: [Point (Point' { coordinates: PointCoordinates { latitude: 0.0, longitude: 0.0, mbElevation: Nothing }, bbox: Nothing})]
  , bbox: Nothing
  }





decenc :: forall a. DecodeJson a => EncodeJson a => Show a => String -> Proxy a /\ Array Json ->  Test
decenc name (_ /\ fixtures) = do
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
