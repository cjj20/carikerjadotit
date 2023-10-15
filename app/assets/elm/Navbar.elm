module Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)



-- VIEW


view : Html msg
view =
    nav [ class "bg-white px-4 border-b" ]
    [
        div [ class "flex justify-between items-center h-16" ]
        [
            div [ class "flex items-center space-x-4" ]
            [
                span [ class "text-gray-900 text-md my-auto font-semibold lg:text-[32px]" ] [ text "carikerja.it" ]
                , span [ class "hidden text-slate-700 text-xs my-auto lg:block" ] [ text "#1 Job Board for tech industry in Asia" ]
            ]
            , div [ class "inline-flex items-center space-x-4" ]
            [
                 a [ class "hidden rounded-xl no-underline text-red-400 text-sm hover:bg-slate-100 hover:cursor-pointer lg:flex" ] [ text "Job offers" ]
                 , a [ class "hidden rounded-xl no-underline text-slate-500 text-sm hover:bg-slate-100 hover:cursor-pointer lg:flex" ] [ text "Top Companies" ]
                 , a [ class "hidden rounded-xl no-underline text-slate-500 text-sm hover:bg-slate-100 hover:cursor-pointer lg:flex" ] [ text "Geek" ]
                 , a [ class "hidden items-center rounded-2xl no-underline outline outline-slate-200 px-4 py-2 hover:outline-slate-700 hover:cursor-pointer md:flex" ]
                 [
                     span [ class "text-sm text-slate-700" ] [ text "Post a job" ]
                 ]
                 , a [ class "flex items-center bg-pink-500 rounded-2xl px-4 py-2 no-underline hover:bg-pink-800 hover:cursor-pointer flex space-x-2" ]
                [
                    span [ class "text-sm text-slate-50" ] [ text "Sign In" ]
                    , span [ class "fa-solid fa-chevron-down text-white text-sm" ] []
                ]
                , div [ class "hidden rounded-full p-2 hover:bg-slate-200 hover:cursor-pointer md:flex justify-center"]
                [
                    a [ class "no-underline text-slate-500 text-sm" ] [ text "IDR" ]
                ]
                , a [ class "no-underline fa-solid fa-bars text-slate-700" ] []
            ]
        ]

    ]



-- MAIN


main =
    view
