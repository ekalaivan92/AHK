#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, off

#include MyKeys_localPathVariables.ahk

<^>!b:: ;Cycle Windows
    WinGet, exevar, ProcessName, A
    CycleProgram(exevar)
return

<^>!e:: ;Edge
    RunProgramOrActivate("ahk_exe msedge.exe", edgeProgramFilePath)
return

<^>!t:: ;Teams
    RunProgramOrActivate("ahk_exe teams.exe", teamsProgramFilePath)
return

<^>!w:: ;Thunderbird
    RunProgramOrActivate("ahk_exe thunderbird.exe", thunderbirdProgramFilePath)
return

<^>!f:: ;Terminal
    RunProgramWithParameter("wt", "")
return

#include MyKeys_Core.ahk