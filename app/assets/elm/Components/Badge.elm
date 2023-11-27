module Components.Badge exposing (..)

import Components.Icons exposing (close16Icon)
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)
import String exposing (fromInt)


searchWord : String -> Bool -> Html msg
searchWord label icon =
    let
        closeIconDisplay =
            if icon == True then
                span [ class "cursor-pointer h-4 ml-2 text-sm w-4 flex items-center" ] [ close16Icon ]

            else
                span [] []
    in
    div [ class "bg-black cursor-pointer flex flex-row h-8 md:h-6 items-center px-3 rounded-[30px]" ]
        [ span [ class "leading-3 text-xs text-white truncate" ] [ text label ]
        , closeIconDisplay
        ]


more : Int -> Html msg
more length =
    div [ class "bg-black flex flex-row justify-center h-8 md:h-6 items-center px-3 rounded-[30px]" ]
        [ span [ class "leading-3 text-xs text-white" ] [ text ("+" ++ fromInt length) ]
        ]


locationWord : String -> String -> Html msg
locationWord label selected =
    div
        [ class "cursor-pointer flex h-9 items-center justify-center px-4 py-2 outline rounded-[30px]"
        , if label == selected then
            class "bg-primary-2 outline-primary-1 text-primary-1"

          else
            class "bg-white outline-[#DBE0E5] text-black-90"
        ]
        [ span [ class "capitalize text-base" ] [ text label ] ]
