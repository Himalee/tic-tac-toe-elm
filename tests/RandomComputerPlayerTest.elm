module RandomComputerPlayerTest exposing (suite)

import Expect
import RandomComputerPlayer exposing (getFirstIndexOfAvailableMove)
import Test exposing (..)


suite : Test
suite =
    describe "RandomComputerPlayer"
        [ test "gets first available move" <|
            \() ->
                Expect.equal 1 <| getFirstIndexOfAvailableMove [ "X", "", "O", "", "", "X", "", "O", "X" ]
        ]
