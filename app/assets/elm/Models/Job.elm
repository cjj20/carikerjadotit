module Models.Job exposing (..)

import Json.Decode as Decode exposing (Decoder, Value, bool, decodeString, field, int, list, map2, string)
import Json.Decode.Pipeline exposing (optional, required)
import Models.Company exposing (Company, companyDecoder)



-- MODEL


type alias Job =
    { id : Int
    , title : String
    , salary_min : String
    , salary_max : String
    , salary_is_undisclosed : Bool
    , is_new : Bool
    , employment_type : String
    , location_type : String
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
    , total_jobs : Int
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
        |> required "is_new" bool
        |> optional "employment_type" string ""
        |> required "location_type" string
        |> required "experience_level" string
        |> optional "type_of_work" string ""
        |> required "job_description" string
        |> optional "apply_link" string ""
        |> optional "main_technology" string ""
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
        |> optional "total_jobs" int 0


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
                , total_jobs = 0
                }
            , data = []
            }
