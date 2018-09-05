module Main exposing (main)

import Captured
import Html exposing (Html, program)



-- MAIN


main : Program Never Captured.Model Captured.Msg
main =
    Html.program
        { init = Captured.init
        , update = Captured.update
        , view = Captured.view
        , subscriptions = always Sub.none
        }
