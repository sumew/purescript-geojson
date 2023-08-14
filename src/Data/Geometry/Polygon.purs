module Data.Polygon where

import Prelude

import Data.Argonaut (class DecodeJson, class EncodeJson, Json, decodeJson, encodeJson, jsonEmptyObject, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (BoundingBox)
import Data.Basic.PolygonCoordinates (PolygonCoordinates)
import Data.Maybe (Maybe)
import Foreign.Object (Object)

newtype Polygon = Polygon { bbox :: Maybe BoundingBox, coordinates :: PolygonCoordinates }

derive newtype instance showPolygon :: Show Polygon
derive newtype instance eqPolygon :: Eq Polygon

instance decodePolygon :: DecodeJson Polygon where
  decodeJson json = do
     (geometry :: Object Json) <- decodeJson json
     coordinates <- geometry .: "coordinates"
     bbox <- geometry .:? "bbox"
     pure $ Polygon { coordinates, bbox }

instance encodePolygon :: EncodeJson Polygon where
  encodeJson (Polygon { coordinates, bbox }) =
    "type" := "Polygon"
    ~> "coordinates" := encodeJson coordinates
    ~> "bbox" :=? (encodeJson <$> bbox)
    ~>? jsonEmptyObject


