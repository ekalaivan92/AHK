RunProgram(exePath, exeName:= "", windowType := "Max")
{
    Run(exePath,,windowType, &OutputVarPID)

    ahkEXEName := exeName == "" ? 
                    Format("ahk_pid {1}", OutputVarPID) : 
                    ahkEXEName := Format("ahk_exe {1}", exeName)

    If(WinWait(ahkEXEName, , 3) and not WinActive(ahkEXEName))
    {
        #WinActivateForce
        WinActivate(ahkEXEName)
    }
}

RunProgramOrActivate(exePath, exeName, createNew := False, windowType := "Max")
{
    ahkEXEName := Format("ahk_exe {1}", exeName)

    if(exeName == "" or createNew or not WinExist(ahkEXEName))
        RunProgram(exePath, ahkEXEName, windowType)
    else
        CycleProgram(exeName)
}

;It is difficult to find the running program with the parameter
;so we can't find existing running program for this call
;Because of it this call will result in always running new program
RunProgramWithParameter(exePath, parameter, windowType := "Max")
{
    pathToExecute := Format('{1} "{2}"', exePath, parameter)
    RunProgram(pathToExecute, "", windowType)
}

;It is difficult to find the running program with the parameter
;so we can't find existing running program for this call
;Because of it this call will result in always running new program
RunSelected(programFilePath, windowType := "Max")
{
    If WinActive("ahk_class keypirinha_wndcls_run")
    {
        Send("^{Enter}")
        Sleep(100)
        Send("{Up 9}")
        Sleep(100)
        Send("{Down 7}")
        Sleep(100)
        Send("{Enter}")
        Sleep(100)
        RunProgramWithParameter(programFilePath, A_Clipboard, windowType)
    }
    Else If WinActive("ahk_class CabinetWClass")
    {
        Send("^+c")
        Sleep(100)
        A_Clipboard := StrReplace(A_Clipboard, '"')
        RunProgramWithParameter(programFilePath, A_Clipboard, windowType)
    }
    else
        RunProgram(programFilePath, "", windowType)
}

CycleProgram(exeName)
{
    ahkEXEName := Format("ahk_exe {1}", exeName)

    If WinActive(ahkEXEName)
    { 
        #WinActivateForce
        WinActivateBottom(ahkEXEName)
    }

    #WinActivateForce
    WinActivate(ahkEXEName)
}

DoInputHook(options, matchList, defaultKey, endKeys := "{enter}.{esc}{tab}")
{
    ih := InputHook(options, endKeys, matchList)

    ih.start()
    ih.wait()

    if(ih.EndReason == "Match")
        return ih.Input
    else
        return defaultKey
}

IsNewWindowCall(newWindowKey := "n")
{
    pressedKey := DoInputHook("T1 L1", newWindowKey, "")
    return pressedKey == newWindowKey
}