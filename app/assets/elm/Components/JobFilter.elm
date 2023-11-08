module Components.JobFilter exposing (..)

import Components.JobTab as JobTab exposing (RemoteToggleMsg(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Integrations.JobApi as JobApi
import Shared.Skill exposing (listSkill)
import Shared.SortDropDown as SortDropDown



-- MODEL


type alias Model =
    { apiJobParameters : JobApi.Parameters
    , sortDropDownModel : SortDropDown.Model
    , tabJobModel : JobTab.Model
    }


type Msg
    = SortDropDownUpdateMsg SortDropDown.Msg
    | JobTabUpdateMsg JobTab.Msg
    | UpdateBoth JobTab.Msg



-- INIT


init : Model
init =
    { apiJobParameters = JobApi.initParameters, sortDropDownModel = SortDropDown.init, tabJobModel = JobTab.init }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SortDropDownUpdateMsg msg_ ->
            let
                ( newUpdateJobTabModel, _ ) =
                    SortDropDown.update msg_ model.sortDropDownModel
            in
            ( { model | sortDropDownModel = newUpdateJobTabModel }, Cmd.none )

        JobTabUpdateMsg msg_ ->
            let
                ( newUpdateJobTabModel, _ ) =
                    JobTab.update msg_ model.tabJobModel
            in
            ( { model | tabJobModel = newUpdateJobTabModel }, Cmd.none )

        UpdateBoth msg_ ->
            let
                ( newUpdateJobTabModel, _ ) =
                    JobTab.update msg_ model.tabJobModel

                --( newUpdateJobTabModel2, _ ) =
                --    SortDropDown.update msg2_ model.sortDropDownModel
            in
            ( { model | tabJobModel = newUpdateJobTabModel }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view { sortDropDownModel } =
    div [ class "bg-white p-2 md:pt-2 md:pb-4" ]
        [ div [ class "md:grid md:grid-cols-3 md:gap-x-4" ]
            [ div [ class "flex items-center overflow-x-scroll no-scrollbar p-1.5 gap-x-2 md:gap-x-4" ]
                [ div [ class "hidden relative md:block" ]
                    [ div [ class "absolute flex inset-y-0 items-center left-0 pl-3 pointer-events-none" ]
                        [ span [ class "text-gray-500 sm:text-sm" ]
                            [ i [ class "fa-solid fa-magnifying-glass" ] []
                            ]
                        ]
                    , input [ placeholder "Search", class "bg-slate-100 border-1 border-slate-200 h-10 pl-8 mt-2 rounded-3xl text-slate-500 w-full focus:outline-none placeholder:text-sm placeholder:text-slate-400" ] []
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
                , a [ class "flex h-8 items-center no-underline outline outline-slate-200 rounded-3xl md:hidden" ]
                    [ span [ class "px-4 text-sm text-slate-700 truncate" ] [ text "More filters" ]
                    ]
                , a [ class "flex h-8 items-center no-underline outline outline-slate-200 rounded-3xl md:hidden" ]
                    [ div [ class "px-4 text-sm text-slate-700 truncate" ] [ text "Sort by: Default" ]
                    , Html.map SortDropDownUpdateMsg <| SortDropDown.sortDropDownView sortDropDownModel.sortDropDown sortDropDownModel.selectedSort
                    ]
                ]
            , div [ class "hidden gap-x-4 md:col-span-2 md:flex md:justify-end" ]
                [ div [ class "flex flex-row gap-x-4 no-scrollbar overflow-x-scroll p-2" ]
                    (listSkill
                        |> List.map
                            (\skill ->
                                div [ class "flex flex-col gap-y-1" ]
                                    [ div [ class "flex h-10 items-center justify-center rounded-full w-10 hover:cursor-pointer hover:outline hover:outline-4 hover:outline-slate-300", class skill.bgColor ]
                                        [ i [ class skill.icon ] []
                                        ]
                                    , div [ class "flex justify-center" ]
                                        [ span [ class "text-xs text-slate-500" ] [ text skill.name ]
                                        ]
                                    ]
                            )
                    )

                --, div []
                --[
                --   div [ class "flex items-center h-10 w-10 justify-center hover:bg-slate-300 rounded-full hover:cursor-pointer" ]
                --   [
                --       i [ class "fa-solid fa-ellipsis text-slate-500" ] []
                --   ]
                --]
                , div [ class "flex items-center" ]
                    [ a [ class "h-8 items-center no-underline outline outline-slate-200 px-4 rounded-3xl w-40 md:flex md:gap-x-2 md:h-10" ]
                        [ span [ class "fa-solid fa-sliders text-slate-700" ] []
                        , span [ class "text-sm text-slate-700" ] [ text "More filters" ]
                        , i [ class "fa-solid fa-chevron-down text-slate-700 text-sm" ] []
                        ]
                    ]
                ]
            ]
        ]
