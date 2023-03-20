module Data.Point where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, decodeJson, encodeJson, fromObject, fromString, (.:))
import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Tuple.Nested ((/\))
import Foreign.Object (fromFoldable)

newtype Point = Point PointCoordinates

derive newtype instance showPoint :: Show Point

instance decodeJsonPoint :: DecodeJson Point where
  decodeJson json = do
     geometry <- decodeJson json
     coordinates <- geometry .: "coordinates"
     pure $ Point coordinates

instance encodeJson :: EncodeJson Point where
  encodeJson (Point point) = 
    fromObject $ fromFoldable [ "type" /\ fromString "Point", "coordinates" /\ encodeJson point ]

--makeGeometryJson :: Point -> Json
--makeGeometryJson point =
--  fromObject $ fromFoldable [ "type" /\ fromString "Point", "coordinates" /\ toJson point]
--
--
--fromGeometryJson :: Json -> Either JsonDecodeError Point
--fromGeometryJson json = do
----  pure { latitude: 0.0, longitude: 0.0, mbElevation: Nothing}
--  geometry <- decodeJson json
--  coordinates <- geometry.: "coordinates"
--  fromJson coordinates






