#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
Example()

Func Example()
	GUICreate("jwh", 200, 100)
	Local $idInput = GUICtrlCreateInput("",10,35,100,30)
	Local $idBtn = GUICtrlCreateButton("execute", 120, 35, 50)
	GUISetState(@SW_SHOW)

	Local $idMsg ,$text


	Do
		$idMsg = GUIGetMsg()
		If $idMsg = $idBtn Then
			$text = GUICtrlRead($idInput)
			Run("notepad.exe")
			WinWaitActive("제목 없음 - 메모장")
			Send(GUICtrlRead($idInput))
			WinClose("제목 없음 - 메모장")
			WinWaitActive("메모장","저장")
			Send("$s")
			WinWaitActive("다른 이름으로 저장","저장")
			Send("firstTxt")
			Send("!s")
		EndIf
	Until $idMsg  = $GUI_EVENT_CLOSE
EndFunc	;