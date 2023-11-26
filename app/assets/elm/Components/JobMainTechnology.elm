module Components.JobMainTechnology exposing (..)

import Components.MainTechnology exposing (listMainTechnology)
import Components.SlideOver exposing (animationMobile, backBackground, closeButton)
import Helpers.State exposing (OpenCloseStateMsg(..))
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    { buttonState : OpenCloseStateMsg
    , selected : String
    }



-- MSG


type Msg
    = ButtonState OpenCloseStateMsg
    | Select String



-- INIT


init : Model
init =
    { buttonState = Close
    , selected = ""
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ButtonState msg_ ->
            ( { model | buttonState = msg_ }, Cmd.none )

        Select msg_ ->
            let
                newModel =
                    if msg_ /= model.selected then
                        { model | selected = msg_, buttonState = Close }

                    else
                        { model | selected = "", buttonState = Close }
            in
            ( newModel, Cmd.none )



-- VIEW


listMainTechnologyView : Model -> Html Msg
listMainTechnologyView { selected } =
    div [ class "flex flex-wrap items-center gap-x-0.5 gap-y-2.5 pt-2 md:flex-row md:flex-nowrap md:gap-x-3 md:no-scrollbar md:overflow-x-scroll md:px-4" ]
        (listMainTechnology
            |> List.map
                (\technology ->
                    div [ class "flex flex-col gap-y-1 w-12 items-center", onClick (Select technology.name) ]
                        [ div
                            [ class "flex h-10 items-center justify-center rounded-full w-10 hover:cursor-pointer hover:outline hover:outline-4 hover:outline-slate-300"
                            , if not (selected == "" || selected == technology.name) then
                                class "grayscale"

                              else
                                class ""
                            ]
                            [ technology.icon ]
                        , div [ class "flex justify-center" ]
                            [ span [ class "text-xs text-[#A5A9B5]" ] [ text technology.name ]
                            ]
                        ]
                )
        )


slideOverView : Model -> Html Msg
slideOverView model =
    div [ class "block relative z-50 md:hidden" ]
        [ backBackground model.buttonState
        , div [ animationMobile model.buttonState ]
            [ div [ class "flex items-end justify-center min-h-full" ]
                [ div [ class "bg-white flex flex-col rounded-t-xl w-full" ]
                    [ div [ class "flex flex-col gap-y-6 px-4 py-6" ]
                        [ div [ class "flex items-center" ]
                            [ div [ class "flex gap-x-4 items-center" ]
                                [ div [ onClick (ButtonState Close) ] [ closeButton ]
                                , span [ class "font-semibold text-xl text-black-90" ] [ text "All Tech" ]
                                ]
                            ]
                        , div [] [ listMainTechnologyView model ]
                        ]
                    ]
                ]
            ]
        ]
