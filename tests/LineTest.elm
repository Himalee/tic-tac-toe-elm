module LineTest exposing (suite)

import Expect
import Line exposing (isGameOver, isThereADraw, isThereAWinner)
import Player exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "Line"
        [ test "checks if there is a winner - row" <|
            \() ->
                Expect.equal True <| isThereAWinner [ "X", "X", "X", "", "", "", "", "", "" ]
        , test "checks if there is a winner - column" <|
            \() ->
                Expect.equal True <| isThereAWinner [ "O", "", "X", "O", "", "", "O", "", "" ]
        , test "checks if there is a winner - diagonal" <|
            \() ->
                Expect.equal True <| isThereAWinner [ "O", "", "X", "", "O", "", "", "", "O" ]
        , test "checks if the board result is a draw" <|
            \() ->
                Expect.equal True <| isThereADraw [ "X", "O", "X", "O", "O", "X", "X", "X", "O" ]
        , test "checks if the game has ended" <|
            \() ->
                Expect.equal True <| isGameOver [ "X", "X", "X", "", "", "", "", "", "" ]
        ]
