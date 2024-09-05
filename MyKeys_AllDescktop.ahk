#Requires AutoHotkey >=2.0
#SingleInstance Force

SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir) ; Ensures a consistent starting directory.
DetectHiddenWindows(True)

#include MyKeys_localPathVariables.ahk
#include MyKeys_Core.ahk 

:*:,mig:: ;database migration file name
{
    item := FormatTime(, "yyyyMMddHHmm")
    send("V" . item . "__.sql")
    send("{left 4}")
}

:*:,mail:: ;office mail id
{
    send(myOfficeMailID)
}

:*:,dwr:: ;Dotnet watch run
{
    send("dotnet watch run")
}

:*:,dr:: ;Dotnet watch run
{
    send("dotnet run")
}

:*:,db:: ;Dotnet watch run
{
    send("dotnet build")
}

:*:,cr:: ;Dotnet watch run
{
    send("caddy run")
}

:*:,dc:: ;Dotnet watch run
{
    send("dotnet clean")
}

<^>!c:: ;--VSCode | A--Edit AHK files | H--Edit Host file | S--Edit SSH Config File | D--DrawIO | E--Excalidraw | N--New Instance
{
    pressedKey := DoInputHook("T1 L1", "a,d,h,e,n,s", "c")

    switch pressedKey
    {
        case "c", "n": RunProgramOrActivate(vsCodeProgramFilePath, "Code.exe", pressedKey == "n")
        case "h": RunProgramWithParameter(vsCodeProgramFilePath, hostsFilepath)
        case "e": RunProgramWithParameter(vsCodeProgramFilePath, myExcalidrawFilePath)
        case "s": RunProgramWithParameter(vsCodeProgramFilePath, mySSHConfigFilePath)
        case "d": RunProgramWithParameter(vsCodeProgramFilePath, myDrawIOFilePath)
        case "a":
            RunProgramWithParameter(vsCodeProgramFilePath, myKeysCoreFilePath)
            RunProgramWithParameter(vsCodeProgramFilePath, myAllDesktopKeysFilePath)
            RunProgramWithParameter(vsCodeProgramFilePath, myCurrentDesktopKeysFilePath)
            RunProgramWithParameter(vsCodeProgramFilePath, myLocalSystemVariablesFilePath)
    }
}

<^>!d:: ;DBEaver
{
    RunProgramOrActivate(dbeaverProgramFilePath, "dbeaver.exe")
}

<^>!g:: ;--LocalHost:5000 | (1to9)--Localhost:500x URL | w--whatsapp
{
    pressedKey := DoInputHook("T1 L1", "0,1,2,3,4,5,6,7,8,9,w", "0")

    endpoint := ""
    switch pressedKey
    {
        case "w": endpoint := "https://web.whatsapp.com/"
        default:  endpoint := "http://localhost:500" . pressedKey . "/"
    }

    RunProgramWithParameter(edgeProgramFilePath, endpoint)
}

<^>!h:: ;Help Window
{
    ; parameter := Format('{1} /c ""lprun6" "{2}""', cmdProgramFilePath, ahkHelpWindowProgramPath)
    RunProgram("./AHKHelpWindow.exe", "", "")
}

<^>!i:: ;Initalize Startup Programs
{
    RunProgramOrActivate(thunderbirdProgramFilePath, "thunderbird.exe")
    RunProgramOrActivate(sublimeMergeProgramFilePath, "sublime_merge.exe")
    RunProgramOrActivate(dbeaverProgramFilePath, "dbeaver.exe")
    RunProgramOrActivate(notionProgramFilePath, "Notion.exe")
    RunProgramWithParameter(edgeProgramFilePath, TeamsStandUpChannelLink)
}

<^>!j:: ;Jmeeter
{
    RunProgramOrActivate(jmeeterProgramFilePath, "javaw.exe", IsNewWindowCall())
}

<^>!k:: ;--notion | l--work log
{
    pressedKey := DoInputHook("T1 L1", "k,l", "k")

    switch pressedKey
    {
        case "l": RunProgram(NotionWorkLogTodayPage)
        case "k":
            if(WinActive("ahk_exe msedge.exe"))
            {
                Send("{F4}")
                Send("^c")
                sleep(50)
                pathToExecute := StrReplace(A_Clipboard, "https", "notion", 1)
                RunProgram(pathToExecute)
            }
            else
            {
                RunProgramOrActivate(notionProgramFilePath, "Notion.exe")
            }
    }
    
    TrayTip("Done", "Opening notion")
}

<^>!l:: ;Linqpad 6
{ 
    RunProgramOrActivate(linqPad6ProgramFilePath, "LINQPad6.exe", IsNewWindowCall())
}

<^>!m:: ;Sublime Merge
{
    RunProgramOrActivate(sublimeMergeProgramFilePath, "sublime_merge.exe", IsNewWindowCall())
}

<^>!n:: ;Notepad
{
    RunProgramOrActivate(notepadProgramFilePath, "Notepad.exe", IsNewWindowCall())
}

<^>!r:: ;Rebuild My AHK Keys
{
    RunProgram(myAllDesktopKeysFilePath, "", "Min")
    RunProgram(myCurrentDesktopKeysFilePath, "", "Min")
}

<^>!s:: ;Sublime Text
{
    RunProgramOrActivate(sublimeTextProgramFilePath, "sublime_text.exe", IsNewWindowCall())
}

<^>!u:: ;WSL Ubuntu
{
    RunProgramOrActivate(wslUbuntuProgramFilePath, "WindowsTerminal.exe", true)
}

#`:: ;Open With Notepad
{
    RunSelected(notepadProgramFilePath)
}

#1:: ;Open With VSCode
{
    RunSelected(vsCodeProgramFilePath)
}

#2:: ;Open With VS22
{
    RunSelected(visualStudio22ProgramFilePath)
}

#3:: ;Open With Sublime
{
    RunSelected(sublimeTextProgramFilePath)
}

#9:: ;Open With VS19
{
    RunSelected(visualStudio19ProgramFilePath)
}

#7:: ;Open With VS17
{
    RunSelected(visualStudio17ProgramFilePath)
}

#-:: ;Minimize Current Window
{
    WinMinimize("A")
}