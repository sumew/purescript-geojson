module Data.MultiPolygon where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, decodeJson, encodeJson, jsonEmptyObject, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (GeoJson)
import Data.Basic.PolygonCoordinates (PolygonCoordinates)

newtype MultiPolygon = MultiPolygon (GeoJson (coordinates :: Array PolygonCoordinates))

derive newtype instance showMultiPolygon :: Show MultiPolygon 

instance decodeMultiPolygon :: DecodeJson MultiPolygon where
  decodeJson json = do
     geometry <- decodeJson json
     coordinates <- geometry .: "coordinates"
     bbox  <- geometry .:? "bbox"
     pure $ MultiPolygon { coordinates , bbox }

instance encodeMultiPolygon :: EncodeJson MultiPolygon where
  encodeJson (MultiPolygon { coordinates, bbox }) =
    "type" := "MultiPolygon"
    ~> "coordinates" := encodeJson coordinates
    ~> "bbox" :=? (encodeJson <$> bbox)
    ~>? jsonEmptyObject
