module FilterJob exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Skill exposing (listSkill)


-- VIEW


view : Html msg
view =
        div [ class "bg-white p-2 lg:p-4" ]
        [
            div [ class "flex justify-between" ]
            [
                div [ class "flex items-center space-x-2 lg:space-x-4" ]
                [
                    input [ placeholder "Search", class "hidden w-1/4 bg-slate-100 border-1 border-slate-200 rounded-3xl h-10 mt-2 lg:block placeholder:text-sm placeholder:text-slate-400 focus:outline-none sm:w-full" ] []
                    , a [ class "flex items-center bg-slate-100 rounded-full p-2.5 no-underline outline outline-slate-200 lg:hidden hover:bg-pink-800 hover:cursor-pointer" ]
                    [
                        span [ class "fa-solid fa-magnifying-glass text-slate-700" ] []
                    ]
                    , a [ class "items-center no-underline outline outline-slate-200 rounded-3xl px-4 py-1.5 h-10" ]
                   [
                       span [ class "text-sm text-slate-700" ] [ text "Location" ]
                   ]
                ]
                , div [ class "hidden space-x-4 lg:flex" ]
                [
                    div [ class "inline-flex space-x-4" ]
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
                           i [ class "fa-solid fa-ellipsis" ] []
                       ]
                    ]
                ]
            ]
        ]
