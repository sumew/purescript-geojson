module Data.Geometry where

import Prelude

import Data.Argonaut (class EncodeJson, decodeJson, encodeJson, (.:), (:=), (~>))
import Data.Basic.BoundingBox (GeoJson)
import Data.Generic.Rep (class Generic)
import Data.LineString (LineString(..))
import Data.MultiLineString (MultiLineString(..))
import Data.MultiPoint (MultiPoint(..))
import Data.MultiPolygon (MultiPolygon(..))
import Data.Point (Point(..))
import Data.Polygon (Polygon(..))
import Data.Show.Generic (genericShow)

newtype GeometryCollection = GeometryCollection (GeoJson (geometries :: Array Geometry))

data Geometry
  = GPoint Point
  | GMultiPoint MultiPoint
  | GLineString LineString
  | GMultiLineString MultiLineString
  | GPolygon Polygon
  | GMultiPolygon MultiPolygon
  | GGeometryCollection 

derive instance genericGeometry :: Generic Geometry _

instance showGeometry :: Show Geometry where
  show = case _ of 
    GeometryCollection arr -> show arr
    other -> genericShow other

instance encodeGeometry :: EncodeJson Geometry where
  encodeJson (GPoint p) = encodeJson p
  encodeJson (GMultiPoint mp) = encodeJson mp
  encodeJson (GLineString ls) = encodeJson ls
  encodeJson (GMultiLineString mls) = encodeJson mls
  encodeJson (GPolygon p) = encodeJson p
  encodeJson (GMultiPolygon mp) = encodeJson mp
  encodeJson (GeometryCollection geometries bbox) = 
    "type" := "GeometryCollection"
    ~> "geometries" := (encodeJson <$> geometries)
    ~> "bbox" :=? (encodeJson bbox)

--instance decodeGeometry :: DecodeJson Geometry where
--  decodeJson json = do
--     geometry <- decodeJson json
--     typs_ <- .: "type"

