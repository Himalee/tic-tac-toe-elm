module UnbeatableComputerPlayer exposing (getBestMove)

import Array exposing (fromList, get)
import Board exposing (..)
import List.Extra exposing (find)
import Player exposing (..)


getBestMove : Player -> List String -> Int
getBestMove currentPlayer board =
    let
        depth =
            1

        scores =
            scoreAvailableMoves board currentPlayer depth

        moves =
            availableMoves board
    in
    pickBestMoveOrHighestScore depth scores moves


scoreAvailableMoves : List String -> Player -> Int -> List Int
scoreAvailableMoves board currentPlayer depth =
    let
        moves =
            availableMoves
                board
    in
    List.map
        (\move ->
            let
                newBoard =
                    markBoard move board (getMark currentPlayer)
            in
            getScore newBoard currentPlayer depth
        )
        moves


getScore : List String -> Player -> Int -> Int
getScore board currentPlayer depth =
    if isGameOver board then
        scoreBoard
            board
            depth
            * -1

    else
        0


scoreBoard : List String -> Int -> Int
scoreBoard board depth =
    if isThereAWinner board then
        (1000 // depth) * -1

    else
        0


pickBestMoveOrHighestScore : Int -> List Int -> List Int -> Int
pickBestMoveOrHighestScore depth scores availableMoves =
    if depth == 1 then
        Maybe.withDefault 0 (Array.get (getIndex scores) (Array.fromList availableMoves))

    else
        maxScore scores


getIndex : List Int -> Int
getIndex scores =
    scores
        |> List.indexedMap Tuple.pair
        |> List.Extra.find (\( index, score ) -> score == maxScore scores)
        |> Maybe.withDefault ( 0, 0 )
        |> getIndexOfBestScore


getIndexOfBestScore : ( Int, Int ) -> Int
getIndexOfBestScore ( index, score ) =
    index


maxScore : List Int -> Int
maxScore scores =
    Maybe.withDefault 0 (List.maximum scores)


switchPlayers :
    Player
    -> Player
switchPlayers player =
    if player == X then
        O

    else
        X