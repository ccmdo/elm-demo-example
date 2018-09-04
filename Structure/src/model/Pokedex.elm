module Model.Pokedex exposing (..)

import Model.Pokemon as Pokemon exposing (..)


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
