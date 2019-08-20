module Main exposing (..)

import Board exposing (..)
import Browser
import Cell exposing (cellIsNotEmpty)
import GameMode exposing (..)
import GameStatus exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Player exposing (..)
import RandomComputerPlayer exposing (getFirstIndexOfAvailableMove)
import UnbeatableComputerPlayer exposing (getBestMove)


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
    , gameMode : GameMode
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { board = create boardSize
      , currentPlayer = X
      , nextPlayer = O
      , gameStatus = GameModeNotChosen
      , gameMode = NotChosen
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = MarkBoard Int
    | SetGameMode GameMode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetGameMode mode ->
            ( { model
                | board = create boardSize
                , currentPlayer = X
                , nextPlayer = O
                , gameStatus = InPlay
                , gameMode = mode
              }
            , Cmd.none
            )

        MarkBoard index ->
            ( let
                nextBoard =
                    markBoard index model.board <| getMark model.currentPlayer

                currentPlayer =
                    model.currentPlayer

                nextPlayer =
                    switchPlayers model.currentPlayer

                gameMode =
                    model.gameMode
              in
              case model.gameMode of
                HumanvRandom ->
                    let
                        boardMarkedWithRandomMove =
                            markBoard (getFirstIndexOfAvailableMove nextBoard) nextBoard <| getMark nextPlayer
                    in
                    { model
                        | board = boardMarkedWithRandomMove
                        , gameStatus = getStatus boardMarkedWithRandomMove gameMode
                    }

                HumanvHard ->
                    let
                        boardMarkedWithHardMove =
                            markBoard (getBestMove nextPlayer nextBoard) nextBoard <| getMark nextPlayer
                    in
                    { model
                        | board = boardMarkedWithHardMove
                        , gameStatus = getStatus boardMarkedWithHardMove gameMode
                    }

                _ ->
                    { model
                        | board = nextBoard
                        , currentPlayer = nextPlayer
                        , nextPlayer = currentPlayer
                        , gameStatus = getStatus nextBoard gameMode
                    }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW HELPER


createBoardWithCells : List String -> GameMode -> List (Html Msg)
createBoardWithCells board gameMode =
    if gameMode /= NotChosen then
        board
            |> List.indexedMap Tuple.pair
            |> List.map
                (\( index, value ) ->
                    button [ onClick <| MarkBoard index, disabled <| cellIsNotEmpty value || isGameOver board, class "cell", id ("cell" ++ String.fromInt index) ] [ text <| value ]
                )

    else
        [ p [] [ text "" ] ]


getStatus : List String -> GameMode -> GameStatus
getStatus board gameMode =
    if isThereAWinner board then
        Winner

    else if isThereADraw board then
        Draw

    else if gameMode == NotChosen then
        GameModeNotChosen

    else
        InPlay


createGameModeButtons : GameMode -> List String -> List (Html Msg)
createGameModeButtons gameMode board =
    if gameMode == NotChosen || isGameOver board then
        [ viewGameModeButton HumanvHuman "humanvhuman"
        , viewGameModeButton HumanvRandom "humanvrandom"
        , viewGameModeButton HumanvHard "humanvhard"
        ]

    else
        [ p [] [ text "" ] ]


viewGameModeButton : GameMode -> String -> Html Msg
viewGameModeButton gameMode buttonId =
    button [ onClick <| SetGameMode gameMode, id buttonId, class "gameModeButton" ] [ text <| getGameMode gameMode ]



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
            [ h1 [ class "header" ]
                [ text "Welcome to Tic Tac Toe" ]
            ]
        , p [ class "gameStatus" ] [ text (getGameStatus model.gameStatus (winningMove model.board)) ]
        , div [ class "gridContainer" ]
            (createGameModeButtons model.gameMode model.board)
        , div [ class "gridContainer" ]
            (createBoardWithCells model.board model.gameMode)
        ]
    }
