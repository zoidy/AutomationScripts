/*
http://www.autohotkey.com/board/topic/83159-solved-removing-windows-taskbar-icons/
  Example: Temporarily remove the active window from the taskbar by using COM.

  Methods in ITaskbarList's VTable:
    IUnknown:
      0 QueryInterface  -- use ComObjQuery instead
      1 AddRef          -- use ObjAddRef instead
      2 Release         -- use ObjRelease instead
    ITaskbarList:
      3 HrInit
      4 AddTab
      5 DeleteTab
      6 ActivateTab
      7 SetActiveAlt
	  
Tested using
	AutoHotkey 1.1.22.6
	Outlook 2010 on Windows 7

Code is released using the MIT license
github: @zoidy
*/

;http://ahkscript.org/docs/commands/OnExit.htm
#Persistent
OnExit, endScript


IID_ITaskbarList  := "{56FDF342-FD6D-11d0-958A-006097C9A090}"
CLSID_TaskbarList := "{56FDF344-FD6D-11d0-958A-006097C9A090}"

; Create the TaskbarList object and store its address in tbl.
tbl := ComObjCreate(CLSID_TaskbarList, IID_ITaskbarList)

DllCall(vtable(tbl,3), "ptr", tbl)                     ; tbl.HrInit()

;regexp
SetTitleMatchMode, RegEx
activeHwnd:=0
while true
{
	activeHwnd := WinExist(".+ - .+ - Microsoft Outlook")
	Sleep 2400
	if activeHwnd!=0
	{
		DllCall(vtable(tbl,5), "ptr", tbl, "ptr", activeHwnd)  ; tbl.DeleteTab(activeHwnd)
		activeHwnd:=0
	}
}


return

endScript:
	;Sleep 3000
	DllCall(vtable(tbl,4), "ptr", tbl, "ptr", activeHwnd)  ; tbl.AddTab(activeHwnd)

	; Non-dispatch objects must always be manually freed.
	ObjRelease(tbl)

	vtable(ptr, n) {
		; NumGet(ptr+0) returns the address of the object's virtual function
		; table (vtable for short). The remainder of the expression retrieves
		; the address of the nth function's address from the vtable.
		return NumGet(NumGet(ptr+0), n*A_PtrSize)
	}
	ExitApp
