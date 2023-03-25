module Data.Geometry.Feature where


import Prelude

import Data.Argonaut (class DecodeJson, Json, JsonDecodeError(..), decodeJson, (.:?))
import Data.Basic.BoundingBox (BoundingBox(..))
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Geometry (Geometry)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)


data FeatureId 
  = FeatureIdString String 
  | FeatureIdNumber Int

derive instance genericFeatureId :: Generic FeatureId _

instance showFeatureId :: Show FeatureId where
  show = genericShow

instance featureIdDecodeJson :: DecodeJson FeatureId where
  decodeJson json = do 
     decoded <- decodeJson json
     decodeda <- case decodeJson json of
         Right (intId :: Int) -> Right $ FeatureIdNumber intId
--         Right (stringId :: String) -> Right $ FeatureIdString stringId
         _ -> Left MissingValue 
     pure decodeda
         
         

newtype Feature'  = Feature' 
  { geometry :: Maybe Geometry
  , properties :: Maybe Json
  , id :: FeatureId
  , bbox :: Maybe BoundingBox
  }


instance decodeJsonFeature :: DecodeJson Feature' where
  decodeJson json = do
     feature <- decodeJson json
     geometry <- feature .:? "geometry"
     properties <- feature .:? "properties"
     id <- feature .:? "id"
     bbox <- feature .:? "bbox"
     pure $ Feature' { geometry, properties, id, bbox }



