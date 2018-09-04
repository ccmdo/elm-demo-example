module Model exposing (..)

import Pokedex exposing (..)
import Pokemon exposing (..)
import Http


type Msg
    = NoOp
    | FetchPokemon
    | LoadPokemon (Result Http.Error Pokemon)
    | ResetPokedexSearch
    | UpdatePokedexSearch String


type alias Model =
    { pokedex : Pokedex }


init : ( Model, Cmd Msg )
init =
    ( { pokedex = Pokedex.newPokedex }, Cmd.none )
