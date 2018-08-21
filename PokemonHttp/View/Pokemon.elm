module View.Pokemon exposing (Msg, view)

import Model.Pokemon as Pokemon exposing(Pokemon)
import Html exposing (Html, div, h3, text)

type Msg =
  NoOp

view : Pokemon -> Html Msg
view pokemon =
    let 
        displayName =
            (toString pokemon.id) ++ " : " ++ pokemon.name
    in
        div []
            [ div []
                [ h3 [] [ text displayName]]
            ]