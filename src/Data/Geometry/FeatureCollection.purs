module Data.FeatureCollection where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, decodeJson, encodeJson, jsonEmptyObject, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (GeoJson)
import Data.Geometry.Feature (Feature')


newtype FeatureCollection' = FeatureCollection' (GeoJson (features :: Array Feature')) 

derive newtype instance showFeatureCollection :: Show FeatureCollection'


instance featureCollectionDecodeJson :: DecodeJson FeatureCollection' where
  decodeJson json = do
     geometry <- decodeJson json
     features <- geometry .: "features"
     bbox <- geometry .:? "bbox"
     pure $ FeatureCollection' { features, bbox}


instance featureCollectionEncodeJson :: EncodeJson FeatureCollection' where
  encodeJson (FeatureCollection' { features, bbox }) =
    "type" := "FeatureCollection"
    ~> "features" := encodeJson features
    ~> "bbox" :=? (encodeJson <$> bbox)
    ~>? jsonEmptyObject
