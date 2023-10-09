module Job exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- VIEW


view =
    div [ class "bg-white rounded-lg px-4 py-1 md:px-8 md:py-3" ]
    [
        div [ class "grid grid-cols-4 gap-4" ]
        [
            div [ class "flex items-center px-1 py-2 sm:px-2 sm:py-2" ]
            [
                img [ src "https://public.justjoin.it/offers/company_logos/thumb_x2/9732a0e8637ca033b9e82cb36016f64383fff25f.png?1695159439", width 100, height 100 ] []
            ]
            , div [ class "col-span-3 flex justify-between items-center" ]
            [
                div [ class "inline-block space-y-1" ]
                [
                    span [ class "text-sm text-slate-700 font-semibold md:text-xl truncate block" ] [ text "Machine Learning Engineer" ]
                    , div [ class "flex space-x-4 text-sm text-slate-500" ]
                    [
                        span [ class "text-xs md:text-md" ] [ text "DLabs.ai" ]
                        , span [ class "text-xs md:text-md" ] [ text "Warszawa, +3" ]
                        , span [ class "bg-slate-300 rounded-xl text-slate-700 px-2 py-1 text-xs" ] [ text "Remote" ]
                    ]
                ]
                , div [ class "space-y-1" ]
                [
                    div [ class "flex space-x-2" ]
                    [
                        span [ class "text-xs text-green-500 md:text-md" ] [ text "3 670 - 4 820 USD" ]
                        , span [ class "px-1 flex items-center bg-slate-300 rounded-xl text-xs text-slate-700 md:px-1.5" ] [ text "New" ]
                    ]
                    , div [ class "hidden justify-end space-x-2 md:flex" ]
                    [
                        span [ class "rounded-xl px-1 py-1 border border-slate-300 text-xs text-slate-700" ] [ text "CI/CD" ]
                        , span [ class "rounded-xl px-1 py-1 border border-slate-300 text-xs text-slate-700" ] [ text "DBT" ]
                        , span [ class "rounded-xl px-1 py-1 border border-slate-300 text-xs text-slate-700" ] [ text "Docker" ]
                    ]
                ]
            ]
        ]
    ]
