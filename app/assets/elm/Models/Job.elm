module Models.Job exposing (..)

import Array exposing (fromList, slice, toList)
import Json.Decode as Decode exposing (Decoder, Value, bool, decodeString, field, int, list, map2, string)
import Json.Decode.Pipeline exposing (optional, required)
import List exposing (length)
import Models.Company exposing (Company, companyDecoder)



-- Helpers


maxSkills : Job -> List String
maxSkills job =
    case length job.tag_names > 2 of
        True ->
            toList (slice 0 3 (fromList job.tag_names))

        False ->
            job.tag_names


salaryUndisclosed : Job -> String
salaryUndisclosed job =
    case job.salary_is_undisclosed of
        True ->
            "Undisclosed Salary"

        False ->
            job.salary_min ++ " - " ++ job.salary_max ++ " IDR"



-- MODEL


type alias Job =
    { id : Int
    , title : String
    , salary_min : String
    , salary_max : String
    , salary_is_undisclosed : Bool
    , employment_type : String
    , location_type : String
    , is_new : Bool
    , experience_level : String
    , type_of_work : String
    , job_description : String
    , apply_link : String
    , main_technology : String
    , online_interview : Bool
    , tag_names : List String
    , company_id : Int
    , created_at : String
    , updated_at : String
    , company : Company
    }


type alias Meta =
    { limit_value : Int
    , total_pages : Int
    , total_undisclosed_salary_jobs : Int
    , total_all_jobs : Int
    }


type alias ListJob =
    List Job


type alias ApiResponse =
    { meta : Meta
    , data : ListJob
    }



-- DECODER


jobDecoder : Decoder Job
jobDecoder =
    Decode.succeed Job
        |> required "id" int
        |> required "title" string
        |> required "salary_min" string
        |> required "salary_max" string
        |> required "salary_is_undisclosed" bool
        |> required "employment_type" string
        |> required "location_type" string
        |> required "is_new" bool
        |> required "experience_level" string
        |> required "type_of_work" string
        |> required "job_description" string
        |> required "apply_link" string
        |> required "main_technology" string
        |> required "online_interview" bool
        |> required "tag_names" (list string)
        |> required "company_id" int
        |> required "created_at" string
        |> required "updated_at" string
        |> required "company" companyDecoder


jobsDecoder : Decoder (List Job)
jobsDecoder =
    list jobDecoder


metaDecoder : Decoder Meta
metaDecoder =
    Decode.succeed Meta
        |> optional "limit_value" int 0
        |> optional "total_pages" int 0
        |> optional "total_undisclosed_salary_jobs" int 0
        |> optional "total_all_jobs" int 0


apiDecoder : Decoder ApiResponse
apiDecoder =
    map2 ApiResponse
        (field "meta" metaDecoder)
        (field "data" jobsDecoder)



-- EXPRESSION


jobsDecodeString : String -> ApiResponse
jobsDecodeString data =
    case decodeString apiDecoder data of
        Ok records ->
            records

        Err _ ->
            { meta =
                { limit_value = 0
                , total_pages = 0
                , total_undisclosed_salary_jobs = 0
                , total_all_jobs = 0
                }
            , data = []
            }
