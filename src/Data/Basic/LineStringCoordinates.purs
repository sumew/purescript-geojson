module Data.Basic.LineStringCoordinates where

import Prelude

import Data.Argonaut (Json, JsonDecodeError, decodeJson, fromArray)
import Data.Array (uncons)
import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Basic.PointCoordinates as PC
import Data.Either (Either)
import Data.Maybe (Maybe(..))

type LineStringCoordinates =  
  { first :: PointCoordinates
  , second :: PointCoordinates
  , rest :: Array PointCoordinates
  }

toPointCoordinateArray :: LineStringCoordinates -> Array PointCoordinates
toPointCoordinateArray { first, second, rest } =  [first] <> [second] <> rest


fromPointCoordinatesArray :: Array PointCoordinates -> Maybe LineStringCoordinates
fromPointCoordinatesArray xs = case uncons xs of
  Just { head:first, tail } -> 
    case uncons tail of
        Just { head: second, tail: rest } -> Just { first, second, rest }
        Nothing -> Nothing
  Nothing -> Nothing


toJson :: LineStringCoordinates -> Json
toJson ls = fromArray $ (toPointCoordinateArray ls) <#> PC.toJson


fromJson :: Json -> Either JsonDecodeError (Maybe LineStringCoordinates)
fromJson json = decodeJson json



