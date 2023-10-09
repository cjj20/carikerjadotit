module Home exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class)
import Json.Decode as Decode exposing (Decoder, int, string, Value, decodeValue, list, bool)
import Json.Decode.Pipeline exposing (required)
import Navbar
import FilterJob
import Job
import OpenStreetMap


-- TYPES


type alias Job =
    {
        title : String
        , salary_min : String
        , salary_max : String
        , salary_is_undisclosed : Bool
        , employment_type : Int
        , location_type : Int
        , is_new : Bool
        , experience_level : Int
        , type_of_work : Int
        , job_description : String
        , apply_link : String
        , created_at : String
        , updated_at : String
    }


type alias Model =
    List Job


type alias Flags =
    {
        jobs : Value
    }


type Msg
    = None


-- INIT


init : Flags -> ( Model, Cmd Msg )
init { jobs } =
    case decodeValue jobsDecoder jobs of
        Ok records ->
            ( records, Cmd.none )

        Err _ ->
            ( [], Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )



-- DECODER


jobDecoder : Decoder Job
jobDecoder =
   Decode.succeed Job
       |> required "title" string
       |> required "salary_min" string
       |> required "salary_max" string
       |> required "salary_is_undisclosed" bool
       |> required "employment_type" int
       |> required "location_type" int
       |> required "is_new" bool
       |> required "experience_level" int
       |> required "type_of_work" int
       |> required "job_description" string
       |> required "apply_link" string
       |> required "created_at" string
       |> required "updated_at" string


jobsDecoder : Decoder (List Job)
jobsDecoder =
    list jobDecoder



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "relative" ]
        [
            Navbar.view
            , FilterJob.view
            , div [ class "relative" ]
            [
                div [ class "grid grid-cols-1 lg:grid-cols-2" ]
                [
                    div [ class "order-last lg:order-first" ]
                    [
                        div [ class "flex justify-between bg-white px-4" ]
                        [
                            div [ class "flex space-x-8" ]
                            [
                                div []
                                [
                                    div []
                                    [
                                        span [ class "text-sm text-slate-500" ] [ text "With salary" ]
                                    ]
                                ]
                                , div []
                                [
                                    div []
                                    [
                                        span [ class "text-sm text-slate-500" ] [ text "All offers", span [ class "text-pink-500 pl-2" ] [ text "13 433 offers" ] ]
                                    ]
                                ]
                            ]
                            , div []
                            [
                                div []
                                [
                                    span [ class "text-sm text-slate-500" ] [ text "Remote" ]
                                ]
                            ]
                        ]
                        , div [ class "py-2 px-4" ]
                        [
                            span [ class "text-slate-500" ] [ text "Work 8 674 offers" ]
                        ]
                        , div [ class "px-4 " ]
                        [
                            div [ class "w-full space-y-2" ]
                            [
                                div [] [ Job.view ]
                                , div [] [ Job.view ]
                                , div [] [ Job.view ]
                                , div [] [ Job.view ]
                            ]
                        ]
                    ]
                    , div [ class "" ]
                    [
                        OpenStreetMap.view
                    ]
                    --, ul [] <| List.map (\job -> li [] [ text job.title ]) model
                ]
            ]
        ]



-- MAIN


main : Program Flags Model Msg
main =
  Browser.element
    {
        init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
    }
