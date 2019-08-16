module GameStatus exposing (..)

import Player exposing (..)


type GameStatus
    = InPlay
    | Winner
    | Draw
    | GameModeNotChosen


getGameStatus : GameStatus -> String -> String
getGameStatus status playerMark =
    case status of
        InPlay ->
            "Play!"

        Winner ->
            "Player " ++ playerMark ++ " wins!"

        Draw ->
            "It's a draw!"

        GameModeNotChosen ->
            "Choose a game mode"
