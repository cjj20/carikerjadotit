module Shared.TabJob exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    { activeTab : Tab
    , toggleRemote : Bool
    , sortDropdownOpen : Bool
    }


type Msg
    = ActiveTab Tab
    | ToggleRemote
    | SortDropdownOpen


type Tab
    = WithSalary
    | AllOffers



-- INIT


init : Model
init =
    { activeTab = WithSalary, toggleRemote = False, sortDropdownOpen = False }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ActiveTab clickedTab ->
            let
                newModel =
                    { model | activeTab = clickedTab }
            in
            ( newModel, Cmd.none )

        ToggleRemote ->
            let
                newModel =
                    if model.toggleRemote == False then
                        { model | toggleRemote = True }

                    else
                        { model | toggleRemote = False }
            in
            ( newModel, Cmd.none )

        SortDropdownOpen ->
            let
                newModel =
                    if model.sortDropdownOpen == False then
                        { model | sortDropdownOpen = True }

                    else
                        { model | sortDropdownOpen = False }
            in
            ( newModel, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "bg-white flex gap-x-1.5 justify-between no-scrollbar overflow-x-scroll px-4" ]
        [ div [ class "flex" ]
            [ div
                [ class "cursor-pointer flex items-center px-4 py-2 md:px-6 md:py-2.5"
                , if model.activeTab == WithSalary then
                    class "bg-gray-100 rounded-t-xl md:rounded-t-3xl"

                  else
                    class "bg-white hover:bg-gray-200 hover:rounded-t-xl hover:md:rounded-t-3xl"
                , onClick (ActiveTab WithSalary)
                ]
                [ span [ class "text-sm text-slate-500 truncate" ] [ text "With salary" ]
                ]
            , div
                [ class "cursor-pointer flex items-center px-4 py-2 md:px-6 md:py-2.5"
                , if model.activeTab == AllOffers then
                    class "bg-gray-100 rounded-t-xl md:rounded-t-3xl"

                  else
                    class "bg-white hover:bg-gray-200 hover:rounded-t-xl hover:md:rounded-t-3xl"
                , onClick (ActiveTab AllOffers)
                ]
                [ span [ class "text-sm text-slate-500 truncate" ] [ text "All offers", span [ class "font-medium pl-2 text-primary-2" ] [ text "13 433 offers" ] ]
                ]
            ]
        , div [ class "flex gap-x-4 items-center justify-center" ]
            [ div [ class "cursor-pointer flex gap-x-2 items-center", onClick ToggleRemote ]
                [ span [ class "text-sm text-slate-500" ] [ text "Remote" ]
                , i
                    [ class "hidden fa-solid text-xl text-slate-400 lg:block"
                    , if model.toggleRemote then
                        class "fa-toggle-on"

                      else
                        class "fa-toggle-off"
                    ]
                    []
                ]
            , div [ class "hidden relative md:block" ]
                [ div [ class "cursor-pointer flex gap-x-2 items-center px-2.5 py-1 rounded-xl hover:bg-gray-200", onClick SortDropdownOpen ]
                    [ span [ class "text-sm text-slate-500" ] [ text "Default" ]
                    , i [ class "fa-solid fa-chevron-down text-sm text-slate-500" ] []
                    ]
                , sortDropdownView model
                ]
            ]
        ]


sortDropdownView : Model -> Html Msg
sortDropdownView model =
    div
        [ class "bg-white mr-4 mt-2 right-0 rounded-xl shadow-lg top-28 w-[140px] z-10 sm:mr-0 sm:right-auto md:top-5 md:-left-[55px]"
        , if model.sortDropdownOpen then
            class "absolute"

          else
            class "hidden"
        ]
        [ div [ class "flex flex-col px-2 py-2 max-w-sm" ]
            [ span [ class "cursor-pointer px-2 py-1 text-base text-primary-2 hover:bg-gray-100 hover:rounded-lg" ] [ text "Default" ]
            , span [ class "cursor-pointer px-2 py-1 text-base text-slate-400 hover:bg-gray-100 hover:rounded-lg" ] [ text "Latest" ]
            , span [ class "cursor-pointer px-2 py-1 text-base text-slate-400 hover:bg-gray-100 hover:rounded-lg" ] [ text "Highest Salary" ]
            , span [ class "cursor-pointer px-2 py-1 text-base text-slate-400 hover:bg-gray-100 hover:rounded-lg" ] [ text "Lowest Salary" ]
            ]
        ]
