module Main exposing (main)

import Html exposing (Html, program)
import Captured


-- MAIN

main : Program Never Captured.Model Captured.Msg
main =
    Html.program
        { init = Captured.init
        , update = Captured.update
        , view = Captured.view
        , subscriptions = (always Sub.none)
        }
