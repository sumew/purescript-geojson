module Data.Point where

import Prelude

import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Either (Either)

import Data.Argonaut (class DecodeJson, class EncodeJson, Json, JsonDecodeError(..), decodeJson, encodeJson, fromObject, fromString)
import Data.Tuple.Nested ((/\))
import Foreign.Object (fromFoldable)

type Point = PointCoordinates

makeGeometryJson :: Point -> Json
makeGeometryJson point =
  fromObject $ fromFoldable [ "type" /\ fromString "Point", "coordinates" /\ encodeJson point]

toJson :: Point -> Json 
toJson = encodeJson 

fromJson :: Json -> Either JsonDecodeError Point
fromJson = decodeJson

