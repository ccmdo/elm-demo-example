module Main exposing (main)

import Html exposing (Html, program)
import Captured

main =
  Html.program
    { init = Captured.init
    , update = Captured.update
    , view = Captured.view
    , subscriptions = (always Sub.none)
    }
