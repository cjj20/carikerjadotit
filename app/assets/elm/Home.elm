module Home exposing (..)

import Api.Job as ApiJob
import Browser
import DataModels.Job as DataModelsJob
import Html exposing (..)
import Html.Attributes exposing (class, src, style, type_)
import Http exposing (Error)
import Shared.FilterJob as FilterJob
import Shared.Job as Job
import Shared.Navbar as Navbar
import Shared.OpenStreetMap as OpenStreetMap
import Shared.SortDropDown as SortDropDown
import Shared.TabJob as TabJob exposing (Msg(..), RemoteToggleMsg(..), TabMsg(..))


type alias Model =
    { navbarModel : Navbar.Model
    , tabJobModel : TabJob.Model
    , filterJobModel : FilterJob.Model
    , loadingGetJobs : Bool
    , error : Maybe Error
    , apiJobParameters : ApiJob.Parameters
    , apiJobListJob : ApiJob.ListJob
    , sortDropDownModel : SortDropDown.Model
    }


type Msg
    = None
    | NavbarUpdateMsg Navbar.Msg
    | TabJobMsg TabJob.Msg
    | FilterJobUpdateMsg FilterJob.Msg
    | ApiJobParametersMsg ApiJob.ParametersMsg
    | ApiJobGetJobRequestMsg ApiJob.Msg
    | SortDropDownUpdateMsg SortDropDown.Msg



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( { navbarModel = Navbar.init
      , tabJobModel = TabJob.init
      , filterJobModel = FilterJob.init
      , loadingGetJobs = True
      , error = Nothing
      , apiJobParameters = ApiJob.initParameters
      , apiJobListJob = []
      , sortDropDownModel = SortDropDown.init
      }
    , Cmd.map ApiJobGetJobRequestMsg <| ApiJob.initListJob
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

        TabJobMsg msg_ ->
            case msg_ of
                ActiveTab _ ->
                    let
                        ( newUpdateTabJobModel, _ ) =
                            TabJob.update msg_ model.tabJobModel

                        newUpdateActiveTab =
                            if newUpdateTabJobModel.activeTab == WithSalary then
                                ApiJob.SalaryIsUndisclosed "false"

                            else
                                ApiJob.SalaryIsUndisclosed ""

                        ( newUpdateApiJobModel, _ ) =
                            ApiJob.updateParameters newUpdateActiveTab model.apiJobParameters
                    in
                    ( { model
                        | tabJobModel = newUpdateTabJobModel
                        , loadingGetJobs = True
                        , apiJobParameters = newUpdateApiJobModel
                      }
                    , Cmd.map ApiJobGetJobRequestMsg <| ApiJob.getJobs newUpdateApiJobModel
                    )

                RemoteToggle ->
                    let
                        ( newUpdateTabJobModel, _ ) =
                            TabJob.update msg_ model.tabJobModel

                        newUpdateRemoteToggle =
                            if newUpdateTabJobModel.remoteToggle == On then
                                ApiJob.LocationType "remote"

                            else
                                ApiJob.LocationType ""

                        ( newUpdateApiJobModel, _ ) =
                            ApiJob.updateParameters newUpdateRemoteToggle model.apiJobParameters
                    in
                    ( { model
                        | tabJobModel = newUpdateTabJobModel
                        , loadingGetJobs = True
                        , apiJobParameters = newUpdateApiJobModel
                      }
                    , Cmd.map ApiJobGetJobRequestMsg <| ApiJob.getJobs newUpdateApiJobModel
                    )

                SortDropDownMsg mssg_ ->
                    let
                        ( newUpdateTabJobModel, _ ) =
                            TabJob.update msg_ model.tabJobModel

                        ( newUpdateTabJobModel2, _ ) =
                            SortDropDown.update mssg_ model.sortDropDownModel

                        newUpdateSortColumn =
                            ApiJob.Sort model.sortDropDownModel.selectedSort.column model.sortDropDownModel.selectedSort.direction

                        ( newUpdateApiJobModel, _ ) =
                            ApiJob.updateParameters newUpdateSortColumn model.apiJobParameters
                    in
                    ( { model
                        | tabJobModel = newUpdateTabJobModel
                        , sortDropDownModel = newUpdateTabJobModel2
                        , apiJobParameters = newUpdateApiJobModel
                      }
                    , Cmd.map ApiJobGetJobRequestMsg <| ApiJob.getJobs newUpdateApiJobModel
                    )

        FilterJobUpdateMsg msg_ ->
            let
                tabJobMsg =
                    msg
            in
            case msg_ of
                FilterJob.SortDropDownUpdateMsg mssg_ ->
                    let
                        ( newUpdateModel, _ ) =
                            FilterJob.update msg_ model.filterJobModel

                        ( newUpdateTabJobModel2, _ ) =
                            SortDropDown.update mssg_ model.sortDropDownModel
                    in
                    ( { model | filterJobModel = newUpdateModel, sortDropDownModel = newUpdateTabJobModel2 }, Cmd.none )

                FilterJob.TabJobUpdateMsg mssg_ ->
                    let
                        ( newUpdateModel, _ ) =
                            TabJob.update mssg_ model.tabJobModel
                    in
                    ( { model | tabJobModel = newUpdateModel }, Cmd.none )

                FilterJob.UpdateBoth _ ->
                    ( model, Cmd.none )

        ApiJobGetJobRequestMsg msg_ ->
            case msg_ of
                ApiJob.GetJobRequest response ->
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

        ApiJobParametersMsg _ ->
            ( model, Cmd.none )

        SortDropDownUpdateMsg msg_ ->
            let
                ( newUpdateTabJobModel, _ ) =
                    SortDropDown.update msg_ model.sortDropDownModel

                newUpdateSortColumn =
                    ApiJob.Sort model.sortDropDownModel.selectedSort.column model.sortDropDownModel.selectedSort.direction

                ( newUpdateApiJobModel, _ ) =
                    ApiJob.updateParameters newUpdateSortColumn model.apiJobParameters
            in
            ( { model
                | sortDropDownModel = newUpdateTabJobModel
                , apiJobParameters = newUpdateApiJobModel
              }
            , Cmd.map ApiJobGetJobRequestMsg <| ApiJob.getJobs newUpdateApiJobModel
            )



-- VIEW


view : Model -> Html Msg
view model =
    let
        listJobView =
            if model.loadingGetJobs then
                List.map Job.loadingView (List.range 1 10)

            else
                List.map (\data -> div [] [ Job.viewJobDetail data ]) model.apiJobListJob
    in
    div [ class "flex flex-col" ]
        [ div [ class "sticky top-0 z-50" ]
            [ Html.map NavbarUpdateMsg <| Navbar.view model.navbarModel
            , Html.map FilterJobUpdateMsg <| FilterJob.view model.filterJobModel
            ]
        , div [ class "grid grid-cols-1 lg:grid-cols-2" ]
            [ div [ class "flex flex-col gap-y-2" ]
                [ Html.map TabJobMsg <| TabJob.view model.tabJobModel
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
