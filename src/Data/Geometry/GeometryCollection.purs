module Data.GeometryCollection where

import Prelude

import Data.Basic.BoundingBox (GeoJson)
import Data.Geometry (Geometry)

newtype GeometryCollection = GeometryCollection (GeoJson (geometries :: Array Geometry))
