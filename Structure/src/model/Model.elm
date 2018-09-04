module Model exposing (..)

import Model.Pokedex as Pokedex exposing (..)
import Model.Pokemon as Pokemon exposing (..)
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
