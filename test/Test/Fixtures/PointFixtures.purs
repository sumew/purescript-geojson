module Test.Fixtures.PointFixtures where

import Data.Argonaut (Json)
import Data.Basic.PointCoordinates (PointCoordinates(..))
import Data.Maybe (Maybe(..))

foreign import point :: Json

foreign import pp :: Json

point' :: PointCoordinates
point' = PointCoordinates
  { latitude: 0.0
  , longitude: 0.0
  , mbElevation: Nothing
  }


