module SeperateModel exposing (..)

import Html exposing (Html, div, text)


-- MODEL


type alias Model =
    { hello : String }


initialModel : Model
initialModel =
    Model "Hello World"


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- MESSAGES


type Msg
    = DoesNothing



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoesNothing ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ text model.hello ]
