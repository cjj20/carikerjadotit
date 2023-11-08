module Components.Skill exposing (..)

-- TYPES


type alias Skill =
    { name : String
    , icon : String
    , bgColor : String
    }


type alias ListSkill =
    List Skill



-- VIEW


listSkill : ListSkill
listSkill =
    [ { name = "JS", icon = "fa-brands fa-js", bgColor = "bg-gradient-to-r from-yellow-500 to-yellow-400" }
    , { name = "HTML", icon = "fa-brands fa-html5", bgColor = "bg-gradient-to-r from-orange-600 to-orange-500" }
    , { name = "PHP", icon = "fa-brands fa-php", bgColor = "bg-gradient-to-r from-blue-500 to-blue-400" }
    , { name = "Python", icon = "fa-brands fa-python", bgColor = "bg-gradient-to-r from-blue-600 to-blue-500" }
    , { name = "Java", icon = "fa-brands fa-java", bgColor = "bg-gradient-to-r from-red-600 to-red-500" }
    , { name = "GO", icon = "fa-brands fa-golang", bgColor = "bg-gradient-to-r from-blue-400 to-blue-300" }
    , { name = "Mobile", icon = "fa-solid fa-mobile-screen", bgColor = "bg-gradient-to-r from-red-600 to-red-400" }
    , { name = "Testing", icon = "fa-solid fa-magnifying-glass", bgColor = "bg-gradient-to-r from-green-700 to-green-500" }
    , { name = "Admin", icon = "fa-solid fa-gears", bgColor = "bg-gradient-to-r from-cyan-600 to-cyan-500" }
    , { name = "Other", icon = "fa-solid fa-display", bgColor = "bg-gradient-to-r from-pink-600 to-pink-500" }
    , { name = "Security", icon = "fa-solid fa-shield", bgColor = "bg-gradient-to-r from-indigo-600 to-indigo-500" }
    , { name = "Game", icon = "fa-solid fa-gamepad", bgColor = "bg-gradient-to-r from-pink-700 to-pink-600" }
    ]
