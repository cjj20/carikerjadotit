module Shared.SimilarOffers exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Shared.Job as Job



-- VIEW


view : Html msg
view =
    div []
    [
        span [ class "text-xl text-slate-700 font-medium" ] [ text "Check similar offers" ]
        , div [ class "flex flex-col gap-y-2 py-2" ]
        [
            div [] [ Job.view ]
            , div [] [ Job.view ]
            , div [] [ Job.view ]
            , div [] [ Job.view ]
            , div [] [ Job.view ]
        ]
    ]
