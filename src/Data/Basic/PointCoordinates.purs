module Data.Basic.PointCoordinates where

import Prelude

import Data.Maybe (Maybe(..))

type PointCoordinates =
  { latitude :: Number
  , longitude :: Number
  , mbElevation :: Maybe Number
  }

toArray :: PointCoordinates -> Array Number
toArray { latitude, longitude, mbElevation } = 
  case mbElevation of
      Nothing -> [latitude, longitude]
      Just elevation -> [latitude, longitude, elevation]

fromArray :: Array Number -> Maybe PointCoordinates
fromArray [latitude, longitude, elevation] = Just { latitude, longitude, mbElevation: Just elevation}
fromArray [latitude, longitude] = Just { latitude, longitude, mbElevation: Nothing }
fromArray _ = Nothing


