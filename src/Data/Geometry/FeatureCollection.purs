module Data.FeatureCollection where

import Prelude

import Control.Apply (lift2)
import Data.Argonaut (class DecodeJson, class EncodeJson, decodeJson, encodeJson, jsonEmptyObject, (.:), (.:?), (:=), (:=?), (~>), (~>?))
import Data.Basic.BoundingBox (BoundingBox)
import Data.Basic.Coordinates (Coordinates(..))
import Data.Geometry (Geometry(..))
import Data.Geometry.Feature (Feature(..))
import Data.Maybe (Maybe(..))
import Data.Point (Point(..))


newtype FeatureCollection = FeatureCollection { bbox :: Maybe BoundingBox, features :: Array Feature }

derive newtype instance showFeatureCollection :: Show FeatureCollection
derive newtype instance eqFeatureCollection :: Eq FeatureCollection 

instance semigroupFeatureCollection :: Semigroup FeatureCollection where
  append :: FeatureCollection -> FeatureCollection -> FeatureCollection
  append (FeatureCollection { bbox: b1, features: f1 }) (FeatureCollection { bbox:b2, features:f2 }) = 
    FeatureCollection { bbox: lift2 append b1 b2, features: f1 <> f2 }

instance monoid :: Monoid FeatureCollection where
  mempty = FeatureCollection { bbox: Nothing, features: []}



instance featureCollectionDecodeJson :: DecodeJson FeatureCollection where
  decodeJson json = do
     geometry <- decodeJson json
     features <- geometry .: "features"
     bbox <- geometry .:? "bbox"
     pure $ FeatureCollection { features, bbox}


instance featureCollectionEncodeJson :: EncodeJson FeatureCollection where
  encodeJson (FeatureCollection { features, bbox }) =
    "type" := "FeatureCollection"
    ~> "features" := encodeJson features
    ~> "bbox" :=? (encodeJson <$> bbox)
    ~>? jsonEmptyObject


emptyFeatureCollection :: FeatureCollection
emptyFeatureCollection =
  FeatureCollection
    { bbox: Nothing
    , features:
        [ Feature
            { geometry:
                Point' $ Point
                  { bbox: Nothing
                  , coordinates: Coordinates { lon: 0.0, lat: 0.0, mbElev: Nothing }
                  }
            , properties: Nothing
            , id: Nothing
            , bbox: Nothing
            }
        ]
    }
