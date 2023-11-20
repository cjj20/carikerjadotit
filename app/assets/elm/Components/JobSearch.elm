module Components.JobSearch exposing (..)

import Components.Icons exposing (keywordIcon, positionIcon, skillIcon)
import Helpers.Converter exposing (isValueInArray, mergedList)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onMouseLeave)
import List exposing (isEmpty, length)
import List.Extra exposing (getAt)
import String exposing (fromInt)



-- MODEL


type alias Model =
    { inputGroupState : InputGroupStateMsg
    , inputValue : String
    , inputFocus : Bool
    , listInputTemp : List String
    , listInputValue : List String
    , lastSearchList : List String
    , keyword : String
    , listSkill : List String
    , listPosition : List String
    }



-- MSG


type Msg
    = InputGroupState InputGroupStateMsg
    | LastSearchListState String
    | InputFocusState InputGroup Bool
    | KeywordState String
    | ListInputValueState InputGroup String
    | SearchState


type InputGroupStateMsg
    = Open
    | Close


type InputGroup
    = Desktop
    | Mobile



-- INIT


init : Model
init =
    { inputGroupState = Close
    , inputValue = ""
    , inputFocus = False
    , listInputTemp = []
    , listInputValue = []
    , lastSearchList = []
    , keyword = ""
    , listSkill = [ "Data Analysis Engineering", "Prompt Engineering", "Quality Engineering" ]
    , listPosition = [ "Active Directory Engineer", "AI Research Engineer" ]
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputGroupState msg_ ->
            let
                newModel =
                    if msg_ == Open then
                        { model
                            | inputGroupState = msg_
                            , inputFocus = False
                            , listInputTemp = model.listInputValue
                        }

                    else
                        { model
                            | inputGroupState = msg_
                            , inputFocus = False
                            , listInputTemp = model.listInputTemp
                        }
            in
            ( newModel, Cmd.none )

        ListInputValueState inputGroup inputValue ->
            let
                newListInputValue =
                    if isValueInArray inputValue model.listInputTemp then
                        { model
                            | listInputTemp = List.filter (\item -> item /= inputValue) model.listInputTemp
                        }

                    else
                        { model
                            | listInputTemp = inputValue :: model.listInputTemp
                        }

                newInputGroupStateModel =
                    if inputGroup == Desktop then
                        { model
                            | inputGroupState = Close
                            , listInputValue = newListInputValue.listInputTemp
                            , lastSearchList = mergedList model.lastSearchList model.listInputValue
                        }

                    else
                        model

                newModel =
                    { model
                        | inputGroupState = newInputGroupStateModel.inputGroupState
                        , inputFocus = False
                        , listInputTemp = newListInputValue.listInputTemp
                        , listInputValue = newInputGroupStateModel.listInputValue
                        , lastSearchList = newInputGroupStateModel.lastSearchList
                        , inputValue = ""
                        , keyword = ""
                    }
            in
            ( newModel, Cmd.none )

        InputFocusState inputGroup inputFocus ->
            let
                newModel =
                    if inputGroup == Desktop then
                        { model | inputFocus = inputFocus, inputGroupState = Open }

                    else
                        { model | inputFocus = inputFocus, inputGroupState = Open }
            in
            ( newModel, Cmd.none )

        LastSearchListState msg_ ->
            let
                newModel =
                    { model
                        | inputValue = ""
                        , lastSearchList = List.filter (\item -> item /= msg_) model.lastSearchList
                        , keyword = ""
                    }
            in
            ( newModel, Cmd.none )

        KeywordState msg_ ->
            let
                newModel =
                    { model
                        | inputValue = msg_
                        , inputFocus = True
                        , keyword = msg_
                    }
            in
            ( newModel, Cmd.none )

        SearchState ->
            let
                newModel =
                    { model
                        | inputGroupState = Close
                        , lastSearchList = mergedList model.lastSearchList model.listInputTemp
                        , listInputValue = model.listInputTemp
                    }
            in
            ( newModel, Cmd.none )



-- VIEW


inputView : InputGroup -> Model -> Html Msg
inputView inputGroup { inputValue, inputFocus, listInputTemp } =
    let
        wordBadgeOnInput =
            if not (isEmpty listInputTemp) then
                div
                    [ class " flex-row gap-x-2"
                    , if inputFocus == True then
                        class "hidden"

                      else
                        class "flex"
                    ]
                    [ div [ class "bg-black flex gap-x-1 h-6 items-center pl-2 pr-1 rounded-[30px] max-w-[80px]" ]
                        [ span
                            [ class "leading-3 text-xs text-white truncate" ]
                            [ text (Maybe.withDefault "" (getAt 0 listInputTemp))
                            ]
                        , i
                            [ class "cursor-pointer fa-solid fa-close text-sm p-1"
                            , onClick
                                (ListInputValueState inputGroup
                                    (Maybe.withDefault "" (getAt 0 listInputTemp))
                                )
                            ]
                            []
                        ]
                    , div
                        [ class "bg-black gap-x-1 h-6 items-center px-2 rounded-[30px]"
                        , if length listInputTemp < 2 then
                            class "hidden"

                          else
                            class "flex"
                        ]
                        [ span [ class "leading-3 text-xs text-white" ]
                            [ text ("+ " ++ fromInt (length listInputTemp - 1))
                            ]
                        ]
                    , div
                        [ class "flex items-center text-sm text-slate-400"
                        , onClick (InputFocusState inputGroup True)
                        ]
                        [ text "Search" ]
                    ]

            else
                div [] []

        placeholderDisplay =
            if isEmpty listInputTemp then
                class "placeholder:text-[#A5A9B5]"

            else
                class "placeholder:text-slate-100"
    in
    div [ class "relative" ]
        [ div [ class "absolute flex gap-x-2 inset-y-0 items-center left-0 pl-4" ]
            [ span [ class "text-gray-500 sm:text-sm" ]
                [ i [ class "fa-solid fa-magnifying-glass text-primary-1" ] []
                ]
            , wordBadgeOnInput
            ]
        , input
            [ placeholder "Search"
            , class "bg-slate-100 border-1 border-slate-200 h-12 mt-2 pl-11 rounded-3xl text-[#242632] w-full md:h-9 md:w-[231px] focus:outline-none text-sm"
            , placeholderDisplay
            , onInput KeywordState
            , onClick (InputFocusState inputGroup True)
            , value inputValue
            ]
            []
        ]


desktopView : Model -> Html Msg
desktopView model =
    let
        inputGroupComponent =
            div
                [ class "bg-white px-6 rounded-xl shadow-lg w-[371px] top-[50px] z-50 "
                , if model.inputGroupState == Open then
                    class "absolute hidden md:block"

                  else
                    class "hidden"
                ]
                [ div [ class "py-6" ]
                    [ inputGroupComponentView Desktop model ]
                ]
    in
    div [ class "relative", onMouseLeave (InputGroupState Close) ]
        [ inputView Desktop model
        , inputGroupComponent
        ]


slideOverView : Model -> Html Msg
slideOverView model =
    let
        closeSlideOverButton =
            a
                [ class "border cursor-pointer flex h-10 items-center justify-center no-underline rounded-full w-10 hover:bg-slate-200"
                , onClick (InputGroupState Close)
                ]
                [ i [ class "fa-solid fa-close text-2xl text-slate-700" ] []
                ]

        slideOverBackground =
            if model.inputGroupState == Open then
                class "block"

            else
                class "hidden"

        slideOverAnimation =
            if model.inputGroupState == Open then
                class "translate-y-0"

            else
                class "translate-y-full"

        searchButton =
            div
                [ class "bg-primary-1 cursor-pointer flex h-10 items-center justify-center py-2 rounded-3xl text-sm text-white w-full"
                , onClick SearchState
                ]
                [ text "Search" ]
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
                                , span [ class "font-medium leading-5 text-[#242632] text-xl" ] [ text "Search" ]
                                ]
                            ]
                        , inputView Mobile model
                        , div [ class "h-[100vh-200px] overflow-y-scroll" ]
                            [ inputGroupComponentView Mobile model
                            ]
                        ]
                    , div [ class "flex h-20 items-center justify-center px-4 py-4" ]
                        [ searchButton ]
                    ]
                ]
            ]
        ]


inputGroupComponentView : InputGroup -> Model -> Html Msg
inputGroupComponentView inputGroup model =
    let
        listInputValueComponent =
            div
                [ if not (isEmpty model.listInputTemp) && model.inputFocus == True then
                    class "flex"

                  else
                    class "hidden"
                ]
                [ listInputValueView inputGroup model
                ]

        lastSearchListComponent =
            div
                [ if not (isEmpty model.lastSearchList) then
                    class "flex"

                  else
                    class "hidden"
                ]
                [ lastSearchListView model ]

        inputValueComponent =
            div
                [ if model.inputValue /= "" then
                    class "flex"

                  else
                    class "hidden"
                ]
                [ keywordView inputGroup model ]
    in
    div [ class "flex flex-col divide-y gap-y-4" ]
        [ listInputValueComponent
        , lastSearchListComponent
        , inputValueComponent
        , listSkillView inputGroup model
        , listPositionView inputGroup model
        ]


wordBadge : String -> Msg -> Html Msg
wordBadge word msg =
    div [ class "bg-black flex gap-x-2 h-6 items-center pl-2 pr-1 rounded-[30px]" ]
        [ span
            [ class "leading-3 text-xs text-white" ]
            [ text word ]
        , i
            [ class "cursor-pointer fa-solid fa-close p-1 text-sm"
            , onClick msg
            ]
            []
        ]


listInputValueView : InputGroup -> Model -> Html Msg
listInputValueView inputGroup model =
    let
        listInputValue =
            model.listInputTemp

        listInputValueBadge =
            listInputValue
                |> List.map
                    (\word ->
                        wordBadge word (ListInputValueState inputGroup word)
                    )
    in
    div
        [ class "flex-col gap-y-6" ]
        [ div [ class "flex flex-wrap gap-2" ]
            listInputValueBadge
        ]


lastSearchListView : Model -> Html Msg
lastSearchListView model =
    let
        lastSearchList =
            model.lastSearchList

        lastSearchListBadge =
            lastSearchList
                |> List.map
                    (\word ->
                        wordBadge word (LastSearchListState word)
                    )
    in
    div
        [ class "flex flex-col pt-4 gap-y-6" ]
        [ span
            [ class "font-semibold text-base text-[#242632]" ]
            [ text "Last Searches" ]
        , div [ class "flex flex-wrap gap-2" ]
            lastSearchListBadge
        ]


keywordView : InputGroup -> Model -> Html Msg
keywordView inputGroup { keyword } =
    div
        [ class "flex flex-col pt-4 gap-y-6" ]
        [ span [ class "font-semibold text-base text-[#242632]" ] [ text "Keyword" ]
        , div [ class "flex flex-col gap-y-4" ]
            [ div
                [ class "cursor-pointer flex flex-row gap-x-2", onClick (ListInputValueState inputGroup keyword) ]
                [ div [ class "flex gap-x-2 items-center" ]
                    [ keywordIcon
                    , span [ class "leading-6 text-sm text-[#242632]" ] [ text keyword ]
                    ]
                ]
            ]
        ]


listSkillView : InputGroup -> Model -> Html Msg
listSkillView inputGroup { listSkill } =
    let
        listSkillText =
            listSkill
                |> List.map
                    (\skill ->
                        div [ class "cursor-pointer flex flex-row gap-x-2", onClick (ListInputValueState inputGroup skill) ]
                            [ div [ class "flex gap-x-2 items-center" ]
                                [ skillIcon
                                , span [ class "leading-6 text-sm text-[#242632]" ] [ text skill ]
                                ]
                            ]
                    )
    in
    div
        [ class "flex flex-col pt-4 gap-y-6" ]
        [ span [ class "font-semibold text-base text-[#242632]" ] [ text "Skills" ]
        , div [ class "flex flex-col gap-y-4" ]
            listSkillText
        ]


listPositionView : InputGroup -> Model -> Html Msg
listPositionView inputGroup { listPosition } =
    let
        listPositionText =
            listPosition
                |> List.map
                    (\position ->
                        div [ class "cursor-pointer flex flex-row gap-x-2", onClick (ListInputValueState inputGroup position) ]
                            [ div [ class "flex gap-x-2 items-center" ]
                                [ positionIcon
                                , span [ class "leading-6 text-sm text-[#242632]" ] [ text position ]
                                ]
                            ]
                    )
    in
    div [ class "flex flex-col pt-4 gap-y-6" ]
        [ span [ class "font-semibold text-base text-[#242632]" ] [ text "Position" ]
        , div [ class "flex flex-col gap-y-4" ]
            listPositionText
        ]
