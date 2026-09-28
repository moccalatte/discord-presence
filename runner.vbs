Set WinScriptHost = CreateObject("WScript.Shell")
WinScriptHost.Run "pythonw.exe terminal_rpc.py", 0, False
Set WinScriptHost = Nothing
