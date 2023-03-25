module Data.Geometry where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, Json, JsonDecodeError(..), decodeJson, encodeJson, isNull, jsonEmptyObject, jsonNull, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (GeoJson)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.LineString (LineString')
import Data.MultiLineString (MultiLineString')
import Data.MultiPoint (MultiPoint')
import Data.MultiPolygon (MultiPolygon')
import Data.Point (Point')
import Data.Polygon (Polygon')

newtype GeometryCollection' = GeometryCollection' (GeoJson (geometries :: Array Geometry))
derive newtype instance showGeometryCollection :: Show GeometryCollection'


instance decodeGeometryCollection :: DecodeJson GeometryCollection' where
  decodeJson json = do
     geometry <- decodeJson json
     geometries <- geometry .: "geometries"
     bbox <- geometry .:? "bbox"
     pure $ GeometryCollection' { geometries, bbox }

instance encodeGeometryCollection :: EncodeJson GeometryCollection' where
  encodeJson (GeometryCollection' { geometries, bbox }) =
    "type" := "GeometryCollection"
    ~> "geometries" := encodeJson geometries
    ~> "bbox" :=? (encodeJson <$> bbox)
    ~>? jsonEmptyObject


data Geometry
  = NoGeometry
  | Point Point'
  | MultiPoint MultiPoint'
  | LineString LineString'
  | MultiLineString MultiLineString'
  | Polygon Polygon'
  | MultiPolygon MultiPolygon'
  | GeometryCollection GeometryCollection'

derive instance genericGeometry :: Generic Geometry _
instance showGeometry :: Show Geometry where
  show (Point p) = show p
  show (MultiPoint mp) = show mp
  show (LineString ls) = show ls 
  show (MultiLineString mls) = show mls
  show (Polygon p) = show p
  show (MultiPolygon mp) = show mp
  show (GeometryCollection gc) = show gc
  show NoGeometry = "null" 


geometryFrom :: String -> Json -> Either JsonDecodeError Geometry
geometryFrom "Point" pointJson = Point <$> decodeJson pointJson
geometryFrom "MultiPoint" multipointJson = MultiPoint <$> decodeJson multipointJson
geometryFrom "LineString" linestringJson = LineString <$> decodeJson linestringJson
geometryFrom "MultiLineString" multilinestringJson = MultiLineString <$> decodeJson multilinestringJson
geometryFrom "Polygon" polygonJson = Polygon <$> decodeJson polygonJson 
geometryFrom "MultiPolygon" multipolygonJson = MultiPolygon <$> decodeJson multipolygonJson
geometryFrom "GeometryCollection" geometryCollectionJson = GeometryCollection <$> decodeJson geometryCollectionJson
geometryFrom "null" _ = pure NoGeometry
geometryFrom _ json = Left (UnexpectedValue json)

instance encodeGeometry :: EncodeJson Geometry where
  encodeJson NoGeometry = jsonNull
  encodeJson (Point p) = encodeJson p
  encodeJson (MultiPoint mp) = encodeJson mp
  encodeJson (LineString ls) = encodeJson ls
  encodeJson (MultiLineString mls) = encodeJson mls
  encodeJson (Polygon p) = encodeJson p
  encodeJson (MultiPolygon mp) = encodeJson mp
  encodeJson (GeometryCollection gc) = encodeJson gc

instance decodeGeometry :: DecodeJson Geometry where
  decodeJson json = 
    if isNull json then pure NoGeometry
    else do
      geometry   <- decodeJson json
      geometryType  <- geometry .: "type"
      geometryFrom geometryType json 

