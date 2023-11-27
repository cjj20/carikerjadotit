module Helpers.JobHelper exposing (..)

import Components.JobMoreFilter
    exposing
        ( EmploymentTypeMsg(..)
        , ExperienceLevelMsg(..)
        , TypeOfWorkMsg(..)
        , employmentTypeMsgToString
        , experienceLevelMsgToString
        , typeOfWorkMsgToString
        )
import Helpers.Converter exposing (listStringToString)


listExperienceMsgToString : List ExperienceLevelMsg -> String
listExperienceMsgToString list =
    listStringToString (List.map experienceLevelMsgToString list)


listEmploymentTypeMsgToString : List EmploymentTypeMsg -> String
listEmploymentTypeMsgToString list =
    listStringToString (List.map employmentTypeMsgToString list)


listTypeOfWorkMsgToString : List TypeOfWorkMsg -> String
listTypeOfWorkMsgToString list =
    listStringToString (List.map typeOfWorkMsgToString list)
