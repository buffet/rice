{ pkgs, colors, xmobarrc }:
''
  import XMonad
  import XMonad.Actions.DwmPromote
  import XMonad.Hooks.DynamicLog
  import XMonad.Hooks.EwmhDesktops
  import XMonad.Hooks.SetWMName
  import XMonad.Layout.Reflect
  import XMonad.Layout.Spacing
  import XMonad.Util.EZConfig
  import XMonad.Util.NamedScratchpad
  import XMonad.Util.SpawnOnce

  main = xmonad =<< bar myConfig

  myConfig = flip additionalKeysP myKeys $ ewmh $ def
      { modMask     = mod4Mask
      , terminal    = "alacritty"
      , borderWidth = 0

      , layoutHook  = myLayoutHook
      , manageHook  = myManageHook
      , startupHook = myStartupHook
      }

  scratchpads = [ NS "plover" "plover" (title =? "Plover") defaultFloating
                ]

  bar = statusBar "${pkgs.xmobar}/bin/xmobar ${xmobarrc}" (namedScratchpadFilterOutWorkspacePP xmobarPP) toggleStrutsKey
      where
          toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b)
          xmobarPP = def
              { ppCurrent = xmobarColor "${colors.wm.focused.text}" ""
              , ppHidden  = xmobarColor "${colors.wm.unfocused.text}" ""
              , ppTitle   = const ""
              , ppLayout  = const ""
              }

  myKeys = [ ("M-<Return>", dwmpromote)
           , ("M-i",        spawn "firefox")
           , ("M-h",        sendMessage Expand)
           , ("M-l",        sendMessage Shrink)
           , ("M-S-x",      spawn "${pkgs.i3lock}/bin/i3lock -ec '${colors.primary.background}'")
           , ("M-p",        spawn "${pkgs.maim}/bin/maim -s | xclip -i -sel c -t image/png")
           , ("M-S-p",      spawn "${pkgs.maim}/bin/maim | xclip -i -sel c -t image/png")
           , ("M-s M-p",    namedScratchpadAction scratchpads "plover")
           ]

  myLayoutHook = tall ||| Full
      where
          tall = applySpacing 6 $ reflectHoriz $ Tall 1 (3/100) (8/13)

  applySpacing size = spacingRaw False border True border True
      where
          border = (Border size size size size)

  myManageHook = namedScratchpadManageHook scratchpads

  myStartupHook = do
      setWMName "LG3D"
      spawnOnce "${pkgs.hsetroot}/bin/hsetroot -solid '${colors.primary.background}'"
      spawnOnce "${pkgs.xbanish}/bin/xbanish"
''
