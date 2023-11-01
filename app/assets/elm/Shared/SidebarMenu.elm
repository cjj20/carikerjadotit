module Shared.SidebarMenu exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Shared.SocialMedia as SocialMedia



-- MODEL


type alias Model =
    { menuOpen : Bool
    }


type Msg
    = ToggleMenu



-- INIT


init : Model
init =
    { menuOpen = False }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleMenu ->
            let
                newModel =
                    if model.menuOpen == False then
                        { model | menuOpen = True }

                    else
                        { model | menuOpen = False }
            in
            ( newModel, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "relative z-10" ]
        [ div
            [ class "bg-slate-500 bg-opacity-20 fixed inset-0 transition-opacity"
            , if model.menuOpen then
                class "block"

              else
                class "hidden"
            , onClick ToggleMenu
            ]
            []
        , div
            [ class "bg-white duration-500 ease-in-out fixed inset-y-0 hidden max-w-sm rounded-l-2xl overflow-y-auto px-6 pt-6 pb-24 right-0 transition w-full md:block"
            , if model.menuOpen then
                class "translate-x-0"

              else
                class "translate-x-full"
            ]
            [ div [ class "flex flex-col h-full justify-between" ]
                [ div []
                    [ div [ class "flex items-center justify-between" ]
                        [ div [ class "flex gap-x-4 items-center" ]
                            [ a [ class "border flex h-10 items-center justify-center no-underline rounded-full w-10 hover:bg-slate-200", onClick ToggleMenu ]
                                [ i [ class "fa-solid fa-close text-2xl text-slate-700" ] []
                                ]
                            , span [ class "font-medium text-xl text-slate-600" ] [ text "Menu" ]
                            ]
                        , div []
                            [ div [ class "flex gap-x-2 items-center justify-center rounded-2xl outline outline-slate-200 h-8 w-20" ]
                                [ span [ class "font-medium text-sm text-slate-600" ] [ text "IDR" ]
                                , i [ class "fa-solid fa-chevron-down text-sm text-slate-600" ] []
                                ]
                            ]
                        ]
                    , div [ class "py-8" ]
                        [ div [ class "flex flex-col gap-y-2" ]
                            [ div [ class "flex flex-row gap-x-3 items-center px-4 py-2 rounded-lg w-full hover:bg-gray-100 lg:hidden" ]
                                [ i [ class "fa-solid fa-briefcase text-slate-500 w-4" ] []
                                , a [ class "font-semibold no-underline text-base text-slate-500 " ] [ text "Offers" ]
                                ]
                            , div [ class "flex flex-row gap-x-3 items-center px-4 py-2 rounded-lg w-full hover:bg-gray-100 lg:hidden" ]
                                [ i [ class "fa-solid fa-building text-slate-500 w-4" ] []
                                , a [ class "font-semibold no-underline text-base text-slate-500 " ] [ text "Top Companies" ]
                                ]
                            , div [ class "flex flex-row gap-x-3 items-center px-4 py-2 rounded-lg w-full hover:bg-gray-100" ]
                                [ i [ class "fa-solid fa-file-lines text-slate-500 w-4" ] []
                                , a [ class "font-semibold no-underline text-base text-slate-500 " ] [ text "Terms" ]
                                ]
                            ]
                        ]
                    ]
                , div [ class "flex items-center justify-center" ]
                    [ div [ class "flex flex-col gap-y-6" ]
                        [ h6 [ class "text-sm text-slate-500" ] [ text "Follow us on social media" ]
                        , SocialMedia.view
                        ]
                    ]
                ]
            ]
        , div
            [ class "bg-white block duration-500 ease-in-out fixed h-full overflow-y-auto px-6 pt-6 pb-24 rounded-t-2xl transition w-full md:hidden"
            , if model.menuOpen then
                class "translate-y-0"

              else
                class "translate-y-full"
            ]
            [ div [ class "flex flex-col h-full justify-between" ]
                [ div []
                    [ div [ class "flex items-center justify-between" ]
                        [ div [ class "flex gap-x-4 items-center" ]
                            [ a [ class "border flex h-10 items-center justify-center no-underline rounded-full w-10 hover:bg-slate-200", onClick ToggleMenu ]
                                [ i [ class "fa-solid fa-close text-2xl text-slate-700" ] []
                                ]
                            , span [ class "font-medium text-xl text-slate-600" ] [ text "Menu" ]
                            ]
                        , div []
                            [ div [ class "flex gap-x-2 items-center justify-center rounded-2xl outline outline-slate-200 h-8 w-20" ]
                                [ span [ class "font-medium text-sm text-slate-600" ] [ text "IDR" ]
                                , i [ class "fa-solid fa-chevron-down text-sm text-slate-600" ] []
                                ]
                            ]
                        ]
                    , div [ class "py-8" ]
                        [ div [ class "flex flex-col gap-y-2" ]
                            [ div [ class "flex flex-row gap-x-3 items-center px-4 py-2 rounded-lg w-full hover:bg-gray-100" ]
                                [ i [ class "fa-solid fa-briefcase text-slate-500 w-4" ] []
                                , a [ class "font-semibold no-underline text-base text-slate-500 " ] [ text "Offers" ]
                                ]
                            , div [ class "flex flex-row gap-x-3 items-center px-4 py-2 rounded-lg w-full hover:bg-gray-100" ]
                                [ i [ class "fa-solid fa-building text-slate-500 w-4" ] []
                                , a [ class "font-semibold no-underline text-base text-slate-500 " ] [ text "Top Companies" ]
                                ]
                            , div [ class "flex flex-row gap-x-3 items-center px-4 py-2 rounded-lg w-full hover:bg-gray-100" ]
                                [ i [ class "fa-solid fa-file-lines text-slate-500 w-4" ] []
                                , a [ class "font-semibold no-underline text-base text-slate-500 " ] [ text "Terms" ]
                                ]
                            ]
                        ]
                    ]
                , div [ class "flex items-center justify-center" ]
                    [ div [ class "flex flex-col gap-y-6" ]
                        [ h6 [ class "text-sm text-slate-500" ] [ text "Follow us on social media" ]
                        , SocialMedia.view
                        ]
                    ]
                ]
            ]
        ]
