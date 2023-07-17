#Requires AutoHotkey >=2.0
#SingleInstance Force

SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir) ; Ensures a consistent starting directory.
DetectHiddenWindows(True)

#include MyKeys_localPathVariables.ahk
#include MyKeys_Core.ahk 

:*:,dbm:: ;database migration file name
{
    item := FormatTime(, "yyyyMMddHHmm")
    send("V" . item . "__.sql")
    send("{left 4}")
}

:*:,mail:: ;database migration file name
{
    send(myOfficeMailID)
}


<^>!c:: ;C--VSCode | A--Edit AHK files | H--Edit Host file | S--Edit SSH Config File | D--DrawIO | E--Excalidraw | N--New Instance
{
    pressedKey := DoInputHook("T1 L1", "a,d,h,e,n,s", "c")

    switch pressedKey
    {
        case "c", "n": RunProgramOrActivate("Code.exe", vsCodeProgramFilePath, pressedKey == "n")
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
    RunProgramOrActivate("dbeaver.exe", dbeaverProgramFilePath)
}

<^>!g:: ;(1-9)--Localhost URL | w--whatsapp
{
    pressedKey := DoInputHook("T1 L1", "0,1,2,3,4,5,6,7,8,9,w,h,m,l,k", "0")

    endpoint := ""
    switch pressedKey
    {
        case "w": endpoint := "https://web.whatsapp.com/"
        case "h": endpoint := "http://localhost:5000/health"
        default:  endpoint := "http://localhost:500" . pressedKey . "/"
    }

    RunProgramWithParameter(edgeProgramFilePath, endpoint)
}

<^>!h:: ;Help Window
{
    parameter := Format('{1} /c ""lprun6" "{2}""', cmdProgramFilePath, ahkHelpWindowProgramPath)
    RunProgram(parameter, "-")
}

<^>!i:: ;Initalize Startup Programs
{
    RunProgramOrActivate("thunderbird.exe", thunderbirdProgramFilePath)
    RunProgramOrActivate("sublime_merge.exe", sublimeMergeProgramFilePath)
    RunProgramOrActivate("dbeaver.exe", dbeaverProgramFilePath)
    RunProgramOrActivate("Notion.exe", notionProgramFilePath)
}

<^>!j:: ;Jmeeter
{
    RunProgramOrActivate("javaw.exe", jmeeterProgramFilePath, IsNewWindowCall())
}

<^>!k:: ;k--notion | l--work log
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
                RunProgramOrActivate("Notion.exe", notionProgramFilePath)
            }
    }
    
    TrayTip("Done", "Opening notion")
}

<^>!l:: ;Linqpad 6
{ 
    RunProgramOrActivate("LINQPad6.exe",  linqPad6ProgramFilePath, IsNewWindowCall())
}

<^>!m:: ;Sublime Merge
{
    RunProgramOrActivate("sublime_merge.exe", sublimeMergeProgramFilePath, IsNewWindowCall())
}

<^>!n:: ;n--Notepad | s--Sublime Text | N N--New NotePad | S N--new Sublime Text
{
    pressedKey := DoInputHook("T1 L1", "n,s", "n")

    switch pressedKey
    {
        case "s": RunProgramOrActivate("sublime_text.exe", sublimeTextProgramFilePath, IsNewWindowCall())
        default: RunProgramOrActivate("Notepad.exe", notepadProgramFilePath, IsNewWindowCall())
    }
}

<^>!o:: ;Obsidian
{
    RunProgramOrActivate("Obsidian.exe", obsidianProgramFilePath)
}

<^>!p:: ;Postman
{
    RunProgramOrActivate("Postman.exe", postmanProgramFilePath, IsNewWindowCall())
}

<^>!r:: ;Rebuild My AHK Keys
{
    RunProgram(myAllDesktopKeysFilePath, "-")
    RunProgram(myCurrentDesktopKeysFilePath, "-")
}

<^>!s:: ;Spotify
{
    RunProgramOrActivate("Spotify.exe", spotifyFilePath)
}


<^>!u:: ;WSL Ubuntu
{
    RunProgramOrActivate("WindowsTerminal.exe", wslUbuntuProgramFilePath)
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