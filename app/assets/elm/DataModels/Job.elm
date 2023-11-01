module DataModels.Job exposing (..)

import DataModels.Company as DataModelsCompany
import Json.Decode as Decode exposing (Decoder, Value, bool, int, list, string)
import Json.Decode.Pipeline exposing (required)


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
    , skills : List String
    , company_id : Int
    , created_at : String
    , updated_at : String
    , company : DataModelsCompany.Company
    }


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
        |> required "skills" (list string)
        |> required "company_id" int
        |> required "created_at" string
        |> required "updated_at" string
        |> required "company" DataModelsCompany.companyDecoder


jobsDecoder : Decoder (List Job)
jobsDecoder =
    list jobDecoder
