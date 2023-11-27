module Components.JobView exposing (..)

import Components.Icons exposing (buildingIcon, dotIcon, mapsGrayIcon)
import Helpers.Converter exposing (stringToFloat)
import Html exposing (Html, div, img, span, text)
import Html.Attributes exposing (class, src)
import Models.Job exposing (Job)
import String exposing (isEmpty, toFloat)



-- VIEW


view : Job -> Html msg
view job =
    let
        isNewLabel =
            if job.is_new == True then
                div [ class "bg-white-30 flex font-semibold h-[22px] items-center justify-center rounded-xl text-xs text-black-90 w-[43px]" ]
                    [ text "New" ]

            else
                div [] []

        employmentTypeLabel =
            if not (isEmpty job.employment_type) then
                div [ class "bg-white-30 flex gap-x-2 h-[22px] items-center justify-center px-4 py-1 rounded" ]
                    [ span [ class "font-semibold text-xs text-black-90 truncate" ] [ text job.employment_type ]
                    ]

            else
                div [] []

        typeOfWorkLabel =
            if not (isEmpty job.type_of_work) then
                div [ class "bg-white-30 flex gap-x-2 h-[22px] items-center justify-center px-4 py-1 rounded" ]
                    [ span [ class "font-semibold text-xs text-black-90 truncate" ] [ text job.type_of_work ]
                    ]

            else
                div [] []

        salaryLabel =
            if not job.salary_is_undisclosed && job.salary_max /= "0" then
                div [ class "font-semibold text-sm text-[#54AF71] truncate" ]
                    [ text (job.salary_min ++ " - " ++ job.salary_max) ]

            else
                div [] []
    in
    div [ class "bg-white p-4 rounded-lg h-[110px]" ]
        [ div [ class "flex flex-col gap-y-4" ]
            [ div [ class "flex gap-x-2 justify-between" ]
                [ div [ class "flex flex-row gap-x-4 truncate" ]
                    [ div [ class "flex items-center" ] [ img [ src job.company.image, class "w-12" ] [] ]
                    , div [ class "flex justify-between w-full truncate" ]
                        [ div [ class "gap-y-1 truncate" ]
                            [ span [ class "font-semibold text-sm text-black-90 md:text-base truncate" ] [ text job.title ]
                            , div [ class "flex gap-x-2 text-[#A5A9B5] truncate" ]
                                [ div [ class "flex gap-x-1 items-center truncate" ]
                                    [ div [] [ buildingIcon ]
                                    , span [ class "text-xs truncate" ] [ text job.company.name ]
                                    ]
                                , div [ class "flex items-center" ] [ dotIcon ]
                                , div [ class "flex gap-x-1 items-center truncate" ]
                                    [ div [] [ mapsGrayIcon ]
                                    , span [ class "text-xs truncate" ] [ text job.company.city ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                , div [] [ isNewLabel ]
                ]
            , div [ class "flex gap-x-4 justify-between" ]
                [ div [ class "flex flex-row gap-x-2 truncate" ]
                    [ div [ class "truncate" ] [ employmentTypeLabel ]
                    , div [ class "truncate" ] [ typeOfWorkLabel ]
                    ]
                , div [ class "truncate" ] [ salaryLabel ]
                ]
            ]
        ]


loadingView : Int -> Html msg
loadingView _ =
    div [ class "bg-white h-[110px] p-4 rounded-lg" ]
        [ div [ class "flex flex-col gap-y-4" ]
            [ div [ class "flex gap-x-2 justify-between" ]
                [ div [ class "flex flex-row gap-x-4" ]
                    [ div [ class "flex items-center" ]
                        [ div [ class "animate-pulse bg-[#F2F6FD] h-10 rounded-xl w-10" ] []
                        ]
                    , div [ class "flex justify-between w-full" ]
                        [ div [ class "flex flex-col gap-y-1" ]
                            [ div [ class "animate-pulse bg-[#F2F6FD] h-5 rounded-lg w-32 md:w-56" ] []
                            , div [ class "flex gap-x-2" ]
                                [ div [ class "animate-pulse bg-[#F2F6FD] h-5 rounded-lg w-14 md:w-20" ] []
                                , div [ class "animate-pulse bg-[#F2F6FD] h-5 rounded-lg w-14 md:w-20" ] []
                                ]
                            ]
                        ]
                    ]
                , div [ class "animate-pulse bg-[#F2F6FD] h-5 rounded-lg w-10" ] []
                ]
            , div [ class "flex gap-x-4 justify-between" ]
                [ div [ class "flex flex-row gap-x-2" ]
                    [ div [ class "animate-pulse bg-[#F2F6FD] h-5 rounded-lg w-20" ] []
                    , div [ class "animate-pulse bg-[#F2F6FD] h-5 rounded-lg w-20" ] []
                    ]
                , div [ class "animate-pulse bg-[#F2F6FD] h-5 rounded-lg w-16" ] []
                ]
            ]
        ]
