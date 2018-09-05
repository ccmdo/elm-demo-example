module Main exposing (main)

import Html
import Pokedex exposing (Msg, Pokedex)



-- MAIN


main : Program Never Pokedex Msg
main =
    Html.program
        { init = Pokedex.init
        , subscriptions = always Sub.none
        , update = Pokedex.update
        , view = Pokedex.view
        }
