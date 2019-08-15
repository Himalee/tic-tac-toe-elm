module Main exposing (..)

import Board exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Line exposing (isGameOver, isThereADraw, isThereAWinner)
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
    , gameStatus : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { board = create boardSize
      , currentPlayer = X
      , gameStatus = "keep playing"
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
                , gameStatus = getStatus nextBoard currentPlayer
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


createBoardWithCells : List String -> Player -> List (Html Msg)
createBoardWithCells board player =
    board
        |> List.indexedMap Tuple.pair
        |> List.map (\( index, value ) -> button [ onClick <| MarkBoard index, disabled <| cellIsNotEmpty value || isGameOver board player, class "cell" ] [ text <| value ])



-- createCell : ( Int, String ) -> Html Msg
-- createCell ( index, value ) =
--     button [ onClick <| MarkBoard index, disabled <| cellIsNotEmpty value, class "cell" ] [ text <| value ]


getStatus : List String -> Player -> String
getStatus board player =
    if isThereAWinner board player == True then
        "Player " ++ getMark player ++ " wins!"

    else if isThereADraw board player == True then
        "It's a draw!"

    else
        "Keep playing"



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
            (createBoardWithCells model.board (switchPlayers model.currentPlayer))
        , p [ class "gameStatus" ] [ text model.gameStatus ]
        ]
    }
