module SimilarOffers exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Job



-- VIEW


view : Html msg
view =
    div [ class "space-y-6 rounded-lg" ]
    [
        div [ class "space-y-2" ]
        [
            span [ class "text-xl text-slate-700 font-medium" ] [ text "Check similar offers" ]
            , div [ class "space-y-2 py-2" ]
            [
                div [] [ Job.view ]
                , div [] [ Job.view ]
                , div [] [ Job.view ]
                , div [] [ Job.view ]
                , div [] [ Job.view ]
            ]
        ]
    ]



-- MAIN


main =
    view
