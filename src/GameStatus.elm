module GameStatus exposing (..)

import Player exposing (..)


type GameStatus
    = InPlay
    | Winner
    | Draw
    | GameModeNotChosen


getGameStatus : GameStatus -> Player -> String
getGameStatus status player =
    case status of
        InPlay ->
            "Play!"

        Winner ->
            "Player " ++ getMark player ++ " wins!"

        Draw ->
            "It's a draw!"

        GameModeNotChosen ->
            "Choose a game mode"
