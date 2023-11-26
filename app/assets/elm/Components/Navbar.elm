module Components.Navbar exposing (..)

import Components.Icons exposing (burgerMenuIcon)
import Components.SidebarMenu as SidebarMenu
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Html, div, nav, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    { sidebarMenuModel : SidebarMenu.Model }



-- MSG


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
                ( newSidebarMenuModel, _ ) =
                    SidebarMenu.update msg_ model.sidebarMenuModel
            in
            ( { model | sidebarMenuModel = newSidebarMenuModel }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "bg-white border-b" ]
        [ nav [ class "px-4 lg:px-[140px]" ]
            [ div [ class "flex h-20 items-center justify-between" ]
                [ div [ class "flex gap-x-4 items-center" ]
                    [ span [ class "font-bold my-auto text-lg" ]
                        [ span [ class "text-primary-1" ] [ text "Cari" ]
                        , span [ class "text-black" ] [ text "Kerja.IT" ]
                        ]
                    ]
                , div [ class "flex flex-row gap-x-3 items-center md:gap-x-4" ]
                    [ div [ class "bg-primary-1 cursor-pointer flex h-10 items-center justify-center rounded-3xl w-[78px] hover:bg-primary-2 lg:h-12 lg:w-[117px]" ]
                        [ span [ class "font-semibold text-sm text-white lg:text-base" ] [ text "Sign In" ] ]
                    , div
                        [ class "cursor-pointer flex h-6 items-center justify-center rounded-lg w-6 hover:bg-white-30"
                        , onClick (SidebarMenuUpdateMsg (SidebarMenu.ButtonState Open))
                        ]
                        [ burgerMenuIcon ]
                    ]
                ]
            ]
        , div [] [ Html.map SidebarMenuUpdateMsg <| SidebarMenu.view model.sidebarMenuModel ]
        ]
