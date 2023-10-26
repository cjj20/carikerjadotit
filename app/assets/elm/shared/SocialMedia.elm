module Shared.SocialMedia exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)



-- VIEW


view : Html msg
view =
    div [ class "flex gap-x-6 text-2xl text-slate-500" ]
        [ i [ class "fa-brands fa-facebook" ] []
        , i [ class "fa-brands fa-instagram" ] []
        , i [ class "fa-brands fa-linkedin" ] []
        , i [ class "fa-brands fa-youtube" ] []
        ]
