module Shared.TabJob exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Shared.SortDropDown as SortDropDown



-- MODEL


type alias Model =
    { activeTab : TabMsg
    , remoteToggle : RemoteToggleMsg
    , sortDropDownModel : SortDropDown.Model
    }


type Msg
    = ActiveTab TabMsg
    | RemoteToggle
    | SortDropDownMsg SortDropDown.Msg


type TabMsg
    = WithSalary
    | AllOffers


type RemoteToggleMsg
    = On
    | Off



-- INIT


init : Model
init =
    { activeTab = WithSalary
    , remoteToggle = Off
    , sortDropDownModel = SortDropDown.init
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ActiveTab activedTab ->
            let
                newModel =
                    { model | activeTab = activedTab }
            in
            ( newModel, Cmd.none )

        RemoteToggle ->
            let
                newModel =
                    if model.remoteToggle == On then
                        { model | remoteToggle = Off }

                    else
                        { model | remoteToggle = On }
            in
            ( newModel, Cmd.none )

        SortDropDownMsg msg_ ->
            let
                ( newUpdateTabJobModel, _ ) =
                    SortDropDown.update msg_ model.sortDropDownModel
            in
            ( { model | sortDropDownModel = newUpdateTabJobModel }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view { activeTab, remoteToggle, sortDropDownModel } =
    let
        activeTabWithSalaryClass =
            if activeTab == WithSalary then
                class "bg-gray-100 rounded-t-xl md:rounded-t-3xl"

            else
                class "bg-white hover:bg-gray-200 hover:rounded-t-xl hover:md:rounded-t-3xl"

        activeTabAllOffersClass =
            if activeTab == AllOffers then
                class "bg-gray-100 rounded-t-xl md:rounded-t-3xl"

            else
                class "bg-white hover:bg-gray-200 hover:rounded-t-xl hover:md:rounded-t-3xl"

        remoteToggleClass =
            if remoteToggle == On then
                class "fa-toggle-on"

            else
                class "fa-toggle-off"
    in
    div [ class "bg-white flex gap-x-1.5 justify-between no-scrollbar overflow-x-scroll px-4" ]
        [ div [ class "flex" ]
            [ div
                [ class "cursor-pointer flex items-center px-4 py-2 md:px-6 md:py-2.5"
                , activeTabWithSalaryClass
                , onClick (ActiveTab WithSalary)
                ]
                [ span [ class "text-sm text-slate-500 truncate" ] [ text "With salary" ]
                ]
            , div
                [ class "cursor-pointer flex items-center px-4 py-2 md:px-6 md:py-2.5"
                , activeTabAllOffersClass
                , onClick (ActiveTab AllOffers)
                ]
                [ span [ class "text-sm text-slate-500 truncate" ] [ text "All offers", span [ class "font-medium pl-2 text-primary-2" ] [ text "13 433 offers" ] ]
                ]
            ]
        , div [ class "flex gap-x-4 items-center justify-end" ]
            [ div [ class "cursor-pointer flex gap-x-2 items-center", onClick RemoteToggle ]
                [ span [ class "text-sm text-slate-500" ] [ text "Remote" ]
                , i
                    [ class "hidden fa-solid text-xl text-slate-400 lg:block", remoteToggleClass ]
                    []
                ]
            , div [ class "hidden md:block" ]
                [ div [ class "cursor-pointer flex gap-x-2 items-center px-2.5 py-1 rounded-xl hover:bg-gray-200", onClick (SortDropDownMsg SortDropDown.SortDropDown) ]
                    [ span [ class "text-sm text-slate-500" ] [ text "Default" ]
                    , i [ class "fa-solid fa-chevron-down text-sm text-slate-500" ] []
                    ]
                ]
            , Html.map SortDropDownMsg <| SortDropDown.sortDropDownView sortDropDownModel.sortDropDown sortDropDownModel.selectedSort
            ]
        ]
