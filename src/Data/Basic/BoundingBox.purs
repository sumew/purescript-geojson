module Data.Basic.BoundingBox where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Argonaut.Decode.Decoders (decodeArray)
import Data.Basic.PointCoordinates (PointCoordinates(..))
import Data.Basic.PointCoordinates as PC
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

newtype BoundingBox = BoundingBox
  { bottomLeft :: PointCoordinates
  , topRight :: PointCoordinates
  }

instance decodeJsonBoundingBox :: DecodeJson BoundingBox where
  decodeJson json = do 
     array <- decodeArray decodeJson json
     fromArray array

instance encodeJsonBoundingBox :: EncodeJson BoundingBox where
  encodeJson = toArray >>> encodeJson 


toArray :: BoundingBox -> Array Number
toArray (BoundingBox { bottomLeft, topRight }) = PC.toNumberArray bottomLeft <> PC.toNumberArray topRight


fromArray :: Array Number -> Either JsonDecodeError BoundingBox 
fromArray [bottomlat, bottomlong, toplat, toplong] = Right $ BoundingBox 
  { bottomLeft: PointCoordinates {latitude: bottomlat, longitude: bottomlong, mbElevation: Nothing } 
  , topRight: PointCoordinates {latitude:toplat, longitude: toplong, mbElevation: Nothing } 
  }
fromArray _ = Left MissingValue



