module View exposing (view)

import Html exposing (Html, div)
import Model exposing (..)
import View.Pokemon exposing (..)
import View.Pokedex exposing (..)


view : Model -> Html Msg
view model =
    case model.pokedex.pokemon of
        Just pokemon ->
            div []
                [ View.Pokemon.view pokemon
                , View.Pokedex.resetButton
                ]

        Nothing ->
            div []
                [ View.Pokedex.view model.pokedex ]
