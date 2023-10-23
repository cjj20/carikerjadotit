module Job exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- VIEW


view =
    div [ class "bg-white px-2 rounded-lg shadow-lg md:px-4 md:py-2" ]
    [
        div [ class "flex h-16 items-center space-x-2" ]
        [
            img [ src "https://public.justjoin.it/offers/company_logos/original_x2/dbb03d4cb319a773cbfa936b438373115490e0b1.png?1696099644", class "p-1 w-20" ] []
            , div [ class "flex items-center justify-between truncate w-full md:space-x-4" ]
            [
                div [ class "text-slate-700 truncate md:space-y-1" ]
                [
                    span [ class "font-semibold text-sm text-slate-700 md:text-lg" ] [ text "Machine Learning Engineer" ]
                    , div [ class "hidden md:flex md:space-x-4" ]
                    [
                        div [ class "flex items-center space-x-2 truncate" ]
                        [
                            i [ class "fa-solid fa-building" ] []
                            , span [ class "text-xs truncate md:text-md" ] [ text "DLabs.ai" ]
                        ]
                        , div [ class "flex items-center space-x-2 truncate" ]
                        [
                            i [ class "fa-solid fa-location-dot" ] []
                            , span [ class "text-xs truncate md:text-md" ] [ text "Warszawa, +3" ]
                        ]
                        , div [ class "bg-slate-300 flex items-center px-2 py-1 rounded-xl space-x-2 truncate" ]
                        [
                            i [ class "fa-solid fa-rss" ] []
                            , span [ class "text-xs truncate md:text-md" ] [ text "Fully remote" ]
                        ]
                    ]
                    , span [ class "block text-[10px] text-green-400 truncate md:hidden" ] [ text "3.6K - 4.8K USD" ]
                ]
                , div [ class "space-y-0.5 truncate md:space-y-1" ]
                [
                    div [ class "flex items-center justify-end md:space-x-2" ]
                    [
                        span [ class "hidden text-sm text-green-500 truncate md:block md:text-base" ] [ text "3 670 - 4 820 USD" ]
                        , div [ class "bg-slate-300 px-1.5 py-0.5 rounded-xl text-xs text-slate-700 md:px-1.5" ] [ text "New" ]
                    ]
                    , div [ class "flex items-center justify-end space-x-1 md:hidden" ]
                    [
                        span [ class "text-[10px] text-slate-500 truncate" ] [ text "Warszawa, +3," ]
                        , span [ class "text-[10px] text-slate-500 truncate" ] [ text "Remote" ]
                    ]
                    , div [ class "hidden justify-end space-x-2 md:flex" ]
                    [
                        span [ class "border border-slate-300 rounded-xl px-1 py-1 text-xs text-slate-700 truncate" ] [ text "CI/CD" ]
                        , span [ class "border border-slate-300 rounded-xl px-1 py-1 text-xs text-slate-700 truncate" ] [ text "DBT" ]
                        , span [ class "border border-slate-300 rounded-xl px-1 py-1 text-xs text-slate-700 truncate" ] [ text "Docker" ]
                    ]
                ]
            ]
        ]
    ]
