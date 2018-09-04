module Pokedex exposing (..)

import Pokemon exposing (..)


type alias Pokedex =
    { search : String
    , pokemon : Maybe Pokemon
    , error : Maybe String
    }


newPokedex : Pokedex
newPokedex =
    Pokedex
        ""
        Nothing
        Nothing
