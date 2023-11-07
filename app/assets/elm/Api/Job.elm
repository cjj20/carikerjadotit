module Api.Job exposing (..)

import DataModels.Job exposing (Job)
import Http exposing (get)
import String exposing (String)



-- MODEL


type alias ListJob =
    List Job


type alias Parameters =
    { company_name : String
    , location_type : String
    , main_technology : String
    , salary_is_undisclosed : String
    , sort_column : String
    , sort_direction : String
    , title : String
    }


type Msg
    = GetJobRequest (Result Http.Error String)


type ParametersMsg
    = CompanyName String
    | LocationType String
    | MainTechnology String
    | SalaryIsUndisclosed String
    | Sort String String
    | Title String



-- INIT


initListJob : Cmd Msg
initListJob =
    getJobs initParameters


initParameters : Parameters
initParameters =
    { company_name = "", location_type = "", main_technology = "", salary_is_undisclosed = "false", sort_column = "created_at", sort_direction = "desc", title = "" }



-- UPDATE


updateParameters : ParametersMsg -> Parameters -> ( Parameters, Cmd Msg )
updateParameters parametersMsg parameters =
    case parametersMsg of
        CompanyName msg_ ->
            ( { parameters | company_name = msg_ }, Cmd.none )

        LocationType msg_ ->
            ( { parameters | location_type = msg_ }, getJobs parameters )

        MainTechnology msg_ ->
            ( { parameters | main_technology = msg_ }, Cmd.none )

        SalaryIsUndisclosed msg_ ->
            ( { parameters | salary_is_undisclosed = msg_ }, Cmd.none )

        Sort column direction ->
            ( { parameters | sort_column = column, sort_direction = direction }, Cmd.none )

        Title msg_ ->
            ( { parameters | title = msg_ }, Cmd.none )



-- EXPRESSION


parametersToString : Parameters -> String
parametersToString jobParameters =
    "company_name="
        ++ jobParameters.company_name
        ++ "&location_type="
        ++ jobParameters.location_type
        ++ "&main_technology="
        ++ jobParameters.main_technology
        ++ "&salary_is_undisclosed="
        ++ jobParameters.salary_is_undisclosed
        ++ "&sort_column="
        ++ jobParameters.sort_column
        ++ "&sort_direction="
        ++ jobParameters.sort_direction
        ++ "&title="
        ++ jobParameters.title



-- CMD


getJobs : Parameters -> Cmd Msg
getJobs parameters =
    let
        parametersString =
            parametersToString parameters
    in
    get
        { url = "http://127.0.0.1:3000/api/v1/jobs?" ++ parametersString
        , expect = Http.expectString GetJobRequest
        }
