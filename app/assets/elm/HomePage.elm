module HomePage exposing (..)

import Browser
import Components.JobFilter as JobFilter
import Components.JobSortDropDown as JobSortDropDown
import Components.JobTab as JobTab exposing (Msg(..), RemoteToggleMsg(..), TabMsg(..))
import Components.JobView as JobView
import Components.Navbar as Navbar
import Components.OpenStreetMap as OpenStreetMap
import Html exposing (..)
import Html.Attributes exposing (class, src, style, type_)
import Http exposing (Error)
import Integrations.JobApi as JobApi
import Models.Job as DataModelsJob exposing (ListJob)



-- MODEL


type alias Model =
    { error : Maybe Error
    , jobFilterModel : JobFilter.Model
    , jobTabModel : JobTab.Model
    , jobSortDropDownModel : JobSortDropDown.Model
    , jobLoading : Bool
    , jobApiParameters : JobApi.Parameters
    , jobList : ListJob
    , navbarModel : Navbar.Model
    }



-- MSG


type Msg
    = None
    | NavbarUpdateMsg Navbar.Msg
    | JobTabUpdateMsg JobTab.Msg
    | JobFilterUpdateMsg JobFilter.Msg
    | JobApiGetJobRequestMsg JobApi.Msg



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( { navbarModel = Navbar.init
      , jobTabModel = JobTab.init
      , jobFilterModel = JobFilter.init
      , jobLoading = True
      , error = Nothing
      , jobApiParameters = JobApi.initParameters
      , jobList = []
      , jobSortDropDownModel = JobSortDropDown.init
      }
    , Cmd.map JobApiGetJobRequestMsg <| JobApi.initListJob
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        NavbarUpdateMsg msg_ ->
            let
                ( newUpdateModel, _ ) =
                    Navbar.update msg_ model.navbarModel
            in
            ( { model | navbarModel = newUpdateModel }, Cmd.none )

        JobTabUpdateMsg msg_ ->
            let
                ( newJobTabModel, _ ) =
                    JobTab.update msg_ model.jobTabModel

                jobCmdUpdate =
                    case msg_ of
                        ActiveTab _ ->
                            let
                                newActiveTab =
                                    if newJobTabModel.activeTab == WithSalary then
                                        JobApi.SalaryIsUndisclosed "false"

                                    else
                                        JobApi.SalaryIsUndisclosed ""

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newActiveTab model.jobApiParameters
                            in
                            ( { model
                                | jobTabModel = newJobTabModel
                                , jobApiParameters = newJobApiModel
                                , jobLoading = True
                              }
                            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                            )

                        RemoteToggle ->
                            let
                                newRemoteToggle =
                                    if newJobTabModel.remoteToggle == On then
                                        JobApi.LocationType "remote"

                                    else
                                        JobApi.LocationType ""

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newRemoteToggle model.jobApiParameters
                            in
                            ( { model
                                | jobTabModel = newJobTabModel
                                , jobApiParameters = newJobApiModel
                                , jobLoading = True
                              }
                            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                            )

                        JobSortDropDownUpdateMsg jobSortDropDownMsg ->
                            case jobSortDropDownMsg of
                                JobSortDropDown.DropDownState ->
                                    let
                                        ( newJobSortDropDownModel, _ ) =
                                            JobSortDropDown.update jobSortDropDownMsg model.jobSortDropDownModel
                                    in
                                    ( { model
                                        | jobTabModel = newJobTabModel
                                        , jobSortDropDownModel = newJobSortDropDownModel
                                      }
                                    , Cmd.none
                                    )

                                JobSortDropDown.Select _ ->
                                    let
                                        ( newJobSortDropDownModel, _ ) =
                                            JobSortDropDown.update jobSortDropDownMsg model.jobSortDropDownModel

                                        newJobApiSortMsg =
                                            JobApi.Sort model.jobSortDropDownModel.selected.column model.jobSortDropDownModel.selected.direction

                                        ( newJobApiModel, _ ) =
                                            JobApi.updateParameters newJobApiSortMsg model.jobApiParameters

                                        newJobFilterMsg =
                                            JobFilter.JobSortDropDownUpdateMsg jobSortDropDownMsg

                                        ( newJobFilterModel, _ ) =
                                            JobFilter.update newJobFilterMsg model.jobFilterModel
                                    in
                                    ( { model
                                        | jobTabModel = newJobTabModel
                                        , jobSortDropDownModel = newJobSortDropDownModel
                                        , jobApiParameters = newJobApiModel
                                        , jobFilterModel = newJobFilterModel
                                        , jobLoading = True
                                      }
                                    , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                                    )
            in
            jobCmdUpdate

        JobFilterUpdateMsg msg_ ->
            case msg_ of
                JobFilter.JobSortDropDownUpdateMsg jobSortDropDownMsg ->
                    let
                        newJobSortDropDownMsg =
                            JobTab.JobSortDropDownUpdateMsg jobSortDropDownMsg

                        ( newJobTabModel, _ ) =
                            JobTab.update newJobSortDropDownMsg model.jobTabModel
                    in
                    case jobSortDropDownMsg of
                        JobSortDropDown.DropDownState ->
                            let
                                ( newJobSortDropDownModel, _ ) =
                                    JobSortDropDown.update jobSortDropDownMsg model.jobSortDropDownModel

                                ( newJobFilterModel, _ ) =
                                    JobFilter.update msg_ model.jobFilterModel
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobSortDropDownModel = newJobSortDropDownModel
                              }
                            , Cmd.none
                            )

                        JobSortDropDown.Select _ ->
                            let
                                ( newJobFilterModel, _ ) =
                                    JobFilter.update msg_ model.jobFilterModel

                                ( newJobSortDropDownModel, _ ) =
                                    JobSortDropDown.update jobSortDropDownMsg model.jobSortDropDownModel

                                newJobApiSortDropDownMsg =
                                    JobApi.Sort model.jobSortDropDownModel.selected.column model.jobSortDropDownModel.selected.direction

                                ( newJobApiModel, _ ) =
                                    JobApi.updateParameters newJobApiSortDropDownMsg model.jobApiParameters
                            in
                            ( { model
                                | jobFilterModel = newJobFilterModel
                                , jobSortDropDownModel = newJobSortDropDownModel
                                , jobTabModel = newJobTabModel
                                , jobApiParameters = newJobApiModel
                                , jobLoading = True
                              }
                            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newJobApiModel
                            )

        JobApiGetJobRequestMsg msg_ ->
            case msg_ of
                JobApi.GetJobRequest response ->
                    case response of
                        Ok data ->
                            ( { model
                                | jobLoading = False
                                , jobList = DataModelsJob.jobsDecodeString data
                              }
                            , Cmd.none
                            )

                        Err error ->
                            ( { model
                                | jobLoading = False
                                , error = Just error
                              }
                            , Cmd.none
                            )



-- VIEW


view : Model -> Html Msg
view { jobLoading, jobList, navbarModel, jobFilterModel, jobTabModel } =
    let
        listJobView =
            if jobLoading then
                List.map JobView.loadingView (List.range 1 10)

            else
                List.map (\data -> div [] [ JobView.viewJob data ]) jobList
    in
    div [ class "flex flex-col" ]
        [ div [ class "sticky top-0 z-50" ]
            [ Html.map NavbarUpdateMsg <| Navbar.view navbarModel
            , Html.map JobFilterUpdateMsg <| JobFilter.view jobFilterModel
            ]
        , div [ class "grid grid-cols-1 lg:grid-cols-2" ]
            [ div [ class "flex flex-col gap-y-2" ]
                [ Html.map JobTabUpdateMsg <| JobTab.view jobTabModel
                , div [ class "px-4" ]
                    [ span [ class "text-sm text-slate-500 lg:text-base" ] [ text "Work 8 674 offers" ]
                    ]
                , div [ class "flex flex-col gap-y-2 h-[calc(100vh-210px)] no-scrollbar overflow-y-scroll md:h-[calc(100vh-250px)]" ]
                    [ div [ class "block px-4 relative lg:hidden" ]
                        [ div [ class "flex items-center justify-center overflow-hidden relative" ]
                            [ img [ src "https://justjoin.it/shared-gfx/map-button/shared/map-button-light.png", class "h-16 object-cover", style "width" "100%" ] []
                            , div [ class "absolute bottom-0 flex items-center justify-center h-full left-0 right-0 top-0 w-full" ]
                                [ a [ class "bg-white flex gap-x-2 h-10 items-center justify-center no-underline rounded-xl w-40", type_ "button" ]
                                    [ i [ class "fa-regular fa-map text-slate-700" ] []
                                    , span [ class "font-semibold text-xs text-slate-700" ] [ text "Look on the map" ]
                                    ]
                                ]
                            ]
                        ]
                    , div [ class "flex flex-col gap-y-1.5 px-4 pb-4" ] <| listJobView
                    ]
                ]
            , div [ class "hidden lg:block lg:h-[calc(100vh-170px)]" ]
                [ OpenStreetMap.view
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
