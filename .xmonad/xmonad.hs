  -- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1, copy)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.FloatKeys
import qualified XMonad.Actions.Search as S

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Tree
import Data.Ratio ((%))
import Data.Maybe (isJust)
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

    -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

    -- Colors
import Colors.DoomOne

-- VARIABLES

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myFont :: String
myFont = "xft:Ubuntu Mono:size=16:antialias=true:hinting=true"

myTerminal = "alacritty"
myTerminal :: String

myBrowser = "brave-browser"
myBrowser :: String

myEditor = "nvim"
myEditor :: String

myBorderWidth = 1
myBorderWidth :: Dimension

myNormColor = "#282c34"
myNormColor :: String

myFocusColor :: String
{- myFocusColor = "#bd9cf9" -- purple -}
{- myFocusColor = "#46d9ff" -- light blue -}
myFocusColor = "#ff5555" -- red

myScripts :: String
myScripts = "/home/maxim/scripts"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"
    spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x282c34  --height 22 &"
    setWMName "LG3D"

-- START_KEYS
myKeys :: [(String, X ())]
myKeys =
    -- KB_GROUP Recompile, restart, quit
        [ ("M-C-r", spawn "xmonad --recompile")       -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")         -- Restarts xmonad
        , ("M-S-q", io exitSuccess)                   -- Quits xmonad
    
    -- KB_GROUP Change keyboard layout
        , ("M-<Space>", spawn "/home/maxim/scripts/ch_key_layout")-- Change keyboard layout

    -- KB_GROUP Run Prompt
        , ("M-S-<Return>", spawn "dmenu_run -i -p \"Run: \"") -- Dmenu
        {- , ("M-S-<Return>", spawn "/home/maxim/scripts/j4-dm") -- Dmenu -}


    -- KB_GROUP Screenshots
    
        , ("<Print>", spawn "flameshot full -p /maxim/home/Pictures")
        , ("S-<Print>", spawn "flameshot gui")

    -- KB_GROUP Get Help
        , ("M-S-/", spawn "~/.xmonad/xmonad_keys.sh") -- Get list of keybindings
        , ("M-/", spawn "dtos-help")                  -- DTOS help/tutorial videos
    -- KB_GROUP Other Dmenu Prompts
    -- In Xmonad and many tiling window managers, M-p is the default keybinding to
    -- launch dmenu_run, so I've decided to use M-p plus KEY for these dmenu scripts.
        , ("M-p h", spawn "dm-hub")       -- allows access to all dmscripts
        , ("M-p c", spawn "dm-colpick")   -- pick color from our scheme
        , ("M-p e", spawn "dm-confedit")  -- edit config files
        , ("M-p i", spawn "dm-maim")      -- screenshots (images)
        , ("M-p k", spawn "dm-kill")      -- kill processes
        , ("M-p m", spawn "dm-man")       -- manpages
        , ("M-p n", spawn "dm-note")      -- store one-line notes and copy them
        , ("M-p o", spawn "dm-bookman")   -- qutebrowser bookmarks/history
        , ("M-p p", spawn "/home/maxim/scripts/passmenu")     -- passmenu
        , ("M-p q", spawn "dm-logout")    -- logout menu

    -- KB_GROUP Useful programs to have a keybinding for launch
        , ("M-<Return>", spawn myTerminal)
        {- , ("M-S-<Return>", spawn myTerminal) -}
        , ("M-b", spawn myBrowser)
        , ("M-M1-h", spawn (myTerminal ++ " -e htop"))

    -- KB_GROUP Copy window
    -- M-c 1..9 - Copy window to a particular workspace using Win+c, release, then <1..9> (aka emacs style)

    -- KB_GROUP Kill windows
        , ("M-S-c", kill1)     -- Kill the currently focused client
        , ("M-S-a", killAll)   -- Kill all windows on current workspace

    -- KB_GROUP Floating windows
        , ("M-f", sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
        , ("M-t", withFocused $ windows . W.sink)  -- Push floating window back to tile
        , ("M-S-t", sinkAll)                       -- Push ALL floating windows to tile

    -- KB_GROUP Windows navigation
        , ("M-m", windows W.focusMaster)  -- Move focus to the master window
        , ("M-j", windows W.focusDown)    -- Move focus to the next windowrenderLoop
        , ("M-k", windows W.focusUp)      -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
        , ("M-<Backspace>", promote)      -- Moves focused window to master, others maintain order
        , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
        , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack

    -- KB_GROUP Layouts
        , ("M-<Tab>", sendMessage NextLayout)           -- Switch to next layout
        , ("C-M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full

    -- KB_GROUP Increase/decrease windows in the master pane or the stack
        , ("M-S-<Up>", sendMessage (IncMasterN 1))      -- Increase # of clients master pane
        , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Decrease # of clients master pane
        , ("M-C-<Up>", increaseLimit)                   -- Increase # of windows
        , ("M-C-<Down>", decreaseLimit)                 -- Decrease # of windows

    -- KB_GROUP Window resizing
        , ("M-h", sendMessage Shrink)                   -- Shrink horiz window width
        , ("M-l", sendMessage Expand)                   -- Expand horiz window width
        , ("M-M1-j", sendMessage MirrorShrink)          -- Shrink vert window width
        , ("M-M1-k", sendMessage MirrorExpand)          -- Expand vert window width

    -- KB_GROUP Sublayouts
    -- This is used to push windows to tabbed sublayouts, or pull them out of it.
        , ("M-C-h", sendMessage $ pullGroup L)
        , ("M-C-l", sendMessage $ pullGroup R)
        , ("M-C-k", sendMessage $ pullGroup U)
        , ("M-C-j", sendMessage $ pullGroup D)
        , ("M-C-m", withFocused (sendMessage . MergeAll))
        -- , ("M-C-u", withFocused (sendMessage . UnMerge))
        , ("M-C-/", withFocused (sendMessage . UnMergeAll))
        , ("M-C-.", onGroup W.focusUp')    -- Switch focus to next tab
        , ("M-C-,", onGroup W.focusDown')  -- Switch focus to prev tab
        ] ++ [("M-c " ++ show i, windows $ copy ws) | (i,ws) <- zip [1..9] myWorkspaces]
-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    {- , swn_fade              = 1.0 -}
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth tall
                                  ||| grid
                                  ||| tabs
{- myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "] -}
{- myWorkspaces = [" dev ", " www ", " edu ", " gfx ", " float ", " doc ", " chat ", " mus ", " --- "] -}
myWorkspaces = [" sub ", " main ", " dev ", " gfx ", " extra1 ", " extra2 ", " extra3 ", " 4 ", " jobs "]
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]


myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x28,0x2c,0x34) -- lowest inactive bg
                  (0x28,0x2c,0x34) -- highest inactive bg
                  (0xc7,0x92,0xea) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0x28,0x2c,0x34) -- active fg

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True


-- Layouts
tall     = renamed [Replace "tall"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ ResizableTall 1 (3/100) (1/2) []
{- magnify  = renamed [Replace "magnify"]
 -            $ smartBorders
 -            $ windowNavigation
 -            $ addTabs shrinkText myTabTheme
 -            $ subLayout [] (smartBorders Simplest)
 -            $ magnifier
 -            $ limitWindows 12
 -            $ mySpacing 8
 -            $ ResizableTall 1 (3/100) (1/2) []
 - monocle  = renamed [Replace "monocle"]
 -           $ smartBorders
 -           $ windowNavigation
 -           $ addTabs shrinkText myTabTheme
 -           $ subLayout [] (smartBorders Simplest)
 -           $ limitWindows 20 Full -}
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
          $ smartBorders
          $ windowNavigation
          $ addTabs shrinkText myTabTheme
          $ subLayout [] (smartBorders Simplest)
          $ limitWindows 12
          $ mySpacing 0
          $ mkToggle (single MIRROR)
          $ Grid (16/10)
{- spirals  = renamed [Replace "spirals"]
 -           $ smartBorders
 -           $ windowNavigation
 -           $ addTabs shrinkText myTabTheme
 -           $ subLayout [] (smartBorders Simplest)
 -           $ mySpacing' 8
 -           $ spiral (6/7) } -}
{- threeCol = renamed [Replace "threeCol"]
 -           $ smartBorders
 -           $ windowNavigation
 -           $ addTabs shrinkText myTabTheme
 -           $ subLayout [] (smartBorders Simplest)
 -           $ limitWindows 7
 -           $ ThreeCol 1 (3/100) (1/2)
 - threeRow = renamed [Replace "threeRow"]
 -           $ smartBorders
 -           $ windowNavigation
 -           $ addTabs shrinkText myTabTheme
 -           $ subLayout [] (smartBorders Simplest)
 -           $ limitWindows 7
 -           -- Mirror takes a layout and rotates it by 90 degrees.
 -           -- So we are applying Mirror to the ThreeCol layout.
 -           $ Mirror
 -           $ ThreeCol 1 (3/100) (1/2) -}
tabs     = renamed [Replace "tabs"]
          -- I cannot add spacing to this layout because it will
          -- add spacing between window and tabs which looks bad.
          $ tabbed shrinkText myTabTheme
{- tallAccordion  = renamed [Replace "tallAccordion"] Accordion
 - wideAccordion  = renamed [Replace "wideAccordion"]
 -            $ Mirror Accordion -}

myTabTheme = def { fontName            = myFont
                 , activeColor         = color15
                 , inactiveColor       = color08
                 , activeBorderColor   = color15
                 , inactiveBorderColor = colorBack
                 , activeTextColor     = colorBack
                 , inactiveTextColor   = color16
                 }

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobarrc"
    xmonad $ ewmh def
        { manageHook         = myManageHook <+> manageDocks
        , handleEventHook    = docksEventHook
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = showWName' myShowWNameTheme myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , focusFollowsMouse   = False
        , logHook = dynamicLogWithPP $ xmobarPP
              -- XMOBAR SETTINGS
              { ppOutput = hPutStrLn xmproc
                -- Current workspace
              , ppCurrent = xmobarColor color06 "" . wrap
                            ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>"
                -- Visible but not current workspace
              , ppVisible = xmobarColor color06 "" . clickable
                -- Hidden workspace
              , ppHidden = xmobarColor color05 "" . wrap
                           ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>" . clickable
                -- Hidden workspaces (no windows)
              , ppHiddenNoWindows = xmobarColor color05 ""  . clickable
                -- Title of active window
              , ppTitle = xmobarColor color16 "" . shorten 60
                -- Separator character
              , ppSep =  "|"
                -- Urgent workspace
              , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
                -- Adding # of windows on current workspace to the bar
              , ppExtras  = [windowCount]
                -- order of things in xmobar
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
              }
        } `additionalKeysP` myKeys
