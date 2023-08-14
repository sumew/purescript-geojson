module Data.Basic.Coordinates where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

newtype Coordinates = Coordinates
  { lon :: Number
  , lat :: Number
  , mbElev :: Maybe Number
  }

derive newtype instance showPointCoordinates :: Show Coordinates
derive newtype instance eqCoordinates :: Eq Coordinates

instance encodeJson :: EncodeJson Coordinates where
  encodeJson = toNumberArray >>> encodeJson

instance decodeJson :: DecodeJson Coordinates where
  decodeJson json = do 
     array <- decodeJson json
     fromNumberArray array


toNumberArray :: Coordinates -> Array Number
toNumberArray (Coordinates { lon, lat, mbElev }) = 
  case mbElev of
      Nothing -> [lon, lat]
      Just elev -> [lon, lat, elev]

fromNumberArray :: Array Number -> Either JsonDecodeError Coordinates
fromNumberArray [lon, lat, elev] = Right $ Coordinates { lon, lat, mbElev: Just elev }
fromNumberArray [lon, lat] = Right $ Coordinates { lon, lat, mbElev: Nothing }
fromNumberArray _ = Left MissingValue 


