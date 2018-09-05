module PokemonDecoder exposing (decoder, httpRequest)

import Http
import Json.Decode exposing (..)
import Model exposing (..)
import Model.Pokemon as Pokemon exposing (..)


httpRequest : String -> Cmd Msg
httpRequest search =
    let
        url =
            "https://pokeapi.co/api/v2/pokemon/" ++ String.toLower search ++ "/"
    in
    Http.send LoadPokemon (Http.get url decoder)


decoder : Decoder Pokemon
decoder =
    map2
        Pokemon
        (field "id" int)
        (field "name" string)
