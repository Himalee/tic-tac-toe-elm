module CellTest exposing (suite)

import Cell exposing (cellIsNotEmpty)
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "Cell"
        [ test "checks whether a cell is not empty" <|
            \() ->
                Expect.equal True <| cellIsNotEmpty "X"
        , test "checks whether a cell is empty" <|
            \() ->
                Expect.equal False <| cellIsNotEmpty ""
        ]
