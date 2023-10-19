module Detail exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, src)
import Json.Decode as Decode exposing (Decoder, Error, Value, bool, decodeValue, int, string)
import Json.Decode.Pipeline exposing (required)
import Navbar
import OpenStreetMap
import SimilarOffers
import Footer



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
        job : Maybe Job
        , errorMessage : Maybe Error
    }

type alias Flags =
    {
        job : Value
    }


type Msg =
    FlagsError Error
    | FlagsSuccess Job



-- INIT


init : Flags -> ( Model, Cmd Msg )
init { job } =
    case decodeValue jobDecoder job of
            Ok records ->
                ( { job = Just records, errorMessage = Nothing }, Cmd.none )

            Err err ->
                ( { job = Nothing, errorMessage = Just err }, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FlagsError err ->
            ( { model | errorMessage = Just err }, Cmd.none)

        FlagsSuccess records ->
            ( { model | job = Just records, errorMessage = Nothing }, Cmd.none)



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



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "" ]
        [
            div [ class "sticky top-0 z-50" ]
            [
                Navbar.view
                , div [ class "bg-white hidden p-6 md:block" ]
                [
                    div [ class "flex items-center space-x-4 text-sm text-slate-500" ]
                    [
                        i [ class "fa-solid fa-arrow-left font-bold text-lg text-slate-700" ] []
                        , span [] [ text "All offers" ]
                        , i [ class "fa-solid fa-chevron-right text-xs text-slate-600" ] []
                        , span [] [ text "Jakarta" ]
                        , i [ class "fa-solid fa-chevron-right text-xs text-slate-600" ] []
                        , span [] [ text "Python" ]
                        , i [ class "fa-solid fa-chevron-right text-xs text-slate-600" ] []
                        , span [] [ text "Senior Fullstack Developer" ]
                    ]
                ]
            ]
            , div [ class "grid grid-cols-1 lg:grid-cols-2" ]
            [
                div [ class "mb-3 space-y-6 md:px-4" ]
                [
                    div [ class "flex flex-col" ]
                    [
                        div [ class "bg-blue-500 flex flex-col p-4 space-y-4 md:px-6 md:rounded-t-lg" ]
                        [
                            div [ class "flex justify-between md:hidden" ]
                            [
                                div [ class "flex items-center" ]
                                [
                                    i [ class "fa-solid fa-arrow-left bg-slate-900 bg-opacity-50 p-2 rounded-full text-white"] []
                                ]
                                , div [ class "flex items-center space-x-3" ]
                                [
                                    a [ class "no-underline outline outline-white px-1.5 py-1 rounded-2xl text-sm text-white" ] [ text "New" ]
                                    , a [ class "bg-white no-underline outline outline-white px-2 text-xl rounded-2xl text-blue-500" ]
                                    [
                                        i [ class "fa-brands fa-python" ] []
                                    ]
                                    , a [ class "bg-white items-center no-underline outline outline-white px-2 rounded-2xl text-xl text-blue-500" ]
                                    [
                                        i [ class "fa-solid fa-share-nodes" ] []
                                    ]
                                ]
                            ]
                            , div [ class "flex space-x-4 md:space-x-6 lg:space-x-3 xl:space-x-6" ]
                            [
                                div [ class "bg-white flex items-center justify-center h-16 w-16 p-3 rounded-full md:h-40 md:w-40 md:p-4 lg:h-20 lg:w-20 xl:h-40 xl:w-40" ]
                                [
                                    img [ class "w-16 md:w-24 lg:w-20 xl:w-24", src "https://public.justjoin.it/offers/company_logos/original_x2/911af49d7d2d530ed4becaae96000cab827e6806.png?1697469588" ] []
                                ]
                                , div [ class "flex flex-col space-y-1 md:space-y-3" ]
                                [
                                    div [ class "min-w-sm" ]
                                    [
                                        span [ class "font-medium text-slate-200 md:text-2xl" ] [ text "Senior Fullstack Developer" ]
                                    ]
                                    , div [ class "flex flex-wrap gap-x-4 min-w-sm text-sm text-slate-200 md:text-lg" ]
                                    [
                                        div [ class "flex items-center space-x-2" ]
                                        [
                                            i [ class "fa-solid fa-building" ] []
                                            , span [] [ text "Infermedica" ]
                                        ]
                                        , div [ class "flex items-center space-x-2" ]
                                        [
                                            i [ class "fa-solid fa-location-dot" ] []
                                            , span [] [ text "Wroclaw," ]
                                            , span [] [ text "2+" ]
                                            , i [ class "fa-solid fa-chevron-down" ] []
                                        ]
                                    ]
                                    , div [ class "hidden space-y-2 md:flex md:flex-col" ]
                                    [
                                        div [ class "bg-black bg-opacity-40 flex items-center justify-center py-2 rounded-xl space-x-4 w-56" ]
                                        [
                                            i [ class "fa-solid fa-wallet text-2xl" ] []
                                            , div [ class "flex flex-col" ]
                                            [
                                                span [] [ text "5 050 - 6 200 USD" ]
                                                , span [ class "text-sm" ] [ text "Net/month - B2B" ]
                                            ]
                                        ]
                                        , div [ class "bg-black bg-opacity-40 flex items-center justify-center px-4 py-2 rounded-2xl w-40" ]
                                        [
                                            span [ class "text-sm" ] [ text "Show base currency" ]
                                        ]
                                    ]
                                ]
                                , div [ class "hidden md:flex md:flex-auto md:gap-x-3 md:items-start md:justify-end lg:flex-col lg:gap-y-2 lg:items-end lg:justify-start xl:flex-row xl:items-start xl:justify-end" ]
                                [
                                    a [ class "no-underline outline outline-white px-1.5 py-1 rounded-2xl text-sm text-white" ] [ text "New" ]
                                    , a [ class "bg-white no-underline outline outline-white px-2 rounded-2xl text-xl text-blue-500" ]
                                    [
                                        div [ class "flex items-center space-x-2 py-1" ]
                                        [
                                            i [ class "fa-brands fa-python" ] []
                                            , span [ class "text-sm" ] [ text "Python" ]
                                        ]
                                    ]
                                    , a [ class "bg-white flex items-center no-underline outline outline-white px-2 py-1 rounded-2xl text-xl text-blue-500" ]
                                    [
                                        i [ class "fa-solid fa-share-nodes" ] []
                                    ]
                                ]
                            ]
                            , div [ class "block md:hidden" ]
                            [
                                div [ class "bg-black bg-opacity-40 flex items-center justify-center py-2 rounded-xl space-x-4" ]
                                [
                                    i [ class "fa-solid fa-wallet text-2xl" ] []
                                    , div [ class "flex flex-col" ]
                                    [
                                        span [] [ text "5 050 - 6 200 USD" ]
                                        , span [ class "text-sm" ] [ text "Net/month - B2B" ]
                                    ]
                                ]
                            ]
                            , div [ class "flex justify-end md:hidden" ]
                            [
                                div [ class "bg-black bg-opacity-30 flex items-center px-4 py-2 rounded-2xl" ]
                                [
                                    span [ class "text-sm" ] [ text "Show base currency" ]
                                ]
                            ]
                        ]
                        , div [ class "bg-white p-4 md:p-8 md:rounded-b-lg" ]
                        [
                            div [ class "grid grid-cols-2 gap-y-8 items-center lg:grid-cols-4" ]
                            [
                                div [ class "flex flex-col items-center space-y-1.5" ]
                                [
                                    div [ class "bg-yellow-100 rounded-2xl" ]
                                    [
                                        i [ class "fa-solid fa-business-time p-2.5 text-yellow-500" ] []
                                    ]
                                    , span [ class "text-sm text-slate-400" ] [ text "Type of work" ]
                                    , span [ class "text-sm text-slate-600" ] [ text "Full-time" ]
                                ]
                                , div [ class "flex flex-col items-center space-y-1.5" ]
                                [
                                    div [ class "bg-purple-100 rounded-2xl" ]
                                    [
                                        i [ class "fa-regular fa-star p-2.5 text-purple-500" ] []
                                    ]
                                    , span [ class "text-sm text-slate-400" ] [ text "Experience" ]
                                    , span [ class "text-sm text-slate-600" ] [ text "Senior" ]
                                ]
                                , div [ class "flex flex-col items-center space-y-1.5" ]
                                [
                                    div [ class "bg-green-100 rounded-2xl" ]
                                    [
                                       i [ class "fa-solid fa-file-circle-check p-2.5 text-green-500" ] []
                                    ]
                                    , span [ class "text-sm text-slate-400" ] [ text "Employement Type" ]
                                    , span [ class "text-sm text-slate-600" ] [ text "B2B" ]
                                ]
                                , div [ class "flex flex-col items-center space-y-1.5" ]
                                [
                                    div [ class "bg-blue-100 rounded-2xl" ]
                                    [
                                        i [ class "fa-solid fa-map-pin p-2.5 text-blue-500" ] []
                                    ]
                                    , span [ class "text-sm text-slate-400" ] [ text "Operating Mode" ]
                                    , span [ class "text-sm text-slate-600" ] [ text "Remote" ]
                                ]
                            ]
                        ]
                    ]
                    , div [ class "md:hidden" ]
                    [
                        div [ class "h-48" ]
                        [
                            OpenStreetMap.view
                        ]
                    ]
                    , div [ class "bg-white flex flex-col gap-y-4 px-4 py-6 md:flex-row md:rounded-lg md:space-x-8" ]
                    [
                        img [ class "h-36 object-cover rounded-xl lg:h-44",  src "https://public.justjoin.it/brand-story-v1/cover_photo/original/e34c4e43d2afccae7d5a25af2c5939b42fd3204b.jpg" ] []
                        , div [ class "flex flex-col gap-y-4" ]
                        [
                            div [ class "space-y-4" ]
                            [
                                span [ class "text-2xl text-slate-700" ] [ text "Intermedica" ]
                                , p [ class "text-sm text-slate-500" ] [ text "From Symptom Checker to API – on a mission to make healthcare accessible, affordable, and convenient by automating primary care, from symptom to outcome." ]
                            ]
                            , div [ class "bg-slate-200 flex items-center justify-center outline outline-slate-300 rounded-xl w-28" ]
                            [
                                span [ class "p-1.5 text-sm text-slate-600" ] [ text "Brand Story" ]
                            ]
                        ]
                    ]
                    , div [ class "bg-white px-4 py-6 space-y-8 md:rounded-lg" ]
                    [
                        span [ class "font-medium text-2xl text-slate-700" ] [ text "Tech Stack" ]
                        , div [ class "grid gap-y-8 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-2 xl:grid-cols-4" ]
                        [
                            div [ class "flex flex-col space-y-1" ]
                            [
                                span [ class "text-md text-slate-700" ] [ text "Python" ]
                                , div [ class "flex space-x-1.5 text-xs" ]
                                [
                                    i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle" ] []
                                ]
                                , span [ class " text-xs text-slate-500" ] [ text "Advanced" ]
                            ]
                            , div [ class "flex flex-col space-y-1" ]
                            [
                                span [ class "text-md text-slate-700" ] [ text "Javascript" ]
                                , div [ class "flex space-x-1.5 text-xs" ]
                                [
                                    i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle" ] []
                                ]
                                , span [ class " text-xs text-slate-500" ] [ text "Advanced" ]
                            ]
                            , div [ class "flex flex-col space-y-1" ]
                            [
                                span [ class "text-md text-slate-700" ] [ text "Django" ]
                                , div [ class "flex space-x-1.5 text-xs" ]
                                [
                                    i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle text-pink-500" ] []
                                    , i [ class "fa-solid fa-circle" ] []
                                ]
                                , span [ class " text-xs text-slate-500" ] [ text "Advanced" ]
                            ]
                        ]
                    ]
                    , div [ class "bg-white px-4 py-6 space-y-4 md:rounded-lg" ]
                    [
                        div [ class "flex flex-col gap-y-4" ]
                        [
                            span [ class "font-medium text-2xl text-slate-700" ] [ text "Job Description" ]
                            , p [ class "text-sm text-slate-500" ] [ text "You'll join our Metabase Team, a cross-functional team that manages and develops the Metabase application and its ecosystem. The main mission for the team is to deliver a well-curated data source that drives and supports the expansion of our AI Engine while providing a good user experience for doctors and content creators. If you are proficient in Python and JavaScript, don't hesitate to apply." ]
                        ]
                        , div [ class "flex flex-col" ]
                        [
                            span [ class "font-semibold text-sm text-slate-700" ] [ text "Role requirements Experience" ]
                            , ul [ class "text-sm text-slate-700" ]
                            [
                                li [] [ text "4+ years of experience in software development in Python (Django/Django Rest Framework/FastAPI/Flask)" ]
                                , li [] [ text "2+ years of experience in software development in JavaScript ES6+, HTML5, CSS, TypeScript, Vue.js 3, Vite" ]
                                , li [] [ text "1+ year of experience in DevOps (AWS/GCP), Docker, K8s and Terraform" ]
                            ]
                        ]
                        , div [ class "flex flex-col" ]
                        [
                            span [ class "font-semibold text-sm text-slate-700" ] [ text "Knowledge / Skills" ]
                            , ul [ class "text-sm text-slate-700" ]
                            [
                                li [] [ text "Knowledge of Pytest" ]
                                , li [] [ text "Knowledge of ORM (SQLalchemy/Django ORM)" ]
                                , li [] [ text "Basic knowledge of building CI/CD pipelines in GitLab" ]
                            ]
                        ]
                    ]
                    , div [ class "bg-white px-4 py-6 space-y-4 md:rounded-lg lg:hidden" ]
                    [
                        SimilarOffers.main
                    ]
                    , div [ class "flex items-center justify-center" ]
                    [
                        div [ class "bg-pink-500 py-2 w-64 flex items-center justify-center rounded-2xl text-white" ] [ text "Apply" ]
                    ]
                ]
                , div [ class "hidden lg:flex lg:flex-col lg:gap-y-6" ]
                [
                    div [ class "h-20 w-50 lg:h-[calc(100vh-135px)]" ]
                    [
                        OpenStreetMap.view
                    ]
                    , div [ class "block px-4 sticky top-3" ]
                    [
                        SimilarOffers.main
                    ]
                ]
            ]
            , div [ class "pt-4" ]
            [
                Footer.main
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
