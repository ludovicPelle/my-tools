import XMonad
import XMonad.Config.Gnome
-- for WorkSpace cycle
import XMonad.Actions.CycleWS
-- for dynamic tiling
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Named
import XMonad.Layout.PerWorkspace

-- for manage layout switch
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
--for mapping object(keysMap for example)
import qualified Data.Map        as M
-- object for stackSet
import qualified XMonad.StackSet as W
------------------------------------------------------------------------
-- Simple stuff

-- The preferred terminal program
myTerminal      = "gnome-terminal"

-- The default is mod1Mask ("left alt"). mod3Mask is ("right alt")
-- "windows key" is usually mod4Mask.
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
myWorkspaces    = ["Web", "Dev", "Test", "Graphic", "Community", "Bdd"]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--  spiral (6/7) |||
--
myLayout = avoidStruts (smartBorders tiled ||| spaced ||| smartBorders (Mirror tiled) ||| noBorders Full)
  where
     spaced = named "Spacing" $ spacing 6 $ Tall 1 (3/100) (1/2)
     tiled  = named "Tiled" $ ResizableTall 1 (2/100) (1/2) []

     -- default tiling algorithm partitions the screen into two panes
     --tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane: nmaster = 1
     -- Default proportion of screen occupied by master pane: ratio = 1/2
     -- Percent of screen to increment by when resizing panes: delta = 3/100
     --
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys  conf@(XConfig {XMonad.modMask = modm}) = M.fromList
    --launch a terminal
    [ ((controlMask .|. modm , xK_t), spawn $ XMonad.terminal conf)
    -- close focused window
    , ((modm,               xK_c     ), kill)
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
     -- Rotate through the available layout algorithms
    , ((modm,               xK_s     ), sendMessage NextLayout)

    -- Move focus to the next/previous/master window
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp)
    , ((modm,               xK_m     ), windows W.focusMaster)

    -- Swap the focused window and the master/next/previous window
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)


    -- cycle workspaces
    , ((modm,               xK_Right ),  nextWS)
    , ((modm,               xK_Left  ),  prevWS)
    , ((modm .|. shiftMask, xK_Left  ),  shiftToPrev)
    , ((modm .|. shiftMask, xK_Right ),  shiftToNext)

    -- Quit or restart xmonad
    -- , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm              , xK_q     ), spawn "xmonad --recompile && xmonad --restart")

    -- Shrink/Expand the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modm .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    , ((modm, xK_space), spawn "dmenu_run -fn \"-*-terminus-medium-r-normal-*-12-*-*-*-*-*-*-*\" -nb \"#131313\" -nf \"#888888\" -sb \"#2A2A2A\" -sf \"#3579A8\"")
    ]
-- application hook
-- > xprop | grep WM_CLASS
myManageHook = composeAll [
    (className =? "Pidgin" <&&> (title =? "Pidgin" <||> title =? "Accounts")) --> doCenterFloat
  , (className =? "Pidgin") --> doShift "3"
  , (className =? "Gnome-panel" <&&> title =? "Run Application") --> doCenterFloat
  , (className =? "Gcr-prompter") --> doCenterFloat
  , isFullscreen --> doFullFloat
  , className =? "Gnome-terminal" --> doShift "Dev"
  , className =? "Chromium" --> doShift "Bdd"
  , className =? "Gimp" --> doShift "Graphic"
  , className =? "Dia-normal" --> doShift "Graphic"
  , className =? "Iceweasel" --> doShift "Test"
  , className =? "Google-chrome" --> doShift "Web"
  , className =? "Icedove" --> doShift "Community"
   ]
main = xmonad $ gnomeConfig {
  modMask            = mod4Mask
  , workspaces         = myWorkspaces
  , borderWidth      = 1
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#3300ff"
  , manageHook       = myManageHook <+> manageHook gnomeConfig
  , keys               = myKeys
  , layoutHook  = smartBorders (layoutHook gnomeConfig)
  --, layoutHook = myLayout ||| layoutHook gnomeConfig
  }
