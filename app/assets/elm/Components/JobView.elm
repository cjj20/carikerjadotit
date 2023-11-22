module Components.JobView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models.Job exposing (Job, maxSkills, salaryUndisclosed)
import String exposing (isEmpty)



-- VIEW


viewJob : Job -> Html msg
viewJob job =
    let
        typeOfWorkLabel =
            if not (isEmpty job.type_of_work) then
                div [ class "bg-slate-300 flex gap-x-2 items-center px-2 py-1 rounded-xl truncate" ]
                    [ i [ class "fa-solid fa-rss" ] []
                    , span [ class "text-xs truncate md:text-md" ] [ text job.type_of_work ]
                    ]

            else if not (isEmpty job.employment_type) then
                div [ class "bg-slate-300 flex gap-x-2 items-center px-2 py-1 rounded-xl truncate" ]
                    [ i [ class "fa-solid fa-rss" ] []
                    , span [ class "text-xs truncate md:text-md" ] [ text job.employment_type ]
                    ]

            else
                div [] []

        isNewLabel =
            if job.is_new == True then
                div [ class "bg-slate-300 px-1.5 py-0.5 rounded-xl text-xs text-slate-700 md:px-1.5" ] [ text "New" ]

            else
                div [] []
    in
    div [ class "bg-white px-2 rounded-lg shadow-lg md:px-4 md:py-2" ]
        [ div [ class "flex gap-x-2 h-16 items-center" ]
            [ div [ class "px-1 md:px-3 md:py-4" ] [ img [ src job.company.image, class "w-14 md:w-20" ] [] ]
            , div [ class "flex items-center justify-between truncate w-full md:space-x-4" ]
                [ div [ class "text-slate-700 truncate md:space-y-1" ]
                    [ span [ class "font-semibold text-sm text-slate-700 md:text-lg" ] [ text job.title ]
                    , div [ class "hidden md:flex md:space-x-4" ]
                        [ div [ class "flex gap-x-2 items-center truncate" ]
                            [ i [ class "fa-solid fa-building" ] []
                            , span [ class "text-xs truncate md:text-md" ] [ text job.company.name ]
                            ]
                        , div [ class "flex gap-x-2 items-center truncate" ]
                            [ i [ class "fa-solid fa-location-dot" ] []
                            , span [ class "text-xs truncate md:text-md" ] [ text job.company.city ]
                            ]
                        , typeOfWorkLabel
                        ]
                    , span [ class "block text-[10px] text-green-400 truncate md:hidden" ] [ text (salaryUndisclosed job) ]
                    ]
                , div [ class "space-y-1 truncate md:gap-y-1" ]
                    [ div [ class "flex items-center justify-end md:gap-x-2" ]
                        [ span [ class "hidden text-sm text-green-500 truncate md:block md:text-base" ] [ text (salaryUndisclosed job) ]
                        , isNewLabel
                        ]
                    , div [ class "flex gap-x-1 items-center justify-end md:hidden" ]
                        [ span [ class "text-[10px] text-slate-500 truncate" ] [ text "Warszawa, +3," ]
                        , span [ class "text-[10px] text-slate-500 truncate" ] [ text "Remote" ]
                        ]
                    , div [ class "gap-x-2 hidden justify-end md:flex" ] <|
                        List.map
                            (\data ->
                                span [ class "border border-slate-300 capitalize rounded-xl px-1 py-1 text-xs text-slate-700 truncate" ]
                                    [ text data ]
                            )
                            (maxSkills job)
                    ]
                ]
            ]
        ]


loadingView : Int -> Html msg
loadingView _ =
    div [ class "bg-white px-2 rounded-lg shadow-lg md:px-4 md:py-2" ]
        [ div [ class "animate-pulse flex gap-x-2 h-16 items-center" ]
            [ div [ class "bg-slate-300 rounded-lg h-12 md:h-14 w-[104px] md:w-[84px]" ] []
            , div
                [ class "flex gap-x-2 items-center justify-between truncate w-full md:gap-x-4" ]
                [ div [ class "flex flex-col truncate gap-y-1 md:gap-y-2" ]
                    [ div [ class "bg-slate-300 h-6 rounded w-32 sm:w-48" ] []
                    , div [ class "hidden md:flex md:space-x-2" ]
                        [ div [ class "bg-slate-300 h-4 rounded w-24" ]
                            []
                        , div [ class "bg-slate-300 h-4 rounded w-24" ]
                            []
                        , div [ class "bg-slate-300 h-4 rounded w-24" ]
                            []
                        ]
                    , div [ class "bg-slate-300 block h-4 rounded truncate w-16 md:hidden" ]
                        []
                    ]
                , div [ class "flex flex-col truncate gap-y-1 md:gap-y-2" ]
                    [ div [ class "flex justify-end" ]
                        [ div [ class "bg-slate-300 h-5 rounded w-20 md:w-36" ]
                            []
                        ]
                    , div [ class "flex gap-x-1 items-center justify-end md:hidden" ]
                        [ div [ class "bg-slate-300 block h-4 rounded w-16 md:hidden" ]
                            []
                        , div [ class "bg-slate-300 block h-4 rounded w-16 md:hidden" ]
                            []
                        ]
                    , div [ class "gap-x-2 hidden justify-end md:flex" ]
                        [ div [ class "bg-slate-300 h-4 rounded w-14" ]
                            []
                        , div [ class "bg-slate-300 h-4 rounded w-14" ]
                            []
                        ]
                    ]
                ]
            ]
        ]
