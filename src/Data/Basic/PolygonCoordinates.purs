module Data.Basic.PolygonCoordinates where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, decodeJson, encodeJson)
import Data.Basic.LinearRingCoordinates (LinearRingCoordinates)

newtype PolygonCoordinates = PolygonCoordinates (Array LinearRingCoordinates)

derive newtype instance showPolygonCoordinates :: Show PolygonCoordinates
derive newtype instance eqPolygonCoordinates :: Eq PolygonCoordinates

instance encodeJsonPolygonCoordinates :: EncodeJson PolygonCoordinates where
  encodeJson (PolygonCoordinates pc ) = encodeJson pc

instance decodeJsonPolygonCoordinates :: DecodeJson PolygonCoordinates where
  decodeJson json=  PolygonCoordinates <$> (decodeJson json)
