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
        , test "size of board" <|
            \() ->
                Expect.equal 3 <| boardSize <| create 9
        ]
