module Main exposing (main)

import Html exposing (Html, div, text)

type alias Model =
  { hello : String }

type Msg
  = NoOp

init : (Model, Cmd Msg)
init =
  ( Model "Hello World"
  , Cmd.none
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  div
    []
    [ text model.hello]

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }