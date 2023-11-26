module Components.Maps exposing (..)

import Components.Icons exposing (mapsPaperIcon)
import Html exposing (Html, div, iframe, img, span, text)
import Html.Attributes exposing (class, src, style, type_)



-- VIEW


view =
    iframe
        [ src "https://www.openstreetmap.org/export/embed.html?bbox=106.82538449764253%2C-6.17655829696689%2C106.8282812833786%2C-6.174256982533537&amp;layer=mapnik"
        , style "height" "100%"
        , style "width" "100%"
        , style "borderRadius" "12px"
        ]
        []


mobileView : Html msg
mobileView =
    div [ class "relative" ]
        [ div [ class "flex items-center justify-center" ]
            [ img [ src "/images/maps-background.png", class "h-[68px] object-cover rounded-xl", style "width" "100%" ] []
            , div [ class "absolute flex items-center justify-center h-full w-full" ]
                [ div [ class "bg-white flex gap-x-2 h-9 items-center justify-center rounded-[30px] w-[122px]", type_ "button" ]
                    [ span [] [ mapsPaperIcon ]
                    , span [ class "font-semibold text-sm text-black-90" ] [ text "See maps" ]
                    ]
                ]
            ]
        ]
