module View.Pokedex exposing (resetButton, view)

import Html exposing (Html, div, button, text, h4, label, input, p)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (src, type_, value, disabled)
import Model exposing (..)
import Model.Pokedex as Pokedex exposing (..)


resetButton : Html Msg
resetButton =
    div
        []
        [ button
            [ onClick ResetPokedexSearch ]
            [ text "Reset" ]
        ]


view : Pokedex -> Html Msg
view pokedex =
    div []
        [ h4 [] [ text "Load pokemon" ]
        , label [] [ text "Pokemon name" ]
        , input
            [ type_ "text"
            , value pokedex.search
            , onInput UpdatePokedexSearch
            ]
            []
        , button
            [ disabled (pokedex.search == "")
            , onClick FetchPokemon
            ]
            [ text "Search" ]
        , p [] [ text pokedex.search ]
        , p [] [ text (Maybe.withDefault "" pokedex.error) ]
        ]
