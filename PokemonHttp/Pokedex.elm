module Pokedex exposing (..)

import Model.Pokemon as PokemonModel exposing (Pokemon, pokemonDecoder)
import View.Pokemon as PokemonView exposing (view)
import Html exposing (..)
import Html.Attributes exposing (class, src, type_, value, disabled)
import Html.Events exposing (onInput, onClick)
import Http

type alias Pokedex =
    { search : String
    , pokemon : Maybe Pokemon
    , error : Maybe String
    }

type Msg
    = UpdatePokedexSearch String
    | FetchPokemon
    | LoadPokemon (Result Http.Error Pokemon)
    | ResetPokedex
    | PokemonViewMsg PokemonView.Msg


-- INIT

initialPokedex : Pokedex
initialPokedex =
    Pokedex "" Nothing Nothing

init : (Pokedex, Cmd Msg)
init =
    ( initialPokedex
    , Cmd.none
    )

-- UPDATE

update : Msg -> Pokedex -> (Pokedex, Cmd Msg)
update msg pokedex =
    case msg of
        PokemonViewMsg _ ->
            (pokedex, Cmd.none)
        UpdatePokedexSearch newSearch ->
            ( newSearch |> asSearchIn pokedex, Cmd.none )
        FetchPokemon ->
            (pokedex, fetchPokemon pokedex.search)
        LoadPokemon result ->
            case result of
                Ok pokemon ->
                    ( { pokedex | pokemon = Just pokemon }, Cmd.none)
                Err _ ->
                    ( { pokedex | pokemon = Nothing, error = Just "Something went wrong." }, Cmd.none)
        ResetPokedex ->
            (initialPokedex, Cmd.none)


-- VIEWS
loadPokemonView : Pokedex -> Html Msg
loadPokemonView pokedex =
    div [ class "load-pokemon"]
        [ h4 [] [ text "Load pokemon" ]
        , label [] [ text "Pokemon name" ]
        , input
            [ type_ "text"
            , value pokedex.search
            , onInput UpdatePokedexSearch
            ]
            []
        , button
            [ disabled (pokedex.search == "") 
            , onClick FetchPokemon
            ]
            [ text "Search"]
        , p [] [ text pokedex.search ]
        , p [] [ text (Maybe.withDefault "" pokedex.error) ]
        ]

view : Pokedex -> Html Msg
view pokedex =
    case pokedex.pokemon of
        Just pokemon ->
            div []
            [ PokemonView.view pokemon |> Html.map PokemonViewMsg
            , button [ onClick ResetPokedex]
                [ text "Reset"]
            ]
        Nothing ->
            loadPokemonView pokedex    


-- FUNCTIONS

setSearch : String -> Pokedex -> Pokedex
setSearch newSearch pokedex =
    { pokedex | search = newSearch }

asSearchIn : Pokedex -> String -> Pokedex
asSearchIn =
    flip setSearch

fetchPokemon : String -> Cmd Msg
fetchPokemon name =
    let
        decoder =
            PokemonModel.pokemonDecoder
        url =
            "https://pokeapi.co/api/v2/pokemon/" ++ String.toLower(name) ++ "/"
        -- url =
        --     "http://localhost:4567/pokemon/name/" ++ name
    in
        Http.send LoadPokemon (Http.get url decoder)