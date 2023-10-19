module Footer exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)



-- VIEW


view : Html msg
view =
    div [ class "bg-white lg:flex lg:justify-center" ]
    [
        div [ class "px-4 py-8 space-y-6 sm:px-6 lg:grid lg:grid-cols-4 lg:space-y-0" ]
        [
            h5 [ class "text-3xl text-slate-700" ] [ text "carikerja.it" ]
            , div [ class "flex flex-wrap gap-x-12 gap-y-4 md:col-span-2" ]
            [
                div [ class "flex flex-col space-y-2 text-xs text-slate-500 md:space-y-4 md:text-sm" ]
                [
                    h6 [ class "text-lg text-slate-700" ] [ text "Products" ]
                    , div [ class "flex flex-col space-y-1.5" ]
                    [
                        span [] [ text "Offers" ]
                        , span [] [ text "Top companies" ]
                        , span [] [ text "Geek" ]
                        , span [] [ text "Employer Panel" ]
                        , span [] [ text "Candidate Profile" ]
                        , span [] [ text "Pricing" ]
                    ]
                ]
                , div [ class "flex flex-col space-y-2 text-xs text-slate-500 md:space-y-4 md:text-sm" ]
                [
                    h6 [ class "text-lg text-slate-700" ] [ text "Resources" ]
                    , div [ class "flex flex-col space-y-1.5" ]
                    [
                        span [] [ text "Help" ]
                        , span [] [ text "Terms" ]
                        , span [] [ text "Privacy Policy" ]
                    ]
                ]
                , div [ class "flex flex-col space-y-2 text-xs text-slate-500 md:space-y-4 md:text-sm" ]
                [
                    h6 [ class "text-lg text-slate-700" ] [ text "About Us" ]
                    , div [ class "flex flex-col space-y-1.5" ]
                    [
                        span [] [ text "About Us" ]
                        , span [] [ text "Career" ]
                    ]
                ]
            ]
            , div [ class "space-y-3 md:space-y-6" ]
            [
                h6 [ class "text-sm text-slate-700 md:text-lg" ] [ text "Follow us on social media" ]
                , div [ class "flex space-x-6 text-2xl text-slate-500" ]
                [
                    i [ class "fa-brands fa-facebook" ] []
                    , i [ class "fa-brands fa-instagram" ] []
                    , i [ class "fa-brands fa-linkedin" ] []
                    , i [ class "fa-brands fa-youtube" ] []
                ]
            ]
        ]
    ]



-- MAIN


main =
    view
