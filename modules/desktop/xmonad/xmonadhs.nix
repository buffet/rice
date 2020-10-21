{ colors, xmobarrc }:
''
  import XMonad
  import XMonad.Hooks.DynamicLog
  import XMonad.Hooks.EwmhDesktops
  import XMonad.Hooks.SetWMName
  import XMonad.Layout.Reflect
  import XMonad.Layout.Spacing
  import XMonad.Util.EZConfig
  import XMonad.Util.SpawnOnce

  -- TODO: screenshots
  -- TODO: disable screensave
  -- TODO: compositor
  -- TODO: fix .profile
  -- TODO: fix workspace 8

  main = xmonad =<< bar myConfig

  myConfig = flip additionalKeysP myKeys $ ewmh $ def
      { modMask  = mod4Mask
      , terminal = "alacritty"

      , layoutHook  = myLayoutHook
      , startupHook = myStartupHook

      , focusedBorderColor = "${colors.wm.focused.border}"
      , normalBorderColor  = "${colors.wm.unfocused.border}"
      }

  bar = statusBar "xmobar ${xmobarrc}" xmobarPP toggleStrutsKey
      where
          toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b)
          xmobarPP = def
              { ppCurrent = xmobarColor "${colors.wm.focused.text}" ""
              , ppHidden  = xmobarColor "${colors.wm.unfocused.text}" ""
              , ppTitle   = const ""
              , ppLayout  = const ""
              }

  myKeys = [ ("M-i",   spawn "firefox")
           , ("M-h",   sendMessage Expand)
           , ("M-l",   sendMessage Shrink)
           , ("M-S-x", spawn "i3lock -ec '${colors.primary.background}'")
           ]

  myLayoutHook = tall ||| Full
      where
          tall = applySpacing 4 $ reflectHoriz $ Tall 1 (3/100) (8/13)

  applySpacing size = spacingRaw False border True border True
      where
          border = (Border size size size size)

  myStartupHook = do
      setWMName "LG3D"
      spawnOnce "hsetroot -solid '${colors.primary.background}'"
      spawnOnce "xbanish"
''
