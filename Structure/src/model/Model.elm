module Model exposing (Model, Msg(..), init)

import Http
import Model.Pokedex as Pokedex exposing (..)
import Model.Pokemon as Pokemon exposing (..)


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
