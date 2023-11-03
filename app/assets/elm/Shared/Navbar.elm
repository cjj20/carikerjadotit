module Shared.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Shared.SidebarMenu as SidebarMenu



-- MODEL


type alias Model =
    { sidebarMenuModel : SidebarMenu.Model
    }


type Msg
    = SidebarMenuUpdateMsg SidebarMenu.Msg



-- INIT


init : Model
init =
    { sidebarMenuModel = SidebarMenu.init }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SidebarMenuUpdateMsg msg_ ->
            let
                ( newUpdateModel, _ ) =
                    SidebarMenu.update msg_ model.sidebarMenuModel
            in
            ( { model | sidebarMenuModel = newUpdateModel }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "bg-white" ]
        [ nav [ class "border-b px-4" ]
            [ div [ class "flex h-16 items-center justify-between" ]
                [ div [ class "flex gap-x-4 items-center" ]
                    [ span [ class "font-semibold my-auto text-md text-gray-900 lg:text-[32px]" ] [ text "carikerja.it" ]
                    , span [ class "hidden my-auto text-xs text-slate-700 lg:block" ] [ text "#1 Job Board for tech industry in Indonesia and SEA" ]
                    ]
                , div [ class "flex flex-row gap-x-4 items-center" ]
                    [ a [ class "font-medium hidden no-underline rounded-xl text-sm text-primary-2 hover:bg-slate-100 hover:cursor-pointer lg:flex" ]
                        [ span [ class "p-2" ] [ text "Job offers" ]
                        ]
                    , a [ class "hidden no-underline rounded-xl text-sm text-slate-500 hover:bg-slate-100 hover:cursor-pointer lg:flex" ]
                        [ span [ class "p-2" ] [ text "Top Companies" ]
                        ]

                    --, a [ class "hidden rounded-xl no-underline text-slate-500 text-sm hover:bg-slate-100 hover:cursor-pointer lg:flex" ] [ text "Geek" ]
                    , a [ class "hidden items-center no-underline outline outline-slate-200 px-4 py-2 rounded-2xl hover:cursor-pointer hover:outline-slate-300 md:flex" ]
                        [ span [ class "text-sm text-slate-700" ] [ text "Post a job" ]
                        ]

                    --, a [ class "flex items-center bg-pink-500 rounded-2xl px-4 py-2 no-underline hover:bg-pink-800 hover:cursor-pointer flex space-x-2" ]
                    --[
                    --    span [ class "text-sm text-slate-50" ] [ text "Sign In" ]
                    --    , span [ class "fa-solid fa-chevron-down text-white text-sm" ] []
                    --]
                    , div [ class "h-10 hidden rounded-full w-12 hover:bg-slate-200 hover:cursor-pointer md:flex md:items-center md:justify-center" ]
                        [ a [ class "font-medium no-underline text-sm text-slate-500" ] [ text "IDR" ]
                        ]
                    , div
                        [ class "flex h-10 items-center justify-center rounded-full w-10 hover:cursor-pointer hover:bg-slate-200"
                        , onClick (SidebarMenuUpdateMsg SidebarMenu.ToggleMenu)
                        ]
                        [ a [ class "fa-solid fa-bars no-underline text-slate-700" ] []
                        ]
                    ]
                ]
            ]
        , Html.map SidebarMenuUpdateMsg <| SidebarMenu.view model.sidebarMenuModel
        ]
