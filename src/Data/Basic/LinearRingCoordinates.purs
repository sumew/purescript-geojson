module Data.Basic.LinearRingCoordinates where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Array (uncons, (:))
import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.NonEmpty (NonEmpty(..))
import Data.NonEmpty as NE

newtype LinearRingCoordinates = LinearRingCoordinates 
  { first:: PointCoordinates
  , second :: PointCoordinates
  , third :: PointCoordinates
  , rest :: NonEmpty Array PointCoordinates
  }

derive newtype instance showLinearRingCoordinates :: Show LinearRingCoordinates

instance decodeLinearRingCoordinates :: DecodeJson LinearRingCoordinates where
  decodeJson json = do
     linearRingArray <- decodeJson json
     fromArray linearRingArray

instance encodeLinearRingCoordinates :: EncodeJson LinearRingCoordinates where
  encodeJson = toArray >>> encodeJson


toArray :: LinearRingCoordinates -> Array PointCoordinates
toArray (LinearRingCoordinates { first, second, third, rest }) = first:second:third:(NE.head rest):(NE.tail rest)


fromArray :: Array PointCoordinates -> Either JsonDecodeError LinearRingCoordinates
fromArray xs = 
  case uncons xs of
      Just { head: first, tail: firstTail  } -> 
        case uncons firstTail of 
            Just { head: second, tail: secondTail } ->
              case uncons secondTail of
                  Just { head: third, tail: thirdTail} -> 
                    case uncons thirdTail of 
                        Just { head: x, tail: lastTail } -> Right (LinearRingCoordinates { first, second, third, rest: NonEmpty x lastTail })
                        _ -> Left MissingValue 
                  Nothing -> Left MissingValue 
            Nothing -> Left MissingValue 
      Nothing -> Left MissingValue 


