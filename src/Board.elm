module Board exposing (..)

import Array exposing (..)


create : Int -> List String
create size =
    List.repeat size ""


getCellValue : Int -> List String -> String
getCellValue index grid =
    grid
        |> Array.fromList
        |> Array.get index
        |> Maybe.withDefault ""


markBoard : Int -> List String -> String -> List String
markBoard index grid playerMark =
    grid
        |> Array.fromList
        |> Array.set index playerMark
        |> Array.toList
