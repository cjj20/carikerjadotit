module Components.JobSort exposing (..)

import Components.SlideOver exposing (animationMobile, backBackground, closeButton)
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick, onMouseLeave)



-- MODEL


type alias Model =
    { buttonState : OpenCloseStateMsg
    , selected : SortItemModel
    }


type alias SortItemModel =
    { name : SortItemMsg
    , text : String
    , column : String
    , direction : String
    }



-- MSG


type Msg
    = ButtonState OpenCloseStateMsg
    | Select SortItemMsg


type SortItemMsg
    = Default
    | Latest
    | HighestSalary
    | LowestSalary



-- INIT


init : Model
init =
    { buttonState = Close
    , selected = { name = Default, text = "Default", column = "boosted", direction = "desc" }
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonState msg_ ->
            ( { model | buttonState = msg_ }, Cmd.none )

        Select msg_ ->
            ( { model | selected = sortItemMsgToSortItemModel msg_, buttonState = Close }, Cmd.none )



-- HELPER


sortItemMsgToSortItemModel : SortItemMsg -> SortItemModel
sortItemMsgToSortItemModel sortItemMsg =
    case sortItemMsg of
        Default ->
            { name = Default, text = "Default", column = "boosted", direction = "desc" }

        Latest ->
            { name = Latest, text = "Latest", column = "created_at", direction = "desc" }

        HighestSalary ->
            { name = HighestSalary, text = "Highest Salary", column = "salary_max", direction = "desc" }

        LowestSalary ->
            { name = LowestSalary, text = "Lowest Salary", column = "salary_min", direction = "asc" }


listSortItemMsg : List SortItemMsg
listSortItemMsg =
    [ Default, Latest, HighestSalary, LowestSalary ]



-- VIEW


dropDownView : Model -> Html Msg
dropDownView model =
    let
        dropDownClass =
            if model.buttonState == Open then
                class "absolute"

            else
                class "hidden"
    in
    div
        [ class "bg-white mt-2 rounded-xl shadow-lg w-[150px] top-[40px] right-auto z-50"
        , dropDownClass
        , onMouseLeave (ButtonState Close)
        ]
        [ div [] [ sortItemsView model ] ]


slideOverView : Model -> Html Msg
slideOverView model =
    div [ class "block relative z-50 md:hidden" ]
        [ backBackground model.buttonState
        , div [ animationMobile model.buttonState ]
            [ div [ class "flex items-end justify-center min-h-full" ]
                [ div [ class "bg-white flex flex-col rounded-t-xl w-full" ]
                    [ div [ class "flex flex-col gap-y-6 px-4 py-6" ]
                        [ div [ class "flex items-center" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ div [ onClick (ButtonState Close) ] [ closeButton ]
                                , span [ class "font-semibold text-xl text-black-90" ] [ text "Sort" ]
                                ]
                            ]
                        , div [] [ sortItemsView model ]
                        ]
                    ]
                ]
            ]
        ]


sortItemsView : Model -> Html Msg
sortItemsView { selected } =
    div [ class "flex flex-wrap gap-3 md:flex-col md:flex-nowrap md:gap-0 md:p-1" ]
        (listSortItemMsg
            |> List.map
                (\sortItemMsg ->
                    div
                        [ class "cursor-pointer flex gap-x-4 h-6 items-center outline rounded-[30px] hover:bg-white-30 md:h-8 md:outline-none md:rounded-lg"
                        , if selected.name == sortItemMsg then
                            class "bg-primary-2 font-semibold outline-primary-1 text-primary-1 md:bg-white"

                          else
                            class "bg-white outline-[#DBE0E5] text-black-90"
                        , onClick (Select sortItemMsg)
                        ]
                        [ span [ class "px-4 text-sm" ] [ text (sortItemMsgToSortItemModel sortItemMsg).text ] ]
                )
        )
