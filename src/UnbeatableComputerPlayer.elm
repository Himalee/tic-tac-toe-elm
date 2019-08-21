module UnbeatableComputerPlayer exposing (getBestMove)

import Array exposing (fromList, get)
import Board exposing (..)
import List.Extra exposing (find)
import Player exposing (..)


middleCellOn3x3Board =
    4


startingDepth =
    1


noScore =
    0


noIndex =
    0


getBestMove : Player -> List String -> Int
getBestMove currentPlayer board =
    if List.member middleCellOn3x3Board (availableMoves board) then
        middleCellOn3x3Board

    else
        findBestMove board currentPlayer startingDepth


findBestMove : List String -> Player -> Int -> Int
findBestMove board currentPlayer depth =
    let
        moves =
            availableMoves
                board

        scores =
            List.map
                (\move ->
                    let
                        newBoard =
                            markBoard move board (getMark currentPlayer)
                    in
                    getScore newBoard currentPlayer depth
                )
                moves
    in
    pickBestMoveOrHighestScore depth scores moves


getScore : List String -> Player -> Int -> Int
getScore board currentPlayer depth =
    if isGameOver board then
        -(scoreBoard board depth)

    else
        -(findBestMove board (switchPlayers currentPlayer) (depth + 1))


scoreBoard : List String -> Int -> Int
scoreBoard board depth =
    if isThereAWinner board then
        -(1000 // depth)

    else
        noScore


pickBestMoveOrHighestScore : Int -> List Int -> List Int -> Int
pickBestMoveOrHighestScore depth scores availableMoves =
    if depth == 1 then
        availableMoves
            |> Array.fromList
            |> Array.get (getIndex scores)
            |> Maybe.withDefault noScore

    else
        maxScore scores


getIndex : List Int -> Int
getIndex scores =
    scores
        |> List.indexedMap Tuple.pair
        |> List.Extra.find (\( index, score ) -> score == maxScore scores)
        |> Maybe.withDefault ( noIndex, noScore )
        |> getIndexOfBestScore


getIndexOfBestScore : ( Int, Int ) -> Int
getIndexOfBestScore ( index, score ) =
    index


maxScore : List Int -> Int
maxScore scores =
    scores
        |> List.maximum
        |> Maybe.withDefault noScore
