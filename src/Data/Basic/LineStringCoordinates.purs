module Data.Basic.LineStringCoordinates where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Array (uncons)
import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

newtype LineStringCoordinates = LineStringCoordinates
  { first :: PointCoordinates
  , second :: PointCoordinates
  , rest :: Array PointCoordinates
  }

derive newtype instance showLineStringCoordinates :: Show LineStringCoordinates

instance encodeJsonLineStringCoordinates :: EncodeJson LineStringCoordinates where
  encodeJson = toArray >>> encodeJson

instance decodeJsonLineStringCoordinates :: DecodeJson LineStringCoordinates where
  decodeJson json = do
     pointCoordinatesArray <- decodeJson json
     fromArray pointCoordinatesArray 


toArray :: LineStringCoordinates -> Array PointCoordinates
toArray (LineStringCoordinates { first, second, rest }) =  [first] <> [second] <> rest


fromArray :: Array PointCoordinates -> Either JsonDecodeError LineStringCoordinates
fromArray xs = case uncons xs of
  Just { head:first, tail } -> 
    case uncons tail of
        Just { head: second, tail: rest } -> Right $ LineStringCoordinates { first, second, rest }
        Nothing -> Left MissingValue 
  Nothing -> Left MissingValue 

