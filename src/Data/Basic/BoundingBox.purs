module Data.Basic.BoundingBox where

import Prelude

import Data.Argonaut (Json, JsonDecodeError, decodeJson, encodeJson)
import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Basic.PointCoordinates as PC
import Data.Either (Either)

type BoundingBox = 
  { bottomLeft :: PointCoordinates
  , topRight :: PointCoordinates
  }

toArray :: BoundingBox -> Array Number
toArray { bottomLeft, topRight } = PC.toNumberArray bottomLeft <> PC.toNumberArray topRight


fromJson :: Json -> Either JsonDecodeError BoundingBox
fromJson = decodeJson


toJson :: BoundingBox -> Json
toJson = encodeJson
