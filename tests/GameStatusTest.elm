module GameStatusTest exposing (..)

import Expect
import GameStatus exposing (..)
import Player exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "GameStatus"
        [ test "gets game status when game is still in play" <|
            \() ->
                Expect.equal "Play!" <| getGameStatus InPlay (getMark X)
        , test "gets game status when X has won the game" <|
            \() ->
                Expect.equal "Player X wins!" <| getGameStatus Winner (getMark X)
        , test "gets game status when O has won the game" <|
            \() ->
                Expect.equal "Player O wins!" <| getGameStatus Winner (getMark O)
        , test "gets game status it is a draw" <|
            \() ->
                Expect.equal "It's a draw!" <| getGameStatus Draw (getMark O)
        , test "gets game status if a game mode has not been chosen" <|
            \() ->
                Expect.equal "Choose a game mode" <| getGameStatus GameModeNotChosen (getMark O)
        ]
