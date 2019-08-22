module Cell exposing (cellIsNotEmpty, emptyCell)


emptyCell : String
emptyCell =
    ""


cellIsNotEmpty : String -> Bool
cellIsNotEmpty value =
    value /= emptyCell
