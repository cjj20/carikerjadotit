module Shared.TabJob exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)



-- VIEW


view : Html msg
view =
    div [ class "bg-white flex justify-between px-4" ]
        [ div [ class "flex" ]
            [ div [ class "bg-gray-100 px-4 py-1 rounded-t-xl md:px-6 md:py-1.5 md:rounded-t-3xl" ]
                [ span [ class "text-sm text-slate-500 truncate" ] [ text "With salary" ]
                ]
            , div [ class "px-4 py-1 md:px-6 md:py-1.5" ]
                [ span [ class "text-sm text-slate-500 truncate" ] [ text "All offers", span [ class "font-medium pl-2 text-primary-2" ] [ text "13 433 offers" ] ]
                ]
            ]
        , div [ class "flex gap-x-6 items-center justify-center" ]
            [ div [ class "flex gap-x-2 items-center" ]
                [ span [ class "text-sm text-slate-500" ] [ text "Remote" ]
                , i [ class "hidden fa-solid fa-toggle-on text-xl text-slate-400 lg:block" ] []
                ]
            , div [ class "gap-x-2 hidden items-center lg:flex" ]
                [ span [ class "text-sm text-slate-500" ] [ text "Default" ]
                , i [ class "hidden fa-solid fa-chevron-down text-sm text-slate-500 lg:block" ] []
                ]
            ]
        ]
