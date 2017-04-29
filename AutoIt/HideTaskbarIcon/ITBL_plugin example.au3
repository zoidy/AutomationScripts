#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_PlugIn_Funcs=ActivateTab,AddTab,DeleteTab,SetActiveAlt
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GuiConstantsEx.au3>
#include <Constants.au3>

Opt("TrayAutoPause", 0)
Opt("TrayMenuMode", 1)

$h_DLL = PluginOpen("ITBL_plugin.dll")
$hwnd = GUICreate("Test GUI", 200, 100)
$cbox = GUICtrlCreateCheckbox("Hide my taskbar button", 20, 20)
GUISetState()

Sleep(1000)
DeleteTab($hwnd)
Sleep(1000)
AddTab($hwnd)
Sleep(1000)
; make sure window is not active to see this effect
ActivateTab($hwnd)

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $cbox
            Switch BitAND(GUICtrlRead($cbox), $GUI_CHECKED)
                Case $GUI_CHECKED
                    DeleteTab($hwnd)
                Case Else
                    AddTab($hwnd)
            EndSwitch
        Case $GUI_EVENT_MINIMIZE
            ; hide taskbar button
            DeleteTab($hwnd)
        Case $GUI_EVENT_CLOSE
            ExitLoop
    EndSwitch
    $msg = TrayGetMsg()
    Switch $msg
        Case $TRAY_EVENT_PRIMARYDOWN
            GUISetState(@SW_RESTORE)
    EndSwitch
WEnd

PluginClose($h_DLL)