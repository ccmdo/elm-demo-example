module Update exposing (update)

import Model exposing (..)
import PokemonDecoder


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchPokemon ->
            ( model, PokemonDecoder.httpRequest model.pokedex.search )

        UpdatePokedexSearch newSearch ->
            let
                oldPokedex =
                    model.pokedex

                newPokedex =
                    { oldPokedex | search = newSearch }
            in
                ( { model | pokedex = newPokedex }, Cmd.none )
        ResetPokedexSearch ->
                let
                    oldPokedex =
                        model.pokedex

                    newPokedex =
                        { oldPokedex | search = "", pokemon = Nothing, error = Nothing }
                in
                    ( { model | pokedex = newPokedex }, Cmd.none )

        LoadPokemon (Ok pokemon) ->
            let
                oldPokedex =
                    model.pokedex

                newPokedex =
                    { oldPokedex | pokemon = Just pokemon, error = Nothing }
            in
                ( { model | pokedex = newPokedex }, Cmd.none )

        LoadPokemon (Err error) ->
            let
                oldPokedex =
                    model.pokedex

                newPokedex =
                    { oldPokedex | pokemon = Nothing, error = Just (toString error) }
            in
                ( { model | pokedex = newPokedex }, Cmd.none )
