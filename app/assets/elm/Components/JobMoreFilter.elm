module Components.JobMoreFilter exposing (..)

import Components.Icons exposing (toggleOffIcon, toggleOnIcon)
import Components.Modal as Modal
import Components.SlideOver as SlideOver
import Helpers.Converter exposing (floatToString, isValueInArray, stringToFloat)
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Attribute, Html, div, i, input, span, text)
import Html.Attributes exposing (class, step, style, type_, value)
import Html.Events exposing (onClick, onInput)
import String exposing (fromFloat)



-- MODEL


type alias Model =
    { buttonState : OpenCloseStateMsg
    , salaryMin : Float
    , salaryMax : Float
    , salaryMinValue : Float
    , salaryMaxValue : Float
    , salarySliderMin : Float
    , salarySliderMax : Float
    , salarySliderMinRange : Float
    , salarySliderStep : Float
    , friendlyOffer : Bool
    , experienceLevel : List ExperienceLevelMsg
    , employmentType : List EmploymentTypeMsg
    , typeOfWork : List TypeOfWorkMsg
    }



-- MSG


type Msg
    = ButtonState OpenCloseStateMsg
    | SalaryMinValueState String
    | SalaryMaxValueState String
    | FriendlyOfferState
    | ExperienceLevelState ExperienceLevelMsg
    | EmploymentTypeState EmploymentTypeMsg
    | TypeOfWorkState TypeOfWorkMsg
    | ClearFilterState
    | ShowOffers


type ExperienceLevelMsg
    = Junior
    | Mid
    | Senior


type EmploymentTypeMsg
    = Permanent
    | Contract
    | Freelance


type TypeOfWorkMsg
    = FullTime
    | PartTime
    | Internship



-- INIT


init : Model
init =
    { buttonState = Close
    , salaryMin = 0
    , salaryMax = 100000000
    , salaryMinValue = 0
    , salaryMaxValue = 100000000
    , salarySliderMin = 0
    , salarySliderMax = 0
    , salarySliderMinRange = 5000000
    , salarySliderStep = 1000000
    , friendlyOffer = False
    , experienceLevel = []
    , employmentType = []
    , typeOfWork = []
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonState msg_ ->
            ( { model | buttonState = msg_ }, Cmd.none )

        SalaryMinValueState msg_ ->
            let
                newModel =
                    if stringToFloat msg_ < model.salaryMaxValue - model.salarySliderMinRange then
                        { model
                            | salaryMinValue = stringToFloat msg_
                            , salarySliderMin = sliderPercentagePosition msg_ model
                        }

                    else
                        { model
                            | salaryMinValue = model.salaryMaxValue - model.salarySliderMinRange
                            , salarySliderMin = sliderPercentagePosition (fromFloat model.salaryMinValue) model
                        }
            in
            ( newModel, Cmd.none )

        SalaryMaxValueState msg_ ->
            let
                newModel =
                    if stringToFloat msg_ > model.salaryMax then
                        { model | salaryMaxValue = model.salaryMax, salarySliderMax = 0 }

                    else if stringToFloat msg_ < model.salaryMinValue + model.salarySliderMinRange then
                        { model
                            | salaryMaxValue = model.salaryMinValue + model.salarySliderMinRange
                            , salarySliderMax =
                                100
                                    - sliderPercentagePosition
                                        (fromFloat (model.salaryMinValue + model.salarySliderMinRange))
                                        model
                        }

                    else
                        { model
                            | salaryMaxValue = stringToFloat msg_
                            , salarySliderMax = 100 - sliderPercentagePosition msg_ model
                        }
            in
            ( newModel, Cmd.none )

        FriendlyOfferState ->
            let
                newModel =
                    if model.friendlyOffer == True then
                        { model | friendlyOffer = False }

                    else
                        { model | friendlyOffer = True }
            in
            ( newModel, Cmd.none )

        ExperienceLevelState msg_ ->
            let
                newModel =
                    if isValueInArray msg_ model.experienceLevel then
                        { model | experienceLevel = List.filter (\item -> item /= msg_) model.experienceLevel }

                    else
                        { model | experienceLevel = msg_ :: model.experienceLevel }
            in
            ( newModel, Cmd.none )

        EmploymentTypeState msg_ ->
            let
                newModel =
                    if isValueInArray msg_ model.employmentType then
                        { model | employmentType = List.filter (\item -> item /= msg_) model.employmentType }

                    else
                        { model | employmentType = msg_ :: model.employmentType }
            in
            ( newModel, Cmd.none )

        TypeOfWorkState msg_ ->
            let
                newModel =
                    if isValueInArray msg_ model.typeOfWork then
                        { model | typeOfWork = List.filter (\item -> item /= msg_) model.typeOfWork }

                    else
                        { model | typeOfWork = msg_ :: model.typeOfWork }
            in
            ( newModel, Cmd.none )

        ClearFilterState ->
            ( { init | buttonState = Open }, Cmd.none )

        ShowOffers ->
            ( { model | buttonState = Close }, Cmd.none )



-- HELPER


experienceLevelMsgToString : ExperienceLevelMsg -> String
experienceLevelMsgToString msg =
    case msg of
        Junior ->
            "junior"

        Mid ->
            "mid"

        Senior ->
            "senior"


employmentTypeMsgToString : EmploymentTypeMsg -> String
employmentTypeMsgToString msg =
    case msg of
        Permanent ->
            "permanent"

        Contract ->
            "contract"

        Freelance ->
            "freelance"


typeOfWorkMsgToString : TypeOfWorkMsg -> String
typeOfWorkMsgToString msg =
    case msg of
        FullTime ->
            "full time"

        PartTime ->
            "part time"

        Internship ->
            "internship"


sliderPercentagePosition : String -> Model -> Float
sliderPercentagePosition value model =
    (stringToFloat value - model.salaryMin) / (model.salaryMax - model.salaryMin) * 100


sliderButtonPosition : String -> String
sliderButtonPosition value =
    fromFloat (stringToFloat value - (stringToFloat value * 0.04))



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ modalView model, slideOverView model ]


modalView : Model -> Html Msg
modalView model =
    div [ class "hidden relative z-50 md:block" ]
        [ Modal.backBackground model.buttonState
        , div
            [ Modal.animation model.buttonState ]
            [ div [ class "flex items-center justify-center min-h-full" ]
                [ div [ class "bg-white flex flex-col rounded-xl px-3 py-3 w-[568px]" ]
                    [ div [ class "flex flex-col gap-y-6 p-4 max-h-[calc(100vh-100px)]" ]
                        [ div [ class "flex items-center justify-between" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ div [ onClick (ButtonState Close) ] [ Modal.closeButton ]
                                , span [ class "font-semibold text-xl text-black-90" ] [ text "More Filters" ]
                                ]
                            , div [ onClick ClearFilterState ] [ Modal.rightTitleSectionButton "Clear Filters" ]
                            ]
                        , div [ class "flex flex-col gap-y-8 overflow-y-auto px-0.5" ]
                            [ div [ class "flex flex-col gap-y-3" ]
                                [ salaryView model
                                , salarySliderView model
                                ]
                            , div [] [ friendlyOfferToggleView model ]
                            , div [] [ experienceLevelView model ]
                            , div [] [ employmentTypeView model ]
                            , div [] [ typeOfWorkView model ]
                            ]
                        , div [ onClick ShowOffers ] [ Modal.confirmButton "Show Offers" ]
                        ]
                    ]
                ]
            ]
        ]


slideOverView : Model -> Html Msg
slideOverView model =
    div [ class "block z-50 md:hidden" ]
        [ SlideOver.backBackground model.buttonState
        , div
            [ SlideOver.animationMobile model.buttonState ]
            [ div [ class "flex items-end justify-center min-h-full" ]
                [ div [ class "bg-white flex flex-col rounded-t-xl w-full" ]
                    [ div [ class "flex flex-col gap-y-6 px-4 py-6 overflow-y-auto" ]
                        [ div [ class "flex items-center justify-between" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ div [ onClick (ButtonState Close) ] [ SlideOver.closeButton ]
                                , span [ class "font-semibold text-xl text-black-90" ] [ text "More Filters" ]
                                ]
                            , div [ onClick ClearFilterState ] [ SlideOver.rightTitleSectionButton "Clear Filters" ]
                            ]
                        , div [ class "flex flex-col gap-y-8 max-h-[calc(100vh-250px)] overflow-y-auto px-0.5" ]
                            [ div [ class "flex flex-col gap-y-3" ]
                                [ salaryView model
                                , salarySliderView model
                                ]
                            , div [] [ friendlyOfferToggleView model ]
                            , div [] [ experienceLevelView model ]
                            , div [] [ employmentTypeView model ]
                            , div [] [ typeOfWorkView model ]
                            ]
                        , div [ onClick ShowOffers ] [ SlideOver.confirmButton "Show Offers" ]
                        ]
                    ]
                ]
            ]
        ]


salaryView : Model -> Html Msg
salaryView { salaryMinValue, salaryMaxValue, salaryMin, salaryMax } =
    div [ class "flex flex-col gap-y-4 items-start text-black-90" ]
        [ span [ class "font-medium text-2xl" ] [ text "Salary" ]
        , div [ class "flex flex-row items-start gap-x-6 px-2 w-full" ]
            [ div [ class "flex flex-col items-start gap-y-1 w-full" ]
                [ span [ class "text-base text-black-90" ] [ text "Salary min" ]
                , div [ class "relative w-full" ]
                    [ input
                        [ class "bg-white border-slate-200 font-medium h-12 pr-12 rounded-xl text-slate-600 text-base text-right w-full focus:border-slate-600 focus:ring-slate-400 [&::-webkit-inner-spin-button]:appearance-none"
                        , type_ "number"
                        , value (floatToString salaryMinValue)
                        , onInput SalaryMinValueState
                        , Html.Attributes.min (floatToString salaryMin)
                        , Html.Attributes.max (floatToString salaryMax)
                        ]
                        []
                    , div [ class "absolute flex h-12 inset-y-0 items-center pointer-events-none pr-3 right-0" ]
                        [ span [ class "text-slate-400 text-base" ] [ text "IDR" ]
                        ]
                    ]
                ]
            , div [ class "flex flex-col items-start gap-y-1 w-full" ]
                [ span [ class "text-base text-black-90" ] [ text "Salary max" ]
                , div [ class "relative w-full" ]
                    [ input
                        [ class "bg-white border-slate-200 font-medium h-12 pr-12 rounded-xl text-slate-600 text-base text-right w-full focus:border-slate-600 focus:ring-slate-400 [&::-webkit-inner-spin-button]:appearance-none"
                        , type_ "number"
                        , value (floatToString salaryMaxValue)
                        , onInput SalaryMaxValueState
                        , Html.Attributes.min (floatToString salaryMin)
                        , Html.Attributes.max (floatToString salaryMax)
                        ]
                        []
                    , div [ class "absolute flex h-12 inset-y-0 items-center pointer-events-none pr-3 right-0" ]
                        [ span [ class "text-slate-400 text-base" ] [ text "IDR" ]
                        ]
                    ]
                ]
            ]
        ]


salarySliderView : Model -> Html Msg
salarySliderView { salarySliderStep, salaryMinValue, salaryMin, salaryMax, salaryMaxValue, salarySliderMin, salarySliderMax } =
    let
        sliderMinButtonPosition =
            sliderButtonPosition (floatToString salarySliderMin)

        sliderMaxButtonPosition =
            sliderButtonPosition (floatToString salarySliderMax)
    in
    div [ class "relative" ]
        [ input
            [ type_ "range"
            , class "absolute cursor-pointer h-1 pointer-events-none opacity-0 w-full z-20"
            , onInput SalaryMinValueState
            , step (floatToString salarySliderStep)
            , value (floatToString salaryMinValue)
            , Html.Attributes.min (floatToString salaryMin)
            , Html.Attributes.max (floatToString salaryMax)
            ]
            []
        , input
            [ type_ "range"
            , class "absolute cursor-pointer h-1 pointer-events-none opacity-0 w-full z-20"
            , onInput SalaryMaxValueState
            , step (floatToString salarySliderStep)
            , value (floatToString salaryMaxValue)
            , Html.Attributes.min (floatToString salaryMin)
            , Html.Attributes.max (floatToString salaryMax)
            ]
            []
        , div [ class "relative z-10 h-2" ]
            [ div [ class "absolute z-10 left-0 right-0 bottom-0 top-0 rounded-md bg-gray-200" ] []
            , div
                [ class "absolute z-20 top-0 bottom-0 rounded-md bg-primary-1"
                , style "right" (sliderMaxButtonPosition ++ "%")
                , style "left" (sliderMinButtonPosition ++ "%")
                ]
                []
            , div
                [ class "absolute z-30 w-6 h-6 top-0 bg-white rounded-full -mt-2 shadow-lg flex items-center justify-center outline outline-slate-300"
                , style "left" (sliderMinButtonPosition ++ "%")
                ]
                [ i [ class "text-[12px] fa-solid fa-bars text-slate-500 rotate-90" ] []
                ]
            , div
                [ class "absolute z-30 w-6 h-6 top-0 right-0 bg-white rounded-full -mt-2 shadow-lg flex items-center justify-center outline outline-slate-300"
                , style "right" (sliderMaxButtonPosition ++ "%")
                ]
                [ i [ class "text-[12px] fa-solid fa-bars text-slate-500 rotate-90" ] []
                ]
            ]
        , div [ class "flex justify-between text-sm mt-4 px-1 text-slate-600" ]
            [ span [] [ text (fromFloat salaryMinValue ++ " IDR") ]
            , span [] [ text (fromFloat salaryMaxValue ++ " IDR") ]
            ]
        ]


friendlyOfferToggleView : Model -> Html Msg
friendlyOfferToggleView { friendlyOffer } =
    let
        toggleIcon =
            if friendlyOffer == True then
                toggleOnIcon

            else
                toggleOffIcon
    in
    div [ class "cursor-pointer flex flex-row gap-x-4 items-center", onClick FriendlyOfferState ]
        [ div [] [ toggleIcon ]
        , span [ class "text-sm text-black-90" ] [ text "Show only Friendly Offers" ]
        ]


experienceLevelView : Model -> Html Msg
experienceLevelView { experienceLevel } =
    div [ class "flex flex-col gap-y-4 items-start text-black-90" ]
        [ span [ class "font-medium text-2xl" ] [ text "Experience Level" ]
        , div [ class "flex flex-col gap-y-1" ]
            ([ Junior, Mid, Senior ]
                |> List.map
                    (\value ->
                        div [ class "cursor-pointer flex flex-row gap-x-2 items-center", onClick (ExperienceLevelState value) ]
                            [ div [ checkIcon value experienceLevel ] []
                            , span [ class "capitalize text-base text-black-90" ] [ text (experienceLevelMsgToString value) ]
                            ]
                    )
            )
        ]


employmentTypeView : Model -> Html Msg
employmentTypeView { employmentType } =
    div [ class "flex flex-col gap-y-4 items-start text-black-90" ]
        [ span [ class "font-medium text-2xl" ] [ text "Employment Type" ]
        , div [ class "flex flex-col gap-y-1" ]
            ([ Permanent, Contract, Freelance ]
                |> List.map
                    (\value ->
                        div [ class "cursor-pointer flex flex-row gap-x-2 items-center", onClick (EmploymentTypeState value) ]
                            [ div [ checkIcon value employmentType ] []
                            , span [ class "capitalize text-base text-black-90" ] [ text (employmentTypeMsgToString value) ]
                            ]
                    )
            )
        ]


typeOfWorkView : Model -> Html Msg
typeOfWorkView { typeOfWork } =
    div [ class "flex flex-col gap-y-4 items-start text-black-90" ]
        [ span [ class "font-medium text-2xl" ] [ text "Type of Work" ]
        , div [ class "flex flex-col gap-y-1" ]
            ([ FullTime, PartTime, Internship ]
                |> List.map
                    (\value ->
                        div [ class "cursor-pointer flex flex-row gap-x-2 items-center", onClick (TypeOfWorkState value) ]
                            [ div [ checkIcon value typeOfWork ] []
                            , span [ class "capitalize text-base text-black-90" ] [ text (typeOfWorkMsgToString value) ]
                            ]
                    )
            )
        ]


checkIcon : a -> List a -> Attribute msg
checkIcon value list =
    if isValueInArray value list then
        class "fa-regular text-xl text-black-90 fa-square-check"

    else
        class "fa-regular text-xl text-black-90 fa-square"
