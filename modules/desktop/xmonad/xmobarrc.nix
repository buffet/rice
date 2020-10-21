{ colors }:
''
  Config
    { font         = "xft:GoMono:normal:size=9:antialias=true"
    , bgColor      = "${colors.primary.background}"
    , fgColor      = "${colors.primary.foreground}"
    , position     = Static
                       { xpos   = 8
                       , ypos   = 6
                       , width  = 1350
                       , height = 20
                       }
    , lowerOnStart = True
    , border       = BottomB
    , borderColor  = "${colors.wm.unfocused.border}"
    , commands     =
        [ Run Battery [ "-t", "<acstatus><left>%"
                      , "--"
                      , "-O", "+"
                      , "-i", "+"
                      , "-o", ""
                      ]
                      50
        , Run Date "%H:%M" "date" 200
        , Run StdinReader
        ]
    , alignSep = "}{"
    , template = "%StdinReader% }{ %battery% %date%"
    }
''
