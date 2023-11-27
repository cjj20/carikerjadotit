module Components.JobSearch exposing (..)

import Components.Badge exposing (more, searchWord)
import Components.Icons exposing (keywordIcon, magnifyingGlassBlueIcon, positionIcon, skillIcon)
import Components.Modal as Modal
import Components.SlideOver as SlideOver
import Helpers.Converter exposing (isValueInArray)
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Attribute, Html, div, input, span, text)
import Html.Attributes exposing (class, placeholder, value)
import Html.Events exposing (onClick, onInput, onMouseLeave)
import List exposing (isEmpty, length)
import List.Extra exposing (getAt)



-- MODEL


type alias Model =
    { dropDownState : OpenCloseStateMsg
    , slideOverState : OpenCloseStateMsg
    , keyword : String
    , inputValue : String
    , listInputTemp : List String
    , listInputValue : List String
    , listSkill : List String
    , listPosition : List String
    }



-- MSG


type Msg
    = DropDownState OpenCloseStateMsg
    | SlideOverState OpenCloseStateMsg
    | KeywordState String
    | AddInputTempState String Component
    | RemoveInputValueState String Component
    | SearchState


type Component
    = DropDown
    | SlideOver



-- INIT


init : Model
init =
    { dropDownState = Close
    , slideOverState = Close
    , keyword = ""
    , inputValue = ""
    , listInputTemp = []
    , listInputValue = []
    , listSkill = [ "Data Analysis Engineering", "Prompt Engineering", "Quality Engineering" ]
    , listPosition = [ "Active Directory Engineer", "AI Research Engineer" ]
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DropDownState msg_ ->
            ( { model | dropDownState = msg_ }, Cmd.none )

        SlideOverState msg_ ->
            ( { model | slideOverState = msg_ }, Cmd.none )

        KeywordState msg_ ->
            ( { model | inputValue = msg_, keyword = msg_ }, Cmd.none )

        AddInputTempState msg_ cpn_ ->
            let
                newListInputTemp =
                    if isValueInArray msg_ model.listInputTemp then
                        model

                    else
                        { model | listInputTemp = msg_ :: model.listInputTemp }

                newModel =
                    if cpn_ == DropDown then
                        { model | dropDownState = Close, listInputValue = newListInputTemp.listInputTemp }

                    else
                        model
            in
            ( { newModel | keyword = "", inputValue = "", listInputTemp = newListInputTemp.listInputTemp }, Cmd.none )

        RemoveInputValueState msg_ cpn_ ->
            let
                newListInputTemp =
                    List.filter (\item -> item /= msg_) model.listInputTemp

                newModel =
                    if cpn_ == DropDown then
                        { model | dropDownState = Close, listInputValue = newListInputTemp }

                    else
                        model
            in
            ( { newModel | listInputTemp = newListInputTemp }, Cmd.none )

        SearchState ->
            ( { model | slideOverState = Close, listInputValue = model.listInputTemp }, Cmd.none )



-- HELPER


placeholderClass : Model -> OpenCloseStateMsg -> Attribute msg
placeholderClass { listInputTemp } state =
    if not (isEmpty listInputTemp) && state == Close then
        class "placeholder:opacity-0"

    else
        class "placeholder:opacity-100"


listInputTempClass : Model -> Attribute msg
listInputTempClass { listInputTemp } =
    if not (List.isEmpty listInputTemp) then
        class "flex"

    else
        class "hidden"


listLastSearchClass : Model -> Attribute msg
listLastSearchClass { listInputValue } =
    if not (List.isEmpty listInputValue) then
        class "flex"

    else
        class "hidden"


keywordClass : Model -> Attribute msg
keywordClass { inputValue } =
    if not (String.isEmpty inputValue) then
        class "flex"

    else
        class "hidden"



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ dropDownView model, slideOverView model ]


dropDownView : Model -> Html Msg
dropDownView model =
    let
        inputGroupClass =
            if model.dropDownState == Open then
                class "absolute hidden md:block"

            else
                class "hidden"
    in
    div [ class "hidden relative z-50 md:block" ]
        [ div [ class "opacity-0", onClick (DropDownState Close) ] [ Modal.backBackground model.dropDownState ]
        , div
            [ class "bg-white max-h-[calc(100vh-200px)] px-6 py-6 rounded-xl shadow-lg overflow-y-auto -top-[20px] w-[371px]"
            , inputGroupClass
            , onMouseLeave (DropDownState Close)
            ]
            [ div [ class "flex flex-col gap-y-6 px-0.5 py-0.5" ]
                [ div [ listLastSearchClass model ] [ listLastSearchDesktopView model DropDown ]
                , div [ keywordClass model ] [ keywordView model DropDown ]
                , div [] [ listSkillView model DropDown ]
                , div [] [ listPositionView model DropDown ]
                ]
            ]
        ]


slideOverView : Model -> Html Msg
slideOverView model =
    div [ class "block relative z-50 md:hidden" ]
        [ SlideOver.backBackground model.slideOverState
        , div [ SlideOver.animationMobile model.slideOverState ]
            [ div [ class "flex items-end justify-center min-h-full" ]
                [ div [ class "bg-white flex flex-col rounded-t-xl w-full" ]
                    [ div [ class "flex flex-col gap-y-6 px-4 py-6 overflow-y-auto" ]
                        [ div [ class "flex items-center justify-between" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ div [ onClick (SlideOverState Close) ] [ SlideOver.closeButton ]
                                , span [ class "font-semibold text-xl text-black-90" ] [ text "Search" ]
                                ]
                            ]
                        , div [ class "flex flex-col gap-y-6 max-h-[calc(100vh-250px)] overflow-y-auto px-0.5 py-0.5" ]
                            [ div [] [ inputMobileView model ]
                            , div [ class "flex flex-col divide-y gap-y-6" ]
                                [ div [ listInputTempClass model ] [ listInputTempView model SlideOver ]
                                , div [ listLastSearchClass model ] [ listLastSearchMobileView model SlideOver ]
                                , div [ keywordClass model ] [ keywordView model SlideOver ]
                                , div [] [ listSkillView model SlideOver ]
                                , div [] [ listPositionView model SlideOver ]
                                ]
                            ]
                        , div [ onClick SearchState ] [ SlideOver.confirmButton "Show Offers" ]
                        ]
                    ]
                ]
            ]
        ]


inputDesktopView : Model -> Html Msg
inputDesktopView model =
    let
        wordBadgeList =
            if not (isEmpty model.listInputTemp) && model.dropDownState == Close then
                wordBadgeOnInput model

            else
                div [] []
    in
    div
        [ class "relative" ]
        [ div [ class "absolute flex gap-x-2 inset-y-0 left-0 pl-3" ]
            [ span [ class "pt-2.5" ] [ magnifyingGlassBlueIcon ]
            , div [ class "pt-1.5" ] [ wordBadgeList ]
            ]
        , input
            [ placeholder "Search"
            , class "bg-white border-0 h-9 min-w-[180px] outline outline-[#DBE0E5] pl-9 rounded-3xl text-sm text-black-90 disabled:bg-white"
            , placeholderClass model model.dropDownState
            , onInput KeywordState
            , value model.inputValue
            ]
            []
        ]


inputMobileView : Model -> Html Msg
inputMobileView model =
    div
        [ class "relative" ]
        [ div [ class "absolute flex gap-x-2 inset-y-0 left-0 pl-4" ]
            [ span [ class "pt-4" ] [ magnifyingGlassBlueIcon ] ]
        , input
            [ placeholder "Search"
            , class "bg-white border-0 h-12 outline outline-[#DBE0E5] pl-11 rounded-3xl text-sm text-black-90 w-full disabled:bg-white"
            , placeholderClass model model.slideOverState
            , onInput KeywordState
            , value model.inputValue
            ]
            []
        ]


wordBadgeOnInput : Model -> Html msg
wordBadgeOnInput { listInputTemp } =
    div [ class "flex flex-row gap-x-1" ]
        [ div [ class "md:w-20" ] [ searchWord (Maybe.withDefault "" (getAt 0 listInputTemp)) True ]
        , if length listInputTemp > 1 then
            div [] [ more (length listInputTemp - 1) ]

          else
            div [] []
        ]


listInputTempView : Model -> Component -> Html Msg
listInputTempView { listInputTemp } component =
    div [ class "flex flex-row flex-wrap gap-2" ]
        (listInputTemp
            |> List.map
                (\value -> div [ onClick (RemoveInputValueState value component) ] [ searchWord value True ])
        )


listLastSearchDesktopView : Model -> Component -> Html Msg
listLastSearchDesktopView { listInputValue } component =
    div [ class "flex flex-col gap-y-4 items-start text-black-90 pt-4" ]
        [ span [ class "font-semibold text-base" ] [ text "Last Searches" ]
        , div [ class "flex flex-row flex-wrap gap-2" ]
            (listInputValue
                |> List.map
                    (\value ->
                        div [ onClick (RemoveInputValueState value component) ] [ searchWord value True ]
                    )
            )
        ]


listLastSearchMobileView : Model -> Component -> Html Msg
listLastSearchMobileView { listInputValue } component =
    div [ class "flex flex-col gap-y-4 items-start text-black-90 pt-4" ]
        [ span [ class "font-semibold text-base" ] [ text "Last Searches" ]
        , div [ class "flex flex-row flex-wrap gap-2" ]
            (listInputValue
                |> List.map
                    (\value ->
                        div [ onClick (AddInputTempState value component) ] [ searchWord value False ]
                    )
            )
        ]


keywordView : Model -> Component -> Html Msg
keywordView { keyword, inputValue } component =
    div [ class "flex flex-col gap-y-4 items-start text-black-90 pt-4 w-full" ]
        [ span [ class "font-semibold text-base" ] [ text "Keyword" ]
        , div [ class "flex flex-col gap-y-4 w-full" ]
            [ div
                [ class "cursor-pointer flex flex-row gap-x-2 rounded-lg hover:bg-white-30"
                , onClick (AddInputTempState keyword component)
                ]
                [ div [ class "flex gap-x-2 items-center p-1" ]
                    [ keywordIcon
                    , span [ class "text-sm text-black-90" ] [ text keyword ]
                    ]
                ]
            ]
        ]


listSkillView : Model -> Component -> Html Msg
listSkillView { listSkill } component =
    div [ class "flex flex-col gap-y-4 items-start text-black-90 pt-4" ]
        [ span [ class "font-semibold text-base" ] [ text "Skills" ]
        , div [ class "flex flex-col gap-y-4 w-full" ]
            (listSkill
                |> List.map
                    (\value ->
                        div
                            [ class "cursor-pointer flex flex-row gap-x-2 rounded-lg hover:bg-white-30"
                            , onClick (AddInputTempState value component)
                            ]
                            [ div [ class "flex gap-x-2 items-center p-1" ]
                                [ skillIcon, span [ class "text-sm text-black-90" ] [ text value ] ]
                            ]
                    )
            )
        ]


listPositionView : Model -> Component -> Html Msg
listPositionView { listPosition } component =
    div [ class "flex flex-col gap-y-4 items-start text-black-90 pt-4" ]
        [ span [ class "font-semibold text-base" ] [ text "Position" ]
        , div [ class "flex flex-col gap-y-4 w-full" ]
            (listPosition
                |> List.map
                    (\value ->
                        div
                            [ class "cursor-pointer flex flex-row gap-x-2 rounded-lg hover:bg-white-30"
                            , onClick (AddInputTempState value component)
                            ]
                            [ div [ class "flex gap-x-2 items-center p-1" ]
                                [ positionIcon, span [ class "text-sm text-black-90" ] [ text value ] ]
                            ]
                    )
            )
        ]
