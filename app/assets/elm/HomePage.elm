module HomePage exposing (..)

import Browser
import Components.JobFilter as JobFilter
import Components.JobLocation as JobLocation
import Components.JobMainTechnology as JobMainTechnology exposing (Msg(..))
import Components.JobMoreFilter as JobMoreFilter exposing (Msg(..))
import Components.JobSearch exposing (Msg(..))
import Components.JobSort as JobSort
import Components.JobTab as JobTab exposing (Msg(..), RemoteToggleMsg(..), TabMsg(..))
import Components.JobView as JobView
import Components.Maps as OpenStreetMap exposing (mobileView)
import Components.Navbar as Navbar
import Helpers.Converter exposing (floatToString)
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)
import Http exposing (Error)
import Integrations.JobApi as JobApi
import Models.Job as DataModelsJob exposing (ListJob)
import String exposing (fromInt)



-- MODEL


type alias Model =
    { navbarModel : Navbar.Model
    , jobFilterModel : JobFilter.Model
    , jobTabModel : JobTab.Model
    , jobSortModel : JobSort.Model
    , jobLoading : Bool
    , jobList : ListJob
    , jobTotal : Int
    , jobApiParameters : JobApi.Parameters
    , error : Maybe Error
    }



-- MSG


type Msg
    = NavbarUpdateMsg Navbar.Msg
    | JobFilterUpdateMsg JobFilter.Msg
    | JobTabUpdateMsg JobTab.Msg
    | JobApiGetJobRequestMsg JobApi.Msg



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( { navbarModel = Navbar.init
      , jobFilterModel = JobFilter.init
      , jobTabModel = JobTab.init
      , jobSortModel = JobSort.init
      , jobLoading = True
      , jobList = []
      , jobTotal = 0
      , jobApiParameters = JobApi.initParameters
      , error = Nothing
      }
    , Cmd.map JobApiGetJobRequestMsg <| JobApi.initListJob
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavbarUpdateMsg msg_ ->
            let
                ( newModel, _ ) =
                    Navbar.update msg_ model.navbarModel
            in
            ( { model | navbarModel = newModel }, Cmd.none )

        JobTabUpdateMsg msg_ ->
            let
                ( newJobTabModel, _ ) =
                    JobTab.update msg_ model.jobTabModel
            in
            case msg_ of
                Active _ ->
                    let
                        newActiveTab =
                            if newJobTabModel.active == WithSalary then
                                JobApi.SalaryIsUndisclosedState "false"

                            else
                                JobApi.SalaryIsUndisclosedState ""

                        ( newJobApiModel, _ ) =
                            JobApi.updateParameters newActiveTab model.jobApiParameters
                    in
                    ( { model
                        | jobTabModel = newJobTabModel
                        , jobLoading = True
                        , jobApiParameters = newJobApiModel
                      }
                    , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                    )

                RemoteToggle ->
                    let
                        newRemoteToggle =
                            if newJobTabModel.remoteToggle == On then
                                JobApi.LocationTypeState "remote"

                            else
                                JobApi.LocationTypeState ""

                        ( newJobApiModel, _ ) =
                            JobApi.updateParameters newRemoteToggle model.jobApiParameters
                    in
                    ( { model
                        | jobTabModel = newJobTabModel
                        , jobLoading = True
                        , jobApiParameters = newJobApiModel
                      }
                    , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                    )

                JobSortUpdateMsg jobSortMsg ->
                    let
                        ( newJobSortModel, _ ) =
                            JobSort.update jobSortMsg model.jobSortModel

                        newJobFilterMsg =
                            JobFilter.JobSortUpdateMsg jobSortMsg

                        ( newJobFilterModel, _ ) =
                            JobFilter.update newJobFilterMsg model.jobFilterModel
                    in
                    case jobSortMsg of
                        JobSort.ButtonState _ ->
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobTabModel = newJobTabModel
                                , jobSortModel = newJobSortModel
                              }
                            , Cmd.none
                            )

                        JobSort.Select _ ->
                            let
                                newJobApiSortStateMsg =
                                    JobApi.SortState newJobSortModel.selected.column newJobSortModel.selected.direction

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiSortStateMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobTabModel = newJobTabModel
                                , jobSortModel = newJobSortModel
                                , jobLoading = True
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                            )

        JobFilterUpdateMsg msg_ ->
            case msg_ of
                JobFilter.JobSortUpdateMsg jobSortMsg ->
                    let
                        newJobSortMsg =
                            JobTab.JobSortUpdateMsg jobSortMsg

                        ( newJobFilterModel, _ ) =
                            JobFilter.update msg_ model.jobFilterModel

                        ( newJobTabModel, _ ) =
                            JobTab.update newJobSortMsg model.jobTabModel

                        ( newJobSortModel, _ ) =
                            JobSort.update jobSortMsg model.jobSortModel
                    in
                    case jobSortMsg of
                        JobSort.ButtonState _ ->
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobTabModel = newJobTabModel
                                , jobSortModel = newJobSortModel
                              }
                            , Cmd.none
                            )

                        JobSort.Select _ ->
                            let
                                newJobApiSortMsg =
                                    JobApi.SortState model.jobSortModel.selected.column model.jobSortModel.selected.direction

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiSortMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobTabModel = newJobTabModel
                                , jobSortModel = newJobSortModel
                                , jobLoading = True
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                            )

                JobFilter.JobMoreFilterUpdateMsg jobMoreFilterMsg ->
                    let
                        newJobMoreFilterMsg =
                            JobFilter.JobMoreFilterUpdateMsg jobMoreFilterMsg

                        ( newJobFilterModel, _ ) =
                            JobFilter.update newJobMoreFilterMsg model.jobFilterModel
                    in
                    case jobMoreFilterMsg of
                        JobMoreFilter.ButtonState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        SalaryMinValueState _ ->
                            let
                                newJobApiSalaryMinStateMsg =
                                    JobApi.SalaryMinState
                                        (floatToString newJobFilterModel.jobMoreFilterModel.salaryMinValue)

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiSalaryMinStateMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.none
                            )

                        SalaryMaxValueState _ ->
                            let
                                newJobApiSalaryMaxStateMsg =
                                    JobApi.SalaryMaxState (floatToString newJobFilterModel.jobMoreFilterModel.salaryMaxValue)

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiSalaryMaxStateMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.none
                            )

                        FriendlyOfferState ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        ExperienceLevelState _ ->
                            let
                                newJobApiExperienceStateMsg =
                                    JobApi.ExperienceState newJobFilterModel.jobMoreFilterModel.experienceLevel

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiExperienceStateMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.none
                            )

                        EmploymentTypeState _ ->
                            let
                                newJobApiEmploymentTypeStateMsg =
                                    JobApi.EmploymentTypeState newJobFilterModel.jobMoreFilterModel.employmentType

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiEmploymentTypeStateMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.none
                            )

                        TypeOfWorkState _ ->
                            let
                                newJobApiTypeOfWorkStateMsg =
                                    JobApi.TypeOfWorkState newJobFilterModel.jobMoreFilterModel.typeOfWork

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiTypeOfWorkStateMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.none
                            )

                        ClearFilterState ->
                            let
                                newJobApiClearMoreFilterStateMsg =
                                    JobApi.ClearMoreFilterState

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiClearMoreFilterStateMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.none
                            )

                        ShowOffers ->
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobLoading = True
                              }
                            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs model.jobApiParameters
                            )

                JobFilter.JobSearchUpdateMsg jobSearchMsg ->
                    let
                        newJobSearchMsg =
                            JobFilter.JobSearchUpdateMsg jobSearchMsg

                        ( newJobFilterModel, _ ) =
                            JobFilter.update newJobSearchMsg model.jobFilterModel

                        newJobApiSearchStateMsg =
                            JobApi.SearchState newJobFilterModel.jobSearchModel.listInputValue

                        ( newJobApiModel, _ ) =
                            JobApi.updateParameters newJobApiSearchStateMsg model.jobApiParameters
                    in
                    case jobSearchMsg of
                        DropDownState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        SlideOverState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        AddInputTempState _ ->
                            let
                                newModelWithCmd =
                                    if
                                        newJobFilterModel.jobSearchModel.listInputTemp
                                            /= model.jobFilterModel.jobSearchModel.listInputTemp
                                    then
                                        ( { model
                                            | jobFilterModel = newJobFilterModel
                                            , jobLoading = True
                                            , jobApiParameters = newJobApiModel
                                          }
                                        , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                                        )

                                    else
                                        ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )
                            in
                            newModelWithCmd

                        RemoveInputValueState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        KeywordState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        SearchState ->
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobLoading = True
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                            )

                JobFilter.JobMainTechnologyUpdateMsg jobMainTechnologyMsg ->
                    let
                        newJobMoreFilterMsg =
                            JobFilter.JobMainTechnologyUpdateMsg jobMainTechnologyMsg

                        ( newJobFilterModel, _ ) =
                            JobFilter.update newJobMoreFilterMsg model.jobFilterModel
                    in
                    case jobMainTechnologyMsg of
                        JobMainTechnology.ButtonState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        Select _ ->
                            let
                                newJobApiMainTechnologyStateMsg =
                                    JobApi.MainTechnologyState newJobFilterModel.jobMainTechnologyModel.selected

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiMainTechnologyStateMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobLoading = True
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                            )

                JobFilter.JobLocationUpdateMsg jobLocationMsg ->
                    let
                        newJobLocationMsg =
                            JobFilter.JobLocationUpdateMsg jobLocationMsg

                        ( newJobFilterModel, _ ) =
                            JobFilter.update newJobLocationMsg model.jobFilterModel
                    in
                    case jobLocationMsg of
                        JobLocation.ButtonState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        JobLocation.SelectState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        JobLocation.ClearFilterState ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        JobLocation.ShowOffersState ->
                            let
                                newJobApiLocationTypeMsg =
                                    JobApi.LocationNameState newJobFilterModel.jobLocationModel.selected

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiLocationTypeMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobLoading = True
                                , jobApiParameters = newJobApiModel
                              }
                            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                            )

                        JobLocation.InputFocusState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

                        JobLocation.SearchState _ ->
                            ( { model | jobFilterModel = newJobFilterModel }, Cmd.none )

        JobApiGetJobRequestMsg msg_ ->
            case msg_ of
                JobApi.GetJobRequest response ->
                    case response of
                        Ok data ->
                            let
                                jobDecoded =
                                    DataModelsJob.jobsDecodeString data

                                jobList =
                                    jobDecoded.data

                                jobTotal =
                                    jobDecoded.meta.total_jobs
                            in
                            ( { model
                                | jobLoading = False
                                , jobList = jobList
                                , jobTotal = jobTotal
                              }
                            , Cmd.none
                            )

                        Err error ->
                            ( { model
                                | jobLoading = False
                                , error = Just error
                                , jobList = []
                                , jobTotal = 0
                              }
                            , Cmd.none
                            )



-- VIEW


view : Model -> Html Msg
view { jobLoading, jobList, navbarModel, jobFilterModel, jobTabModel, jobTotal } =
    let
        listJobMap =
            if jobLoading then
                List.map JobView.loadingView (List.range 1 10)

            else
                List.map (\data -> div [] [ JobView.view data ]) jobList
    in
    div [ class "flex flex-col gap-y-4 bg-white-30" ]
        [ div [ class "sticky top-0 z-50" ]
            [ Html.map NavbarUpdateMsg <| Navbar.view navbarModel
            , Html.map JobFilterUpdateMsg <| JobFilter.view jobFilterModel
            , Html.map JobTabUpdateMsg <| JobTab.view jobTabModel
            ]
        , div [ class "bg-white-30 gap-x-4 h-[calc(100vh-210px)] lg:flex lg:h-[calc(100vh-230px)] lg:justify-between" ]
            [ div [ class "flex flex-col gap-y-4 bg-white-30 w-full lg:w-1/2 px-4 lg:pl-[140px]" ]
                [ span [ class "text-sm text-black-90 lg:text-base" ] [ text ("Work: " ++ fromInt jobTotal ++ " offers") ]
                , div [ class "flex flex-col gap-y-2 h-[calc(100vh-270px)] no-scrollbar overflow-y-scroll md:h-[calc(100vh-250px)]" ]
                    [ div [ class "block lg:hidden" ] [ mobileView ]
                    , div [ class "flex flex-col gap-y-2 lg:gap-y-3 pb-4" ] <| listJobMap
                    ]
                ]
            , div [ class "flex justify-center lg:w-1/2 pt-2" ]
                [ div [ class "hidden lg:block lg:h-[calc(100vh-250px)] rounded-xl w-full bg-[#F2F6FD] pr-[140px]" ]
                    [ OpenStreetMap.view
                    ]
                ]
            ]
        ]



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
