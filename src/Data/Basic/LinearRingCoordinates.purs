module Data.Basic.LinearRingCoordinates where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, JsonDecodeError(..), decodeJson, encodeJson)
import Data.Array (uncons, (:))
import Data.Basic.Coordinates (Coordinates)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.NonEmpty (NonEmpty(..))
import Data.NonEmpty as NE

newtype LinearRingCoordinates = LinearRingCoordinates 
  { first:: Coordinates
  , second :: Coordinates
  , third :: Coordinates
  , rest :: NonEmpty Array Coordinates
  }

derive newtype instance showLinearRingCoordinates :: Show LinearRingCoordinates
derive newtype instance eqLinearRingCoordinates :: Eq LinearRingCoordinates

instance decodeLinearRingCoordinates :: DecodeJson LinearRingCoordinates where
  decodeJson json = do
     linearRingArray <- decodeJson json
     fromArray linearRingArray

instance encodeLinearRingCoordinates :: EncodeJson LinearRingCoordinates where
  encodeJson = toArray >>> encodeJson


toArray :: LinearRingCoordinates -> Array Coordinates
toArray (LinearRingCoordinates { first, second, third, rest }) = first:second:third:(NE.head rest):(NE.tail rest)


fromArray :: Array Coordinates -> Either JsonDecodeError LinearRingCoordinates
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


