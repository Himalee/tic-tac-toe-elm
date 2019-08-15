module BoardTest exposing (suite)

import Array exposing (fromList)
import Board exposing (..)
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "Board"
        [ test "creates List of 9 empty strings" <|
            \() ->
                Expect.equal [ "", "", "", "", "", "", "", "", "" ] <| create 9
        , test "marks board with player mark given index" <|
            \() ->
                Expect.equal [ "X", "", "O" ] <| markBoard 0 [ "", "", "O" ] "X"
        , test
            "checks if there is a winner - row"
          <|
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
