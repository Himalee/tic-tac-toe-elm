module UnbeatableComputerPlayerTest exposing (suite)

import Expect
import Player exposing (..)
import Test exposing (..)
import UnbeatableComputerPlayer exposing (getBestMove)


suite : Test
suite =
    describe "Unbeatable Computer Player"
        [ test "gets last remaining move which results in a win" <|
            \() ->
                Expect.equal 2 <| getBestMove X [ "X", "X", "", "O", "O", "X", "X", "O", "O" ]
        , test "gets last remaining move which results in a win for O" <|
            \() ->
                Expect.equal 2 <| getBestMove O [ "O", "O", "", "X", "X", "O", "O", "X", "X" ]
        , test "gets last remaining move which results in a draw" <|
            \() ->
                Expect.equal 6 <| getBestMove X [ "X", "O", "X", "O", "O", "X", "", "X", "O" ]
        , test "gets winning move with 3 moves remaining" <|
            \() ->
                Expect.equal 1 <| getBestMove X [ "X", "", "X", "O", "O", "X", "", "", "O" ]
        , test "gets winning move with 5 moves remaining" <|
            \() ->
                Expect.equal 4 <| getBestMove X [ "O", "X", "", "", "", "", "", "X", "O" ]
        , test "X picks move to block O from winning" <|
            \() ->
                Expect.equal 2 <| getBestMove X [ "O", "O", "", "X", "", "", "", "X", "" ]
        , test "O picks move to block X from winning" <|
            \() ->
                Expect.equal 2 <| getBestMove O [ "X", "X", "", "O", "", "", "", "O", "" ]
        , test "O picks move to win vs move to block X from winning" <|
            \() ->
                Expect.equal 6 <| getBestMove O [ "X", "X", "", "", "", "", "", "O", "O" ]
        ]
