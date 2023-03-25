module Data.Point where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, decodeJson, encodeJson, jsonEmptyObject, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (BoundingBox)
import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Maybe (Maybe)

newtype Point' = Point'
  { coordinates :: PointCoordinates 
  , bbox :: Maybe BoundingBox
  }

derive newtype instance showPoint :: Show Point'

instance decodeJsonPoint :: DecodeJson Point' where
  decodeJson json = do
     geometry <- decodeJson json
     coordinates <- geometry .: "coordinates"
     bbox <- geometry .:? "bbox"
     pure $ Point' { coordinates, bbox }

instance encodeJson :: EncodeJson Point' where
  encodeJson (Point' { coordinates, bbox }) = 
    "type" := "Point"
      ~> "coordinates" := (encodeJson coordinates)
      ~> "bbox" :=? (encodeJson <$> bbox)
      ~>? jsonEmptyObject

