module Components.JobFilter exposing (..)

import Components.JobMoreFilter as JobMoreFilter
import Components.JobSearch as JobSearch exposing (InputGroupStateMsg(..))
import Components.JobSort as JobSort
import Components.MainTechnology exposing (MainTechnology, emptyMainTechnology, listMainTechnology)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (isEmpty, length)
import String exposing (fromInt)



-- MODEL


type alias Model =
    { jobSearchModel : JobSearch.Model
    , selectedMainTechnology : MainTechnology
    , jobSortModel : JobSort.Model
    , jobMoreFilterModel : JobMoreFilter.Model
    }



-- MSG


type Msg
    = JobSearchUpdateMsg JobSearch.Msg
    | SelectMainTechnologyState MainTechnology
    | JobSortUpdateMsg JobSort.Msg
    | JobMoreFilterUpdateMsg JobMoreFilter.Msg



-- INIT


init : Model
init =
    { jobSearchModel = JobSearch.init
    , selectedMainTechnology = emptyMainTechnology
    , jobSortModel = JobSort.init
    , jobMoreFilterModel = JobMoreFilter.init
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JobSearchUpdateMsg msg_ ->
            let
                ( newJobSearchUpdate, _ ) =
                    JobSearch.update msg_ model.jobSearchModel
            in
            ( { model | jobSearchModel = newJobSearchUpdate }, Cmd.none )

        SelectMainTechnologyState msg_ ->
            let
                newModel =
                    if model.selectedMainTechnology == msg_ then
                        { model | selectedMainTechnology = emptyMainTechnology }

                    else
                        { model | selectedMainTechnology = msg_ }
            in
            ( newModel, Cmd.none )

        JobSortUpdateMsg msg_ ->
            let
                ( newJobSortUpdate, _ ) =
                    JobSort.update msg_ model.jobSortModel
            in
            ( { model | jobSortModel = newJobSortUpdate }, Cmd.none )

        JobMoreFilterUpdateMsg msg_ ->
            let
                ( newJobMoreFilterUpdate, _ ) =
                    JobMoreFilter.update msg_ model.jobMoreFilterModel
            in
            ( { model | jobMoreFilterModel = newJobMoreFilterUpdate }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view { jobMoreFilterModel, jobSearchModel, jobSortModel, selectedMainTechnology } =
    let
        searchButtonMobile =
            a
                [ class "flex items-center justify-center no-underline outline outline-slate-200 p-2 rounded-full hover:cursor-pointer md:hidden"
                , if isEmpty jobSearchModel.listInputValue then
                    class "bg-slate-100 text-slate-500"

                  else
                    class "bg-primary-1 text-white"
                , onClick (JobSearchUpdateMsg (JobSearch.InputGroupState Open))
                ]
                [ div [ class "flex flex-row items-center" ]
                    [ span [ class "fa-solid fa-magnifying-glass" ] []
                    , if isEmpty jobSearchModel.listInputValue then
                        span [] []

                      else
                        span [ class "pl-2 text-xs" ] [ text ("+" ++ fromInt (length jobSearchModel.listInputValue)) ]
                    ]
                ]

        listMainTechnologyView =
            listMainTechnology
                |> List.map
                    (\mainTechnology ->
                        div
                            [ class "flex flex-col gap-y-1"
                            , onClick (SelectMainTechnologyState mainTechnology)
                            ]
                            [ div
                                [ class "flex h-10 items-center justify-center rounded-full w-10 hover:cursor-pointer hover:outline hover:outline-4 hover:outline-slate-300"
                                , if
                                    selectedMainTechnology
                                        == emptyMainTechnology
                                        || selectedMainTechnology
                                        == mainTechnology
                                  then
                                    class mainTechnology.bgColor

                                  else
                                    class "bg-slate-500"
                                ]
                                [ i [ class mainTechnology.icon ] []
                                ]
                            , div [ class "flex justify-center" ]
                                [ span [ class "text-xs text-slate-500" ] [ text mainTechnology.name ]
                                ]
                            ]
                    )
    in
    div [ class "relative z-10" ]
        [ div [ class "bg-white h-full" ]
            [ div [ class "block md:hidden" ] [ Html.map JobSearchUpdateMsg <| JobSearch.slideOverView jobSearchModel ]
            , div [ class "flex px-2.5 justify-between" ]
                [ div [ class "flex items-center px-1.5 py-2.5 gap-x-2 md:gap-x-4 overflow-x-auto md:w-[400px] md:overflow-x-visible" ]
                    [ div [ class "hidden relative md:block" ]
                        [ Html.map JobSearchUpdateMsg <| JobSearch.desktopView jobSearchModel
                        ]
                    , searchButtonMobile
                    , a [ class "h-8 items-center no-underline outline outline-slate-200 px-4 rounded-3xl md:h-9 md:flex md:gap-x-2" ]
                        [ div [ class "hidden items-center md:block" ]
                            [ span [ class "fa-solid fa-location-dot text-slate-700" ] []
                            ]
                        , span [ class "text-sm text-slate-700" ] [ text "Location" ]
                        , div [ class "hidden items-center md:flex" ]
                            [ i [ class "fa-solid fa-chevron-down text-sm text-slate-700" ] []
                            ]
                        ]
                    , a [ class "flex h-8 items-center no-underline outline outline-slate-200 rounded-3xl md:hidden" ]
                        [ span [ class "px-4 text-sm text-slate-700 truncate" ] [ text "Tech" ]
                        ]
                    , a
                        [ class "flex h-8 items-center no-underline outline outline-slate-200 rounded-3xl md:hidden"
                        , onClick (JobMoreFilterUpdateMsg JobMoreFilter.ModalState)
                        ]
                        [ span [ class "px-4 text-sm text-slate-700 truncate" ] [ text "More filters" ]
                        ]
                    , a
                        [ class "flex h-8 items-center no-underline outline outline-slate-200 rounded-3xl md:hidden"
                        , onClick (JobSortUpdateMsg JobSort.ButtonState)
                        ]
                        [ div [ class "px-4 text-sm text-slate-700 truncate" ] [ text "Sort by: Default" ]
                        ]
                    ]
                , div [ class "hidden gap-x-4 px-1 md:flex md:justify-end overflow-x-auto" ]
                    [ div [ class "flex flex-row gap-x-4 no-scrollbar overflow-x-scroll p-2" ]
                        listMainTechnologyView
                    , div [ class "flex items-center" ]
                        [ a
                            [ class "cursor-pointer h-8 items-center no-underline outline outline-slate-200 px-4 rounded-3xl w-40 md:flex md:gap-x-2 md:h-10"
                            , onClick (JobMoreFilterUpdateMsg JobMoreFilter.ModalState)
                            ]
                            [ span [ class "fa-solid fa-sliders text-slate-700" ] []
                            , span [ class "text-sm text-slate-700" ] [ text "More filters" ]
                            , i [ class "fa-solid fa-chevron-down text-slate-700 text-sm" ] []
                            ]
                        ]
                    ]
                , Html.map JobMoreFilterUpdateMsg <| JobMoreFilter.view jobMoreFilterModel
                , div [ class "block md:hidden" ] [ Html.map JobSortUpdateMsg <| JobSort.slideOverView jobSortModel ]
                ]
            ]
        ]
