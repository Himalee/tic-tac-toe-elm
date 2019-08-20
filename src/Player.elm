module Player exposing (..)


type Player
    = X
    | O


getMark : Player -> String
getMark player =
    case player of
        X ->
            "X"

        O ->
            "O"


switchPlayers :
    Player
    -> Player
switchPlayers player =
    if player == X then
        O

    else
        X
