module Shared.TabJob exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onMouseLeave)



-- MODEL


type alias Model =
    { activeTab : TabMsg
    , remoteToggle : RemoteToggleMsg
    , sortDropDown : SortDropDownMsg
    , selectedSort : SortModel
    }


type alias SortModel =
    { name : SortMsg
    , text : String
    , column : String
    , direction : String
    }


type alias ListSortMsg =
    List SortMsg


type Msg
    = ActiveTab TabMsg
    | RemoteToggle
    | SortDropDown
    | SelectSort SortMsg


type TabMsg
    = WithSalary
    | AllOffers


type RemoteToggleMsg
    = On
    | Off


type SortDropDownMsg
    = Open
    | Close


type SortMsg
    = Default
    | Latest
    | HighestSalary
    | LowestSalary



-- INIT


init : Model
init =
    { activeTab = WithSalary
    , remoteToggle = Off
    , sortDropDown = Close
    , selectedSort =
        { name = Default, text = "Default", column = "created_at", direction = "asc" }
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

        SortDropDown ->
            let
                newModel =
                    if model.sortDropDown == Open then
                        { model | sortDropDown = Close }

                    else
                        { model | sortDropDown = Open }
            in
            ( newModel, Cmd.none )

        SelectSort selectedSort ->
            let
                newModel =
                    { model | selectedSort = sortMsgToSortModel selectedSort }
            in
            ( newModel, Cmd.none )



-- EXPRESSION


sortMsgToSortModel : SortMsg -> SortModel
sortMsgToSortModel sortMsg =
    case sortMsg of
        Default ->
            { name = Default, text = "Default", column = "created_at", direction = "asc" }

        Latest ->
            { name = Latest, text = "Latest", column = "created_at", direction = "desc" }

        HighestSalary ->
            { name = HighestSalary, text = "Highest Salary", column = "salary_max", direction = "desc" }

        LowestSalary ->
            { name = LowestSalary, text = "Lowest Salary", column = "salary_min", direction = "asc" }


listSortMsg : ListSortMsg
listSortMsg =
    [ Default, Latest, HighestSalary, LowestSalary ]



-- VIEW


view : Model -> Html Msg
view { activeTab, remoteToggle, sortDropDown, selectedSort } =
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
                [ div [ class "cursor-pointer flex gap-x-2 items-center px-2.5 py-1 rounded-xl hover:bg-gray-200", onClick SortDropDown ]
                    [ span [ class "text-sm text-slate-500" ] [ text "Default" ]
                    , i [ class "fa-solid fa-chevron-down text-sm text-slate-500" ] []
                    ]
                ]
            , sortDropDownView sortDropDown selectedSort
            ]
        ]


sortDropDownView : SortDropDownMsg -> SortModel -> Html Msg
sortDropDownView sortDropDownMsg sortModel =
    let
        dropDownClass =
            if sortDropDownMsg == Open then
                class "absolute"

            else
                class "hidden"

        listDropDownItems =
            List.map (\sortMsg -> sortDropDownItemView sortMsg sortModel) listSortMsg
    in
    div
        [ class "bg-white mr-4 mt-2 rounded-xl shadow-lg w-[140px] z-50 fixed top-28 md:top-[200px] md:right-0 md:right-auto md:mr-0"
        , dropDownClass
        , onMouseLeave SortDropDown
        ]
        [ div [ class "flex flex-col px-2 py-2 max-w-sm" ]
            listDropDownItems
        ]


sortDropDownItemView : SortMsg -> SortModel -> Html Msg
sortDropDownItemView sortMsg sortModel =
    let
        textColorActiveSort =
            if sortMsg == sortModel.name then
                class "text-primary-2"

            else
                class "text-slate-400"

        textSort =
            (sortMsgToSortModel sortMsg).text
    in
    span
        [ class "cursor-pointer px-2 py-1 text-base text-primary-2 hover:bg-gray-100 hover:rounded-lg"
        , textColorActiveSort
        , onClick (SelectSort sortMsg)
        ]
        [ text textSort ]
