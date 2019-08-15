module Board exposing (..)

import Array exposing (..)
import Cell exposing (emptyCell)


create : Int -> List String
create size =
    List.repeat size emptyCell


markBoard : Int -> List String -> String -> List String
markBoard index grid playerMark =
    grid
        |> Array.fromList
        |> Array.set index playerMark
        |> Array.toList


boardSize : List String -> Int
boardSize grid =
    grid
        |> List.length
        |> toFloat
        |> sqrt
        |> round
