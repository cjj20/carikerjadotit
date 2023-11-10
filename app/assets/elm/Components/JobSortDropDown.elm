module Components.JobSortDropDown exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onMouseLeave)



-- MODEL


type alias Model =
    { dropDownState : DropDownStateMsg
    , selected : SortModel
    }


type alias SortModel =
    { name : SortMsg
    , text : String
    , column : String
    , direction : String
    }



-- MSG


type Msg
    = DropDownState
    | Select SortMsg


type DropDownStateMsg
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
    { dropDownState = Close
    , selected =
        { name = Default, text = "Default", column = "created_at", direction = "asc" }
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DropDownState ->
            let
                newModel =
                    if model.dropDownState == Open then
                        { model | dropDownState = Close }

                    else
                        { model | dropDownState = Open }
            in
            ( newModel, Cmd.none )

        Select msg_ ->
            let
                newModel =
                    { model | selected = sortMsgToSortModel msg_, dropDownState = Close }
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


listSortMsg : List SortMsg
listSortMsg =
    [ Default, Latest, HighestSalary, LowestSalary ]



-- VIEW


dropDownView : Model -> Html Msg
dropDownView model =
    let
        dropDownClass =
            if model.dropDownState == Open then
                class "absolute"

            else
                class "hidden"

        dropDownItems =
            List.map (\sortMsg -> dropDownItemView sortMsg model.selected) listSortMsg
    in
    div
        [ class "bg-white mr-4 mt-2 rounded-xl shadow-lg w-[140px] z-50 fixed top-28 md:top-[200px] md:right-auto md:mr-0"
        , dropDownClass
        ]
        [ div [ class "flex flex-col px-2 py-2 max-w-sm" ]
            dropDownItems
        ]


dropDownItemView : SortMsg -> SortModel -> Html Msg
dropDownItemView sortMsg sortModel =
    let
        sortActiveTextColor =
            if sortMsg == sortModel.name then
                class "text-primary-2"

            else
                class "text-slate-400"

        sortText =
            (sortMsgToSortModel sortMsg).text
    in
    span
        [ class "cursor-pointer px-2 py-1 text-base text-primary-2 hover:bg-gray-100 hover:rounded-lg"
        , sortActiveTextColor
        , onClick (Select sortMsg)
        ]
        [ text sortText ]
