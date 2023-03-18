module Data.Basic.LineStringCoordinates where

import Prelude

import Data.Array ((:), head)
import Data.Array.Partial(tail)
import Data.Array.NonEmpty (toUnfoldable)
import Data.Basic.PointCoordinates (PointCoordinates)
import Data.List (List(..))
import Data.Maybe (Maybe(..))

type LineStringCoordinates =
  { first :: PointCoordinates
  , second :: PointCoordinates
  , rest ::  Array PointCoordinates
  }

toArray :: LineStringCoordinates -> Array PointCoordinates
toArray {first, second, rest } =  [first, second] <> rest 


fromArray :: Array PointCoordinates -> Maybe LineStringCoordinates
fromArray = case _ of
  [] -> Nothing
  [first, second] -> Just $ { first, second, rest:[] }
  rest@[first,second,z] -> Just { first, second, rest }
  _ -> Nothing
