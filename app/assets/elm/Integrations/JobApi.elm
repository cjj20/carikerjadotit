module Integrations.JobApi exposing (..)

import Components.JobMoreFilter
    exposing
        ( EmploymentTypeMsg
        , ExperienceLevelMsg
        , TypeOfWorkMsg
        )
import Helpers.Converter exposing (listStringToString)
import Helpers.JobHelper
    exposing
        ( listEmploymentTypeMsgToString
        , listExperienceMsgToString
        , listTypeOfWorkMsgToString
        )
import Http exposing (get)
import String exposing (String, fromInt)



-- CONFIG


baseUrl : String
baseUrl =
    "http://127.0.0.1:3000"



-- MODEL


type alias Parameters =
    { company_name : String
    , location_type : String
    , main_technology : String
    , salary_is_undisclosed : String
    , sort_column : String
    , sort_direction : String
    , search : List String
    , salary_min : String
    , salary_max : String
    , experience : List ExperienceLevelMsg
    , employment_type : List EmploymentTypeMsg
    , type_of_work : List TypeOfWorkMsg
    , location_name : String
    , page : Int
    , per_page : Int
    }



-- MSG


type Msg
    = GetJobRequest (Result Http.Error String)


type ParametersMsg
    = CompanyNameState String
    | LocationTypeState String
    | MainTechnologyState String
    | SalaryIsUndisclosedState String
    | SortState String String
    | SearchState (List String)
    | SalaryMinState String
    | SalaryMaxState String
    | ExperienceState (List ExperienceLevelMsg)
    | EmploymentTypeState (List EmploymentTypeMsg)
    | TypeOfWorkState (List TypeOfWorkMsg)
    | LocationNameState String
    | ClearMoreFilterState
    | NextPage



-- INIT


initListJob : Cmd Msg
initListJob =
    getJobs initParameters


initParameters : Parameters
initParameters =
    { company_name = ""
    , location_type = ""
    , main_technology = ""
    , salary_is_undisclosed = "false"
    , sort_column = "created_at"
    , sort_direction = "desc"
    , search = []
    , salary_min = ""
    , salary_max = ""
    , experience = []
    , employment_type = []
    , type_of_work = []
    , location_name = ""
    , page = 1
    , per_page = 20
    }



-- UPDATE


updateParameters : ParametersMsg -> Parameters -> ( Parameters, Cmd Msg )
updateParameters parametersMsg parameters =
    case parametersMsg of
        CompanyNameState msg_ ->
            ( { parameters | company_name = msg_ }, Cmd.none )

        LocationTypeState msg_ ->
            ( { parameters | location_type = msg_ }, getJobs parameters )

        MainTechnologyState msg_ ->
            ( { parameters | main_technology = msg_ }, Cmd.none )

        SalaryIsUndisclosedState msg_ ->
            ( { parameters | salary_is_undisclosed = msg_ }, Cmd.none )

        SortState column direction ->
            ( { parameters | sort_column = column, sort_direction = direction }, Cmd.none )

        SearchState msg_ ->
            ( { parameters | search = msg_ }, Cmd.none )

        SalaryMinState msg_ ->
            ( { parameters | salary_min = msg_ }, Cmd.none )

        SalaryMaxState msg_ ->
            ( { parameters | salary_max = msg_ }, Cmd.none )

        ExperienceState msg_ ->
            ( { parameters | experience = msg_ }, Cmd.none )

        EmploymentTypeState msg_ ->
            ( { parameters | employment_type = msg_ }, Cmd.none )

        TypeOfWorkState msg_ ->
            ( { parameters | type_of_work = msg_ }, Cmd.none )

        LocationNameState msg_ ->
            ( { parameters | location_name = msg_ }, Cmd.none )

        ClearMoreFilterState ->
            ( { parameters
                | salary_min = ""
                , salary_max = ""
                , experience = []
                , employment_type = []
                , type_of_work = []
              }
            , Cmd.none
            )

        NextPage ->
            ( { parameters | page = parameters.page + 1 }, Cmd.none )



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
        ++ "&search="
        ++ listStringToString jobParameters.search
        ++ "&salary_min="
        ++ jobParameters.salary_min
        ++ "&salary_max="
        ++ jobParameters.salary_max
        ++ "&experience="
        ++ listExperienceMsgToString jobParameters.experience
        ++ "&employment_type="
        ++ listEmploymentTypeMsgToString jobParameters.employment_type
        ++ "&type_of_work="
        ++ listTypeOfWorkMsgToString jobParameters.type_of_work
        ++ "&location_name="
        ++ jobParameters.location_name
        ++ "&page="
        ++ fromInt jobParameters.page
        ++ "&per_page="
        ++ fromInt jobParameters.per_page



-- CMD


getJobs : Parameters -> Cmd Msg
getJobs parameters =
    let
        parametersString =
            parametersToString parameters
    in
    get
        { url = baseUrl ++ "/api/v1/jobs?" ++ parametersString
        , expect = Http.expectString GetJobRequest
        }
