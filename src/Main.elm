module Main exposing (..)

import Board exposing (..)
import Browser
import Cell exposing (cellIsNotEmpty)
import GameStatus exposing (..)
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
    , nextPlayer : Player
    , gameStatus : GameStatus
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { board = create boardSize
      , currentPlayer = X
      , nextPlayer = O
      , gameStatus = InPlay
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
            ( let
                nextBoard =
                    markBoard index model.board <| getMark model.currentPlayer

                currentPlayer =
                    model.currentPlayer

                nextPlayer =
                    switchPlayers model.currentPlayer
              in
              { model
                | board = nextBoard
                , currentPlayer = nextPlayer
                , nextPlayer = currentPlayer
                , gameStatus = getStatus nextBoard
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


createBoardWithCells : List String -> List (Html Msg)
createBoardWithCells board =
    board
        |> List.indexedMap Tuple.pair
        |> List.map (\( index, value ) -> button [ onClick <| MarkBoard index, disabled <| cellIsNotEmpty value || isGameOver board, class "cell" ] [ text <| value ])


getStatus : List String -> GameStatus
getStatus board =
    if isThereAWinner board == True then
        Winner

    else if isThereADraw board == True then
        Draw

    else
        InPlay



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
            [ h1 [ class "textContent" ]
                [ text "Welcome to Tic Tac Toe" ]
            ]
        , div [ class "gridContainer" ]
            (createBoardWithCells model.board)
        , p [ class "gameStatus" ] [ text (getGameStatus model.gameStatus model.nextPlayer) ]
        ]
    }
