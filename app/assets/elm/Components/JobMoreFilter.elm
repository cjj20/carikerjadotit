module Components.JobMoreFilter exposing (..)

import Helpers.Converter exposing (floatToString, isValueInArray, stringToFloat)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String exposing (fromFloat)



-- MODEL


type alias Model =
    { modalState : ModalStateMsg
    , salaryMin : Float
    , salaryMax : Float
    , salaryMinValue : Float
    , salaryMaxValue : Float
    , salarySliderMin : Float
    , salarySliderMax : Float
    , salarySliderMinRange : Float
    , salarySliderStep : Float
    , friendlyOffer : Bool
    , experience : List ExperienceMsg
    , employmentType : List EmploymentTypeMsg
    , typeOfWork : List TypeOfWorkMsg
    }



-- MSG


type Msg
    = ModalState
    | SalaryMinValueState String
    | SalaryMaxValueState String
    | FriendlyOfferState
    | ExperienceState ExperienceMsg
    | EmploymentTypeState EmploymentTypeMsg
    | TypeOfWorkState TypeOfWorkMsg
    | ClearFilterState
    | ShowOffers


type ModalStateMsg
    = Open
    | Close


type ExperienceMsg
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
    { modalState = Close
    , salaryMin = 0
    , salaryMax = 100000000
    , salaryMinValue = 0
    , salaryMaxValue = 100000000
    , salarySliderMin = 0
    , salarySliderMax = 0
    , salarySliderMinRange = 5000000
    , salarySliderStep = 1000000
    , friendlyOffer = False
    , experience = []
    , employmentType = []
    , typeOfWork = []
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ModalState ->
            let
                newModel =
                    if model.modalState == Open then
                        { model | modalState = Close }

                    else
                        { model | modalState = Open }
            in
            ( newModel, Cmd.none )

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
                    if model.friendlyOffer then
                        { model | friendlyOffer = False }

                    else
                        { model | friendlyOffer = True }
            in
            ( newModel, Cmd.none )

        ExperienceState msg_ ->
            let
                newModel =
                    if isValueInArray msg_ model.experience then
                        { model | experience = List.filter (\item -> item /= msg_) model.experience }

                    else
                        { model | experience = msg_ :: model.experience }
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
            ( { init | modalState = Open }, Cmd.none )

        ShowOffers ->
            ( { model | modalState = Close }, Cmd.none )



-- HELPERS


experienceMsgToString : ExperienceMsg -> String
experienceMsgToString msg =
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
view { modalState, salaryMin, salaryMax, salaryMinValue, salaryMaxValue, salarySliderMin, salarySliderMax, salarySliderStep, friendlyOffer, experience, employmentType, typeOfWork } =
    let
        closeModalButton =
            a
                [ class "border cursor-pointer flex h-10 items-center justify-center no-underline rounded-full w-10 hover:bg-slate-200"
                , onClick ModalState
                ]
                [ i [ class "fa-solid fa-close text-2xl text-slate-700" ] []
                ]

        modalAnimationMobile =
            if modalState == Open then
                class "translate-y-0"

            else
                class "translate-y-full"

        modalAnimationDesktop =
            if modalState == Open then
                class "opacity-100 scale-10"

            else
                class "opacity-0 scale-0"

        modalBackground =
            if modalState == Open then
                class "block"

            else
                class "hidden"

        clearFilterButton =
            a [ class "cursor-pointer flex h-10 items-center justify-center no-underline w-20", onClick ClearFilterState ]
                [ span [ class "font-medium text-sm text-slate-400 hover:text-slate-500" ] [ text "Clear filters" ]
                ]

        salaryMinInput =
            div [ class "relative" ]
                [ input
                    [ class "bg-white border-slate-200 font-medium h-12 pr-12 rounded-xl text-slate-600 text-base text-right md:w-44 focus:border-slate-600 focus:ring-slate-400 lg:w-56 [&::-webkit-inner-spin-button]:appearance-none"
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

        salaryMaxInput =
            div [ class "relative" ]
                [ input
                    [ class "bg-white border-slate-200 font-medium h-12 pr-12 rounded-xl text-slate-600 text-base text-right md:w-44 focus:border-slate-600 focus:ring-slate-400 lg:w-56 [&::-webkit-inner-spin-button]:appearance-none"
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

        sliderMinButtonPosition =
            sliderButtonPosition (floatToString salarySliderMin)

        sliderMaxButtonPosition =
            sliderButtonPosition (floatToString salarySliderMax)

        salarySliderInput =
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
                        [ class "absolute z-20 top-0 bottom-0 rounded-md bg-primary-2"
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
                ]

        friendlyOfferToggle =
            if friendlyOffer then
                div [ class "cursor-pointer flex flex-row gap-x-4 items-center", onClick FriendlyOfferState ]
                    [ i [ class "fa-solid fa-toggle-on text-4xl text-slate-400" ] []
                    , span [ class "text-sm" ] [ text "Show only Friendly Offers" ]
                    ]

            else
                div [ class "cursor-pointer flex flex-row gap-x-4 items-center", onClick FriendlyOfferState ]
                    [ i [ class "fa-solid fa-toggle-off text-4xl text-slate-400" ] []
                    , span [ class "text-sm" ] [ text "Show only Friendly Offers" ]
                    ]

        experienceList =
            [ Junior, Mid, Senior ]
                |> List.map
                    (\value ->
                        div [ class "cursor-pointer flex flex-row gap-x-2 items-center", onClick (ExperienceState value) ]
                            [ i
                                [ class "fa-regular text-xl text-slate-400"
                                , if isValueInArray value experience then
                                    class "fa-square-check"

                                  else
                                    class "fa-square"
                                ]
                                []
                            , span [ class "text-base capitalize" ] [ text (experienceMsgToString value) ]
                            ]
                    )

        employmentTypeList =
            [ Permanent, Contract, Freelance ]
                |> List.map
                    (\value ->
                        div [ class "cursor-pointer flex flex-row gap-x-2 items-center", onClick (EmploymentTypeState value) ]
                            [ i
                                [ class "fa-regular text-xl text-slate-400"
                                , if isValueInArray value employmentType then
                                    class "fa-square-check"

                                  else
                                    class "fa-square"
                                ]
                                []
                            , span [ class "text-base capitalize" ] [ text (employmentTypeMsgToString value) ]
                            ]
                    )

        typeOfWorkList =
            [ FullTime, PartTime, Internship ]
                |> List.map
                    (\value ->
                        div [ class "cursor-pointer flex flex-row gap-x-2 items-center", onClick (TypeOfWorkState value) ]
                            [ i
                                [ class "fa-regular text-xl text-slate-400"
                                , if isValueInArray value typeOfWork then
                                    class "fa-square-check"

                                  else
                                    class "fa-square"
                                ]
                                []
                            , span [ class "text-base capitalize" ] [ text (typeOfWorkMsgToString value) ]
                            ]
                    )

        showOffersButton =
            div
                [ class "bg-primary-2 cursor-pointer flex h-10 items-center justify-center py-2 rounded-3xl text-sm text-white w-48"
                , onClick ShowOffers
                ]
                [ text "Show offers" ]
    in
    div [ class "relative z-10" ]
        [ div
            [ class "fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"
            , modalBackground
            , onClick ModalState
            ]
            []

        -- Desktop
        , div
            [ class "hidden duration-500 ease-in-out fixed inset-0 transition-opacity z-10 md:block"
            , modalAnimationDesktop
            ]
            [ div [ class "flex items-center justify-center min-h-full" ]
                [ div [ class "flex flex-col w-1/2" ]
                    [ div [ class "bg-white flex flex-col gap-y-8 p-6 rounded-t-3xl" ]
                        [ div [ class "flex items-center justify-between" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ closeModalButton
                                , span [ class "font-medium text-xl text-slate-600" ] [ text "More Filters" ]
                                ]
                            , clearFilterButton
                            ]
                        , div [ class "flex flex-col gap-y-8 max-h-[calc(100vh-400px)] overflow-y-scroll" ]
                            [ div [ class "flex flex-col gap-y-4 items-start" ]
                                [ span [ class "font-medium text-xl text-slate-600" ] [ text "Salary" ]
                                , div [ class "flex flex-col gap-y-8 w-full" ]
                                    [ div [ class "flex flex-row items-start gap-x-6 ml-2" ]
                                        [ div [ class "flex flex-col items-start gap-y-1 " ]
                                            [ span [ class "text-base text-slate-600" ] [ text "Salary min" ]
                                            , salaryMinInput
                                            ]
                                        , div [ class "flex flex-col items-start gap-y-1" ]
                                            [ span [ class "text-base text-slate-600" ] [ text "Salary max" ]
                                            , salaryMaxInput
                                            ]
                                        ]
                                    , div [ class "relative px-4" ]
                                        [ salarySliderInput
                                        ]
                                    ]
                                ]
                            , div [ class "flex flex-col gap-y-4 items-start text-slate-600" ]
                                [ span [ class "font-medium text-xl" ] [ text "Friendly Offer" ]
                                , friendlyOfferToggle
                                ]
                            , div [ class "flex flex-col gap-y-4 items-start text-slate-600" ]
                                [ span [ class "font-medium text-2xl" ] [ text "Experience" ]
                                , div [ class "flex flex-col gap-y-2" ]
                                    experienceList
                                ]
                            , div [ class "flex flex-col gap-y-4 items-start text-slate-600" ]
                                [ span [ class "font-medium text-2xl" ] [ text "Employment Type" ]
                                , div [ class "flex flex-col gap-y-2" ]
                                    employmentTypeList
                                ]
                            , div [ class "flex flex-col gap-y-4 items-start text-slate-600" ]
                                [ span [ class "font-medium text-2xl" ] [ text "Type of Work" ]
                                , div [ class "flex flex-col gap-y-2" ]
                                    typeOfWorkList
                                ]
                            ]
                        ]
                    , div [ class "bg-slate-200 flex h-20 items-center justify-center rounded-b-3xl" ]
                        [ showOffersButton
                        ]
                    ]
                ]
            ]

        -- MOBILE
        , div
            [ class "duration-500 ease-in-out fixed inset-0 transition z-10 md:hidden"
            , modalAnimationMobile
            ]
            [ div [ class "flex items-end justify-center min-h-full" ]
                [ div [ class "flex flex-col w-full h-[calc(100vh-65px)]" ]
                    [ div [ class "bg-white flex flex-col gap-y-8 p-6 rounded-t-3xl" ]
                        [ div [ class "flex items-center justify-between" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ closeModalButton
                                , span [ class "font-medium text-lg text-slate-600 sm:text-xl" ] [ text "More Filters" ]
                                ]
                            , clearFilterButton
                            ]
                        , div [ class "flex flex-col gap-y-8 max-h-[calc(100vh-250px)] overflow-y-scroll" ]
                            [ div [ class "flex flex-col gap-y-4 items-start" ]
                                [ span [ class "font-medium text-xl text-slate-600" ] [ text "Salary" ]
                                , div [ class "flex flex-col gap-y-8 w-full" ]
                                    [ div [ class "flex flex-col gap-x-6 ml-2 sm:flex-row" ]
                                        [ div [ class "flex flex-col items-start gap-y-1" ]
                                            [ span [ class "text-base text-slate-600" ] [ text "Salary min" ]
                                            , div [ class "relative" ]
                                                [ salaryMinInput
                                                ]
                                            ]
                                        , div [ class "flex flex-col items-start gap-y-1" ]
                                            [ span [ class "text-base text-slate-600" ] [ text "Salary max" ]
                                            , div [ class "relative" ]
                                                [ salaryMaxInput
                                                ]
                                            ]
                                        ]
                                    , div [ class "relative px-4" ]
                                        [ salarySliderInput
                                        ]
                                    ]
                                ]
                            , div [ class "flex flex-col gap-y-4 items-start text-slate-600" ]
                                [ span [ class "font-medium text-xl" ] [ text "Friendly Offer" ]
                                , friendlyOfferToggle
                                ]
                            , div [ class "flex flex-col gap-y-4 items-start text-slate-600" ]
                                [ span [ class "font-medium text-xl sm:text-2xl" ] [ text "Experience" ]
                                , div [ class "flex flex-col gap-y-2" ]
                                    experienceList
                                ]
                            , div [ class "flex flex-col gap-y-4 items-start text-slate-600" ]
                                [ span [ class "font-medium text-xl sm:text-2xl" ] [ text "Employment Type" ]
                                , div [ class "flex flex-col gap-y-2" ]
                                    employmentTypeList
                                ]
                            , div [ class "flex flex-col gap-y-4 items-start text-slate-600" ]
                                [ span [ class "font-medium text-xl sm:text-2xl" ] [ text "Type of Work" ]
                                , div [ class "flex flex-col gap-y-2" ]
                                    typeOfWorkList
                                ]
                            ]
                        ]
                    , div [ class "bg-slate-200 flex h-20 items-center justify-center" ]
                        [ showOffersButton
                        ]
                    ]
                ]
            ]
        ]
