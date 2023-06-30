#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, on

#include MyKeys_localPathVariables.ahk

:*:,dbm:: ;database migration file name
    FormatTime, time, A_now, yyyyMMddHHmm
    send % "V" . time . "__.sql"
    send, {left 4}
return

<^>!c:: ;C--VSCode | A--Edit AHK files | H--Edit Host file | S--Edit SSH Config File | D--DrawIO
    Input, SingleKey, T1 L1, {enter}.{esc}{tab}, a,d,h,e,s

    if(ErrorLevel == "Timeout" or ErrorLevel != "match")
    {
        RunProgramOrActivate("ahk_exe Code.exe", vsCodeProgramFilePath)
    }   
    else if(SingleKey == "a")
    {
        RunProgramWithParameter(vsCodeProgramFilePath, myKeysCoreFilePath)
        RunProgramWithParameter(vsCodeProgramFilePath, myAllDesktopKeysFilePath)
        RunProgramWithParameter(vsCodeProgramFilePath, myCurrentDesktopKeysFilePath)
        RunProgramWithParameter(vsCodeProgramFilePath, myLocalSystemVariablesFilePath)
    }
    else if (SingleKey == "h")
    {
        RunProgramWithParameter(vsCodeProgramFilePath, hostsFilepath)
    }
    else if(SingleKey == "e")
    {
        RunProgramWithParameter(vsCodeProgramFilePath, myExcalidrawFilePath)
    }
    else if (SingleKey == "s")
    {
        RunProgramWithParameter(vsCodeProgramFilePath, mySSHConfigFilePath)
    }
    else if (SingleKey == "d")
    {
        RunProgramWithParameter(vsCodeProgramFilePath, myDrawIOFilePath)
    }
return

<^>!d:: ;DBEaver
    RunProgramOrActivate("ahk_exe dbeaver.exe", dbeaverProgramFilePath)
return

<^>!g:: ;(1-9)--Localhost URL | w--whatsapp
    Input, SingleKey, T1 L1, {enter}.{esc}{tab}, 0,1,2,3,4,5,6,7,8,9,w,h

    if(ErrorLevel == "Timeout" or ErrorLevel != "match")
    {
        SingleKey := "0"
    }   

    endpoint := ""
    if(SingleKey == "w")
    {
        endpoint := "https://web.whatsapp.com/"
    }
    else if(SingleKey == "h")
    {
        endpoint := "http://localhost:5000/health"
    }
    else 
    {
        endpoint := % "http://localhost:500" . SingleKey . "/"
    }

    RunProgramWithParameter(edgeProgramFilePath, endpoint)
return

<^>!h:: ;Help Window
    Run, %ComSpec% /c "lprun6 "D:\WorkDir\Projects\00 Exp\Apps\AHKHelpWindow.linq"",,Min
return

<^>!i:: ;Initalize Startup Programs
    RunProgramOrActivate("ahk_exe thunderbird.exe", thunderbirdProgramFilePath)
    RunProgramOrActivate("ahk_exe sublime_merge.exe", sublimeMergeProgramFilePath)
    RunProgramOrActivate("ahk_exe dbeaver.exe", dbeaverProgramFilePath)
    RunProgramOrActivate("ahk_exe Notion.exe", notionProgramFilePath)
return

<^>!j:: ;Jmeeter
    RunProgramOrActivate("ahk_exe javaw.exe", jmeeterProgramFilePath)
return

<^>!k:: ;k--notion | l--work log
    Input, SingleKey, T1 L1, {enter}.{esc}{tab}, k,l

    if(ErrorLevel == "Timeout" or ErrorLevel != "match")
    {
        SingleKey := "l"
    }

    if(SingleKey == "k")
    {
        RunProgramOrActivate("ahk_exe Notion.exe", notionProgramFilePath)
    }
    else  if(SingleKey == "l")
    {
       Run, %NotionWorkLogTodayPage%
    }

    TrayTip "Done", "Opening notion"
return

<^>!l:: ;Linqpad 6
    RunProgramOrActivate("ahk_exe LINQPad6.exe",  linqPad6ProgramFilePath)
return

<^>!m:: ;Sublime Merge
    RunProgramOrActivate("ahk_exe sublime_merge.exe", sublimeMergeProgramFilePath)
return

<^>!n:: ;Sublime Text
    RunProgramOrActivate("ahk_exe sublime_text.exe", sublimeTextProgramFilePath)
return

<^>!o:: ;Obsidian
    RunProgramOrActivate("ahk_exe Obsidian.exe", obsidianProgramFilePath)
return

<^>!p:: ;Postman
    RunProgramOrActivate("ahk_exe Postman.exe", postmanProgramFilePath)
return

<^>!r:: ;Rebuild My AHK Keys
    RunProgram(myAllDesktopKeysFilePath, "-")
    RunProgram(myCurrentDesktopKeysFilePath, "-")
return

<^>!u:: ;WSL Ubuntu
    RunProgramOrActivate("ahk_exe WindowsTerminal.exe", wslUbuntuProgramFilePath)
return

#1:: ;Open With VSCode
    RunFromKeyPrinhaProgram(vsCodeProgramFilePath)
return

#2:: ;Open With VS22
    RunFromKeyPrinhaProgram(visualStudio22ProgramFilePath)
return

#9:: ;Open With VS19
    RunFromKeyPrinhaProgram(visualStudio19ProgramFilePath)
return

#7:: ;Open With VS17
    RunFromKeyPrinhaProgram(visualStudio17ProgramFilePath)
return

#-:: ;Minimize Current Window
    WinMinimize, A
return

<^>!x:: ;Open Browser Link in Notion
    ; Open link in clipboard (assumed to be a notion link) in notion instead
    ; of in the browser
    #if WinActive("ahk_exe msedge.exe")
    Send, {F4}
    Send, ^c
    sleep 50
    Clipboard := StrReplace(Clipboard, "https", "notion", 1)
    Run, %Clipboard%
    #ifWinActive
return

#include MyKeys_Core.ahk