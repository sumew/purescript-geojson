module Data.Basic.BoundingBox where

import Prelude

import Data.Basic.PointCoordinates (PointCoordinates)
import Data.Basic.PointCoordinates as PC 

type BoundingBox = 
  { bottomLeft :: PointCoordinates
  , topRight :: PointCoordinates
  }

toArray :: BoundingBox -> Array Number
toArray { bottomLeft, topRight } = PC.toArray bottomLeft <> PC.toArray topRight
