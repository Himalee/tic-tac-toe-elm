module RandomComputerPlayer exposing (getFirstIndexOfAvailableMove)

import Array exposing (fromList, get)
import Board exposing (availableMoves)
import Random exposing (..)


defaultRandomMove =
    0


getFirstIndexOfAvailableMove : List String -> Int
getFirstIndexOfAvailableMove board =
    Maybe.withDefault defaultRandomMove (Array.get 0 (Array.fromList (availableMoves board)))
