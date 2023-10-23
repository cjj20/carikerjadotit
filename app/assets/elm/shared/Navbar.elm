module Shared.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)



-- VIEW


view : Html msg
view =
    nav [ class "bg-white border-b px-4" ]
    [
        div [ class "flex h-16 items-center justify-between" ]
        [
            div [ class "flex gap-x-4 items-center" ]
            [
                span [ class "font-semibold my-auto text-md text-gray-900 lg:text-[32px]" ] [ text "carikerja.it" ]
                , span [ class "hidden my-auto text-xs text-slate-700 lg:block" ] [ text "#1 Job Board for tech industry in Indonesia and SEA" ]
            ]
            , div [ class "flex flex-row gap-x-4 items-center" ]
            [
                a [ class "hidden no-underline rounded-xl text-sm text-red-400 hover:bg-slate-100 hover:cursor-pointer lg:flex" ]
                [
                    span [ class "p-2" ] [ text "Job offers" ]
                ]
                , a [ class "hidden no-underline rounded-xl text-sm text-slate-500 hover:bg-slate-100 hover:cursor-pointer lg:flex" ]
                [
                    span [ class "p-2" ] [ text "Top Companies" ]
                ]
                --, a [ class "hidden rounded-xl no-underline text-slate-500 text-sm hover:bg-slate-100 hover:cursor-pointer lg:flex" ] [ text "Geek" ]
                , a [ class "hidden items-center no-underline outline outline-slate-200 px-4 py-2 rounded-2xl hover:cursor-pointer hover:outline-slate-300 md:flex" ]
                [
                    span [ class "text-sm text-slate-700" ] [ text "Post a job" ]
                ]
                --, a [ class "flex items-center bg-pink-500 rounded-2xl px-4 py-2 no-underline hover:bg-pink-800 hover:cursor-pointer flex space-x-2" ]
                --[
                --    span [ class "text-sm text-slate-50" ] [ text "Sign In" ]
                --    , span [ class "fa-solid fa-chevron-down text-white text-sm" ] []
                --]
                , div [ class "hidden rounded-full hover:bg-slate-200 hover:cursor-pointer md:flex"]
                [
                    a [ class "font-medium no-underline p-2 text-sm text-slate-500" ] [ text "IDR" ]
                ]
                , a [ class "fa-solid fa-bars no-underline text-slate-700 hover:cursor-pointer" ] []
            ]
        ]

    ]
