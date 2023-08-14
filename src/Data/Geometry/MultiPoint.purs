module Data.MultiPoint where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, decodeJson, encodeJson, jsonEmptyObject, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (BoundingBox)
import Data.Basic.Coordinates (Coordinates)
import Data.Maybe (Maybe)


newtype MultiPoint = MultiPoint { bbox :: Maybe BoundingBox, coordinates :: Array Coordinates }

derive newtype instance showMultiPoint :: Show MultiPoint
derive newtype instance eqMultiPoint :: Eq MultiPoint


instance decodeJsonMultiPoint :: DecodeJson MultiPoint where
  decodeJson json = do
     geometry <- decodeJson json
     coordinates <- geometry .: "coordinates"
     bbox <- geometry .:? "bbox"
     pure $ MultiPoint { coordinates, bbox }

instance encodeJson :: EncodeJson MultiPoint where
  encodeJson (MultiPoint { coordinates, bbox }) =
    "type" := "MultiPoint"
    ~> "coordinates" := encodeJson coordinates
    ~> "bbox" :=? (encodeJson <$> bbox)
    ~>? jsonEmptyObject
