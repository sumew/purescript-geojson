module Data.Geometry.Feature where


import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, Json, JsonDecodeError(..), decodeJson, encodeJson, jsonEmptyObject, stringify, toNumber, toString, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (BoundingBox)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Geometry (Geometry)
import Data.Maybe (Maybe(..))


data FeatureId 
  = FeatureIdString String 
  | FeatureIdNumber Number 

derive instance genericFeatureId :: Generic FeatureId _
derive instance eqFeatureId :: Eq FeatureId

instance showFeatureId :: Show FeatureId where
  show (FeatureIdString str) = show str 
  show (FeatureIdNumber nbr) = show nbr

instance featureIdDecodeJson :: DecodeJson FeatureId where
  decodeJson json = 
    case toNumber json of
        Just number -> Right $ FeatureIdNumber number
        _ -> case toString json of
                 Just string -> Right $ FeatureIdString string
                 _ -> Left $ TypeMismatch "Expected String or Number for FeatureId" 

instance featureIdEncodeJson :: EncodeJson FeatureId where
  encodeJson (FeatureIdString string) = encodeJson string
  encodeJson (FeatureIdNumber number) = encodeJson number


newtype FeatureProperties = FeatureProperties Json

derive newtype instance eqFeatureProperties :: Eq FeatureProperties

instance showFeatureProperties :: Show FeatureProperties where
  show (FeatureProperties json) = stringify json

instance featurePropertiesDecodeJson :: DecodeJson FeatureProperties where 
  decodeJson json = pure $ FeatureProperties json

instance featurePropertiesEncodeJson :: EncodeJson FeatureProperties where
  encodeJson (FeatureProperties properties) = properties



newtype Feature  = Feature 
  { geometry :: Geometry
  , properties :: Maybe FeatureProperties 
  , id :: Maybe FeatureId
  , bbox :: Maybe BoundingBox
  }

derive newtype instance showFeature :: Show Feature

derive newtype instance eqFeature :: Eq Feature

instance decodeJsonFeature :: DecodeJson Feature where
  decodeJson json = do
     feature <- decodeJson json
     geometry <- feature .: "geometry"
     properties <- feature .:? "properties"
     id <- feature .:? "id"
     bbox <- feature .:? "bbox"
     pure $ Feature { geometry, properties, id, bbox }

instance encodeJsonFeature :: EncodeJson Feature where
  encodeJson (Feature { geometry, properties, id, bbox }) = 
    "type" := "Feature"
    ~> "geometry" := encodeJson geometry
    ~> "properties" :=? (encodeJson <$> properties)
    ~>? "id" :=? (encodeJson <$> id)
    ~>? "bbox" :=? (encodeJson <$> bbox)
    ~>? jsonEmptyObject


