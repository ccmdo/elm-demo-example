module View.Pokemon exposing (Msg, view)

import Html exposing (Html, div, h3, text)
import Model.Pokemon as Pokemon exposing (Pokemon)



-- MESSAGES


type Msg
    = NoOp



-- VIEW


view : Pokemon -> Html Msg
view pokemon =
    let
        displayName =
            toString pokemon.id ++ " : " ++ pokemon.name
    in
    div []
        [ div []
            [ h3 [] [ text displayName ] ]
        ]
