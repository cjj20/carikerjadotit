module Job exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- VIEW


view =
    div [ class "bg-white rounded-lg shadow-lg px-2 py-1 md:px-4" ]
    [
        div [ class "flex items-center space-x-2 h-16" ]
        [
            img [ src "https://public.justjoin.it/offers/company_logos/original_x2/dbb03d4cb319a773cbfa936b438373115490e0b1.png?1696099644", class "w-20 p-1" ] []
            , div [ class "w-full flex justify-between items-center truncate md:space-x-4" ]
            [
                div [ class "truncate text-slate-700 md:space-y-1" ]
                [
                    span [ class "text-sm text-slate-700 font-semibold md:text-lg" ] [ text "Machine Learning Engineer" ]
                    , div [ class "hidden md:flex md:space-x-4" ]
                    [
                        div [ class "flex space-x-2 items-center truncate" ]
                        [
                            i [ class "fa-solid fa-building" ] []
                            , span [ class "text-xs md:text-md truncate" ] [ text "DLabs.ai" ]
                        ]
                        , div [ class "flex space-x-2 items-center truncate" ]
                        [
                            i [ class "fa-solid fa-location-dot" ] []
                            , span [ class "text-xs md:text-md truncate" ] [ text "Warszawa, +3" ]
                        ]
                        , div [ class "flex space-x-2 items-center bg-slate-300 rounded-xl px-2 py-1 truncate" ]
                        [
                            i [ class "fa-solid fa-rss" ] []
                            , span [ class "text-xs md:text-md truncate" ] [ text "Fully remote" ]
                        ]
                    ]
                    , span [ class "block text-[10px] text-green-400 truncate md:hidden" ] [ text "3.6K - 4.8K USD" ]
                ]
                , div [ class "truncate space-y-0.5 md:space-y-1" ]
                [
                    div [ class "flex justify-end items-center md:space-x-2" ]
                    [
                        span [ class "hidden text-sm text-green-500 md:text-base md:block truncate" ] [ text "3 670 - 4 820 USD" ]
                        , div [ class "px-1.5 py-0.5 bg-slate-300 rounded-xl text-xs text-slate-700 md:px-1.5" ] [ text "New" ]
                    ]
                    , div [ class "flex justify-end space-x-1 items-center md:hidden" ]
                    [
                        span [ class "text-[10px] text-slate-500 truncate" ] [ text "Warszawa, +3," ]
                        , span [ class "text-[10px] text-slate-500 truncate" ] [ text "Remote" ]
                    ]
                    , div [ class "hidden justify-end space-x-2 md:flex" ]
                    [
                        span [ class "rounded-xl px-1 py-1 border border-slate-300 text-xs text-slate-700 truncate" ] [ text "CI/CD" ]
                        , span [ class "rounded-xl px-1 py-1 border border-slate-300 text-xs text-slate-700 truncate" ] [ text "DBT" ]
                        , span [ class "rounded-xl px-1 py-1 border border-slate-300 text-xs text-slate-700 truncate" ] [ text "Docker" ]
                    ]
                ]
            ]
        ]
    ]
