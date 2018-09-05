module Captured exposing (Ball(..), BallHPFactor(..), Captured(..), Model, Msg(..), Status(..), StatusFactor(..), ballHPFactorValueFromBall, ballRNGCmd, ballRNGGenerator, ballRNGLimitValueFromBall, emptyModel, init, statusFactorValueFromStatus, statusValueFromStatusFactor, update, updateBall, updateStatus, view, wasItCaptured)

import Html exposing (Html, br, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Random
import Select



-- MODEL


type alias Model =
    { ball : Ball
    , ballHPFactor : BallHPFactor
    , ballRNG : Int
    , status : Status
    , statusFactor : StatusFactor
    , catchRate : Int
    , currentHP : Int
    , maxHP : Int
    , captured : Captured
    }


type Ball
    = Pokeball
    | Greatball
    | Ultraball
    | Masterball


type BallHPFactor
    = PokeballHPFactor
    | GreatballHPFactor
    | NoBallHPFactor


type Status
    = Asleep
    | Burned
    | Frozen
    | Paralysed
    | Poisoned
    | NoStatus


type StatusFactor
    = HighStatusFactor
    | MidStatusFactor
    | NoStatusFactor


type Captured
    = Caught
    | Escaped


emptyModel : Model
emptyModel =
    { ball = Pokeball
    , ballHPFactor = PokeballHPFactor
    , ballRNG = 0
    , status = NoStatus
    , statusFactor = NoStatusFactor
    , catchRate = 255
    , currentHP = 100
    , maxHP = 100
    , captured = Escaped
    }


init : ( Model, Cmd Msg )
init =
    ( emptyModel
    , ballRNGCmd Pokeball
    )



-- MESSAGES


type Msg
    = NewBall Ball
    | NewStatus Status
    | Throw
    | UpdateBallRNGValue Int



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewBall newBall ->
            let
                newModel =
                    updateBall newBall model
            in
            ( newModel, ballRNGCmd newBall )

        NewStatus newStatus ->
            let
                newModel =
                    updateStatus newStatus model
            in
            ( newModel, Cmd.none )

        Throw ->
            let
                newModel =
                    wasItCaptured model
            in
            ( newModel, Cmd.none )
                |> Debug.log "update.result"

        UpdateBallRNGValue ballRNGValue ->
            let
                newModel =
                    { model | ballRNG = ballRNGValue }
            in
            ( newModel, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        balls =
            [ Pokeball, Greatball, Ultraball, Masterball ]

        statuses =
            [ NoStatus, Asleep, Burned, Frozen, Paralysed, Poisoned ]
    in
    div
        [ style [ ( "padding", "5rem" ) ] ]
        [ text <| "Calculator"
        , br [] []
        , Select.from balls NewBall
        , Select.from statuses NewStatus
        , button [ onClick Throw ] [ text "Throw" ]
        ]



-- FUNCTIONS


ballRNGCmd : Ball -> Cmd Msg
ballRNGCmd ball =
    Random.generate UpdateBallRNGValue (ballRNGGenerator ball)


ballRNGGenerator : Ball -> Random.Generator Int
ballRNGGenerator ball =
    let
        upperLimit =
            ballRNGLimitValueFromBall ball
    in
    Random.int 0 upperLimit


ballRNGLimitValueFromBall : Ball -> Int
ballRNGLimitValueFromBall ball =
    case ball of
        Pokeball ->
            255

        Greatball ->
            200

        Ultraball ->
            150

        _ ->
            0


statusValueFromStatusFactor : StatusFactor -> Int
statusValueFromStatusFactor statusFactor =
    case statusFactor of
        HighStatusFactor ->
            25

        MidStatusFactor ->
            12

        _ ->
            0


wasItCaptured : Model -> Model
wasItCaptured model =
    case model.ball of
        Masterball ->
            { model | captured = Caught }

        _ ->
            let
                calculation_r_star =
                    model.ballRNG - statusValueFromStatusFactor model.statusFactor
            in
            case calculation_r_star < 0 of
                True ->
                    { model | captured = Caught }

                _ ->
                    case model.catchRate < calculation_r_star of
                        True ->
                            { model | captured = Escaped }

                        _ ->
                            let
                                newModel =
                                    ballRNGCmd model.ball
                                        |> Debug.log "model.ball"
                            in
                            model
                                |> Debug.log "newModel"


updateBall : Ball -> Model -> Model
updateBall ball model =
    let
        ballHPFactorValue =
            ballHPFactorValueFromBall ball
    in
    { model | ball = ball, ballHPFactor = ballHPFactorValue }


ballHPFactorValueFromBall : Ball -> BallHPFactor
ballHPFactorValueFromBall ball =
    case ball of
        Pokeball ->
            PokeballHPFactor

        Greatball ->
            GreatballHPFactor

        _ ->
            NoBallHPFactor


updateStatus : Status -> Model -> Model
updateStatus status model =
    let
        statusFactorValue =
            statusFactorValueFromStatus status
    in
    { model | status = status, statusFactor = statusFactorValue }


statusFactorValueFromStatus : Status -> StatusFactor
statusFactorValueFromStatus status =
    case status of
        NoStatus ->
            NoStatusFactor

        Asleep ->
            HighStatusFactor

        Frozen ->
            HighStatusFactor

        _ ->
            MidStatusFactor
