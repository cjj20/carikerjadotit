module Components.Icons exposing (..)

import Html exposing (Html)
import Svg exposing (circle, clipPath, defs, g, path, rect, svg)
import Svg.Attributes exposing (clipPathUnits, cx, cy, d, fill, height, id, r, rx, stroke, strokeLinecap, strokeLinejoin, strokeWidth, transform, viewBox, width, x, y)


keywordIcon : Html msg
keywordIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ circle [ cx "9", cy "14", r "3", stroke "#242632", strokeWidth "2", strokeLinejoin "round" ] []
        , path [ d "M11.5 11.5L17 6L19 8", stroke "#242632", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        , path [ d "M15 8L17 10", stroke "#242632", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        ]


skillIcon : Html msg
skillIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ path
            [ d "M10.8907 8.54544L10 6.80008L9.10928 8.54544L8.44122 9.85452L6.98976 10.0854L5.05458 10.3931L6.43927 11.7796L7.47784 12.8195L7.24886 14.2712L6.94356 16.2068L8.69006 15.3183L10 14.652L11.3099 15.3183L13.0564 16.2068L12.7511 14.2712L12.5222 12.8195L13.5607 11.7796L14.9454 10.3931L13.0102 10.0854L11.5588 9.85452L10.8907 8.54544Z"
            , stroke "#242632"
            , strokeWidth "2"
            ]
            []
        , path [ d "M17 16L17.5995 17.1748L18.9021 17.382L17.9701 18.3152L18.1756 19.618L17 19.02L15.8244 19.618L16.0299 18.3152L15.0979 17.382L16.4005 17.1748L17 16Z", fill "#242632" ] []
        , path [ d "M17 4L17.5995 5.1748L18.9021 5.38197L17.9701 6.3152L18.1756 7.61803L17 7.02L15.8244 7.61803L16.0299 6.3152L15.0979 5.38197L16.4005 5.1748L17 4Z", fill "#242632" ] []
        ]


positionIcon : Html msg
positionIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ rect [ x "4", y "8", width "16", height "11", rx "1", stroke "black", strokeWidth "2" ] []
        , rect [ x "9", y "5", width "6", height "14", rx "1", stroke "black", strokeWidth "2" ] []
        ]


burgerMenuIcon : Html msg
burgerMenuIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ path [ d "M5 7H19", stroke "#242632", strokeWidth "2", strokeLinecap "round" ] []
        , path [ d "M5 12H19", stroke "#242632", strokeWidth "2", strokeLinecap "round" ] []
        , path [ d "M5 17H19", stroke "#242632", strokeWidth "2", strokeLinecap "round" ] []
        ]


close24Icon : Html msg
close24Icon =
    svg [ width "36", height "36", viewBox "0 0 36 36", fill "none" ]
        [ path [ d "M24 12L12 24", stroke "#242632", strokeWidth "2", strokeLinecap "round" ] []
        , path [ d "M12 12L24 24", stroke "#242632", strokeWidth "2", strokeLinecap "round" ] []
        ]


close16Icon : Html msg
close16Icon =
    svg [ width "16", height "16", viewBox "0 0 16 16", fill "none" ]
        [ path [ d "M11 5L5 11", stroke "white", strokeWidth "2", strokeLinecap "round" ] []
        , path [ d "M5 5L11 11", stroke "white", strokeWidth "2", strokeLinecap "round" ] []
        ]


rocketIcon : Html msg
rocketIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ g [ clipPathUnits "url(#clip0_135_1117)" ]
            [ path [ d "M7.64567 17.7886L5.58763 15.7305M10.7164 16.7759L6.60029 12.6598C9.16738 2.94746 17.1324 3.15412 19.3242 3.405L19.3236 3.40564C19.6626 3.44351 19.9308 3.71298 19.9667 4.05262C20.2022 6.23535 20.3497 14.1387 10.7164 16.7759ZM10.7164 16.7759L11.1145 20.234C11.1431 20.4833 11.2977 20.7004 11.5242 20.8096C11.7501 20.9181 12.0153 20.9038 12.2261 20.7701L16.5704 18.0157C16.7595 17.896 16.8823 17.6947 16.9013 17.4713L17.2927 12.9702M10.3221 6.09151L5.90557 6.47553C5.68209 6.49449 5.4808 6.61732 5.36112 6.80645L2.6067 11.1507C2.47302 11.3616 2.45871 11.6267 2.56723 11.8526C2.67639 12.0792 2.89352 12.2338 3.14281 12.2623L6.60093 12.6605", stroke "#242632", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ]
                []
            , circle
                [ cx "16.0169", cy "7.25392", r "1.4944", fill "#242632" ]
                []
            ]
        , defs []
            [ clipPath [ id "clip0_135_1117" ] [ rect [ width "24", height "24", fill "white" ] [] ]
            ]
        ]


questionMarkIcon : Html msg
questionMarkIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ circle [ cx "12", cy "12", r "10", stroke "black", strokeWidth "2" ] []
        , path [ d "M10.4747 14.2603V14.0266C10.4747 13.3805 10.5279 12.8656 10.6344 12.4817C10.7446 12.0979 10.9043 11.79 11.1133 11.5582C11.3224 11.3226 11.5771 11.1078 11.8774 10.914C12.1169 10.762 12.3298 10.6081 12.516 10.4523C12.7061 10.2926 12.8563 10.1216 12.9665 9.93919C13.0767 9.75677 13.1319 9.54964 13.1319 9.31781C13.1319 9.09359 13.0786 8.89596 12.9722 8.72494C12.8658 8.55392 12.7194 8.4228 12.5331 8.33159C12.3507 8.23658 12.1473 8.18907 11.923 8.18907C11.6987 8.18907 11.4878 8.24038 11.2901 8.34299C11.0962 8.44561 10.9366 8.59192 10.8111 8.78195C10.6895 8.96817 10.6268 9.1943 10.623 9.46033H8C8.0114 8.66223 8.19577 8.00855 8.5531 7.49929C8.91423 6.99002 9.3913 6.61378 9.98432 6.37055C10.5773 6.12351 11.2312 6 11.9458 6C12.7289 6 13.4246 6.12162 14.0328 6.36485C14.6448 6.60808 15.1257 6.96722 15.4754 7.44228C15.8251 7.91734 16 8.49881 16 9.1867C16 9.63895 15.924 10.038 15.7719 10.3838C15.6199 10.7297 15.407 11.0356 15.1333 11.3017C14.8634 11.5639 14.546 11.8033 14.181 12.02C13.8959 12.1872 13.6584 12.362 13.4683 12.5444C13.282 12.7268 13.1414 12.9359 13.0463 13.1715C12.9513 13.4033 12.9038 13.6884 12.9038 14.0266V14.2603H10.4747ZM11.7349 18C11.3243 18 10.9727 17.8556 10.68 17.5667C10.3911 17.2779 10.2485 16.9283 10.2523 16.5178C10.2485 16.115 10.3911 15.771 10.68 15.486C10.9727 15.1971 11.3243 15.0527 11.7349 15.0527C12.1264 15.0527 12.4704 15.1971 12.7669 15.486C13.0634 15.771 13.2136 16.115 13.2174 16.5178C13.2136 16.7914 13.1414 17.0404 13.0007 17.2646C12.8639 17.4888 12.6833 17.6675 12.459 17.8005C12.2385 17.9335 11.9971 18 11.7349 18Z", fill "black" ] []
        ]


fileLinesIcon : Html msg
fileLinesIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ rect [ x "7", y "4", width "13", height "13", rx "1", stroke "#242632", strokeWidth "2" ] []
        , path [ d "M3 5V19C3 20.1046 3.89543 21 5 21H19", stroke "#242632", strokeWidth "2", strokeLinecap "round" ] []
        , path [ d "M11 8H16", stroke "#242632", strokeWidth "2", strokeLinecap "round" ] []
        , path [ d "M11 12H15", stroke "#242632", strokeWidth "2", strokeLinecap "round" ] []
        ]


facebookIcon : Html msg
facebookIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ path [ d "M14.2572 6.36452H15.75V3.86027C15.0272 3.78573 14.301 3.74893 13.5744 3.75002C11.4146 3.75002 9.93768 5.05727 9.93768 7.45127V9.51451H7.5V12.318H9.93768V19.5H12.8597V12.318H15.2895L15.6547 9.51451H12.8597V7.72689C12.8597 6.90002 13.0821 6.36452 14.2572 6.36452Z", fill "#242632" ] []
        ]


twitterIcon : Html msg
twitterIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ path [ d "M19.5 7.43768C18.9363 7.67803 18.3401 7.83691 17.73 7.90939C18.3736 7.53152 18.856 6.93707 19.0875 6.2363C18.4827 6.59013 17.8206 6.83942 17.13 6.97334C16.6684 6.48142 16.0537 6.15397 15.3824 6.04234C14.711 5.93072 14.0209 6.04124 13.4203 6.35657C12.8198 6.67191 12.3427 7.17421 12.0639 7.78471C11.7852 8.39521 11.7205 9.07937 11.88 9.72989C10.6571 9.6691 9.46083 9.35618 8.36899 8.81143C7.27715 8.26669 6.31413 7.50231 5.5425 6.56797C5.27185 7.03243 5.12964 7.55843 5.13 8.09365C5.12904 8.5907 5.25316 9.08027 5.49132 9.51878C5.72947 9.95728 6.07426 10.3311 6.495 10.607C6.00598 10.5939 5.52741 10.4649 5.1 10.2311V10.2679C5.10367 10.9644 5.352 11.6382 5.80299 12.1754C6.25398 12.7126 6.87994 13.0802 7.575 13.2161C7.30744 13.2961 7.02966 13.3383 6.75 13.3414C6.55642 13.3392 6.36332 13.3219 6.1725 13.2898C6.37043 13.8889 6.75347 14.4124 7.26831 14.7876C7.78315 15.1628 8.40418 15.3709 9.045 15.383C7.9629 16.2198 6.62691 16.6764 5.25 16.6802C4.9993 16.681 4.7488 16.6663 4.5 16.636C5.90582 17.528 7.54411 18.0015 9.2175 17.9995C10.3723 18.0113 11.5179 17.7969 12.5873 17.3687C13.6568 16.9405 14.6288 16.3072 15.4464 15.5057C16.264 14.7043 16.911 13.7508 17.3494 12.7009C17.7879 11.6509 18.009 10.5257 18 9.39085C18 9.26555 18 9.13288 18 9.00022C18.5885 8.56891 19.0961 8.04016 19.5 7.43768Z", fill "#242632" ] []
        ]


instagramIcon : Html msg
instagramIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ path [ d "M16.005 7.095C15.827 7.095 15.653 7.14778 15.505 7.24668C15.357 7.34557 15.2416 7.48613 15.1735 7.65058C15.1054 7.81504 15.0876 7.996 15.1223 8.17058C15.157 8.34516 15.2427 8.50553 15.3686 8.6314C15.4945 8.75726 15.6548 8.84298 15.8294 8.87771C16.004 8.91243 16.185 8.89461 16.3494 8.82649C16.5139 8.75837 16.6544 8.64302 16.7533 8.49501C16.8522 8.34701 16.905 8.173 16.905 7.995C16.905 7.7563 16.8102 7.52739 16.6414 7.3586C16.4726 7.18982 16.2437 7.095 16.005 7.095ZM19.455 8.91C19.4404 8.28772 19.3239 7.67205 19.11 7.0875C18.9193 6.58735 18.6225 6.13446 18.24 5.76C17.8686 5.37557 17.4147 5.08063 16.9125 4.8975C16.3295 4.67712 15.7131 4.55791 15.09 4.545C14.295 4.5 14.04 4.5 12 4.5C9.96 4.5 9.705 4.5 8.91 4.545C8.28686 4.55791 7.67051 4.67712 7.0875 4.8975C6.58626 5.08249 6.1327 5.37717 5.76 5.76C5.37557 6.13138 5.08063 6.58533 4.8975 7.0875C4.67712 7.67051 4.55791 8.28686 4.545 8.91C4.5 9.705 4.5 9.96 4.5 12C4.5 14.04 4.5 14.295 4.545 15.09C4.55791 15.7131 4.67712 16.3295 4.8975 16.9125C5.08063 17.4147 5.37557 17.8686 5.76 18.24C6.1327 18.6228 6.58626 18.9175 7.0875 19.1025C7.67051 19.3229 8.28686 19.4421 8.91 19.455C9.705 19.5 9.96 19.5 12 19.5C14.04 19.5 14.295 19.5 15.09 19.455C15.7131 19.4421 16.3295 19.3229 16.9125 19.1025C17.4147 18.9194 17.8686 18.6244 18.24 18.24C18.6242 17.8669 18.9213 17.4136 19.11 16.9125C19.3239 16.3279 19.4404 15.7123 19.455 15.09C19.455 14.295 19.5 14.04 19.5 12C19.5 9.96 19.5 9.705 19.455 8.91ZM18.105 15C18.0995 15.4761 18.0133 15.9478 17.85 16.395C17.7302 16.7214 17.5379 17.0163 17.2875 17.2575C17.0442 17.5054 16.7499 17.6973 16.425 17.82C15.9778 17.9833 15.5061 18.0695 15.03 18.075C14.28 18.1125 14.0025 18.12 12.03 18.12C10.0575 18.12 9.78 18.12 9.03 18.075C8.53567 18.0843 8.04345 18.0081 7.575 17.85C7.26434 17.7211 6.98352 17.5296 6.75 17.2875C6.50107 17.0466 6.31113 16.7514 6.195 16.425C6.01189 15.9714 5.91033 15.489 5.895 15C5.895 14.25 5.85 13.9725 5.85 12C5.85 10.0275 5.85 9.75 5.895 9C5.89836 8.51329 5.98721 8.03096 6.1575 7.575C6.28954 7.25843 6.4922 6.97624 6.75 6.75C6.97786 6.49213 7.25947 6.28732 7.575 6.15C8.03216 5.98503 8.514 5.89881 9 5.895C9.75 5.895 10.0275 5.85 12 5.85C13.9725 5.85 14.25 5.85 15 5.895C15.4761 5.90046 15.9478 5.98668 16.395 6.15C16.7358 6.27649 17.0417 6.48214 17.2875 6.75C17.5333 6.98038 17.7253 7.26205 17.85 7.575C18.0167 8.0317 18.103 8.51383 18.105 9C18.1425 9.75 18.15 10.0275 18.15 12C18.15 13.9725 18.1425 14.25 18.105 15ZM12 8.1525C11.2394 8.15398 10.4962 8.38089 9.86449 8.80456C9.23276 9.22823 8.74078 9.82965 8.45073 10.5328C8.16067 11.236 8.08554 12.0093 8.23485 12.7552C8.38415 13.501 8.75118 14.1859 9.28956 14.7232C9.82794 15.2606 10.5135 15.6263 11.2596 15.7741C12.0058 15.922 12.779 15.8453 13.4816 15.5539C14.1842 15.2625 14.7847 14.7693 15.2071 14.1368C15.6295 13.5042 15.855 12.7606 15.855 12C15.856 11.4938 15.7569 10.9925 15.5634 10.5247C15.37 10.057 15.0859 9.63211 14.7277 9.27454C14.3694 8.91697 13.944 8.63376 13.4758 8.4412C13.0077 8.24864 12.5062 8.15052 12 8.1525ZM12 14.4975C11.506 14.4975 11.0232 14.351 10.6125 14.0766C10.2018 13.8022 9.88164 13.4121 9.69261 12.9558C9.50358 12.4994 9.45412 11.9972 9.55049 11.5128C9.64686 11.0283 9.88472 10.5833 10.234 10.234C10.5833 9.88472 11.0283 9.64686 11.5128 9.55049C11.9972 9.45412 12.4994 9.50358 12.9558 9.69261C13.4121 9.88164 13.8022 10.2018 14.0766 10.6125C14.351 11.0232 14.4975 11.506 14.4975 12C14.4975 12.328 14.4329 12.6527 14.3074 12.9558C14.1819 13.2588 13.9979 13.5341 13.766 13.766C13.5341 13.9979 13.2588 14.1819 12.9558 14.3074C12.6527 14.4329 12.328 14.4975 12 14.4975Z", fill "#242632" ] []
        ]


linkedInIcon : Html msg
linkedInIcon =
    svg [ width "24", height "24", viewBox "0 0 24 24", fill "none" ]
        [ path [ d "M4.5 5.49242C4.5 4.98736 4.67737 4.5707 5.03209 4.24242C5.38682 3.91414 5.84798 3.75 6.41554 3.75C6.97298 3.75 7.42398 3.91161 7.76858 4.23485C8.12331 4.56818 8.30068 5.00251 8.30068 5.53788C8.30068 6.02272 8.12838 6.42675 7.78378 6.74999C7.42906 7.08333 6.96284 7.24999 6.38513 7.24999H6.36993C5.81249 7.24999 5.36149 7.08333 5.01689 6.74999C4.67229 6.41666 4.5 5.99747 4.5 5.49242ZM4.69764 18.75V8.62878H8.07263V18.75H4.69764ZM9.94257 18.75H13.3176V13.0985C13.3176 12.7449 13.3581 12.4722 13.4392 12.2803C13.5811 11.9368 13.7965 11.6464 14.0853 11.4091C14.3742 11.1717 14.7365 11.053 15.1723 11.053C16.3074 11.053 16.875 11.8156 16.875 13.3409V18.75H20.25V12.947C20.25 11.452 19.8953 10.3182 19.1858 9.54544C18.4763 8.77272 17.5389 8.38636 16.3733 8.38636C15.0659 8.38636 14.0473 8.94696 13.3176 10.0682V10.0985H13.3024L13.3176 10.0682V8.62878H9.94257C9.96283 8.95201 9.97297 9.95705 9.97297 11.6439C9.97297 13.3308 9.96283 15.6995 9.94257 18.75Z", fill "#242632" ] []
        ]


magnifyingGlassGrayIcon : Html msg
magnifyingGlassGrayIcon =
    svg [ width "16", height "16", viewBox "0 0 16 16", fill "none" ]
        [ path [ d "M11.4 11.3999L14 13.9999", stroke "#242632", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        , circle [ cx "7.06667", cy "7.06667", r "5.06667", stroke "#242632", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        ]


magnifyingGlassBlueIcon : Html msg
magnifyingGlassBlueIcon =
    svg [ width "16", height "16", viewBox "0 0 16 16", fill "none" ]
        [ path [ d "M11.4 11.3999L14 13.9999", stroke "#1371F9", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        , circle [ cx "7.06667", cy "7.06667", r "5.06667", stroke "#1371F9", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        ]


mapsBlueIcon : Html msg
mapsBlueIcon =
    svg [ width "16", height "16", viewBox "0 0 16 16", fill "none" ]
        [ g [ clipPathUnits "url(#clip0_223_3060)" ]
            [ path [ d "M13.5 6.54545C13.5 8.69158 12.1063 10.8122 10.5217 12.4966C9.74935 13.3175 8.97369 13.9905 8.39004 14.4585C8.24703 14.5732 8.11603 14.6751 8 14.7636C7.88397 14.6751 7.75297 14.5732 7.60996 14.4585C7.02631 13.9905 6.25065 13.3175 5.47834 12.4966C3.89367 10.8122 2.5 8.69158 2.5 6.54545C2.5 3.47661 4.9694 1 8 1C11.0306 1 13.5 3.47661 13.5 6.54545Z", stroke "#1371F9", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
            , circle [ cx "8", cy "6", r "2", fill "#1371F9" ] []
            ]
        , defs [] [ clipPath [ id "clip0_223_3060" ] [ rect [ width "16", height "16", fill "white" ] [] ] ]
        ]


mapsGrayIcon : Html msg
mapsGrayIcon =
    svg [ width "12", height "12", viewBox "0 0 12 12", fill "none" ]
        [ path [ d "M9.5625 5.09091C9.5625 6.48215 8.66254 7.83791 7.66708 8.89603C7.17936 9.41444 6.68997 9.83898 6.32197 10.1341C6.1991 10.2326 6.09022 10.3163 6 10.3839C5.90979 10.3163 5.8009 10.2326 5.67803 10.1341C5.31003 9.83898 4.82064 9.41444 4.33292 8.89603C3.33746 7.83791 2.4375 6.48215 2.4375 5.09091C2.4375 3.10467 4.03602 1.5 6 1.5C7.96398 1.5 9.5625 3.10467 9.5625 5.09091Z", stroke "#A5A9B5", strokeLinecap "round", strokeLinejoin "round" ] []
        , Svg.circle [ cx "6", cy "5", r "1", fill "#A5A9B5" ] []
        ]


mapsPaperIcon : Html msg
mapsPaperIcon =
    svg [ width "17", height "15", viewBox "0 0 17 15", fill "none" ]
        [ path [ d "M6 1L1 4V14L6 11L11 14L16 11V1L11 4L6 1Z", fill "white", stroke "#101010", strokeWidth "2", strokeLinejoin "round" ] []
        , path [ d "M6 1V11", stroke "#101010", strokeWidth "2", strokeLinejoin "round" ] []
        , path [ d "M11 4V14", stroke "#101010", strokeWidth "2", strokeLinejoin "round" ] []
        ]


chevronDownGrayIcon : Html msg
chevronDownGrayIcon =
    svg [ width "16", height "16", viewBox "0 0 16 16", fill "none" ]
        [ path [ d "M12 6L8 10L4 6", stroke "#101010", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        ]


chevronDownBlueIcon : Html msg
chevronDownBlueIcon =
    svg [ width "16", height "16", viewBox "0 0 16 16", fill "none" ]
        [ path [ d "M12 6L8 10L4 6", stroke "#1371F9", strokeWidth "2", strokeLinecap "round", strokeLinejoin "round" ] []
        ]


slidersIcon : Html msg
slidersIcon =
    svg [ width "16", height "16", viewBox "0 0 16 16", fill "none" ]
        [ path [ d "M1 4L7 4", stroke "#1371F9", strokeWidth "2", strokeLinecap "round" ] []
        , path [ d "M13 4L15 4", stroke "#1371F9", strokeWidth "2", strokeLinecap "round" ] []
        , circle [ cx "10", cy "4", r "2", stroke "#1371F9", strokeWidth "2" ] []
        , path [ d "M15 12L9 12", stroke "#1371F9", strokeWidth "2", strokeLinecap "round" ] []
        , path [ d "M3 12H1", stroke "#1371F9", strokeWidth "2", strokeLinecap "round" ] []
        , path [ d "M6 10C4.89543 10 4 10.8954 4 12C4 13.1046 4.89543 14 6 14C7.10457 14 8 13.1046 8 12C8 10.8954 7.10457 10 6 10Z", stroke "#1371F9", strokeWidth "2" ] []
        ]


toggleOnIcon : Html msg
toggleOnIcon =
    svg [ width "34", height "20", viewBox "0 0 34 20", fill "none" ]
        [ rect [ width "34", height "20", rx "10", fill "#1371F9" ] []
        , circle [ cx "24", cy "10", r "8", fill "white" ] []
        ]


toggleOffIcon : Html msg
toggleOffIcon =
    svg [ width "34", height "20", viewBox "0 0 34 20", fill "none" ]
        [ rect [ x "34", y "20", width "34", height "20", rx "10", transform "rotate(-180 34 20)", fill "#A5A9B5" ] []
        , circle [ cx "10", cy "10", r "8", transform "rotate(-180 10 10)", fill "white" ] []
        ]


buildingIcon : Html msg
buildingIcon =
    svg [ width "12", height "12", viewBox "0 0 12 12", fill "none" ]
        [ Svg.rect [ width "12", height "12", fill "white" ] []
        , path [ d "M9 10.5H9.5V10V3C9.5 2.17157 8.82843 1.5 8 1.5H4C3.17157 1.5 2.5 2.17157 2.5 3V10V10.5H3H9Z", stroke "#A5A9B5" ] []
        , path [ d "M5 8C5 7.44772 5.44772 7 6 7C6.55228 7 7 7.44772 7 8V10H5V8Z", fill "#A5A9B5" ] []
        , Svg.rect [ x "4", y "3", width "1", height "1", fill "#A5A9B5" ] []
        , Svg.rect [ x "4", y "5", width "1", height "1", fill "#A5A9B5" ] []
        , Svg.rect [ x "7", y "3", width "1", height "1", fill "#A5A9B5" ] []
        , Svg.rect [ x "7", y "5", width "1", height "1", fill "#A5A9B5" ] []
        ]


dotIcon : Html msg
dotIcon =
    svg [ width "2", height "2", viewBox "0 0 2 2", fill "none" ]
        [ Svg.circle [ cx "1", cy "1", r "1", fill "#A5A9B5" ] []
        ]
