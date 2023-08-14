module Data.Basic.LineStringCoordinates where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Array (uncons)
import Data.Basic.Coordinates (Coordinates)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

newtype LineStringCoordinates = LineStringCoordinates
  { first :: Coordinates
  , second :: Coordinates
  , rest :: Array Coordinates
  }

derive newtype instance showLineStringCoordinates :: Show LineStringCoordinates
derive newtype instance eqLineString :: Eq LineStringCoordinates

instance encodeJsonLineStringCoordinates :: EncodeJson LineStringCoordinates where
  encodeJson = toArray >>> encodeJson

instance decodeJsonLineStringCoordinates :: DecodeJson LineStringCoordinates where
  decodeJson json = do
     pointCoordinatesArray <- decodeJson json
     fromArray pointCoordinatesArray 


toArray :: LineStringCoordinates -> Array Coordinates
toArray (LineStringCoordinates { first, second, rest }) =  [first] <> [second] <> rest


fromArray :: Array Coordinates -> Either JsonDecodeError LineStringCoordinates
fromArray xs = case uncons xs of
  Just { head:first, tail } -> 
    case uncons tail of
        Just { head: second, tail: rest } -> Right $ LineStringCoordinates { first, second, rest }
        Nothing -> Left MissingValue 
  Nothing -> Left MissingValue 

