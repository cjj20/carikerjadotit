module Components.JobFilter exposing (..)

import Components.Icons exposing (chevronDownBlueIcon, chevronDownGrayIcon, magnifyingGlassBlueIcon, magnifyingGlassGrayIcon, mapsBlueIcon, slidersIcon)
import Components.JobLocation as JobLocation
import Components.JobMainTechnology as JobMainTechnology exposing (Msg(..))
import Components.JobMoreFilter as JobMoreFilter
import Components.JobSearch as JobSearch exposing (..)
import Components.JobSort as JobSort exposing (sortItemMsgToSortItemModel)
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Attribute, Html, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import List exposing (length)



-- MODEL


type alias Model =
    { jobSearchModel : JobSearch.Model
    , jobLocationModel : JobLocation.Model
    , jobMainTechnologyModel : JobMainTechnology.Model
    , jobMoreFilterModel : JobMoreFilter.Model
    , jobSortModel : JobSort.Model
    }



-- MSG


type Msg
    = JobSearchUpdateMsg JobSearch.Msg
    | JobLocationUpdateMsg JobLocation.Msg
    | JobMainTechnologyUpdateMsg JobMainTechnology.Msg
    | JobMoreFilterUpdateMsg JobMoreFilter.Msg
    | JobSortUpdateMsg JobSort.Msg



-- INIT


init : Model
init =
    { jobSearchModel = JobSearch.init
    , jobLocationModel = JobLocation.init
    , jobMainTechnologyModel = JobMainTechnology.init
    , jobMoreFilterModel = JobMoreFilter.init
    , jobSortModel = JobSort.init
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JobSearchUpdateMsg msg_ ->
            let
                ( newJobSearchModel, _ ) =
                    JobSearch.update msg_ model.jobSearchModel
            in
            ( { model | jobSearchModel = newJobSearchModel }, Cmd.none )

        JobLocationUpdateMsg msg_ ->
            let
                ( newJobLocationModel, _ ) =
                    JobLocation.update msg_ model.jobLocationModel
            in
            ( { model | jobLocationModel = newJobLocationModel }, Cmd.none )

        JobMainTechnologyUpdateMsg msg_ ->
            let
                ( newJobMainTechnologyModel, _ ) =
                    JobMainTechnology.update msg_ model.jobMainTechnologyModel
            in
            ( { model | jobMainTechnologyModel = newJobMainTechnologyModel }, Cmd.none )

        JobMoreFilterUpdateMsg msg_ ->
            let
                ( newJobMoreFilterModel, _ ) =
                    JobMoreFilter.update msg_ model.jobMoreFilterModel
            in
            ( { model | jobMoreFilterModel = newJobMoreFilterModel }, Cmd.none )

        JobSortUpdateMsg msg_ ->
            let
                ( newJobSortModel, _ ) =
                    JobSort.update msg_ model.jobSortModel
            in
            ( { model | jobSortModel = newJobSortModel }, Cmd.none )



-- HELPER


buttonClass : Bool -> Attribute msg
buttonClass value =
    if value then
        class "bg-primary-2 outline-primary-1 text-primary-1"

    else
        class "bg-white outline-[#DBE0E5] text-[#101010]"


chevronDownIcon : Bool -> Html msg
chevronDownIcon value =
    if value then
        chevronDownBlueIcon

    else
        chevronDownGrayIcon



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "relative" ]
        [ div [ class "bg-white px-4 lg:px-[140px]" ]
            [ div [ class "flex gap-x-3 h-18 justify-between no-scrollbar overflow-x-scroll" ]
                [ div [ class "flex gap-x-2 px-0.5 pt-4 pb-4 md:gap-x-3 md:pb-2" ]
                    [ div
                        [ class "hidden relative md:block"
                        , onClick (JobSearchUpdateMsg (JobSearch.DropDownState Open))
                        ]
                        [ Html.map JobSearchUpdateMsg <| JobSearch.inputDesktopView model.jobSearchModel ]
                    , div [] [ searchMobileButton model ]
                    , div [] [ locationButton model ]
                    , div [] [ mainTechnologyButton model ]
                    , div [ class "block md:hidden" ] [ moreFilterButton model ]
                    , div [] [ sortButton model ]
                    ]
                , div [ class "hidden gap-x-4 px-1 pt-2 md:flex md:justify-end overflow-x-auto" ]
                    [ Html.map JobMainTechnologyUpdateMsg <| JobMainTechnology.listMainTechnologyView model.jobMainTechnologyModel
                    , div [ class "pt-2" ] [ moreFilterButton model ]
                    ]
                ]
            , div [ class "relative z-50" ]
                [ Html.map JobSearchUpdateMsg <| JobSearch.view model.jobSearchModel
                , Html.map JobLocationUpdateMsg <| JobLocation.view model.jobLocationModel
                , Html.map JobMainTechnologyUpdateMsg <| JobMainTechnology.slideOverView model.jobMainTechnologyModel
                , Html.map JobMoreFilterUpdateMsg <| JobMoreFilter.view model.jobMoreFilterModel
                , Html.map JobSortUpdateMsg <| JobSort.slideOverView model.jobSortModel
                ]
            ]
        ]


searchMobileButton : Model -> Html Msg
searchMobileButton { jobSearchModel } =
    let
        magnifyingGlassIcon =
            if length jobSearchModel.listInputValue > 0 then
                magnifyingGlassBlueIcon

            else
                magnifyingGlassGrayIcon
    in
    div
        [ class "flex items-center justify-center outline p-2 rounded-full md:hidden"
        , buttonClass (jobSearchModel /= JobSearch.init)
        , onClick (JobSearchUpdateMsg (JobSearch.SlideOverState Open))
        ]
        [ div [ class "flex items-center justify-center" ]
            [ span [] [ magnifyingGlassIcon ] ]
        ]


locationButton : Model -> Html Msg
locationButton { jobLocationModel } =
    div
        [ class "cursor-pointer flex gap-x-1 h-8 items-center justify-center outline rounded-3xl w-[105px] md:h-9 md:justify-between md:px-3 md:w-[174px]"
        , buttonClass (jobLocationModel /= JobLocation.init)
        , onClick (JobLocationUpdateMsg (JobLocation.ButtonState Open))
        ]
        [ div [ class "flex flex-row gap-x-2 items-center" ]
            [ span [ class "hidden items-center md:flex" ] [ mapsBlueIcon ]
            , span [ class "text-sm" ] [ text "Location" ]
            ]
        , span [] [ chevronDownIcon (jobLocationModel /= JobLocation.init) ]
        ]


mainTechnologyButton : Model -> Html Msg
mainTechnologyButton { jobMainTechnologyModel } =
    div
        [ class "flex h-8 items-center justify-center outline rounded-3xl px-4 w-[101px] md:hidden"
        , buttonClass (jobMainTechnologyModel /= JobMainTechnology.init)
        , onClick (JobMainTechnologyUpdateMsg (JobMainTechnology.ButtonState Open))
        ]
        [ div [ class "flex flex-row gap-x-1 items-center" ]
            [ span [ class "text-sm" ] [ text "All Tech" ]
            , span [] [ chevronDownIcon (jobMainTechnologyModel /= JobMainTechnology.init) ]
            ]
        ]


moreFilterButton : Model -> Html Msg
moreFilterButton { jobMoreFilterModel } =
    div
        [ class "cursor-pointer flex gap-x-1 h-8 items-center justify-center outline rounded-3xl w-[127px] md:h-9 md:justify-between md:px-3 md:w-[155px]"
        , buttonClass (jobMoreFilterModel /= JobMoreFilter.init)
        , onClick (JobMoreFilterUpdateMsg (JobMoreFilter.ButtonState Open))
        ]
        [ div [ class "flex flex-row gap-x-2 items-center" ]
            [ span [ class "hidden items-center md:flex" ] [ slidersIcon ]
            , span [ class "text-sm" ] [ text "More Filters" ]
            ]
        , span [] [ chevronDownIcon (jobMoreFilterModel /= JobMoreFilter.init) ]
        ]


sortButton : Model -> Html Msg
sortButton { jobSortModel } =
    div
        [ class "flex h-8 items-center no-underline outline rounded-3xl md:hidden"
        , buttonClass (jobSortModel /= JobSort.init)
        , onClick (JobSortUpdateMsg (JobSort.ButtonState Open))
        ]
        [ div [ class "px-4 text-sm truncate" ]
            [ text ("Sort by: " ++ (sortItemMsgToSortItemModel jobSortModel.selected.name).text) ]
        ]
