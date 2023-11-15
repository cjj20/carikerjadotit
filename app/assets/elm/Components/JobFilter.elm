module Components.JobFilter exposing (..)

import Components.JobMoreFilter as JobMoreFilter
import Components.JobSortDropDown as JobSortDropDown exposing (DropDownStateMsg(..))
import Components.MainTechnology exposing (MainTechnology, emptyMainTechnology, listMainTechnology)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    { jobSortDropDownModel : JobSortDropDown.Model
    , jobMoreFilterModel : JobMoreFilter.Model
    , selectedMainTechnology : MainTechnology
    }



-- MSG


type Msg
    = JobSortDropDownUpdateMsg JobSortDropDown.Msg
    | JobMoreFilterUpdateMsg JobMoreFilter.Msg
    | SelectMainTechnologyState MainTechnology



-- INIT


init : Model
init =
    { jobSortDropDownModel = JobSortDropDown.init
    , jobMoreFilterModel = JobMoreFilter.init
    , selectedMainTechnology = emptyMainTechnology
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JobSortDropDownUpdateMsg msg_ ->
            let
                ( newJobSortDropDownUpdate, _ ) =
                    JobSortDropDown.update msg_ model.jobSortDropDownModel
            in
            ( { model | jobSortDropDownModel = newJobSortDropDownUpdate }, Cmd.none )

        JobMoreFilterUpdateMsg msg_ ->
            let
                ( newJobMoreFilterUpdate, _ ) =
                    JobMoreFilter.update msg_ model.jobMoreFilterModel
            in
            ( { model | jobMoreFilterModel = newJobMoreFilterUpdate }, Cmd.none )

        SelectMainTechnologyState msg_ ->
            let
                newSelectedMainTechnology =
                    if model.selectedMainTechnology == msg_ then
                        { model | selectedMainTechnology = emptyMainTechnology }

                    else
                        { model | selectedMainTechnology = msg_ }
            in
            ( newSelectedMainTechnology, Cmd.none )



-- VIEW


view : Model -> Html Msg
view { jobSortDropDownModel, jobMoreFilterModel, selectedMainTechnology } =
    let
        listMainTechnologyView =
            listMainTechnology
                |> List.map
                    (\mainTechnology ->
                        div
                            [ class "flex flex-col gap-y-1"
                            , onClick (SelectMainTechnologyState mainTechnology)
                            ]
                            [ div
                                [ class "flex h-10 items-center justify-center rounded-full w-10 hover:cursor-pointer hover:outline hover:outline-4 hover:outline-slate-300"
                                , if
                                    selectedMainTechnology
                                        == emptyMainTechnology
                                        || selectedMainTechnology
                                        == mainTechnology
                                  then
                                    class mainTechnology.bgColor

                                  else
                                    class "bg-slate-500"
                                ]
                                [ i [ class mainTechnology.icon ] []
                                ]
                            , div [ class "flex justify-center" ]
                                [ span [ class "text-xs text-slate-500" ] [ text mainTechnology.name ]
                                ]
                            ]
                    )
    in
    div [ class "bg-white p-2 md:pt-2 md:pb-4" ]
        [ div []
            [ div [ class "md:grid md:grid-cols-3 md:gap-x-4" ]
                [ div [ class "flex items-center overflow-x-scroll no-scrollbar p-1.5 gap-x-2 md:gap-x-4" ]
                    [ div [ class "hidden relative md:block" ]
                        [ div [ class "absolute flex inset-y-0 items-center left-0 pl-3 pointer-events-none" ]
                            [ span [ class "text-gray-500 sm:text-sm" ]
                                [ i [ class "fa-solid fa-magnifying-glass" ] []
                                ]
                            ]
                        , input
                            [ placeholder "Search"
                            , class "bg-slate-100 border-1 border-slate-200 h-10 pl-8 mt-2 rounded-3xl text-slate-500 w-full focus:outline-none placeholder:text-sm placeholder:text-slate-400"
                            ]
                            []
                        ]
                    , a [ class "bg-slate-100 flex items-center justify-center no-underline outline outline-slate-200 p-2 rounded-full hover:cursor-pointer md:hidden" ]
                        [ span [ class "fa-solid fa-magnifying-glass text-slate-500" ] []
                        ]
                    , a [ class "h-8 items-center no-underline outline outline-slate-200 px-4 rounded-3xl md:h-10 md:flex md:gap-x-2" ]
                        [ div [ class "hidden items-center md:block" ]
                            [ span [ class "fa-solid fa-location-dot text-slate-700" ] []
                            ]
                        , span [ class "text-sm text-slate-700" ] [ text "Location" ]
                        , div [ class "hidden items-center md:flex" ]
                            [ i [ class "fa-solid fa-chevron-down text-sm text-slate-700" ] []
                            ]
                        ]
                    , a [ class "flex h-8 items-center no-underline outline outline-slate-200 rounded-3xl md:hidden" ]
                        [ span [ class "px-4 text-sm text-slate-700 truncate" ] [ text "Tech" ]
                        ]
                    , a
                        [ class "flex h-8 items-center no-underline outline outline-slate-200 rounded-3xl md:hidden"
                        , onClick (JobMoreFilterUpdateMsg JobMoreFilter.ModalState)
                        ]
                        [ span [ class "px-4 text-sm text-slate-700 truncate" ] [ text "More filters" ]
                        ]
                    , div []
                        [ a
                            [ class "flex h-8 items-center no-underline outline outline-slate-200 rounded-3xl md:hidden"
                            , onClick (JobSortDropDownUpdateMsg JobSortDropDown.DropDownState)
                            ]
                            [ div [ class "px-4 text-sm text-slate-700 truncate" ] [ text "Sort by: Default" ]
                            ]
                        , Html.map JobSortDropDownUpdateMsg <| JobSortDropDown.dropDownView jobSortDropDownModel
                        ]
                    ]
                , div [ class "hidden gap-x-4 md:col-span-2 md:flex md:justify-end" ]
                    [ div [ class "flex flex-row gap-x-4 no-scrollbar overflow-x-scroll p-2" ]
                        listMainTechnologyView
                    , div [ class "flex items-center" ]
                        [ a
                            [ class "cursor-pointer h-8 items-center no-underline outline outline-slate-200 px-4 rounded-3xl w-40 md:flex md:gap-x-2 md:h-10"
                            , onClick (JobMoreFilterUpdateMsg JobMoreFilter.ModalState)
                            ]
                            [ span [ class "fa-solid fa-sliders text-slate-700" ] []
                            , span [ class "text-sm text-slate-700" ] [ text "More filters" ]
                            , i [ class "fa-solid fa-chevron-down text-slate-700 text-sm" ] []
                            ]
                        ]
                    ]
                ]
            , Html.map JobMoreFilterUpdateMsg <| JobMoreFilter.view jobMoreFilterModel
            ]
        ]
