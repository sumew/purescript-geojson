module Test.Fixtures where

import Data.Argonaut (Json)

foreign import point_ :: Json
foreign import point3d_ :: Json
foreign import pointbbox_ :: Json
foreign import pointext_ :: Json


foreign import multipoint_ :: Json
foreign import multipoint3d_ :: Json
foreign import multipointbbox_ :: Json
foreign import linestring_ :: Json
foreign import linestring3d_ :: Json
foreign import linestringbbox_ :: Json
foreign import multilinestring_ :: Json
foreign import multilinestring3d_ :: Json
foreign import multilinestringbbox_ :: Json
foreign import polygon_ :: Json
foreign import polygon3d_ :: Json
foreign import polygonbbox_ :: Json
foreign import polygonext_  :: Json
foreign import multipolygon_ :: Json
foreign import multipolygon3d_ :: Json
foreign import multipolygonbbox_ :: Json
foreign import feature_ :: Json
foreign import featureNull_ :: Json
foreign import featureEmpty_ :: Json
foreign import featureNumberId_ :: Json
foreign import featureStringId_ :: Json
foreign import featureCollection_ :: Json
foreign import featureCollectionEmpty_ :: Json
foreign import geometryCollection_ :: Json
foreign import geometryCollection3d_ :: Json
foreign import geometryCollectionbbox_ :: Json
foreign import mapboxFeature :: Json


foreign import geocoll :: Json
foreign import polygona_ :: Json

