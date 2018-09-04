module Main exposing (main)

import Html exposing (Html)
import SeperateModel


-- MAIN


main : Program Never SeperateModel.Model SeperateModel.Msg
main =
    Html.program
        { init = SeperateModel.init
        , view = SeperateModel.view
        , update = SeperateModel.update
        , subscriptions = always Sub.none
        }
