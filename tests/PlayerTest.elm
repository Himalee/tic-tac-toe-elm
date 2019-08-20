module PlayerTest exposing (..)

import Expect
import Player exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "Player"
        [ test "gets mark for player X" <|
            \() ->
                Expect.equal "X" <| getMark X
        , test "gets mark for player O" <|
            \() ->
                Expect.equal "O" <| getMark O
        , test "switches players from X to O" <|
            \() ->
                Expect.equal O <| switchPlayers X
        , test "switches players from O to X" <|
            \() ->
                Expect.equal X <| switchPlayers O
        ]
