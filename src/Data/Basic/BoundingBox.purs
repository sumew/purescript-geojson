module Data.Basic.BoundingBox where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Argonaut.Decode.Decoders (decodeArray)
import Data.Basic.Coordinates (Coordinates(..))
import Data.Basic.Coordinates as PC
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

newtype BoundingBox = BoundingBox
  { sw :: Coordinates
  , ne :: Coordinates
  }

derive newtype instance showBoundingBox :: Show BoundingBox

instance decodeJsonBoundingBox :: DecodeJson BoundingBox where
  decodeJson json = do 
     array <- decodeArray decodeJson json
     fromArray array

instance encodeJsonBoundingBox :: EncodeJson BoundingBox where
  encodeJson = toArray >>> encodeJson 


toArray :: BoundingBox -> Array Number
toArray (BoundingBox { sw, ne }) = PC.toNumberArray sw <> PC.toNumberArray ne 


fromArray :: Array Number -> Either JsonDecodeError BoundingBox 
fromArray [bottomlat, bottomlong, toplat, toplong] = Right $ BoundingBox 
  { sw: Coordinates {lat: bottomlat, lon: bottomlong, mbElev: Nothing } 
  , ne: Coordinates {lat:toplat, lon: toplong, mbElev: Nothing } 
  }
fromArray _ = Left MissingValue


type GeoJson r =
  { bbox :: Maybe BoundingBox
  | r  
  }
