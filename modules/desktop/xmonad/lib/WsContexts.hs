-----------------------------------------------------------------------------
-- |
-- Module      :  WsContexts
-- Copyright   :  (c) Niclas Meyer, 2020
-- License     :  MPL2.0 (see LICENSE)
--
-- Maintainer  :  Niclas Meyer <niclas@countingsort.com>
-- Stability   :  unstable
-- Portability :  unportable
--
-- Define and switch between sets of workspaces
--
-----------------------------------------------------------------------------

module WsContexts ( addContext
                  , deleteContext
                  , selectContext
                  ) where

import XMonad

-- $usage
-- You can use this module by importing it into your @~\/.xmonad\/xmonad.hs@:
--
-- > import WsContexts
--
-- Then define a template like this:
--
-- > contextTemplate = map (WsNormal . show) [1..8] ++ [(WsSticky "9")]
--

data WsContextStack = WsContextStack
    { contexts :: [WsContext]
    , stickies :: [WsContextWorkspace]
    }

-- TODO: working dir
data WsContext = WsContext
    { name       :: String
    , workspaces :: [WsContextWorkspace]
    }

data WsContextWorkspace = WsSticky WorkspaceId | WsNormal WorkspaceId

addContext :: String -> X ()
addContext = error "not implemented"

deleteContext :: String -> X ()
deleteContext = error "not implemented"

selectContext :: String -> X ()
selectContext = error "not implemented"
