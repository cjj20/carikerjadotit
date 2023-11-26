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
import Helpers.Converter exposing (listStringToString, stringToFloat)
import String exposing (fromInt)


listExperienceMsgToString : List ExperienceLevelMsg -> String
listExperienceMsgToString list =
    listStringToString (List.map experienceLevelMsgToString list)


listEmploymentTypeMsgToString : List EmploymentTypeMsg -> String
listEmploymentTypeMsgToString list =
    listStringToString (List.map employmentTypeMsgToString list)


listTypeOfWorkMsgToString : List TypeOfWorkMsg -> String
listTypeOfWorkMsgToString list =
    listStringToString (List.map typeOfWorkMsgToString list)


formatSalary : String -> String
formatSalary number =
    let
        floatNumber =
            stringToFloat number

        integerPart =
            floor floatNumber

        decimalPart =
            floatNumber - toFloat integerPart
    in
    if decimalPart == 0.0 then
        fromInt integerPart

    else
        number
