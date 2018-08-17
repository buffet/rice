import XMonad

main = xmonad def {
    modMask    = myModMask,
    workspaces = myWorkspaces
    terminal   = myTerminal,
    manageHook = myManageHook,
}

myModMask    = mod4Mask
myWorkspaces = map show [1..9]
myTerminal   = "st"
myScreenlock = "slock"

myKeys = [
    ((myModMask .|. shiftMask, xK_x),
     spawn myScreenlock)
    ]

myManageHook = composeAll [
    
    ]
