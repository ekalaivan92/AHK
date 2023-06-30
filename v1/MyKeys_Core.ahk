RunProgramOrActivate(exeName, exePath, windowType:="max")
{
    WinGet, currProcessPath, ProcessPath, A
    
    if (currProcessPath = exePath)
    {
        CycleProgram(exeName)
    }
    else
    {
        exist := WinExist(exeName)

        if %exist%
        {
            #WinActivateForce
            WinActivate, %exeName%
        }
        else
        {
            RunProgram(exePath, windowType)
        }    
    }
}

RunProgram(exePath, windowType:="max")
{
    if (windowType = "-")
        Run %exePath%
    else
        Run, %exePath%,, max
}

RunProgramWithParameter(exePath, parameter)
{
    Run %exePath% %parameter%
}

RunFromKeyPrinhaProgram(programFilePath)
{
    If WinActive("ahk_class keypirinha_wndcls_run")
    {
        Send ^{Enter}
        Sleep, 100
        Send {Up 9}
        Sleep, 100
        Send {Down 7}
        Sleep, 100
        Send {Enter}
        Sleep, 100
        filePath = "%Clipboard%"
        RunProgramWithParameter(programFilePath, filePath)
    }
    Else If WinActive("ahk_exe Explorer.EXE")
    {
        Send ^+c
        Sleep, 100
        RunProgramWithParameter(programFilePath, Clipboard)
    }
    else
    {
        RunProgram(programFilePath)
    }
}

CycleProgram(exeName)
{
    IfWinActive, ahk_exe %exeName%
    {   
        #WinActivateForce
        WinActivateBottom, ahk_exe %exeName%
    }
    else
    {
        #WinActivateForce
        WinActivate, ahk_exe %exeName%
        MsgBox, wrong state
    }
}