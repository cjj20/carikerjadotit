module HomePage exposing (..)

import Browser
import Components.JobFilter as JobFilter
import Components.JobTab as JobTab exposing (Msg(..), RemoteToggleMsg(..), TabMsg(..))
import Components.JobView as JobView
import Html exposing (..)
import Html.Attributes exposing (class, src, style, type_)
import Http exposing (Error)
import Integrations.JobApi as JobApi
import Models.Job as DataModelsJob exposing (ListJob)
import Shared.Navbar as Navbar
import Shared.OpenStreetMap as OpenStreetMap
import Shared.SortDropDown as SortDropDown


type alias Model =
    { navbarModel : Navbar.Model
    , tabJobModel : JobTab.Model
    , filterJobModel : JobFilter.Model
    , loadingGetJobs : Bool
    , error : Maybe Error
    , apiJobParameters : JobApi.Parameters
    , apiJobListJob : ListJob
    , sortDropDownModel : SortDropDown.Model
    }


type Msg
    = None
    | NavbarUpdateMsg Navbar.Msg
    | JobTabMsg JobTab.Msg
    | JobFilterUpdateMsg JobFilter.Msg
    | JobApiParametersMsg JobApi.ParametersMsg
    | JobApiGetJobRequestMsg JobApi.Msg
    | SortDropDownUpdateMsg SortDropDown.Msg



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( { navbarModel = Navbar.init
      , tabJobModel = JobTab.init
      , filterJobModel = JobFilter.init
      , loadingGetJobs = True
      , error = Nothing
      , apiJobParameters = JobApi.initParameters
      , apiJobListJob = []
      , sortDropDownModel = SortDropDown.init
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

        JobTabMsg msg_ ->
            case msg_ of
                ActiveTab _ ->
                    let
                        ( newUpdateJobTabModel, _ ) =
                            JobTab.update msg_ model.tabJobModel

                        newUpdateActiveTab =
                            if newUpdateJobTabModel.activeTab == WithSalary then
                                JobApi.SalaryIsUndisclosed "false"

                            else
                                JobApi.SalaryIsUndisclosed ""

                        ( newUpdateJobApiModel, _ ) =
                            JobApi.updateParameters newUpdateActiveTab model.apiJobParameters
                    in
                    ( { model
                        | tabJobModel = newUpdateJobTabModel
                        , loadingGetJobs = True
                        , apiJobParameters = newUpdateJobApiModel
                      }
                    , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newUpdateJobApiModel
                    )

                RemoteToggle ->
                    let
                        ( newUpdateJobTabModel, _ ) =
                            JobTab.update msg_ model.tabJobModel

                        newUpdateRemoteToggle =
                            if newUpdateJobTabModel.remoteToggle == On then
                                JobApi.LocationType "remote"

                            else
                                JobApi.LocationType ""

                        ( newUpdateJobApiModel, _ ) =
                            JobApi.updateParameters newUpdateRemoteToggle model.apiJobParameters
                    in
                    ( { model
                        | tabJobModel = newUpdateJobTabModel
                        , loadingGetJobs = True
                        , apiJobParameters = newUpdateJobApiModel
                      }
                    , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newUpdateJobApiModel
                    )

                SortDropDownMsg mssg_ ->
                    let
                        ( newUpdateJobTabModel, _ ) =
                            JobTab.update msg_ model.tabJobModel

                        ( newUpdateJobTabModel2, _ ) =
                            SortDropDown.update mssg_ model.sortDropDownModel

                        newUpdateSortColumn =
                            JobApi.Sort model.sortDropDownModel.selectedSort.column model.sortDropDownModel.selectedSort.direction

                        ( newUpdateJobApiModel, _ ) =
                            JobApi.updateParameters newUpdateSortColumn model.apiJobParameters
                    in
                    ( { model
                        | tabJobModel = newUpdateJobTabModel
                        , sortDropDownModel = newUpdateJobTabModel2
                        , apiJobParameters = newUpdateJobApiModel
                      }
                    , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newUpdateJobApiModel
                    )

        JobFilterUpdateMsg msg_ ->
            let
                tabJobMsg =
                    msg
            in
            case msg_ of
                JobFilter.SortDropDownUpdateMsg mssg_ ->
                    let
                        ( newUpdateModel, _ ) =
                            JobFilter.update msg_ model.filterJobModel

                        ( newUpdateJobTabModel2, _ ) =
                            SortDropDown.update mssg_ model.sortDropDownModel
                    in
                    ( { model | filterJobModel = newUpdateModel, sortDropDownModel = newUpdateJobTabModel2 }, Cmd.none )

                JobFilter.JobTabUpdateMsg mssg_ ->
                    let
                        ( newUpdateModel, _ ) =
                            JobTab.update mssg_ model.tabJobModel
                    in
                    ( { model | tabJobModel = newUpdateModel }, Cmd.none )

                JobFilter.UpdateBoth _ ->
                    ( model, Cmd.none )

        JobApiGetJobRequestMsg msg_ ->
            case msg_ of
                JobApi.GetJobRequest response ->
                    case response of
                        Ok data ->
                            ( { model
                                | loadingGetJobs = False
                                , apiJobListJob = DataModelsJob.jobsDecodeString data
                              }
                            , Cmd.none
                            )

                        Err error ->
                            ( { model
                                | loadingGetJobs = False
                                , error = Just error
                              }
                            , Cmd.none
                            )

        JobApiParametersMsg _ ->
            ( model, Cmd.none )

        SortDropDownUpdateMsg msg_ ->
            let
                ( newUpdateJobTabModel, _ ) =
                    SortDropDown.update msg_ model.sortDropDownModel

                newUpdateSortColumn =
                    JobApi.Sort model.sortDropDownModel.selectedSort.column model.sortDropDownModel.selectedSort.direction

                ( newUpdateJobApiModel, _ ) =
                    JobApi.updateParameters newUpdateSortColumn model.apiJobParameters
            in
            ( { model
                | sortDropDownModel = newUpdateJobTabModel
                , apiJobParameters = newUpdateJobApiModel
              }
            , Cmd.map JobApiGetJobRequestMsg <| JobApi.getJobs newUpdateJobApiModel
            )



-- VIEW


view : Model -> Html Msg
view model =
    let
        listJobView =
            if model.loadingGetJobs then
                List.map JobView.loadingView (List.range 1 10)

            else
                List.map (\data -> div [] [ JobView.viewJob data ]) model.apiJobListJob
    in
    div [ class "flex flex-col" ]
        [ div [ class "sticky top-0 z-50" ]
            [ Html.map NavbarUpdateMsg <| Navbar.view model.navbarModel
            , Html.map JobFilterUpdateMsg <| JobFilter.view model.filterJobModel
            ]
        , div [ class "grid grid-cols-1 lg:grid-cols-2" ]
            [ div [ class "flex flex-col gap-y-2" ]
                [ Html.map JobTabMsg <| JobTab.view model.tabJobModel
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
