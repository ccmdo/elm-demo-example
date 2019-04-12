module Page.Character exposing (Model, Msg, init, subscriptions, update, view)

import Character exposing (Character)
import Html exposing (Html, text)
import Http



-- MODEL


type alias Model =
    { character : Status Character }


type Status a
    = Loading
    | Loaded a
    | Failed


initialCharacterToLoad =
    -- For testing
    "ccmdo"


init : () -> ( Model, Cmd Msg )
init () =
    ( { character = Loading }
    , Character.fetch initialCharacterToLoad
        |> Http.send CompletedLoadCharacter
    )



-- VIEW


view : Model -> Html Msg
view model =
    case model.character of
        Loaded character ->
            viewCharacter character

        Loading ->
            text "Loading"

        Failed ->
            text "Error loading character"


viewCharacter : Character -> Html Msg
viewCharacter character =
    text (Character.name character)



-- UPDATE


type Msg
    = CompletedLoadCharacter (Result Http.Error Character)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CompletedLoadCharacter (Ok character) ->
            ( { model | character = Loaded character }, Cmd.none )

        CompletedLoadCharacter (Err error) ->
            ( { model | character = Failed }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
