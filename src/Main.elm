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
              if model.gameMode == HumanvRandom then
                let
                    boardMarkedWithHumanMove =
                        markBoard index model.board <| getMark model.currentPlayer

                    boardMarkedWithRandomMove =
                        markBoard (getFirstIndexOfAvailableMove boardMarkedWithHumanMove) boardMarkedWithHumanMove <| getMark model.nextPlayer
                in
                { model
                    | board = boardMarkedWithRandomMove
                    , currentPlayer = currentPlayer
                    , nextPlayer = nextPlayer
                    , gameStatus = getStatus boardMarkedWithRandomMove gameMode
                }

              else
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


switchPlayers :
    Player
    -> Player
switchPlayers player =
    if player == X then
        O

    else
        X


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
        [ button [ onClick <| SetGameMode HumanvHuman, id "humanvhuman" ] [ text <| getGameMode HumanvHuman ]
        , button [ onClick <| SetGameMode HumanvRandom, id "humanvrandom" ] [ text <| getGameMode HumanvRandom ]
        ]

    else
        [ p [] [ text "" ] ]



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
        , div [ class "gridContainer" ]
            (createGameModeButtons model.gameMode model.board)
        , div [ class "gridContainer" ]
            (createBoardWithCells model.board model.gameMode)
        , p [ class "gameStatus" ] [ text (getGameStatus model.gameStatus (winningMove model.board)) ]
        ]
    }
