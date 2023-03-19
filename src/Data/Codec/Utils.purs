module Data.Codec.Utils where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, Json, JsonDecodeError(..), decodeJson, encodeJson, fromObject, fromString)
import Data.Either (Either(..))
import Data.Point (Point)
import Data.Tuple.Nested ((/\))
import Foreign.Object (fromFoldable)





makeGeometryJson :: forall a. EncodeJson a => String -> a -> Json
makeGeometryJson _type coordinates =
  fromObject $ fromFoldable [ "type" /\ fromString _type, "coordinates" /\ encodeJson coordinates ]

--readGeometryJson :: Json -> Either JsonDecodeError Point 
--readGeometryJson  bfjson =  





