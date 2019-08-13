module Main exposing (..)

import Array exposing (..)
import Board exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Player exposing (..)


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
    , currentPlayer : Player
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { board = create boardSize
      , currentPlayer = X
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
                | board = markBoard index model.board <| getMark model.currentPlayer
                , currentPlayer = switchPlayers model.currentPlayer
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW HELPER


switchPlayers :
    Player
    -> Player
switchPlayers player =
    if player == X then
        O

    else
        X


createBoardWithButtons : List String -> List (Html Msg)
createBoardWithButtons board =
    board
        |> List.indexedMap Tuple.pair
        |> List.map createCell


createCell : ( Int, String ) -> Html Msg
createCell ( index, value ) =
    button [ onClick <| MarkBoard index, disabled <| cellIsNotEmpty value ] [ text <| value ]



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
