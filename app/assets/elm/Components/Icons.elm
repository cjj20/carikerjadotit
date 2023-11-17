module Components.Icons exposing (..)

import Html exposing (Html)
import Svg exposing (circle, path, rect, svg)
import Svg.Attributes exposing (cx, cy, d, fill, height, r, rx, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox, width, x, y)


keywordIcon : Html msg
keywordIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ circle [ cx "9", cy "14", r "3", stroke "#242632", strokeWidth "2", strokeLinejoin "round" ] []
        , path [ d "M11.5 11.5L17 6L19 8", stroke "#242632", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        , path [ d "M15 8L17 10", stroke "#242632", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        ]


skillIcon : Html msg
skillIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ path
            [ d "M10.8907 8.54544L10 6.80008L9.10928 8.54544L8.44122 9.85452L6.98976 10.0854L5.05458 10.3931L6.43927 11.7796L7.47784 12.8195L7.24886 14.2712L6.94356 16.2068L8.69006 15.3183L10 14.652L11.3099 15.3183L13.0564 16.2068L12.7511 14.2712L12.5222 12.8195L13.5607 11.7796L14.9454 10.3931L13.0102 10.0854L11.5588 9.85452L10.8907 8.54544Z"
            , stroke "#242632"
            , strokeWidth "2"
            ]
            []
        , path [ d "M17 16L17.5995 17.1748L18.9021 17.382L17.9701 18.3152L18.1756 19.618L17 19.02L15.8244 19.618L16.0299 18.3152L15.0979 17.382L16.4005 17.1748L17 16Z", fill "#242632" ] []
        , path [ d "M17 4L17.5995 5.1748L18.9021 5.38197L17.9701 6.3152L18.1756 7.61803L17 7.02L15.8244 7.61803L16.0299 6.3152L15.0979 5.38197L16.4005 5.1748L17 4Z", fill "#242632" ] []
        ]


positionIcon : Html msg
positionIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ rect [ x "4", y "8", width "16", height "11", rx "1", stroke "black", strokeWidth "2" ] []
        , rect [ x "9", y "5", width "6", height "14", rx "1", stroke "black", strokeWidth "2" ] []
        ]
