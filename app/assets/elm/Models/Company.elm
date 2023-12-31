module Models.Company exposing (..)

import Json.Decode as Decode exposing (Decoder, Value, int, string)
import Json.Decode.Pipeline exposing (optional, required)



-- MODEL


type alias Company =
    { id : Int
    , name : String
    , image : String
    , country : String
    , city : String
    , hq_location : String
    , created_at : String
    , updated_at : String
    }


type alias Model =
    { company : Company
    }



-- DECODER


companyDecoder : Decoder Company
companyDecoder =
    Decode.succeed Company
        |> required "id" int
        |> required "name" string
        |> required "image" string
        |> required "country" string
        |> required "city" string
        |> optional "hq_location" string ""
        |> required "created_at" string
        |> required "updated_at" string
