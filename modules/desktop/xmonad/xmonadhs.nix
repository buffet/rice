{ pkgs, colors, xmobarrc }:
''
  import           Control.Monad
  import           Data.Function
  import           Data.List                   (find)
  import           Data.Maybe
  import           System.Environment
  import           XMonad
  import           XMonad.Actions.DwmPromote
  import           XMonad.Actions.SpawnOn
  import           XMonad.Hooks.DynamicLog
  import           XMonad.Hooks.EwmhDesktops
  import           XMonad.Hooks.SetWMName
  import           XMonad.Layout.Reflect
  import           XMonad.Layout.Spacing
  import qualified XMonad.StackSet             as W
  import           XMonad.Util.EZConfig
  import           XMonad.Util.NamedScratchpad
  import           XMonad.Util.SpawnOnce

  main = xmonad =<< bar myConfig

  myConfig = flip additionalKeysP myKeys $ ewmh $ def
      { modMask     = mod4Mask
      , terminal    = "alacritty"
      , borderWidth = 0
      , workspaces  = myWorkspaces

      , layoutHook  = myLayoutHook
      , manageHook  = myManageHook
      , startupHook = myStartupHook
      }

  myWorkspaces = map show [1..9]

  scratchpads = [ NS "plover" "plover" (title =? "Plover") (floatCentered 0.4 0.6)
                , NS "barrier" "barrier" (className =? "Barrier") (floatCentered 0.4 0.6)
                ]

  floatCentered w h = customFloating $ W.RationalRect ((1 - w) / 2) ((1 - h) / 2) w h

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
           , ("M-n",        maybeSpawn =<< (liftIO visualEditor))
           , ("M-S-x",      spawn "${pkgs.i3lock}/bin/i3lock -ec '${colors.primary.background}'")
           , ("M-p",        spawn "${pkgs.flameshot}/bin/flameshot gui")
           , ("M-S-p",      spawn "${pkgs.maim}/bin/maim | xclip -i -sel c -t image/png")
           , ("M-s M-p",    namedScratchpadAction scratchpads "plover")
           , ("M-s M-b",    namedScratchpadAction scratchpads "barrier")

           , ("C-q",        pure ())  -- stop me from accidentally closing all firefox tabs
           ]
           ++
           [("M-C-" ++ ws, windows $ swapCurrentWspContentsWith ws) | ws <- myWorkspaces]


  maybeSpawn = maybe (pure ()) spawn

  visualEditor = lookupEnv "VISUAL"

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
      spawnOnce "${pkgs.xcalib}/bin/xcalib ${../icc/ThinkPad_X250_FHD_LP125WF2_SPB2.icm}"

  swapCurrentWspContentsWith :: Eq i => i -> W.StackSet i l a sid sd -> W.StackSet i l a sid sd
  swapCurrentWspContentsWith other ws =
      case find ((other ==) . W.tag) $ W.workspaces ws of
          Just otherWsp -> W.mapWorkspace (swapWith otherWsp) ws
          Nothing -> ws
      where
          currentWsp = W.workspace $ W.current ws
          swapWith otherWsp w
              | W.tag w == other            = currentWsp { W.tag = W.tag otherWsp }
              | W.tag w == W.tag currentWsp = otherWsp   { W.tag = W.tag currentWsp }
              | otherwise                   = w

  -- TODO: FIX
  -- | launch a program by starting an instance in a hidden workspace,
  -- and just raising an already running instance. This allows for super quick "startup" time.
  -- For this to work, the window needs to have the `_NET_WM_PID` set and unique!
  launchWithBackgroundInstance :: (Query Bool) -> String -> X ()
  launchWithBackgroundInstance windowQuery commandToRun = withWindowSet $ \winSet -> do
      fittingHiddenWindows <- (W.allWindows winSet) & filter (\win -> Just "7" == W.findTag win winSet)
                                                    & filterM (runQuery windowQuery)
      case fittingHiddenWindows of
        []        -> do spawnHere commandToRun
                        spawnOn "7" commandToRun
        [winId]   -> do windows $ W.shiftWin (W.currentTag winSet) winId
                        spawnOn "7" commandToRun
        (winId:_) -> windows $ W.shiftWin (W.currentTag winSet) winId
''
