module GameStatus exposing (..)

import Player exposing (..)


type GameStatus
    = InPlay
    | Winner
    | Draw


getGameStatus : GameStatus -> Player -> String
getGameStatus status player =
    case status of
        InPlay ->
            "Keep playing"

        Winner ->
            "Player " ++ getMark player ++ " wins!"

        Draw ->
            "It's a draw!"
