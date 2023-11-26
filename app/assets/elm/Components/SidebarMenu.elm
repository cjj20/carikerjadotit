module Components.SidebarMenu exposing (..)

import Components.Icons exposing (fileLinesIcon, questionMarkIcon, rocketIcon)
import Components.SlideOver exposing (animationDesktop, animationMobile, backBackground, closeButton)
import Components.SocialMedia as SocialMedia
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Html, div, h6, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    { buttonState : OpenCloseStateMsg
    }


type Msg
    = ButtonState OpenCloseStateMsg



-- INIT


init : Model
init =
    { buttonState = Close }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonState msg_ ->
            ( { model | buttonState = msg_ }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ desktopView model, slideOverView model ]


desktopView : Model -> Html Msg
desktopView model =
    div [ class "hidden relative z-50 md:block" ]
        [ backBackground model.buttonState
        , div [ animationDesktop model.buttonState ]
            [ div [ class "flex h-full items-end justify-center" ]
                [ div [ class "bg-white flex flex-col h-full justify-between rounded-l-xl w-[352px]" ]
                    [ div [ class "flex flex-col gap-y-8 h-full px-6 py-6" ]
                        [ div [ class "flex items-center justify-between" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ div [ onClick (ButtonState Close) ] [ closeButton ]
                                , span [ class "font-semibold text-xl text-black-90" ] [ text "Menu" ]
                                ]
                            ]
                        , div [ class "flex flex-col gap-y-8 h-full overflow-y-auto px-0.5" ]
                            [ div [] [ menuListView ]
                            ]
                        , div [ class "flex flex-col gap-y-6 px-4" ]
                            [ h6 [ class "font-semibold text-base text-black-90" ] [ text "Follow us" ]
                            , SocialMedia.view
                            ]
                        ]
                    ]
                ]
            ]
        ]


slideOverView : Model -> Html Msg
slideOverView model =
    div [ class "block relative z-50 md:hidden" ]
        [ backBackground model.buttonState
        , div [ animationMobile model.buttonState ]
            [ div [ class "flex items-end justify-center min-h-full" ]
                [ div [ class "bg-white flex flex-col h-[calc(100vh-80px)] rounded-t-xl w-full" ]
                    [ div [ class "flex flex-col gap-y-6 h-full px-4 py-6" ]
                        [ div [ class "flex items-center justify-between" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ div [ onClick (ButtonState Close) ] [ closeButton ]
                                , span [ class "font-semibold text-xl text-black-90" ] [ text "Menu" ]
                                ]
                            ]
                        , div [ class "flex flex-col gap-y-8 h-full overflow-y-auto px-0.5" ]
                            [ div [] [ menuListView ]
                            ]
                        , div [ class "flex flex-col gap-y-6 px-4" ]
                            [ h6 [ class "font-semibold text-base text-black-90" ] [ text "Follow us" ]
                            , SocialMedia.view
                            ]
                        ]
                    ]
                ]
            ]
        ]


menuListView : Html msg
menuListView =
    div [ class "flex flex-col" ]
        [ div [ class "cursor-pointer flex flex-row gap-x-4 h-14 items-center p-4 rounded-xl w-full hover:bg-white-30" ]
            [ rocketIcon
            , div [ class "font-semibold text-base text-black-90" ] [ text "Career" ]
            ]
        , div [ class "cursor-pointer flex flex-row gap-x-4 h-14 items-center p-4 rounded-xl w-full hover:bg-white-30" ]
            [ questionMarkIcon
            , div [ class "font-semibold text-base text-black-90" ] [ text "Help" ]
            ]
        , div [ class "cursor-pointer flex flex-row gap-x-4 h-14 items-center p-4 rounded-xl w-full hover:bg-white-30" ]
            [ fileLinesIcon
            , div [ class "font-semibold text-base text-black-90" ] [ text "Terms" ]
            ]
        ]
