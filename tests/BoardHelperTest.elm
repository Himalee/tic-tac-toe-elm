module BoardHelperTest exposing (suite)

import Array exposing (fromList)
import Expect
import Helpers.BoardHelper exposing (create)
import Test exposing (..)


suite : Test
suite =
    describe "Board Helper"
        [ test "creates Array of 9 empty strings" <|
            \() ->
                Expect.equal (create 9) (Array.fromList [ "", "", "", "", "", "", "", "", "" ])
        ]
