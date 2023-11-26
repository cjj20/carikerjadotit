module Helpers.Converter exposing (..)

import String exposing (fromFloat)


listStringToString : List String -> String
listStringToString listString =
    String.join "," listString


stringToFloat : String -> Float
stringToFloat value =
    Maybe.withDefault 0 (String.toFloat value)


floatToString : Float -> String
floatToString value =
    fromFloat value


isValueInArray : a -> List a -> Bool
isValueInArray value array =
    List.member value array


mergeList : List String -> List String -> List String
mergeList list1 list2 =
    List.append list1 (List.filter (\item -> not (List.member item list1)) list2)
