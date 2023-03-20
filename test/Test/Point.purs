module Test.Point where
 

import Prelude

import Data.Argonaut (decodeJson, encodeJson)
import Data.Argonaut.Core (stringify)
import Data.Either (Either(..))
import Data.Point (Point(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Test.Fixtures.PointFixtures (point, point')


--kaka :: Effect Unit 
--kaka = case fromGeometryJson point of
--  Right decoded ->
--    log $ show decoded 
--  Left error ->
--    log $ show error
--

mesbah :: Effect Unit
mesbah = log  $ stringify $  encodeJson point'

urby :: Effect Unit
urby = case decodeJson point of
  Right (decoded :: Point) -> log $ show decoded
  Left error -> log $ show error
