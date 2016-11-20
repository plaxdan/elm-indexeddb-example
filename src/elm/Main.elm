port module Main exposing (..)

import Html exposing (Html, h1, h3, div, br, hr, text, button, input)
import Html.Attributes exposing (value, placeholder, style)
import Html.Events exposing (onClick, onInput)
import Services.Storage as Storage


type alias Model =
    { question : String
    , answer : String
    }


type Msg
    = SetQuestion String
    | AskQuestion
    | ReceiveAnswer String
    | SaveTuple
    | SaveRecord
    | SaveList


init : ( Model, Cmd Msg )
init =
    ( Model "" "", Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "IndexedDB Example" ]
        , h3 [ style [ ( "font-style", "italic" ) ] ] [ text "Using LocalForage" ]
        , input
            [ onInput SetQuestion
            , value model.question
            , placeholder "What is your question?"
            ]
            []
        , button [ onClick AskQuestion ] [ text "Ask JavaScript!" ]
        , hr [] []
        , text <| toString model
        , hr [] []
        , button [ onClick SaveTuple ] [ text "Save as Tuple" ]
        , br [] []
        , button [ onClick SaveRecord ] [ text "Save as Record" ]
        , br [] []
        , button [ onClick SaveList ] [ text "Save as List" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetQuestion str ->
            ( Model str model.answer, Cmd.none )

        AskQuestion ->
            ( model, sendPrompt model.question )

        ReceiveAnswer str ->
            ( Model model.question str, Cmd.none )

        SaveList ->
            let
                payload =
                    { key = "elm/question/array"
                    , value = [ model.question, model.answer ]
                    }
            in
                ( model, Storage.saveArray payload )

        SaveTuple ->
            let
                key =
                    "elm/question/tuple"

                value =
                    "Question: "
                        ++ model.question
                        ++ ", Answer: "
                        ++ model.answer

                payload =
                    ( key, value )
            in
                ( model, Storage.saveTuple payload )

        SaveRecord ->
            let
                payload =
                    { key = "elm/question/record"
                    , value =
                        { question = model.question
                        , answer = model.answer
                        }
                    }
            in
                ( model, Storage.saveRecord payload )


subscriptions : Model -> Sub Msg
subscriptions model =
    receivePrompt ReceiveAnswer


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


port receivePrompt : (String -> msg) -> Sub msg


port sendPrompt : String -> Cmd msg
