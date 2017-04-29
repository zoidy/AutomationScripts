;Hides the icon in the taskbar of the specified program. Can use a window spy tool like Au3Info
;to get the class name.
;
;Tested using AutoIT 3.3.6.1
;Requires the included ITBL_plugin
;
;Source: unknown
;This version released using the MIT license
;github: @zoidy

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_PlugIn_Funcs=ActivateTab,AddTab,DeleteTab,SetActiveAlt
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****



$h_DLL = PluginOpen("ITBL_plugin.dll")

While 1
	$hwnd = WinGetHandle("[CLASS:ProcessHacker]")
	$hwnd2 = WinGetHandle("[CLASS:WindowsForms10.Window.8.app.0.1983833_r11_ad1]") ;qperfmon
	DeleteTab($hwnd)
	DeleteTab($hwnd2)
	
	Sleep(1500)
WEnd

PluginClose($h_DLL)

;Function for getting HWND from PID
Func _GetHwndFromPID($PID)
	$hWnd = 0
	$winlist = WinList()
	Do
		For $i = 1 To $winlist[0][0]
			If $winlist[$i][0] <> "" Then
				$iPID2 = WinGetProcess($winlist[$i][1])
				If $iPID2 = $PID Then
					$hWnd = $winlist[$i][1]
					ExitLoop
				EndIf
			EndIf
		Next
	Until $hWnd <> 0
	Return $hWnd
EndFunc;==>_GetHwndFromPID

; Returns an array of all Windows associated with a given process
Func WinHandFromPID($pid, $winTitle = "", $timeout = 8)
    Local $secs = TimerInit()
    Do
        $wins = WinList($winTitle)
        For $i = UBound($wins) - 1 To 1 Step -1
            If (WinGetProcess($wins[$i][1]) <> $pid) Or (BitAND(WinGetState($wins[$i][1]), 2) = 0) Then _ArrayDelete($wins, $i)
        Next
        $wins[0][0] = UBound($wins) - 1
        If $wins[0][0] Then Return SetError(0, 0, $wins)
        Sleep(1000)
    Until TimerDiff($secs) >= $timeout * 1000
    Return SetError(1, 0, $wins)
EndFunc   ;==>WinHandFromPID
