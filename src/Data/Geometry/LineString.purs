module Data.LineString where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, decodeJson, encodeJson, jsonEmptyObject, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (GeoJson)
import Data.Basic.LineStringCoordinates (LineStringCoordinates)

newtype LineString' = LineString' (GeoJson (coordinates :: LineStringCoordinates))

derive newtype instance showLineString :: Show LineString'

instance decodeJsonLineString :: DecodeJson LineString' where
  decodeJson json = do
     geometry <- decodeJson json
     coordinates <- geometry .: "coordinates"
     bbox <- geometry .:? "bbox"
     pure $ LineString' { coordinates, bbox }

instance encodeJsonLineString :: EncodeJson LineString' where
  encodeJson (LineString' { coordinates, bbox }) = 
    "type" := "LineString"
    ~> "coordinates" := encodeJson coordinates
    ~> "bbox" :=? (encodeJson <$> bbox)
    ~>? jsonEmptyObject
