RunProgramOrActivate(exeName, exePath, createNew := False, windowType := "Max")
{
    ahkEXEName := Format("ahk_exe {1}", exeName)

    if(createNew == True or WinExist(ahkEXEName) == False)
        RunProgram(exePath, windowType, ahkEXEName)
    else 
        CycleProgram(exeName)
}

RunProgram(exePath, windowType := "Max", ahkEXEName:= "")
{
    Run(exePath,,windowType, &OutputVarPID)

    If(ahkEXEName != "" and WinWait(ahkEXEName, , , 0) and not WinActive(ahkEXEName))
    {
        #WinActivateForce
        WinActivate(ahkEXEName)
    }
}

RunProgramWithParameter(exePath, parameter, windowType := "Max")
{
    pathToExecute := Format('{1} "{2}"', exePath, parameter)
    RunProgram(pathToExecute, windowType)
}

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
    Else If WinActive("ahk_exe Explorer.EXE")
    {
        Send("^+c")
        Sleep(100)
        A_Clipboard := StrReplace(A_Clipboard, '"')
        RunProgramWithParameter(programFilePath, A_Clipboard, windowType)
    }
    else
    {
        RunProgram(programFilePath, windowType)
    }
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