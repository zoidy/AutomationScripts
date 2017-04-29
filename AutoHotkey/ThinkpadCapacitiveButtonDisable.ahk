;This script "disables" the capacitive button on Thinkpads (tested on Thinkpad X1 Yoga 2016)
;The code below is based on https://autohotkey.com/board/topic/103174-dual-function-control-key/
;
;Tested using AutoHotkey 1.1.24
;
;Code is released using the MIT license
;github: @zoidy

#InstallKeybdHook
;KeyHistory

LWin_keydown_time:=-1

;captures the Fn key on Thinkpad. The key is still seen by the system 
;even though this hotkey still works.
;The scancode can be found by uncommenting KeyHistory, to open the main
;script window, and opening the keyboard history and script info menu item.
;SC163::
;    Msgbox, blah
;    return


$~*LWin::
    ;start the timer on left win key down (this is the key that is mapped to the button)
    LWin_keydown_time:=A_TickCount
    return
    
$LWin up::
    LWin_downup_elapsed:=A_TickCount-LWin_keydown_time
    last_key:=A_PriorKey
    
    ;handle Win+<key> combinations.
    if !instr(A_PriorKey, "LWin")
        return
    
    ;if the time between key down and key up less than this value, cancel the key up event
    ;may need to tune this depending on the system. Some ghost presses of the capacitive button
    ;might still sneak through but they are very few and far between
    if (LWin_downup_elapsed<45)
    {
        ;Msgbox, LWin DownUp Elapsed = %LWin_downup_elapsed%. LWin keypress canceled
        return
    }
    else
        Send {RWin}
    return
