module Home exposing (..)

import Browser
import DataModels.Job as DataModelsJob
import Html exposing (..)
import Html.Attributes exposing (class, src, style, type_)
import Json.Decode exposing (decodeString)
import Shared.FilterJob as FilterJob
import Shared.Job as Job
import Shared.Navbar as Navbar
import Shared.OpenStreetMap as OpenStreetMap
import Shared.TabJob as TabJob


type alias Model =
    { listJob : List DataModelsJob.Job
    , navbarModel : Navbar.Model
    }


type alias Flags =
    { jobs : String
    }


type Msg
    = None
    | NavbarUpdateMsg Navbar.Msg



-- INIT


init : Flags -> ( Model, Cmd Msg )
init flags =
    case decodeString DataModelsJob.jobsDecoder flags.jobs of
        Ok records ->
            ( { listJob = records, navbarModel = Navbar.init }, Cmd.none )

        Err _ ->
            ( { listJob = [], navbarModel = Navbar.init }, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )

        NavbarUpdateMsg msg_ ->
            let
                ( newUpdateModel, _ ) =
                    Navbar.update msg_ model.navbarModel
            in
            ( { model | navbarModel = newUpdateModel }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "flex flex-col" ]
        [ div [ class "sticky top-0 z-50" ]
            [ Html.map NavbarUpdateMsg <| Navbar.view model.navbarModel
            , FilterJob.view
            ]
        , div [ class "grid grid-cols-1 lg:grid-cols-2" ]
            [ div [ class "flex flex-col gap-y-2" ]
                [ TabJob.view
                , div [ class "px-4" ]
                    [ span [ class "text-sm text-slate-500 lg:text-base" ] [ text "Work 8 674 offers" ]
                    ]
                , div [ class "flex flex-col gap-y-2 h-[calc(100vh-210px)] no-scrollbar overflow-y-scroll md:h-[calc(100vh-250px)]" ]
                    [ div [ class "block px-4 relative lg:hidden" ]
                        [ div [ class "flex items-center justify-center overflow-hidden relative" ]
                            [ img [ src "https://justjoin.it/shared-gfx/map-button/shared/map-button-light.png", class "h-16 object-cover", style "width" "100%" ] []
                            , div [ class "absolute bottom-0 flex items-center justify-center h-full left-0 right-0 top-0 w-full" ]
                                [ a [ class "bg-white flex gap-x-2 h-10 items-center justify-center no-underline rounded-xl w-40", type_ "button" ]
                                    [ i [ class "fa-regular fa-map text-slate-700" ] []
                                    , span [ class "font-semibold text-xs text-slate-700" ] [ text "Look on the map" ]
                                    ]
                                ]
                            ]
                        ]
                    , div [ class "flex flex-col gap-y-1.5 px-4 pb-4" ] <|
                        List.map (\data -> div [] [ Job.viewJobDetail data ]) model.listJob
                    ]
                ]
            , div [ class "hidden lg:block lg:h-[calc(100vh-170px)]" ]
                [ OpenStreetMap.view
                ]
            ]
        ]



-- MAIN


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
