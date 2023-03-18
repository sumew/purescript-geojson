module Data.Basic.BoundingBox where

import Prelude

import Data.Basic.PointCoordinates (PointCoordinates)

type BoundingBox = 
  { bottomLeft :: PointCoordinates
  , topRight :: PointCoordinates
  }
