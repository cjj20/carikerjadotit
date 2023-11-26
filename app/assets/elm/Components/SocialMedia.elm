module Components.SocialMedia exposing (..)

import Components.Icons exposing (facebookIcon, instagramIcon, linkedInIcon, twitterIcon)
import Html exposing (Html, div)
import Html.Attributes exposing (class)



-- VIEW


view : Html msg
view =
    div [ class "flex gap-x-4" ]
        [ div [ class "cursor-pointer flex h-9 items-center justify-center ring-1 ring-[#DBE0E5] rounded-full w-9 hover:bg-white-30" ]
            [ facebookIcon
            ]
        , div [ class "cursor-pointer flex h-9 items-center justify-center ring-1 ring-[#DBE0E5] rounded-full w-9 hover:bg-white-30" ]
            [ twitterIcon
            ]
        , div [ class "cursor-pointer flex h-9 items-center justify-center ring-1 ring-[#DBE0E5] rounded-full w-9 hover:bg-white-30" ]
            [ instagramIcon ]
        , div [ class "cursor-pointer flex h-9 items-center justify-center ring-1 ring-[#DBE0E5] rounded-full w-9 hover:bg-white-30" ]
            [ linkedInIcon ]
        ]
