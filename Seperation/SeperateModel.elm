module SeperateModel exposing (..)

import Html exposing (Html, div, text)

type alias Model =
  { hello : String }

type Msg
  = DoesNothing

initialModel : Model
initialModel =
  Model "Hello World"

init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    DoesNothing ->
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  div
    []
    [ text model.hello ]