--------------------------------------------------------------------------

-- MY XMONAD CONFIG --

--------------------------------------------------------------------------
-- Modules --

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Layout.ToggleLayouts
import qualified XMonad.StackSet as W
import XMonad.Util.SpawnOnce (spawnOnce)
import qualified Data.Map        as M
import XMonad.Actions.CycleWS (WSType (Not), moveTo, emptyWS, nextWS, prevWS, shiftToNext, shiftToPrev, toggleWS)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.ThreeColumns (ThreeCol(ThreeColMid))
import XMonad.Actions.CopyWindow (copyToAll, killAllOtherCopies)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.VoidBorders (normalBorders,voidBorders)
import XMonad.Hooks.ManageHelpers (doRectFloat)
import XMonad.Layout.Spacing (spacingWithEdge)
import XMonad.Layout.LimitWindows (limitWindows)

--------------------------------------------------------------------------
-- Basic Settings --

myTerminal      = "alacritty"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
myClickJustFocuses :: Bool
myClickJustFocuses = False
myBorderWidth   = 2
myModMask       = mod4Mask
myWorkspaces    = ["www","ter","cht","mus","oth"]
myNormalBorderColor = "#5D2D2D"
myFocusedBorderColor = "#B44740"

--------------------------------------------------------------------------
-- [ User Defined Functions ]

-- (Centre floating window and toggle) --

centreRect = W.RationalRect 0.25 0.25 0.5 0.5

hasBorder :: Query Bool
hasBorder = ask >>= \w -> liftX $ do
  wa <- withDisplay $ \d -> io $ getWindowAttributes d w
  return $ wa_border_width wa /= 0

floatOrNot f n = withFocused $ \windowId -> do
    floats <- gets (W.floating . windowset)
    hasBorders <- runQuery hasBorder windowId
    if not (windowId `M.member` floats) && hasBorders
        then n
        else f

centreFloat win = do
    (_, W.RationalRect x y w h) <- floatLocation win
    windows $ W.float win (W.RationalRect ((1 - w) / 2) ((1 - h) / 2) w h)
    return ()

centreFloat' w = windows $ W.float w centreRect

standardSize win = do
    (_, W.RationalRect x y w h) <- floatLocation win
    windows $ W.float win (W.RationalRect x y 0.5 0.5)
    return ()

toggleFloat = floatOrNot (withFocused $ windows . W.sink) (withFocused centreFloat')

-- (Toggle fullscreen if the currently focused widow is not floating) --

toggleFullScreenIfNotFloating :: X ()
toggleFullScreenIfNotFloating = withFocused $ \windowId -> do
    floats <- gets (W.floating . windowset)
    if not (windowId `M.member` floats)
        then sendMessage ToggleLayout 
        else return ()  -- Empty else case
 
--------------------------------------------------------------------------
-- Key bindings --

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    ,  ((0                     , xF86XK_AudioLowerVolume), spawn "audioctrl adec")
    
    , ((modm, xK_s ), windows copyToAll) 

    , ((modm .|. shiftMask, xK_s ),  killAllOtherCopies) 

    ,  ((0                     , xF86XK_AudioRaiseVolume), spawn "audioctrl ainc")

    , ((modm,                    xK_f), toggleFullScreenIfNotFloating )

    ,  ((0                     , xF86XK_AudioMute), spawn "audioctrl atogg")

    , ((0, xF86XK_MonBrightnessUp), spawn "brightnessctrl binc")
   
    , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctrl bdec")

    , ((0,                   xK_Print    ), spawn "flameshot screen")

    , ((modm,                xK_Print    ), spawn "flameshot launcher")

    , ((modm,                xK_p    ), spawn "launcher")

    , ((modm,                xK_i    ), spawn "quickinfo")

    , ((modm .|. shiftMask,  xK_l    ), spawn "alacritty -e lfub")

    , ((modm,                xK_b    ), spawn "polybar-msg cmd toggle")

    , ((modm,                xK_q     ), kill)

    , ((modm .|. shiftMask,  xK_q     ), spawn "powermenu")

    , ((modm,               xK_space ), sendMessage NextLayout)

    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    , ((modm,               xK_n     ), refresh)

    , ((modm,               xK_Tab   ), windows W.focusDown)

    , ((modm,               xK_j     ), windows W.focusDown)

    , ((modm,               xK_k     ), windows W.focusUp  )

    , ((modm .|. shiftMask, xK_Tab     ), windows W.focusUp  )

    , ((modm,               xK_m     ), windows W.focusMaster  )

    , ((modm,               xK_Return), windows W.swapMaster)

    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    , ((modm,               xK_h     ), sendMessage Shrink)

    , ((modm,               xK_l     ), sendMessage Expand)

    , ((modm,               xK_Up), nextWS)

    , ((modm,               xK_Right), moveTo Next (Not emptyWS))

    , ((modm,               xK_Left), moveTo Prev (Not emptyWS))

    , ((modm,               xK_Down), prevWS)

    , ((modm .|. shiftMask, xK_Up),  shiftToNext >> nextWS)

    , ((modm .|. shiftMask, xK_Down),    shiftToPrev >> prevWS)

    , ((modm,               xK_a), toggleWS)

    , ((modm,               xK_t ), toggleFloat)

    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")

    ]
    ++


    [((m .|. modm, k), do
        windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


--------------------------------------------------------------------------
-- Mouse bindings -- 

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w))

    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

--------------------------------------------------------------------------
-- Layouts --

myLayout = avoidStruts 
           $ toggleLayouts ( voidBorders Full ) 
           $ spacingWithEdge 5
           $ normalBorders 
           $ tiled ||| 
             Mirror ( limitWindows 4 $ Tall 1 (3/100) (1/2)) ||| 
             Full |||
             ThreeColMid 1 (3/100) (1/2)
  where
     tiled   = limitWindows 4 
               $ Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

--------------------------------------------------------------------------
-- Window rules --

myManageHook = composeAll
    [ className =? "Gimp"           --> doFloat
    , className =? "Brave"      --> doRectFloat(W.RationalRect 0.25 0.25 0.5 0.5)  ]

--------------------------------------------------------------------------
-- Event handling --

myEventHook = mempty

--------------------------------------------------------------------------
-- Status bars and logging --

myLogHook = return ()

--------------------------------------------------------------------------
-- Startup hook --

myStartupHook = do
	spawnOnce "startupscript&"

--------------------------------------------------------------------------
-- Main --

main = xmonad  $  ewmhFullscreen $ ewmh $ docks defaults

defaults = def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
	
--------------------------------------------------------------------------
-- END --
