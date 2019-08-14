module Board exposing (..)

import Array exposing (..)


emptyString =
    ""


create : Int -> List String
create size =
    List.repeat size emptyString


getCellValue : Int -> List String -> String
getCellValue index grid =
    grid
        |> Array.fromList
        |> Array.get index
        |> Maybe.withDefault emptyString


markBoard : Int -> List String -> String -> List String
markBoard index grid playerMark =
    grid
        |> Array.fromList
        |> Array.set index playerMark
        |> Array.toList


cellIsNotEmpty : String -> Bool
cellIsNotEmpty value =
    value /= emptyString


boardSize : List String -> Int
boardSize grid =
    grid
        |> List.length
        |> toFloat
        |> sqrt
        |> round
