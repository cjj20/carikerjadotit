module FilterJob exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Skill exposing (listSkill)



-- VIEW

view : Html msg
view =
        div [ class "bg-white pb-2 md:px-2" ]
        [
            div [ class "md:grid md:grid-cols-3 md:gap-x-4" ]
            [
                div [ class "flex items-center space-x-2 md:space-x-4 overflow-scroll p-1.5 no-scrollbar" ]
                [
                    div [ class "relative rounded-md shadow-sm hidden md:block" ]
                    [
                        div [ class "pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3" ]
                        [
                            span [ class "text-gray-500 sm:text-sm" ]
                            [
                                i [ class "fa-solid fa-magnifying-glass" ] []
                            ]
                        ]
                        , input [ placeholder "Search", class "w-full pl-8 bg-slate-100 border-1 border-slate-200 rounded-3xl h-10 mt-2 placeholder:text-sm placeholder:text-slate-400 focus:outline-none" ] []
                    ]
                    , a [ class "flex items-center bg-slate-100 rounded-full p-2 justify-center no-underline outline outline-slate-200 md:hidden hover:bg-pink-800 hover:cursor-pointer" ]
                    [
                        span [ class "fa-solid fa-magnifying-glass text-slate-500" ] []
                    ]
                    , a [ class "items-center no-underline outline outline-slate-200 rounded-3xl px-4 h-8 md:h-10 md:flex md:space-x-2" ]
                    [
                        div [ class "hidden md:block" ]
                        [
                            span [ class "fa-solid fa-location-dot text-slate-700" ] []
                        ]
                        , span [ class "text-sm text-slate-700" ] [ text "Location" ]
                        , div [ class "hidden md:block" ]
                        [
                             i [ class "hidden fa-solid fa-chevron-down text-slate-700 text-sm lg:block" ] []
                        ]
                    ]
                    , a [ class "flex items-center no-underline outline outline-slate-200 rounded-3xl px-4 h-8 md:hidden md:space-x-2" ]
                    [
                        span [ class "text-sm text-slate-700 truncate" ] [ text "Tech" ]
                    ]
                    , a [ class "flex items-center no-underline outline outline-slate-200 rounded-3xl px-4 h-8 md:hidden md:space-x-2" ]
                    [
                        span [ class "text-sm text-slate-700 truncate" ] [ text "More filters" ]
                    ]
                    , a [ class "flex items-center no-underline outline outline-slate-200 rounded-3xl px-4 h-8 md:hidden md:space-x-2" ]
                    [
                        span [ class "text-sm text-slate-700 truncate" ] [ text "Sort by: Default" ]
                    ]
                ]
                , div [ class "md:col-span-2 hidden space-x-4 md:flex mt-4 flex justify-end" ]
                [
                    div [ class "flex space-x-4 flex-row overflow-x-scroll no-scrollbar" ]
                    (
                        listSkill |> List.map
                            (\skill
                                -> div [ class "space-y-1" ]
                                    [
                                         div [ class "bg-yellow-500 flex justify-center items-center rounded-full rounded-full h-10 w-10 hover:outline hover:outline-4 hover:outline-slate-300 hover:cursor-pointer" ]
                                         [
                                             i [ class (skill.icon) ] []
                                         ]
                                         , div [ class "flex justify-center" ]
                                         [
                                             span [ class "text-xs text-slate-500" ] [ text (skill.name) ]
                                         ]
                                    ]
                            )
                    )
                    , div []
                    [
                       div [ class "flex items-center h-10 w-10 justify-center hover:bg-slate-300 rounded-full hover:cursor-pointer" ]
                       [
                           i [ class "fa-solid fa-ellipsis text-slate-500" ] []
                       ]
                    ]
                    , div [ class "flex" ]
                    [
                        a [ class "items-center no-underline outline outline-slate-200 rounded-3xl px-4 h-8 w-40 md:h-10 md:flex md:space-x-2" ]
                        [
                            span [ class "fa-solid fa-sliders text-slate-700" ] []
                            , span [ class "text-sm text-slate-700" ] [ text "More filters" ]
                            , i [ class "hidden fa-solid fa-chevron-down text-slate-700 text-sm lg:block" ] []
                        ]
                    ]
                ]
            ]
        ]
