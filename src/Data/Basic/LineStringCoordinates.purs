module Data.Basic.LineStringCoordinates where

import Prelude

import Data.Array (uncons)
import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Maybe (Maybe(..))

type LineStringCoordinates =  
  { first :: PointCoordinates
  , second :: PointCoordinates
  , rest :: Array PointCoordinates
  }

toArray :: LineStringCoordinates -> Array PointCoordinates
toArray { first, second, rest } =  [first] <> [second] <> rest


fromArray :: Array PointCoordinates -> Maybe LineStringCoordinates
fromArray xs = case uncons xs of
  Just { head:first, tail } -> 
    case uncons tail of
        Just { head: second, tail: rest } -> Just { first, second, rest }
        Nothing -> Nothing
  Nothing -> Nothing

