module View.Pokemon exposing (view)

import Html exposing (Html, div, text)
import Model exposing (..)
import Model.Pokemon exposing (..)


view : Pokemon -> Html Msg
view pokemon =
    div
        []
        [ text (toString pokemon.id)
        , text ": "
        , text pokemon.name
        ]
