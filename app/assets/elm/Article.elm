module Article exposing (main)

import Browser
import Html exposing (..)
import Json.Decode as Decode exposing (Decoder, Value, decodeValue, field, list, string)



-- TYPES


type alias Article =
    { title : String }


type alias Model =
    List Article


type alias Flags =
    { articles : Value
    }


type Msg
    = None



-- DECODER


articleDecoder : Decoder Article
articleDecoder =
    Decode.map (\title -> { title = title })
        (field "title" string)


articlesDecoder : Decoder (List Article)
articlesDecoder =
    list articleDecoder



-- VIEW


view : Model -> Html Msg
view model =
    Html.main_ []
        [ h1 [] [ text "This is amazing articles for you" ]
        , text "Articles for read: "
        , ul [] <| List.map (\article -> li [] [ text article.title ]) model
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )



-- INIT


init : Flags -> ( Model, Cmd Msg )
init { articles } =
    case decodeValue articlesDecoder articles of
        Ok records ->
            ( records, Cmd.none )

        Err _ ->
            ( [], Cmd.none )



-- MAIN


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
