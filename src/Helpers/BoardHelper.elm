module Helpers.BoardHelper exposing (create)

import Array exposing (Array, fromList)


create : Int -> Array String
create size =
    Array.repeat size ""
