module Board exposing (..)

import Array exposing (fromList, set, toList)
import Cell exposing (emptyCell)
import Line exposing (allWinningLines, containsTheSameMark)
import List.Extra exposing (dropWhile)


defaultIndexIfCellIsNotEmpty =
    55


create : Int -> List String
create size =
    List.repeat size emptyCell


markBoard : Int -> List String -> String -> List String
markBoard index grid playerMark =
    grid
        |> Array.fromList
        |> Array.set index playerMark
        |> Array.toList


isThereAWinner : List String -> Bool
isThereAWinner board =
    board
        |> allWinningLines
        |> List.any containsTheSameMark


isThereADraw : List String -> Bool
isThereADraw board =
    not (isThereAWinner board) && List.all ((/=) emptyCell) board


isGameOver : List String -> Bool
isGameOver board =
    isThereAWinner board || isThereADraw board


availableMoves : List String -> List Int
availableMoves board =
    board
        |> List.indexedMap Tuple.pair
        |> List.map getIndexIfValueIsEmpty
        |> List.Extra.dropWhile ((==) defaultIndexIfCellIsNotEmpty)


getIndexIfValueIsEmpty : ( Int, String ) -> Int
getIndexIfValueIsEmpty ( index, value ) =
    if value == emptyCell then
        index

    else
        defaultIndexIfCellIsNotEmpty
