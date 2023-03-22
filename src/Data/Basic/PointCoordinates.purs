module Data.Basic.PointCoordinates where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

newtype PointCoordinates = PointCoordinates
  { latitude :: Number
  , longitude :: Number
  , mbElevation :: Maybe Number
  }

derive newtype instance showPointCoordinates :: Show PointCoordinates

instance encodeJsonPointCoordinates :: EncodeJson PointCoordinates where
  encodeJson = toNumberArray >>> encodeJson

instance decodeJsonPointCoordinates :: DecodeJson PointCoordinates where
  decodeJson json = do 
     array <- decodeJson json
     fromNumberArray array


toNumberArray :: PointCoordinates -> Array Number
toNumberArray (PointCoordinates { latitude, longitude, mbElevation }) = 
  case mbElevation of
      Nothing -> [latitude, longitude]
      Just elevation -> [latitude, longitude, elevation]

fromNumberArray :: Array Number -> Either JsonDecodeError PointCoordinates
fromNumberArray [latitude, longitude, elevation] = Right $ PointCoordinates { latitude, longitude, mbElevation: Just elevation}
fromNumberArray [latitude, longitude] = Right $ PointCoordinates { latitude, longitude, mbElevation: Nothing }
fromNumberArray _ = Left MissingValue 


