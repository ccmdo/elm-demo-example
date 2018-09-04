module View exposing (view)

import Html exposing (Html, div, text, h4, label, input, p, button)
import Html.Attributes exposing (src, type_, value, disabled)
import Html.Events exposing (onInput, onClick)
import Model exposing (..)


view : Model -> Html Msg
view model =
    case model.pokedex.pokemon of
        Just pokemon ->
            div []
                [ text (toString pokemon.id )
                , text ": "
                , text pokemon.name
                ]

        Nothing ->
            div []
                [ h4 [] [ text "Load pokemon" ]
                , label [] [ text "Pokemon name" ]
                , input
                    [ type_ "text"
                    , value model.pokedex.search
                    , onInput UpdatePokedexSearch
                    ]
                    []
                , button
                    [ disabled (model.pokedex.search == "")
                    , onClick FetchPokemon
                    ]
                    [ text "Search" ]
                , p [] [ text model.pokedex.search ]
                , p [] [ text (Maybe.withDefault "" model.pokedex.error) ]
                ]
