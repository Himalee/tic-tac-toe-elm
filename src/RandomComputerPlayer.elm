module RandomComputerPlayer exposing (getFirstIndexOfAvailableMove)

import Array exposing (fromList, get)
import Board exposing (availableMoves)


defaultRandomMove =
    0


getFirstIndexOfAvailableMove : List String -> Int
getFirstIndexOfAvailableMove board =
    board
        |> availableMoves
        |> Array.fromList
        |> Array.get 0
        |> Maybe.withDefault defaultRandomMove
