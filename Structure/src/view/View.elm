module View exposing (view)

import Html exposing (Html, div, text)
import Model exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ text "View" ]
