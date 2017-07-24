import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Layout.Fullscreen
import           XMonad.Layout.Grid
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spacing
import           XMonad.ManageHook
import           XMonad.Util.EZConfig
import           XMonad.Util.Run

formatWorkspace :: String -> String
formatWorkspace []       = []
formatWorkspace (':':xs) = " ^fn(FontAwesome)" ++ xs ++ "^fn()"
formatWorkspace (x:xs)   = x : formatWorkspace xs

myLogHook h = dynamicLogWithPP ( defaultPP
    { ppCurrent   = dzenColor iconColor background . pad . formatWorkspace
    , ppVisible   = dzenColor foreground background . pad . formatWorkspace
    , ppHidden   = dzenColor foreground background . pad . formatWorkspace
    , ppHiddenNoWindows   = dzenColor foreground background . pad . (\x -> "")
    , ppWsSep   = ""
    , ppSep   = "   "
    , ppLayout   = dzenColor background background . shorten 0
    , ppTitle   = dzenColor background background . shorten 0
    , ppOrder   = \(ws:l:t:_) -> [ws, l, t]
    , ppOutput   = hPutStrLn h
    } )

myDzenCmd = "dzen2 -x '0' -y '0' -h '25' -ta 'l' -fg '"++foreground++
  "' -bg '"++background++"' -fn "++myFont++" -e onstart=lower -dock"

myLayoutHook = avoidStruts ( master ||| full ||| grid )
  where
    full = noBorders(fullscreenFull Full)
    master = spacing 25 $ Tall 1 (5/100) (1/2)
    grid = spacing 50 Grid

myManageHook = manageDocks <+> composeAll
  [ resource =? "conky" --> doIgnore
  , resource =? "dzen2" --> doIgnore
  ]

main = do
  systemBar <- spawnPipe "spotify_bar.sh"
  spotifyBar <- spawnPipe "system_bar.sh"
  workspaceBar <- spawnPipe myDzenCmd
  xmonad $ defaultConfig
    { workspaces = ["1:\xf268", "2:\xf121", "3:\xf120", "4:\xf120", "5:\xf001"]
    , layoutHook = myLayoutHook
    , logHook = myLogHook workspaceBar
    , manageHook = myManageHook
    , handleEventHook = docksEventHook
    , borderWidth = 0
    }

    `additionalKeys`

    [ ((mod1Mask, xK_r), spawn "rofi -show run")
    , ((mod1Mask, xK_p), spawn "sp play")
    ]

background = "#212121"
foreground = "#cfd8dc"
iconColor = "#00bcd4"
myFont = "Iosevka"
