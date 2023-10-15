module OpenStreetMap exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)



-- VIEW


view =
    div [ class "h-20 w-50 lg:h-[calc(100vh-150px)]" ]
    [
        iframe [ src "https://www.openstreetmap.org/export/embed.html?bbox=106.82538449764253%2C-6.17655829696689%2C106.8282812833786%2C-6.174256982533537&amp;layer=mapnik", style "height" "100%", style "width" "100%" ]
        []
    ]
