module Components.SortDropDown exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onMouseLeave)



-- MODEL


type alias Model =
    { sortDropDown : SortDropDownMsg
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
    = SortDropDown
    | SelectSort SortMsg


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
    { sortDropDown = Close
    , selectedSort =
        { name = Default, text = "Default", column = "created_at", direction = "asc" }
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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
