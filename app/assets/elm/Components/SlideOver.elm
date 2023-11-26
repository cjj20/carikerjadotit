module Components.SlideOver exposing (..)

import Components.Icons exposing (close24Icon)
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Attribute, Html, div, span, text)
import Html.Attributes exposing (class)



-- VIEW


animationMobile : OpenCloseStateMsg -> Attribute msg
animationMobile slideOverStateMsg =
    if slideOverStateMsg == Open then
        class "duration-500 ease-in-out fixed inset-0 transition translate-y-0 z-10 md:hidden"

    else
        class "duration-500 ease-in-out fixed inset-0 transition translate-y-full z-10 md:hidden"


animationDesktop : OpenCloseStateMsg -> Attribute msg
animationDesktop slideOverStateMsg =
    if slideOverStateMsg == Open then
        class "duration-500 ease-in-out fixed inset-y-0 right-0 transition translate-x-0 md:block"

    else
        class "duration-500 ease-in-out fixed inset-y-0 right-0 transition translate-x-full md:block"


backBackground : OpenCloseStateMsg -> Html msg
backBackground slideOverStateMsg =
    if slideOverStateMsg == Open then
        div [ class "block fixed bg-gray-500 bg-opacity-75 inset-0 transition-opacity" ] []

    else
        div [ class "hidden" ] []


closeButton : Html msg
closeButton =
    div [ class "cursor-pointer flex h-10 items-center justify-center outline outline-[#DBE0E5] rounded-full w-10 hover:bg-slate-200" ]
        [ close24Icon ]


rightTitleSectionButton : String -> Html msg
rightTitleSectionButton label =
    div [ class "cursor-pointer flex h-10 items-center justify-center no-underline w-20" ]
        [ span [ class "text-sm text-primary-1" ] [ text label ] ]


confirmButton : String -> Html msg
confirmButton label =
    div [ class "bg-primary-1 cursor-pointer flex font-semibold h-12 items-center justify-center py-3.5 rounded-3xl text-sm text-white w-full" ]
        [ text label ]
