#include <file.au3>
#include <MsgBoxConstants.au3>
Dim $list
$Path = @ScriptDir & "\test\"
ConsoleWrite($Path)
$list = _FileListToArray($Path,"*.hwp",1)
For $i = 1 to $list[0]
Run('explorer.exe ' & $Path&'' & $list[$i])
Local $myString = StringTrimRight($list[$i],4) & '.hwp [' & $Path  & '\] - ÇÑ±Û'
WinWaitActive($myString)
WinClose($myString)
Next