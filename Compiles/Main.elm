module Main exposing (main)

import Html exposing (Html, div, text)



-- MODEL


type alias Model =
    { hello : String }


init : ( Model, Cmd Msg )
init =
    ( Model "Hello World"
    , Cmd.none
    )



-- MESSAGES


type Msg
    = NoOp



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ text model.hello ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
