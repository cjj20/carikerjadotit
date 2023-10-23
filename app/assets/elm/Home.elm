module Home exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, src, style, type_)
import Json.Decode as Decode exposing (Decoder, string, Value, decodeValue, list, bool)
import Json.Decode.Pipeline exposing (required)
import Shared.FilterJob as FilterJob
import Shared.Job as Job
import Shared.Navbar as Navbar
import Shared.OpenStreetMap as OpenStreetMap
import Shared.TabJob as TabJob



-- TYPES


type alias Job =
    {
        title : String
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
        , created_at : String
        , updated_at : String
    }


type alias Model =
    {
        listJob : List Job
    }


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
                ( { listJob = records }, Cmd.none )

            Err _ ->
                ( { listJob = [] }, Cmd.none )



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
       |> required "employment_type" string
       |> required "location_type" string
       |> required "is_new" bool
       |> required "experience_level" string
       |> required "type_of_work" string
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
    div [ class "flex flex-col" ]
        [
            div [ class "sticky top-0 z-50" ]
            [
                Navbar.view
                , FilterJob.view
            ]
            , div [ class "grid grid-cols-1 lg:grid-cols-2" ]
            [
                div [ class "flex flex-col gap-y-2" ]
                [
                    TabJob.view
                    , div [ class "px-4" ]
                    [
                        span [ class "text-sm text-slate-500 lg:text-base" ] [ text "Work 8 674 offers" ]
                    ]
                    , div [ class "h-[calc(100vh-210px)] no-scrollbar overflow-y-scroll md:h-[calc(100vh-250px)]" ]
                    [
                        div [ class "block px-4 relative lg:hidden" ]
                        [
                            div [ class "flex items-center justify-center overflow-hidden relative"]
                            [
                                img [ src "https://justjoin.it/shared-gfx/map-button/shared/map-button-light.png", class "h-16 object-cover", style "width" "100%" ] []
                                , div [ class "absolute bottom-0 flex items-center justify-center h-full left-0 right-0 top-0 w-full" ]
                                [
                                    a [ class "bg-white flex gap-x-2 h-10 items-center justify-center no-underline rounded-xl w-40", type_ "button" ]
                                    [
                                      i [ class "fa-regular fa-map text-slate-700" ] []
                                      , span [ class "font-semibold text-xs text-slate-700" ] [ text "Look on the map" ]
                                    ]
                                ]
                            ]
                        ]
                        , div [ class "flex flex-col gap-y-1.5 px-4 pb-4" ]
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
                , div [ class "hidden lg:block lg:h-[calc(100vh-170px)]" ]
                [
                    OpenStreetMap.view
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
