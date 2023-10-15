module Skill exposing (..)



-- TYPES


type alias Skill =
    {
        name : String
        , icon : String
    }


type alias ListSkill =
    List Skill



-- VIEW


listSkill : ListSkill
listSkill =
    [
        { name = "JS", icon = "fa-brands fa-js" }
        , { name = "PHP", icon = "fa-brands fa-php"}
        , { name = "Python", icon = "fa-brands fa-python"}
        , { name = "Java", icon = "fa-brands fa-java"}
        , { name = "HTML", icon = "fa-brands fa-html5"}
        , { name = "HTML", icon = "fa-brands fa-html5"}
        , { name = "HTML", icon = "fa-brands fa-html5"}
        , { name = "HTML", icon = "fa-brands fa-html5"}
        , { name = "HTML", icon = "fa-brands fa-html5"}
        , { name = "HTML", icon = "fa-brands fa-html5"}
        , { name = "HTML", icon = "fa-brands fa-html5"}
        , { name = "HTML", icon = "fa-brands fa-html5"}
    ]
