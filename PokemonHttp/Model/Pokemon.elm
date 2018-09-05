module Model.Pokemon exposing (Pokemon, pokemonDecoder)

import Json.Decode exposing (..)



-- MODEL


type alias Pokemon =
    { id : Int
    , name : String
    }



-- DECODER


pokemonDecoder : Decoder Pokemon
pokemonDecoder =
    map2
        Pokemon
        (field "id" int)
        (field "name" string)
