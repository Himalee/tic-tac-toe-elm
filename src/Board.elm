module Board exposing (..)

import Array exposing (fromList, set, toList)
import Cell exposing (emptyCell)
import Line exposing (allWinningLines, containsTheSameMark)
import List.Extra exposing (dropWhile, find)


defaultIndexIfCellIsNotEmpty =
    55


create : Int -> List String
create size =
    List.repeat size emptyCell


markBoard : Int -> List String -> String -> List String
markBoard index board playerMark =
    board
        |> Array.fromList
        |> Array.set index playerMark
        |> Array.toList


isThereAWinner : List String -> Bool
isThereAWinner board =
    board
        |> allWinningLines
        |> List.any containsTheSameMark


winningMove : List String -> String
winningMove board =
    board
        |> getWinningLine
        |> Array.fromList
        |> Array.get 0
        |> Maybe.withDefault emptyCell


getWinningLine : List String -> List String
getWinningLine board =
    board
        |> allWinningLines
        |> List.filter containsTheSameMark
        |> List.head
        |> Maybe.withDefault []


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
        |> List.Extra.dropWhile (\( index, value ) -> value /= emptyCell)
        |> List.map (\( index, value ) -> index)
