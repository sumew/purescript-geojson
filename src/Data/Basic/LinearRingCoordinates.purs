module Data.Basic.LinearRingCoordinates where



import Data.Argonaut (Json, JsonDecodeError, decodeJson, encodeJson)
import Data.Array (uncons, (:))
import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Either (Either)
import Data.Maybe (Maybe(..))
import Data.NonEmpty (NonEmpty(..))
import Data.NonEmpty as NE

type LinearRingCoordinates = 
  { first:: PointCoordinates
  , second :: PointCoordinates
  , third :: PointCoordinates
  , rest :: NonEmpty Array PointCoordinates
  }

toArray :: LinearRingCoordinates -> Array PointCoordinates
toArray { first, second, third, rest } = first:second:third:(NE.head rest):(NE.tail rest)


fromArray :: Array PointCoordinates -> Maybe LinearRingCoordinates
fromArray xs = 
  case uncons xs of
      Just { head: first, tail: firstTail  } -> 
        case uncons firstTail of 
            Just { head: second, tail: secondTail } ->
              case uncons secondTail of
                  Just { head: third, tail: thirdTail} -> 
                    case uncons thirdTail of 
                        Just { head: x, tail: lastTail } -> Just { first, second, third, rest: NonEmpty x lastTail }
                        _ -> Nothing
                  Nothing -> Nothing
            Nothing -> Nothing
      Nothing -> Nothing


fromJson :: Json -> Either JsonDecodeError (Maybe LinearRingCoordinates)
fromJson = decodeJson


toJson :: LinearRingCoordinates -> Json
toJson = encodeJson
