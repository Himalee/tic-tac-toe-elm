module GameMode exposing (..)


type GameMode
    = HumanvHuman
    | HumanvRandom
    | HumanvHard
    | NotChosen


getGameMode : GameMode -> String
getGameMode gameMode =
    case gameMode of
        HumanvHuman ->
            "Human vs Human"

        HumanvRandom ->
            "Human vs Random"

        HumanvHard ->
            "Human vs Hard"

        NotChosen ->
            ""
