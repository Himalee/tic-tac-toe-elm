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
        , test "gets value from board given index" <|
            \() ->
                Expect.equal "X" <| getCellValue 0 [ "X", "", "O" ]
        , test "marks board with player mark given index" <|
            \() ->
                Expect.equal [ "X", "", "O" ] <| markBoard 0 [ "", "", "O" ] "X"
        , test "checks whether a cell is not empty" <|
            \() ->
                Expect.equal True <| cellIsNotEmpty "X"
        , test "checks whether a cell is empty" <|
            \() ->
                Expect.equal False <| cellIsNotEmpty ""
        , test "size of board" <|
            \() ->
                Expect.equal 3 <| boardSize <| create 9
        ]
