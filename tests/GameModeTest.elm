module GameModeTest exposing (..)

import Expect
import GameMode exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "GameMode"
        [ test "gets human v human game mode" <|
            \() ->
                Expect.equal "Human vs Human" <| getGameMode HumanvHuman
        , test "gets human v random game mode" <|
            \() ->
                Expect.equal "Human vs Random" <| getGameMode HumanvRandom
        , test "gets human v hard game mode" <|
            \() ->
                Expect.equal "Human vs Hard" <| getGameMode HumanvHard
        , test "gets an empty string when a game mode has not been chosen" <|
            \() ->
                Expect.equal "" <| getGameMode NotChosen
        ]
