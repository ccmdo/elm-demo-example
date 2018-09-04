module Update.Pokedex exposing (..)

import Model exposing (..)


resetPokedexSearch : Model -> ( Model, Cmd Msg )
resetPokedexSearch model =
    let
        oldPokedex =
            model.pokedex

        newPokedex =
            { oldPokedex | search = "", pokemon = Nothing, error = Nothing }
    in
        ( { model | pokedex = newPokedex }, Cmd.none )


updatePokedexSearch : String -> Model -> ( Model, Cmd Msg )
updatePokedexSearch newSearch model =
    let
        oldPokedex =
            model.pokedex

        newPokedex =
            { oldPokedex | search = newSearch }
    in
        ( { model | pokedex = newPokedex }, Cmd.none )
