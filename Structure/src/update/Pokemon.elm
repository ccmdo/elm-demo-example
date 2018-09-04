module Update.Pokemon exposing (..)

import Http
import Model exposing (..)
import Model.Pokemon as Pokemon exposing (..)
import PokemonDecoder exposing (..)


loadPokemonSuccess : Pokemon -> Model -> ( Model, Cmd Msg )
loadPokemonSuccess pokemon model =
    let
        oldPokedex =
            model.pokedex

        newPokedex =
            { oldPokedex | pokemon = Just pokemon, error = Nothing }
    in
        ( { model | pokedex = newPokedex }, Cmd.none )


loadPokemonError : Http.Error -> Model -> ( Model, Cmd Msg )
loadPokemonError error model =
    let
        oldPokedex =
            model.pokedex

        newPokedex =
            { oldPokedex | pokemon = Nothing, error = Just (toString error) }
    in
        ( { model | pokedex = newPokedex }, Cmd.none )


fetchPokemon : Model -> ( Model, Cmd Msg )
fetchPokemon model =
    ( model, PokemonDecoder.httpRequest model.pokedex.search )
