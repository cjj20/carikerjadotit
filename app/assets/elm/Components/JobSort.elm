module Components.JobSort exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onMouseLeave)



-- MODEL


type alias Model =
    { buttonState : ButtonStateMsg
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
    = ButtonState
    | Select SortMsg


type ButtonStateMsg
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
    { buttonState = Close
    , selected =
        { name = Default, text = "Default", column = "created_at", direction = "asc" }
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonState ->
            let
                newModel =
                    if model.buttonState == Open then
                        { model | buttonState = Close }

                    else
                        { model | buttonState = Open }
            in
            ( newModel, Cmd.none )

        Select msg_ ->
            let
                newModel =
                    { model | selected = sortMsgToSortModel msg_, buttonState = Close }
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
dropDownView { buttonState, selected } =
    let
        dropDownClass =
            if buttonState == Open then
                class "absolute"

            else
                class "hidden"

        dropDownItems =
            List.map (\sortMsg -> dropDownItemView sortMsg selected) listSortMsg
    in
    div
        [ class "bg-white mt-2 rounded-xl shadow-lg w-[140px] top-[170px] right-auto z-50"
        , dropDownClass
        , onMouseLeave ButtonState
        ]
        [ div [ class "flex flex-col px-2 py-2 max-w-sm" ]
            dropDownItems
        ]


dropDownItemView : SortMsg -> SortModel -> Html Msg
dropDownItemView sortMsg { name } =
    let
        sortActiveTextColor =
            if sortMsg == name then
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


slideOverView : Model -> Html Msg
slideOverView { buttonState, selected } =
    let
        closeSlideOverButton =
            a
                [ class "border cursor-pointer flex h-10 items-center justify-center no-underline rounded-full w-10 hover:bg-slate-200"
                , onClick ButtonState
                ]
                [ i [ class "fa-solid fa-close text-2xl text-slate-700" ] []
                ]

        slideOverBackground =
            if buttonState == Open then
                class "block"

            else
                class "hidden"

        slideOverAnimation =
            if buttonState == Open then
                class "translate-y-0"

            else
                class "translate-y-full"

        sortItems =
            div [ class "flex flex-wrap gap-3" ]
                (List.map
                    (\sortMsg ->
                        div
                            [ class "bg-white flex gap-x-4 h-6 items-center outline rounded-[30px]"
                            , if selected.name == sortMsg then
                                class "outline-primary-1"

                              else
                                class "outline-slate-200"
                            , onClick (Select sortMsg)
                            ]
                            [ span
                                [ class "px-4 text-sm text-slate-700" ]
                                [ text (sortMsgToSortModel sortMsg).text ]
                            ]
                    )
                    listSortMsg
                )
    in
    div []
        [ div
            [ class "bg-gray-500 bg-opacity-75 fixed inset-0 transition-opacity"
            , slideOverBackground
            ]
            []
        , div
            [ class "duration-500 ease-in-out fixed inset-0 transition z-10 md:hidden"
            , slideOverAnimation
            ]
            [ div [ class "flex items-end justify-center min-h-full" ]
                [ div [ class "bg-white flex flex-col rounded-t-3xl w-full" ]
                    [ div [ class "flex flex-col gap-y-6 px-4 py-6" ]
                        [ div [ class "flex items-center" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ closeSlideOverButton
                                , span [ class "font-medium leading-5 text-[#242632] text-xl" ] [ text "Sort" ]
                                ]
                            ]
                        , sortItems
                        ]
                    ]
                ]
            ]
        ]
