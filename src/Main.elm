module Main exposing (..)

import Array exposing (..)
import Board exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


boardSize =
    9


main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { board : List String
    , currentMark : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { board = create boardSize
      , currentMark = "X"
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = MarkBoard Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MarkBoard index ->
            ( { model
                | board = markBoard index model.board model.currentMark
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW HELPER


createBoardWithButtons : List String -> List (Html Msg)
createBoardWithButtons board =
    board
        |> List.indexedMap Tuple.pair
        |> List.map createCell


createCell : ( Int, String ) -> Html Msg
createCell ( index, value ) =
    button [ onClick <| MarkBoard index, disabled False ] [ text <| value ]



-- VIEW


type alias Document msg =
    { title : String
    , body : List (Html msg)
    }


view : Model -> Document Msg
view model =
    { title = "Tic Tac Toe"
    , body =
        [ div []
            [ h1 []
                [ text "Welcome to Tic Tac Toe" ]
            ]
        , div [ class "gridContainer" ]
            (createBoardWithButtons model.board)
        ]
    }
