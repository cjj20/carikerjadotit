module Components.JobLocation exposing (..)

import Components.Badge exposing (locationWord, searchWord)
import Components.Icons exposing (magnifyingGlassBlueIcon)
import Components.Modal as Modal
import Components.SlideOver as SlideOver
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Html, div, input, li, span, text)
import Html.Attributes exposing (class, disabled, placeholder, value)
import Html.Events exposing (onClick, onInput, onMouseLeave)
import List exposing (length)



-- MODEL


type alias Model =
    { buttonState : OpenCloseStateMsg
    , inputFocus : Bool
    , inputValue : String
    , search : String
    , selected : String
    , listAll : List String
    , listTop : List String
    , listOther : List String
    }



-- MSG


type Msg
    = ButtonState OpenCloseStateMsg
    | InputFocusState Bool
    | SearchState String
    | SelectState String
    | ClearFilterState
    | ShowOffersState



-- INIT


init : Model
init =
    { buttonState = Close
    , inputFocus = False
    , inputValue = ""
    , search = ""
    , selected = ""
    , listAll = [ "Jakarta", "Yogyakarta", "Bandung", "Surabaya", "Medan", "Bali", "Makassar", "Lombok", "Singapore" ]
    , listTop = [ "Jakarta", "Yogyakarta", "Bandung", "Surabaya", "Medan" ]
    , listOther = [ "Bali", "Makassar", "Lombok", "Singapore" ]
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonState msg_ ->
            ( { model | buttonState = msg_ }, Cmd.none )

        InputFocusState msg_ ->
            ( { model | inputFocus = msg_ }, Cmd.none )

        SearchState msg_ ->
            ( { model | search = msg_, inputValue = msg_ }, Cmd.none )

        SelectState msg_ ->
            ( { model | selected = msg_, inputFocus = False, inputValue = "" }, Cmd.none )

        ClearFilterState ->
            ( { init | buttonState = Open }, Cmd.none )

        ShowOffersState ->
            ( { model | buttonState = Close }, Cmd.none )



-- HELPER


filteredList : Model -> List String
filteredList model =
    let
        lowercaseSearch =
            String.toLower model.search

        matches search =
            String.contains lowercaseSearch (String.toLower search)
    in
    List.filter matches model.listAll



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ modalView model, slideOverView model ]


modalView : Model -> Html Msg
modalView model =
    div [ class "hidden z-50 md:block" ]
        [ Modal.backBackground model.buttonState
        , div
            [ Modal.animation model.buttonState ]
            [ div [ class "flex items-center justify-center min-h-full" ]
                [ div [ class "bg-white flex flex-col rounded-3xl w-[568px]" ]
                    [ div [ class "flex flex-col gap-y-6 p-6 max-h-[calc(100vh-100px)]" ]
                        [ div [ class "flex items-center justify-between" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ div [ onClick (ButtonState Close) ] [ Modal.closeButton ]
                                , span [ class "font-semibold text-xl text-black-90" ] [ text "Location" ]
                                ]
                            , div [ onClick ClearFilterState ] [ Modal.rightTitleSectionButton "Clear Filters" ]
                            ]
                        , div [ class "flex flex-col gap-y-4 overflow-y-auto px-0.5 py-0.5" ]
                            [ div [] [ inputSearchView model ]
                            , div [] [ listTopView model ]
                            , div [] [ listOtherView model ]
                            ]
                        , div [ onClick ShowOffersState ] [ Modal.confirmButton "Show Offers" ]
                        ]
                    ]
                ]
            ]
        ]


slideOverView : Model -> Html Msg
slideOverView model =
    div [ class "block relative z-50 md:hidden" ]
        [ SlideOver.backBackground model.buttonState
        , div
            [ SlideOver.animationMobile model.buttonState ]
            [ div [ class "flex items-end justify-center min-h-full" ]
                [ div [ class "bg-white flex flex-col rounded-t-xl w-full" ]
                    [ div [ class "flex flex-col gap-y-6 px-4 py-6 overflow-y-auto" ]
                        [ div [ class "flex items-center justify-between" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ div [ onClick (ButtonState Close) ] [ SlideOver.closeButton ]
                                , span [ class "font-semibold text-xl text-black-90" ] [ text "Location" ]
                                ]
                            , div [ onClick ClearFilterState ] [ SlideOver.rightTitleSectionButton "Clear Filters" ]
                            ]
                        , div [ class "flex flex-col gap-y-4 max-h-[calc(100vh-250px)] overflow-y-auto px-0.5 py-0.5" ]
                            [ div [] [ inputSearchView model ]
                            , div [] [ listTopView model ]
                            , div [] [ listOtherView model ]
                            ]
                        , div [ onClick ShowOffersState ] [ SlideOver.confirmButton "Show Offers" ]
                        ]
                    ]
                ]
            ]
        ]


inputSearchView : Model -> Html Msg
inputSearchView model =
    let
        wordBadge =
            if model.selected /= "" then
                searchWord model.selected True

            else
                div [] []

        placeholderClass =
            if model.selected /= "" then
                class "placeholder:opacity-0"

            else
                class "placeholder:opacity-100"
    in
    div
        [ class "relative", onMouseLeave (InputFocusState False) ]
        [ div [ class "absolute flex gap-x-2 inset-y-0 left-0 pl-4" ]
            [ span [ class "pt-4" ] [ magnifyingGlassBlueIcon ]
            , div [ class "pt-2 md:pt-3", onClick ClearFilterState ] [ wordBadge ]
            ]
        , input
            [ placeholder "Where do you want to work?"
            , class "bg-white border-0 h-12 outline outline-[#DBE0E5] pl-11 rounded-3xl text-sm text-black-90 w-full disabled:bg-white"
            , placeholderClass
            , disabled (model.selected /= "")
            , onClick (InputFocusState True)
            , onInput SearchState
            , value model.inputValue
            ]
            []
        , div [] [ listLocationView model ]
        ]


listLocationView : Model -> Html Msg
listLocationView model =
    let
        inputFocusClass =
            if model.inputFocus then
                class "absolute"

            else
                class "hidden"

        listValueDisplay =
            if length (filteredList model) > 0 then
                div [ class "flex flex-col gap-y-2 px-2 py-2" ]
                    (List.map (\value -> listDropDownView value) (filteredList model))

            else
                listDropDownView "No Options"
    in
    div
        [ class "bg-white list-none z-10 max-h-48 w-full overflow-auto rounded-xl text-sm shadow", inputFocusClass ]
        [ div [] [ listValueDisplay ] ]


listDropDownView : String -> Html Msg
listDropDownView value =
    li [ class "cursor-pointer px-3 py-1 rounded-lg hover:bg-white-30", onClick (SelectState value) ]
        [ span [ class "text-black-90" ] [ text value ] ]


listTopView : Model -> Html Msg
listTopView { listTop, selected } =
    div [ class "flex flex-col gap-y-4 items-start text-black-90 py-0.5" ]
        [ span [ class "font-semibold text-base" ] [ text "Top Indonesia" ]
        , div [ class "flex flex-row flex-wrap gap-2" ]
            (listTop
                |> List.map (\value -> div [ onClick (SelectState value) ] [ locationWord value selected ])
            )
        ]


listOtherView : Model -> Html Msg
listOtherView { listOther, selected } =
    div [ class "flex flex-col gap-y-4 items-start text-black-90 py-0.5" ]
        [ span [ class "font-semibold text-base" ] [ text "Other Location" ]
        , div [ class "flex flex-row flex-wrap gap-2" ]
            (listOther
                |> List.map (\value -> div [ onClick (SelectState value) ] [ locationWord value selected ])
            )
        ]
