module RandomComputerPlayerTest exposing (suite)

import Expect
import RandomComputerPlayer exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "Random Computer Player"
        [ test "gets first available move" <|
            \() ->
                Expect.equal 1 <| getFirstIndexOfAvailableMove [ "X", "", "O", "", "", "X", "", "O", "X" ]
        ]
