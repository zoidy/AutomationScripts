; Run Notepad++ in multi instance mode without saving the session. Used for launching
; a separate instance from a launcher without interfering with instances opened via double
; clicking text files in explorer. Change the window title to temporarily
; differentiate it from other instances.
;
;Relased under the MIT licence
;github: @zoidy

Local $iPID = Run("c:\apps\Notepad++\notepad++.exe -nosession -multiInst")
WinWaitActive("new  0 - Notepad++")
WinSetTitle("new  0 - Notepad++", "", "New Notepad Title - AutoIt")
