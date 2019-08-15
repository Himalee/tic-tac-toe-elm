module LineTest exposing (suite)

import Expect
import Line exposing (allWinningLines, containsTheSameMark)
import Player exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "Line"
        [ test "checks if a line contains the same player mark" <|
            \() ->
                Expect.equal True <| containsTheSameMark [ "X", "X", "X" ]
        , test "checks if line is empty and does not contain the same player mark" <|
            \() ->
                Expect.equal False <| containsTheSameMark [ "", "", "" ]
        , test "gets all potential winning lines" <|
            \() ->
                Expect.equal
                    [ [ "O", "", "X" ]
                    , [ "", "O", "" ]
                    , [ "", "", "O" ]
                    , [ "O", "", "" ]
                    , [ "", "O", "" ]
                    , [ "X", "", "O" ]
                    , [ "O", "O", "O" ]
                    , [ "X", "O", "" ]
                    ]
                <|
                    allWinningLines
                        [ "O"
                        , ""
                        , "X"
                        , ""
                        , "O"
                        , ""
                        , ""
                        , ""
                        , "O"
                        ]
        ]
