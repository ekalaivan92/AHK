#Requires AutoHotkey >=2.0
#SingleInstance Force

SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir) ; Ensures a consistent starting directory.
DetectHiddenWindows(False)

#include MyKeys_localPathVariables.ahk
#include MyKeys_Core.ahk

<^>!b:: ;Cycle Windows
{
    exeName := WinGetProcessName("A")
    CycleProgram(exeName)
}

<^>!e:: ;Edge
{
    RunProgramOrActivate("msedge.exe", edgeProgramFilePath, IsNewWindowCall())
}

<^>!t:: ;Teams
{
    RunProgramOrActivate("ms-teams.exe", teamsProgramFilePath)
}

<^>!w:: ;Thunderbird
{
    RunProgramOrActivate("thunderbird.exe", thunderbirdProgramFilePath)
}

<^>!f:: ;Terminal
{
    RunProgramWithParameter("wt", "wt", "WindowsTerminal.exe")
}