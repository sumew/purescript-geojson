module Test.Main where


import Prelude

import Control.Monad.Reader (ReaderT, ask, local, runReaderT)
import Data.Argonaut (class DecodeJson, class EncodeJson, Json, decodeJson, encodeJson, stringify)
import Data.Either (Either(..))
import Data.FeatureCollection (FeatureCollection)
import Data.Foldable (for_)
import Data.Geometry (GeometryCollection)
import Data.Geometry.Feature (Feature)
import Data.LineString (LineString)
import Data.Monoid (power)
import Data.MultiLineString (MultiLineString)
import Data.MultiPoint (MultiPoint)
import Data.MultiPolygon (MultiPolygon)
import Data.Point (Point)
import Data.Polygon (Polygon)
import Data.Tuple.Nested (type (/\), (/\))
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Class.Console (log)
import Effect.Exception (throw)
import Test.Fixtures (featureCollectionEmpty_, featureCollection_, featureEmpty_, featureNull_, featureNumberId_, feature_, geometryCollection3d_, geometryCollection_, geometryCollectionbbox_, linestring3d_, linestring_, linestringbbox_, mapboxFeature, multilinestring3d_, multilinestring_, multilinestringbbox_, multipoint3d_, multipoint_, multipointbbox_, multipolygon3d_, multipolygon_, multipolygonbbox_, point3d_, point_, pointbbox_, polygon3d_, polygon_, polygona_, polygonbbox_)
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

failure :: String -> Test
failure = liftEffect <<< throw

--------------------------------------------------------------------------------------------------------------------
_point :: Proxy Point
_point = Proxy

points:: Proxy Point /\ (Array Json)
points =  _point /\ [point_,pointbbox_, point3d_]
--------------------------------------------------------------------------------------------------------------------

_multiPoint :: Proxy MultiPoint
_multiPoint = Proxy

multipoints :: Proxy MultiPoint /\ Array Json
multipoints = _multiPoint /\ [multipoint_, multipointbbox_, multipoint3d_ ]

--------------------------------------------------------------------------------------------------------------------
_lineString :: Proxy LineString
_lineString = Proxy

linestrings :: Proxy LineString /\ Array Json
linestrings = _lineString /\ [linestring_, linestringbbox_, linestring3d_]

--------------------------------------------------------------------------------------------------------------------
_multilinestring :: Proxy MultiLineString
_multilinestring = Proxy

multilinestrings :: Proxy MultiLineString /\ Array Json
multilinestrings = _multilinestring /\ [ multilinestring_, multilinestringbbox_, multilinestring3d_]

--------------------------------------------------------------------------------------------------------------------
_polygon :: Proxy Polygon
_polygon = Proxy

polygons :: Proxy Polygon /\ Array Json
polygons = _polygon /\ [polygona_, polygon_, polygonbbox_, polygon3d_ ]
 
--------------------------------------------------------------------------------------------------------------------
_multipolygon :: Proxy MultiPolygon
_multipolygon = Proxy

multipolygons :: Proxy MultiPolygon /\ Array Json
multipolygons = _multipolygon /\ [multipolygon_, multipolygonbbox_, multipolygon3d_]

--------------------------------------------------------------------------------------------------------------------
_geometrycollection :: Proxy GeometryCollection
_geometrycollection = Proxy

geometrycollections :: Proxy GeometryCollection /\ Array Json
geometrycollections = _geometrycollection /\ [geometryCollection_, geometryCollectionbbox_, geometryCollection3d_]
--------------------------------------------------------------------------------------------------------------------
_feature :: Proxy Feature
_feature = Proxy

features :: Proxy Feature /\ Array Json
features = _feature /\ [feature_, featureNull_, featureNumberId_, featureEmpty_, mapboxFeature]

--------------------------------------------------------------------------------------------------------------------
_featurecollection :: Proxy FeatureCollection
_featurecollection = Proxy

featurecollections :: Proxy FeatureCollection /\ Array Json
featurecollections = _featurecollection /\ [featureCollection_, featureCollectionEmpty_ ]

--------------------------------------------------------------------------------------------------------------------

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
 -- decenc "Feature" features
  decenc "FeatureCollection" featurecollections
  dec _feature mapboxFeature


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
      


decenc :: forall a m. MonadEffect m => DecodeJson a => EncodeJson a => Show a => String -> Proxy a /\ Array Json -> m Unit 
decenc name (_ /\ fixtures) = do
  log ("Testing " <> name) 
  for_ fixtures \value ->
    case decodeJson value of
        Right (decoded :: a) ->
          let encoded = encodeJson decoded
          in
            if encoded == value 
            then pure unit
            else liftEffect $ throw (
              "decoded value " <> show decoded <> 
              "\n encoded value: " <> stringify encoded <> " doesn't match " <> stringify value 
              )
        _ -> liftEffect $ throw ("Failed to properly decode JSON string: " <> stringify value)
