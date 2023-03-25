{ name = "geojson"
, license = "MIT"
, repository = "https://github.com/sumew/purescript-geojson"
, dependencies =
  [ "argonaut"
  , "argonaut-codecs"
  , "arrays"
  , "console"
  , "effect"
  , "either"
  , "exceptions"
  , "foldable-traversable"
  , "foreign-object"
  , "maybe"
  , "nonempty"
  , "prelude"
  , "transformers"
  , "tuples"
  , "typelevel-prelude"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
