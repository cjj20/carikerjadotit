module Components.Footer exposing (..)

import Components.SocialMedia as SocialMedia
import Html exposing (Html, div, h5, h6, span, text)
import Html.Attributes exposing (class)



-- VIEW


view : Html msg
view =
    div [ class "bg-white lg:flex lg:justify-center" ]
        [ div [ class "space-y-6 px-4 py-8 sm:px-6 lg:grid lg:grid-cols-4 lg:space-y-0" ]
            [ h5 [ class "text-3xl text-slate-700" ] [ text "carikerja.it" ]
            , div [ class "flex flex-wrap gap-x-12 gap-y-4 md:col-span-2" ]
                [ div [ class "flex flex-col gap-y-2 text-xs text-slate-500 md:gap-y-4 md:text-sm" ]
                    [ h6 [ class "text-lg text-slate-700" ] [ text "Products" ]
                    , div [ class "flex flex-col gap-y-1.5" ]
                        [ span [] [ text "Offers" ]
                        , span [] [ text "Top companies" ]
                        , span [] [ text "Geek" ]
                        , span [] [ text "Employer Panel" ]
                        , span [] [ text "Candidate Profile" ]
                        , span [] [ text "Pricing" ]
                        ]
                    ]
                , div [ class "flex flex-col gap-y-2 text-xs text-slate-500 md:space-y-4 md:text-sm" ]
                    [ h6 [ class "text-lg text-slate-700" ] [ text "Resources" ]
                    , div [ class "flex flex-col gap-y-1.5" ]
                        [ span [] [ text "Help" ]
                        , span [] [ text "Terms" ]
                        , span [] [ text "Privacy Policy" ]
                        ]
                    ]
                , div [ class "flex flex-col gap-y-2 text-xs text-slate-500 md:gap-y-4 md:text-sm" ]
                    [ h6 [ class "text-lg text-slate-700" ] [ text "About Us" ]
                    , div [ class "flex flex-col gap-y-1.5" ]
                        [ span [] [ text "About Us" ]
                        , span [] [ text "Career" ]
                        ]
                    ]
                ]
            , div [ class "space-y-3 md:gap-y-6" ]
                [ h6 [ class "text-sm text-slate-700 md:text-lg" ] [ text "Follow us on social media" ]
                , SocialMedia.view
                ]
            ]
        ]
