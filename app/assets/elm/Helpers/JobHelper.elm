module Helpers.JobHelper exposing (..)

import Components.JobMoreFilter
    exposing
        ( EmploymentTypeMsg(..)
        , ExperienceMsg(..)
        , TypeOfWorkMsg(..)
        , employmentTypeMsgToString
        , experienceMsgToString
        , typeOfWorkMsgToString
        )
import Helpers.Converter exposing (listStringToString)


listExperienceMsgToString : List ExperienceMsg -> String
listExperienceMsgToString list =
    listStringToString (List.map experienceMsgToString list)


listEmploymentTypeMsgToString : List EmploymentTypeMsg -> String
listEmploymentTypeMsgToString list =
    listStringToString (List.map employmentTypeMsgToString list)


listTypeOfWorkMsgToString : List TypeOfWorkMsg -> String
listTypeOfWorkMsgToString list =
    listStringToString (List.map typeOfWorkMsgToString list)
