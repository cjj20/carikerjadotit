module Components.JobTab exposing (..)

import Components.Icons exposing (chevronDownBlueIcon, chevronDownGrayIcon, toggleOffIcon, toggleOnIcon)
import Components.JobSort as JobSort exposing (..)
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Attribute, Html, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    { active : TabMsg
    , remoteToggle : RemoteToggleMsg
    , jobSortModel : JobSort.Model
    }



-- MSG


type Msg
    = Active TabMsg
    | RemoteToggle
    | JobSortUpdateMsg JobSort.Msg


type TabMsg
    = WithSalary
    | AllOffers


type RemoteToggleMsg
    = On
    | Off



-- INIT


init : Model
init =
    { active = WithSalary
    , remoteToggle = Off
    , jobSortModel = JobSort.init
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Active msg_ ->
            ( { model | active = msg_ }, Cmd.none )

        RemoteToggle ->
            let
                newModel =
                    if model.remoteToggle == On then
                        { model | remoteToggle = Off }

                    else
                        { model | remoteToggle = On }
            in
            ( newModel, Cmd.none )

        JobSortUpdateMsg msg_ ->
            let
                ( newJobSortUpdate, _ ) =
                    JobSort.update msg_ model.jobSortModel
            in
            ( { model | jobSortModel = newJobSortUpdate }, Cmd.none )



-- HELPER


tabActiveClass : Model -> TabMsg -> Attribute Msg
tabActiveClass { active } tab =
    if active == tab then
        class "bg-white-30 font-semibold rounded-t-xl md:rounded-t-xl"

    else
        class "bg-white hover:bg-gray-200 hover:rounded-t-xl hover:md:rounded-t-xl"



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "relative z-10" ]
        [ div [ class "bg-white h-12 pt-2 px-4 lg:px-[140px] overflow-x-auto" ]
            [ div [ class "flex gap-x-2.5 justify-between" ]
                [ div [ class "flex" ]
                    [ div
                        [ class "cursor-pointer flex items-center justify-center py-2.5 w-[120px] lg:w-[157px]"
                        , tabActiveClass model WithSalary
                        , onClick (Active WithSalary)
                        ]
                        [ span [ class "text-sm text-black-90 truncate" ] [ text "With salary" ] ]
                    , div
                        [ class "cursor-pointer flex items-center justify-center py-2.5 w-[120px] lg:w-[157px]"
                        , tabActiveClass model AllOffers
                        , onClick (Active AllOffers)
                        ]
                        [ span [ class "text-sm text-black-90 truncate" ] [ text "All offers" ] ]
                    ]
                , div [ class "flex gap-x-4 items-center justify-end pt-2.5 lg:pt-1.5" ]
                    [ div [] [ remoteButton model ]
                    , div [ class "hidden md:block" ]
                        [ div [] [ jobSortButton model ]
                        , div [ class "flex justify-end" ]
                            [ Html.map JobSortUpdateMsg <| JobSort.dropDownView model.jobSortModel ]
                        ]
                    ]
                ]
            ]
        ]


remoteButton : Model -> Html Msg
remoteButton { remoteToggle } =
    let
        remoteToggleIcon =
            if remoteToggle == On then
                toggleOnIcon

            else
                toggleOffIcon
    in
    div [ class "cursor-pointer flex gap-x-2 items-center", onClick RemoteToggle ]
        [ span [ class "text-sm text-black-90" ] [ text "Remote" ]
        , span [] [ remoteToggleIcon ]
        ]


jobSortButton : Model -> Html Msg
jobSortButton { jobSortModel } =
    let
        labelClass =
            if jobSortModel /= JobSort.init then
                class "text-primary-1 font-semibold"

            else
                class "text-black-90"

        chevronDownIcon =
            if jobSortModel /= JobSort.init then
                chevronDownBlueIcon

            else
                chevronDownGrayIcon
    in
    div
        [ class "cursor-pointer flex gap-x-3 items-center px-3 py-1 rounded-xl hover:bg-white-30"
        , onClick (JobSortUpdateMsg (JobSort.ButtonState Open))
        ]
        [ span [ class "text-sm", labelClass ] [ text (sortItemMsgToSortItemModel jobSortModel.selected.name).text ]
        , span [] [ chevronDownIcon ]
        ]
