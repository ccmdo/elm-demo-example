module Model exposing (..)

import Pokedex exposing (..)


type Msg
    = NoOp


type alias Model =
    { pokedex : Pokedex }


init : ( Model, Cmd Msg )
init =
    ( { pokedex = Pokedex.newPokedex }, Cmd.none )
