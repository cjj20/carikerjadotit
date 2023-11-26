module Components.SimilarOffers exposing (..)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)



-- VIEW


view : Html msg
view =
    div []
        [ span [ class "text-xl text-slate-700 font-medium" ] [ text "Check similar offers" ]
        , div [ class "flex flex-col gap-y-2 py-2" ]
            []
        ]
