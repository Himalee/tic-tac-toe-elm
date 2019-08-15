module Cell exposing (cellIsNotEmpty, emptyCell)

import Array exposing (fromList, get)


emptyCell : String
emptyCell =
    ""


cellIsNotEmpty : String -> Bool
cellIsNotEmpty value =
    value /= emptyCell
