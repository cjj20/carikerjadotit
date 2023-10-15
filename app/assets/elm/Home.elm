module Home exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, src, width, height, style, type_)
import Html.Events exposing (keyCode, on, onClick, onInput)
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
    {
        listJob : List Job
        , remoteToggle : Bool
    }

type alias Flags =
    {
        jobs : Value
    }


type Msg
    = RemoteToggle


-- INIT


init : Flags -> ( Model, Cmd Msg )
init { jobs } =
    case decodeValue jobsDecoder jobs of
            Ok records ->
                ( { listJob = records, remoteToggle = False }, Cmd.none )

            Err _ ->
                ( { listJob = [], remoteToggle = False }, Cmd.none )






-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RemoteToggle ->
            ( { model | remoteToggle = not model.remoteToggle }, Cmd.none )



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
    div [ class "" ]
        [
            div [ class "sticky top-0 z-50" ]
            [
                Navbar.view
                , FilterJob.view
            ]
            , div [ class "" ]
            [
                div [ class "grid grid-cols-1 lg:grid-cols-2" ]
                [
                    div [ class "" ]
                    [
                        div [ class "pb-2.5 bg-gray-100 sticky z-50" ]
                        [
                            div [ class "flex justify-between bg-white px-4" ]
                            [
                                div [ class "flex bg-white " ]
                                [
                                    div [ class "px-4 md:px-6 bg-gray-100 rounded-t-xl md:rounded-t-3xl md:py-1.5" ]
                                    [
                                        span [ class "text-sm text-slate-500 truncate" ] [ text "With salary" ]
                                    ]
                                    , div [ class "px-4 md:px-6 md:py-1.5" ]
                                    [
                                        span [ class "text-sm text-slate-500 truncate" ] [ text "All offers", span [ class "text-pink-500 pl-2" ] [ text "13 433 offers" ] ]
                                    ]
                                ]
                                , div [ class "flex justify-center items-center space-x-6" ]
                                [
                                    div [ class "flex items-center space-x-2", onClick RemoteToggle ]
                                    [
                                        span [ class "text-sm text-slate-500" ] [ text "Remote" ]
                                        , i [ if model.remoteToggle then class "hidden fa-solid fa-toggle-on text-slate-400 text-xl lg:block" else class "hidden fa-solid fa-toggle-off text-slate-400 text-xl lg:block" ] []
                                    ]
                                    , div [ class "hidden items-center space-x-2 lg:flex" ]
                                    [
                                        span [ class "text-sm text-slate-500" ] [ text "Default" ]
                                        , i [ class "hidden fa-solid fa-chevron-down text-slate-500 text-sm lg:block" ] []
                                    ]
                                ]
                            ]
                        ]
                        , div [ class "" ]
                        [
                            div [ class "px-4" ]
                            [
                                span [ class "text-sm text-slate-500 lg:text-base" ] [ text "Work 8 674 offers" ]
                            ]
                            , div [ class "overflow-y-scroll no-scrollbar h-[calc(100vh-190px)] md:h-[calc(100vh-225px)]" ]
                            [
                                div [ class "block px-4 py-2 relative lg:hidden" ]
                                [
                                    div [ class "relative overflow-hidden flex items-center justify-center"]
                                    [
                                        img [ src "https://justjoin.it/shared-gfx/map-button/shared/map-button-light.png", class "object-cover h-16", style "width" "100%" ] []
                                        , div [ class "absolute w-full h-full top-0 bottom-0 left-0 right-0 flex items-center justify-center" ]
                                        [
                                            a [ class "no-underline bg-white rounded-xl flex justify-center items-center space-x-2 h-10 w-40", type_ "button" ]
                                            [
                                              i [ class "fa-regular fa-map text-slate-700" ] []
                                              , span [ class "text-xs text-slate-700 font-semibold" ] [ text "Look on the map" ]
                                            ]
                                        ]
                                    ]
                                ]
                                , div [ class "space-y-1.5 px-4 py-2" ]
                                [
                                    div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                    , div [] [ Job.view ]
                                ]
                            ]
                        ]
                    ]
                    , div [ class "hidden lg:block" ]
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
