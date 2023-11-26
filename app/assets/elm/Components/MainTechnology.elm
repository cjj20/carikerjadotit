module Components.MainTechnology exposing (..)

import Components.TechnologyIcons exposing (..)
import Html exposing (Html)


listMainTechnology : List { name : String, icon : Html msg }
listMainTechnology =
    [ { name = "JS", icon = javascriptIcon }
    , { name = "HTML", icon = htmlIcon }
    , { name = "PHP", icon = phpIcon }
    , { name = "Python", icon = pythonIcon }
    , { name = ".NET", icon = dotNetIcon }
    , { name = "Scala", icon = scalaIcon }
    , { name = "UI/UX", icon = uiUxIcon }
    , { name = "Mobile", icon = mobileIcon }
    , { name = "Testing", icon = testingIcon }
    , { name = "Data", icon = dataIcon }
    , { name = "Analytics", icon = analyticsIcon }
    , { name = "Other", icon = otherIcon }
    , { name = "Ruby", icon = rubyIcon }
    , { name = "Swift", icon = swiftIcon }
    , { name = "Go", icon = golangIcon }
    , { name = "Rust", icon = rustIcon }
    , { name = "SQL", icon = sqlIcon }
    , { name = "Kotlin", icon = kotlinIcon }
    , { name = "Haskell", icon = haskellIcon }
    , { name = "Admin", icon = adminIcon }
    ]
