module Line exposing (allWinningLines, containsTheSameMark)

import Array exposing (fromList)
import Cell exposing (emptyCell)
import List exposing (all, any)
import List.Extra exposing (groupsOf, transpose)
import Maybe exposing (withDefault)
import Player exposing (..)


containsTheSameMark : List String -> Bool
containsTheSameMark line =
    List.all ((==) (getMark X)) line || List.all ((==) (getMark O)) line


allWinningLines : List String -> List (List String)
allWinningLines board =
    rows board ++ columns board ++ diagonals board


diagonals : List String -> List (List String)
diagonals board =
    [ diagonalLine [] board 0 (boardSize board + 1)
    , diagonalLine [] board (boardSize board - 1) (boardSize board - 1)
    ]


diagonalLine : List String -> List String -> Int -> Int -> List String
diagonalLine line board currentIndex increaseIndexBy =
    let
        transformedBoard =
            Array.fromList board
    in
    if List.length line == boardSize board then
        line

    else
        diagonalLine (line ++ [ Maybe.withDefault emptyCell (Array.get currentIndex transformedBoard) ]) board (currentIndex + increaseIndexBy) increaseIndexBy


columns : List String -> List (List String)
columns board =
    board
        |> split (boardSize board)
        |> List.Extra.transpose


rows : List String -> List (List String)
rows board =
    board
        |> split (boardSize board)


split : Int -> List String -> List (List String)
split size board =
    List.Extra.groupsOf size board


boardSize : List String -> Int
boardSize grid =
    grid
        |> List.length
        |> toFloat
        |> sqrt
        |> round
