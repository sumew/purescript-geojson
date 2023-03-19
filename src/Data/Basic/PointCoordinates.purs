module Data.Basic.PointCoordinates where

import Prelude

import Data.Argonaut (Json, JsonDecodeError, decodeJson, encodeJson)
import Data.Either (Either)
import Data.Maybe (Maybe(..))

type PointCoordinates =
  { latitude :: Number
  , longitude :: Number
  , mbElevation :: Maybe Number
  }

toNumberArray :: PointCoordinates -> Array Number
toNumberArray { latitude, longitude, mbElevation } = 
  case mbElevation of
      Nothing -> [latitude, longitude]
      Just elevation -> [latitude, longitude, elevation]

fromNumberArray :: Array Number -> Maybe PointCoordinates
fromNumberArray [latitude, longitude, elevation] = Just { latitude, longitude, mbElevation: Just elevation}
fromNumberArray [latitude, longitude] = Just { latitude, longitude, mbElevation: Nothing }
fromNumberArray _ = Nothing


toJson :: PointCoordinates -> Json
toJson = toNumberArray >>> encodeJson

fromJson :: Json -> Either JsonDecodeError (Maybe PointCoordinates)
fromJson json = fromNumberArray <$> decodeJson json

