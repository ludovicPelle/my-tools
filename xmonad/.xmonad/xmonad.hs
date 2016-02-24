import XMonad
import System.IO
import XMonad.Actions.CycleWS
import XMonad.Util.EZConfig
import XMonad.Config.Kde
import XMonad.Hooks.SetWMName
import XMonad.Util.WindowProperties (getProp32s)
import qualified XMonad.StackSet as W -- to shift and float windows

import Data.Monoid
import System.Exit
import qualified Data.Map        as M
import Graphics.X11.Xlib
-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Named
import XMonad.Layout.PerWorkspace
import Data.Ratio((%))
-- hooks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks

-- independent workspace on monitor
-- import XMonad.Layout.IndependentScreens
-- ------------------------------------------------------------------------
-- Simple stuff
-- The preferred terminal program
myTerminal      = "Konsole"

-- The default is mod1Mask ("left alt"). mod3Mask is ("right alt")
-- "windows key" is usually mod4Mask.
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
{-myWorkspaces    = withScreens 2 ["Web", "Dev", "Test", "backtask", "Perso", "Gimp", "Files", "Community"]-}
myWorkspaces    = ["Web", "Dev", "Test", "backtask", "Perso", "Gimp", "Files", "Community"]

-- Width of the window border in pixels.
myBorderWidth   = 2

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#2A2A2A"
myFocusedBorderColor = "#55FF55"

-- show current layout
curLayout :: X String
curLayout = gets windowset >>= return . description . W.layout . W.workspace . W.current

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

 ------------------------------------------------------------------------
 -- Key bindings. Add, modify or remove key bindings here.

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
     -- launch a terminal
     [ ((modm .|. shiftMask, xK_space), spawn "konsole")
     -- launchers
 --     , ((modm, xK_p), spawn "dmenu_run -fn \"-*-terminus-medium-r-normal-*-12-*-*-*-*-*-*-*\" -nb \"#131313\" -nf \"#888888\" -sb \"#2A2A2A\" -sf \"#3579A8\"")
 --     , ((modm,               xK_p     ), spawn "dmenu_run -i -b -p '>' -nb '#242424' -nf '#f6f3e8' -sb '#242424' -sf '#e5786d' -fn '-*-terminus-*-r-normal-*-*-160-*-*-*-*-iso8859-*'")
     --, ((modm,               xK_p     ), spawn "gmrun")
     --, ((modm .|. shiftMask, xK_p     ), spawn "kupfer")

     -- launch apps
     --, ((modm,               xK_a     ), spawn "nautilus ~/")
     --, ((modm .|. shiftMask, xK_a     ), spawn "nautilus --browser ~/")
     --, ((modm .|. shiftMask, xK_f     ), spawn "firefox")
     --, ((modm .|. shiftMask, xK_t     ), spawn "thunderbird")
     --, ((modm,               xK_Print ), spawn "scrot -q 90 ~/Images/Screenshots/%F-%T.png")

     -- show layout
     , ((modm,                 xK_i   ), (curLayout >>= \d->spawn $"notify-send -u low -t 1000 Xmonad \""++d++"\""))

     -- close focused window
     , ((modm,               xK_c     ), kill)

      -- Rotate through the available layout algorithms
     , ((modm,               xK_s     ), sendMessage NextLayout)
     --  Reset the layouts on the current workspace to default
     , ((modm .|. shiftMask, xK_r ), setLayout $ XMonad.layoutHook conf)
     -- Push window back into tiling
     , ((modm,               xK_t     ), withFocused $ windows . W.sink)

     -- Resize viewed windows to the correct size
     , ((modm,               xK_n     ), refresh)

     -- Move focus to the next/previous/master window
     , ((modm,               xK_Tab   ), windows W.focusDown)
     , ((modm,               xK_j     ), windows W.focusDown)
     , ((modm,               xK_k     ), windows W.focusUp)
     , ((modm,               xK_m     ), windows W.focusMaster)

     -- Swap the focused window and the master/next/previous window
     , ((modm,               xK_Return), windows W.swapMaster)
     , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)
     , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)

     -- Shrink/Expand the master area
     , ((modm,               xK_h     ), sendMessage Shrink)
     , ((modm,               xK_l     ), sendMessage Expand)
     , ((modm .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
     , ((modm .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

     -- Increment/Deincrement the number of windows in the master area
     , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
     , ((modm              , xK_semicolon), sendMessage (IncMasterN (-1)))

     -- cycle workspaces
     , ((modm,               xK_Right ),  nextWS)
     , ((modm,               xK_Left  ),  prevWS)
     , ((modm .|. shiftMask, xK_Left  ),  shiftToPrev)
     , ((modm .|. shiftMask, xK_Right ),  shiftToNext)

     -- Toggle the status bar gap
     -- Use this binding with avoidStruts from Hooks.ManageDocks.
     -- See also the statusBar function from Hooks.DynamicLog.
     , ((modm              , xK_b     ), sendMessage ToggleStruts)

     -- Quit or restart xmonad
     -- , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
     , ((modm              , xK_q     ), spawn "xmonad --recompile && xmonad --restart")
     ]
     -- ++
     -- mod-[1..9], Switch to workspace N
     -- mod-shift-[1..9], Move client to workspace N
     -- [((m .|. modm, k), windows $ f i)
     --    | (i, k) <- zip (XMonad.workspaces conf) [xK_F1 .. xK_F9]
     --    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
      ++
     -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
     -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
     [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
         | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
         , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myFocusFollowsMouse::Bool
myFocusFollowsMouse = True


main = xmonad $ kde4Config
     {
       borderWidth        = myBorderWidth
     , workspaces         = myWorkspaces
     , normalBorderColor  = myNormalBorderColor
     , focusedBorderColor = myFocusedBorderColor
     , modMask            = myModMask
     , keys               = myKeys

     -- add manage hooks while still ignoring panels and using default manageHooks
     , manageHook = manageDocks <+> myManageHook <+> manageHook kde4Config

     -- add a fullscreen tabbed layout that does not avoid covering
     -- up desktop panels before the desktop layouts
     --, layoutHook = myLayout
     , layoutHook = myLayout ||| layoutHook kde4Config
 --     , logHook = myLogHook >> logHook kde4Config
 --     , handleEventHook    = mappend myEventHook (handleEventHook desktopConfig)
     -- , startupHook        = myStartupHook >> startupHook kde4Config
     , startupHook = startupHook kde4Config >> setWMName "LG3D"
     , focusFollowsMouse  = myFocusFollowsMouse
     }

  where

    myManageHook = composeAll . concat $
      [ [ className   =? c --> doFloat           | c <- myFloats]
      , [ title       =? t --> doFloat           | t <- myOtherFloats]
      , [ className   =? w --> doF (W.shift "Web") | w <- webApps]
      , [ className   =? o --> doF (W.shift "Community") | o <- communityApps]
      , [ ((className =? "krunner") >>= return . not --> manageHook kde4Config) <+> (kdeOverride --> doFloat)]
      ]
      {-myManageHook = composeAll . concat $-}
      {-[ [ className =? c --> doFloat | c <- myFloats]-}
      {-, [ ((className =? "krunner") >>= return . not --> manageHook kde4Config) <+> (kdeOverride --> doFloat)]-}
      {-, [ title =? t --> doFloat | t <- myOtherFloats]-}
      {-, [ className =? "Chrome - Google Chrome" --> doShift "Web" ]-}
      {-]-}

    myFloats = ["Gimp","gimp-2.8","Thunderbird", "google-chrome", "Google-chrome-stable", "Firefox", "chrome"]
    myOtherFloats = []
    webApps = ["google-chrome", "Google-chrome-stable"]
    communityApps = ["Thunderbird"]

kdeOverride :: Query Bool
kdeOverride = ask >>= \w -> liftX $ do
  override <- getAtom "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
  wt <- getProp32s "_NET_WM_WINDOW_TYPE" w
  return $ maybe False (elem $ fromIntegral override) wt
