module Update exposing (update)

import Model exposing (..)
import Update.Pokedex exposing (..)
import Update.Pokemon exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchPokemon ->
            Update.Pokemon.fetchPokemon model

        UpdatePokedexSearch newSearch ->
            Update.Pokedex.updatePokedexSearch newSearch model

        ResetPokedexSearch ->
            Update.Pokedex.resetPokedexSearch model

        LoadPokemon (Ok pokemon) ->
            Update.Pokemon.loadPokemonSuccess pokemon model

        LoadPokemon (Err error) ->
            Update.Pokemon.loadPokemonError error model
