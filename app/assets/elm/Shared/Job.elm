module Shared.Job exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)



-- MODEL


type alias Job =
    { id : Int
    , title : String
    , salary_min : String
    , salary_max : String
    , salary_is_undisclosed : Bool
    , employment_type : String
    , location_type : String
    , is_new : Bool
    , experience_level : String
    , type_of_work : String
    , job_description : String
    , apply_link : String
    , created_at : String
    , updated_at : String
    }


type alias Model =
    { job : Job
    }



-- EXPRESSION


salaryUndisclosed : Job -> String
salaryUndisclosed job =
    case job.salary_is_undisclosed of
        True ->
            ""

        False ->
            job.salary_min ++ " - " ++ job.salary_max ++ " IDR"


isNew : Job -> Html msg
isNew job =
    case job.is_new of
        True ->
            div [ class "bg-slate-300 px-1.5 py-0.5 rounded-xl text-xs text-slate-700 md:px-1.5" ] [ text "New" ]

        False ->
            div [] []



-- VIEW


viewJobDetail : Job -> Html msg
viewJobDetail job =
    div [ class "bg-white px-2 rounded-lg shadow-lg md:px-4 md:py-2" ]
        [ div [ class "flex gap-x-2 h-16 items-center" ]
            [ img [ src "https://public.justjoin.it/offers/company_logos/original_x2/dbb03d4cb319a773cbfa936b438373115490e0b1.png?1696099644", class "p-1 w-20" ] []
            , div [ class "flex items-center justify-between truncate w-full md:space-x-4" ]
                [ div [ class "text-slate-700 truncate md:space-y-1" ]
                    [ span [ class "font-semibold text-sm text-slate-700 md:text-lg" ] [ text job.title ]
                    , div [ class "hidden md:flex md:space-x-4" ]
                        [ div [ class "flex gap-x-2 items-center truncate" ]
                            [ i [ class "fa-solid fa-building" ] []
                            , span [ class "text-xs truncate md:text-md" ] [ text "DLabs.ai" ]
                            ]
                        , div [ class "flex gap-x-2 items-center truncate" ]
                            [ i [ class "fa-solid fa-location-dot" ] []
                            , span [ class "text-xs truncate md:text-md" ] [ text "Warszawa, +3" ]
                            ]
                        , div [ class "bg-slate-300 flex gap-x-2 items-center px-2 py-1 rounded-xl truncate" ]
                            [ i [ class "fa-solid fa-rss" ] []
                            , span [ class "text-xs truncate md:text-md" ] [ text job.type_of_work ]
                            ]
                        ]
                    , span [ class "block text-[10px] text-green-400 truncate md:hidden" ] [ text (salaryUndisclosed job) ]
                    ]
                , div [ class "space-y-1 truncate md:gap-y-1" ]
                    [ div [ class "flex items-center justify-end md:gap-x-2" ]
                        [ span [ class "hidden text-sm text-green-500 truncate md:block md:text-base" ] [ text (salaryUndisclosed job) ]
                        , isNew job
                        ]
                    , div [ class "flex gap-x-1 items-center justify-end md:hidden" ]
                        [ span [ class "text-[10px] text-slate-500 truncate" ] [ text "Warszawa, +3," ]
                        , span [ class "text-[10px] text-slate-500 truncate" ] [ text "Remote" ]
                        ]
                    , div [ class "gap-x-2 hidden justify-end md:flex" ]
                        [ span [ class "border border-slate-300 rounded-xl px-1 py-1 text-xs text-slate-700 truncate" ] [ text "CI/CD" ]
                        , span [ class "border border-slate-300 rounded-xl px-1 py-1 text-xs text-slate-700 truncate" ] [ text "DBT" ]
                        , span [ class "border border-slate-300 rounded-xl px-1 py-1 text-xs text-slate-700 truncate" ] [ text "Docker" ]
                        ]
                    ]
                ]
            ]
        ]
