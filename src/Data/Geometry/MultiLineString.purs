module Data.MultiLineString where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, decodeJson, encodeJson, jsonEmptyObject, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (BoundingBox)
import Data.Basic.LineStringCoordinates (LineStringCoordinates)
import Data.Maybe (Maybe)

newtype MultiLineString = MultiLineString { bbox :: Maybe BoundingBox, coordinates :: Array LineStringCoordinates }

derive newtype instance showMultiLineString :: Show MultiLineString
derive newtype instance eqMultiLineString :: Eq MultiLineString

instance decodeJsonMultiLineString :: DecodeJson MultiLineString where
  decodeJson json = do
     geometry <- decodeJson json
     coordinates <- geometry .: "coordinates"
     bbox <- geometry .:? "bbox"
     pure $ MultiLineString { coordinates, bbox } 

instance encodeJsonMultiLineString :: EncodeJson MultiLineString where
  encodeJson (MultiLineString { coordinates, bbox }) =
    "type" := "MultiLineString"
    ~> "coordinates" := encodeJson coordinates
    ~> "bbox"  :=? (encodeJson <$> bbox) 
    ~>? jsonEmptyObject
