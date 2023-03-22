module Test.Main where


import Prelude

import Control.Monad.Reader (ReaderT, ask, local, runReaderT)
import Data.Argonaut (Json, decodeJson, encodeJson, stringify)
import Data.Either (Either(..))
import Data.Foldable (class Foldable, for_)
import Data.LineString (LineString(..))
import Data.Map (Map)
import Data.Map as Map
import Data.Monoid (power)
import Data.MultiPoint (MultiPoint(..))
import Data.Point (Point)
import Data.Tuple.Nested (type (/\), (/\))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Exception (throw)
import Test.Fixtures (linestring3d_, linestring_, linestringbbox_, multipoint3d_, multipoint_, multipointbbox_, point3d_, point_, pointbbox_)


type Test = ReaderT Int Effect Unit 

suite :: String -> Test -> Test
suite = test


test :: String -> Test -> Test
test name run = do
  indent <- ask
  log (mkIndent indent <> name)
  local (_ + 2) run

mkIndent :: Int -> String
mkIndent = power " "


failure :: String -> Test
failure = liftEffect <<< throw

fixtures :: Array (String /\ Type /\ (Array Json))
fixtures = 
  [ "Point" /\ Point /\ [point_,pointbbox_, point3d_]
  , "MultiPoint" /\ [multipoint_, multipointbbox_, multipoint3d_ ]
  , "LineString" /\ [linestring_, linestringbbox_, linestring3d_]

  ]

testa :: Array (String /\ Array Json) ->  Test
testa fixtureTuple = do
   for_ fixtureTuple \(name /\ values) ->
     for_ values \value ->
       test name do
         case decodeJson value of
             Right (decoded :: Point) ->
               let encoded = encodeJson decoded
               in
                 if encoded == value 
                 then pure unit
                 else failure (
                   "decoded value " <> show decoded <> 
                   "\n encoded value: " <> stringify encoded <> " doesn't match " <> stringify value 
                   )
             _ -> failure ("Failed to properly decode JSON string: " <> stringify value)
main :: Effect Unit
main = flip runReaderT 0 do 
  log "🍝"
--  testa fixtures
  test "Point" do
     for_ [point_, pointbbox_, point3d_] \p ->
       case decodeJson p of
           Right (decoded :: Point) ->
             let encoded = encodeJson decoded
             in
               if encoded == p 
               then pure unit
               else failure (
                 "decoded value " <> show decoded <> 
                 "\n encoded value: " <> stringify encoded <> " doesn't match " <> stringify p 
                 )
           _ -> failure ("Failed to properly decode JSON string: " <> stringify p)
  test "MultiPoint" do
     for_ [multipoint_, multipointbbox_, multipoint3d_] \p ->
       case decodeJson p of
           Right (decoded :: MultiPoint) ->
             let encoded = encodeJson decoded
             in
               if encoded == p 
               then pure unit
               else failure (
                 "decoded value " <> show decoded <> 
                 "\n encoded value: " <> stringify encoded <> " doesn't match " <> stringify p 
                 )
           _ -> failure ("Failed to properly decode JSON string: " <> stringify p)
  test "LineString" do
     for_ [linestring_, linestring3d_, linestringbbox_] \p ->
       case decodeJson p of
           Right (decoded :: LineString) ->
             let encoded = encodeJson decoded
             in
               if encoded == p 
               then pure unit
               else failure (
                 "decoded value " <> show decoded <> 
                 "\n encoded value: " <> stringify encoded <> " doesn't match " <> stringify p 
                 )
           _ -> failure ("Failed to properly decode JSON string: " <> stringify p)
