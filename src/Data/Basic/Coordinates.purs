module Data.Basic.Coordinates where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

newtype Coordinates = Coordinates
  { lat :: Number
  , lon :: Number
  , mbElev :: Maybe Number
  }

derive newtype instance showPointCoordinates :: Show Coordinates

instance encodeJsonPointCoordinates :: EncodeJson Coordinates where
  encodeJson = toNumberArray >>> encodeJson

instance decodeJsonPointCoordinates :: DecodeJson Coordinates where
  decodeJson json = do 
     array <- decodeJson json
     fromNumberArray array


toNumberArray :: Coordinates -> Array Number
toNumberArray (Coordinates { lat, lon, mbElev }) = 
  case mbElev of
      Nothing -> [lat, lon]
      Just elev -> [lat, lon, elev]

fromNumberArray :: Array Number -> Either JsonDecodeError Coordinates
fromNumberArray [lat, lon, elev] = Right $ Coordinates { lat, lon, mbElev: Just elev }
fromNumberArray [lat, lon] = Right $ Coordinates { lat, lon, mbElev: Nothing }
fromNumberArray _ = Left MissingValue 


