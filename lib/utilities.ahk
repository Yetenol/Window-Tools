; Main AHK library 
; - various functions

; Author: Anton Pusch
; Last update: 2021-02-14

/* Show a notification
 * @param (optional) title: Text header
 * @param (optional) message: Text body
 * @param (optional) options: space seperated string of flags
 * ->  "" Default    "I" Info    "W" Warning    "E" Error
 * ->  "S" Silent
 * ->  "M" Use AHK's message dialog, pauses the script
 * ->  "K" Kill the windows notification
 * -> e.g: "S M" means silent Message Dialog
 */
;error() {
;    toast
;}
toastError(title := "", message := "", timeout := -1, doSound := true, options := 0) {
    toast(title, message, timeout, doSound, options, "Error")
}
toastInfo(title := "", message := "", timeout := -1, doSound := true, options := 0) {
    toast(title, message, timeout, doSound, options,  "Info")
}
toastQuestion(title := "", message := "", timeout := -1, doSound := true, options := 0) {
    toast(title, message, timeout, doSound, options,  "Question")
}
toastWarning(title := "", message := "", timeout := -1, doSound := true, options := 0) {
    toast(title, message, timeout, doSound, options,  "Warning")
}



toast(title := "", message := "", timeout := -1, doSound := true, options := 0, styleIcon := "")
{
    ; Deside whether to use native Balloon notifications or a Message Box
    EnvGet, domain, USERDOMAIN
    design := (options || domain = "TUV") ? "Message Box" : "Balloon"
    
    ; Message can't be empty
    message := (message = "") ? " " :  message

    if (design = "Balloon")
    {
        ; parse configuration
        flags := (doSound) ? 0x0 : 0x10 ; mute if necessary

        if (styleIcon = "Error") {
            flags |= 0x3
        } else if (styleIcon = "Info" || styleIcon = "Question") {
            flags |= 0x1
        } else if (styleIcon = "Warning") {
            flags |= 0x2
        }

        ; delete notification queue
        if (timeout != -1)  
        {
            killBalloon()
        }

        ; display notification
        TrayTip, % title, % message,, % flags

        ; await timeout
        if (timeout != -1)
        {
            Sleep, timeout * 1000
            killBalloon()
        }
    }
    else 
    {
        ; parse configuration
        ; Override the second hex letter in options
        if (styleIcon = "Error") {
            options := (options & ~0xf0) | 0x10
        } else if (styleIcon = "Info") {
            options := (options & ~0xf0) | 0x40
        } else if (styleIcon = "Question") {
            options := (options & ~0xf0) | 0x20
        } else if (styleIcon = "Warning") {
            options := (options & ~0xf0) | 0x30
        }

        ; display notification    
        MsgBox, % options, % title, % message, % timeout
    }
}

; Kill the notification queue and all it's balloons
killBalloon() {
    Menu, Tray, NoIcon
    Sleep, 10
    Menu, Tray, Icon
}

; Handle external resource
; - Get the correct filepath from multiple posibilities
; - Display error messages
getFile(filename, validLocations) {
    for i, location in validLocations
    { ; Check all locations and use the first valid one
        if (attributes := FileExist(location))
        { ; Path is valid
            if (InStr(attributes, "D"))
            { ; Path is a directory
                if (FileExist(location "\" filename))
                { ; Location contains a valid file
                    return location "\" filename
                }
            }
            else
            { ; Location is a valid file
                return location
            }
        }
    }
    ; No valid location found
    toast("File missing", A_ScriptDir "\" filename, "E")
    return   
}

; Find a specific image inside a window
locateImageInWindow(window, imagePath) {
    Coordmode, % "pixel", % "screen"
    if(!WinExist(window))
    { ; Window doesn't exist
        toast("Targeted window doesn't exist", "Window:`t" window "`nImage:`t" imagePath, "E")
    }
    WinGetPos, x, y, width, height, % window
    
    ImageSearch, imageX, imageY, x, y, % x + width, % y + height, % imagePath
    if (ErrorLevel = 2)
    { ; PROBLEM that prevented the command from conducting the search (such as failure to open the image file or a badly formatted option)
        toast("Failure to execute imageSearch", "Window:`t" window "`nImage:`t" imagePath, "E")
        return {}
    }
    else if (ErrorLevel = 1)
    { ; Cannot find image! => At least one tab open
        return false
    }
    else
    { ; Image was found!
        return {x: imageX, y: imageY}
    }
}

; Click a specific image inside a window
clickImageInWindow(window, imagePath) {
    image := locateImageInWindow(window, imagePath)
    if (!image)
    { ; Cannot find image!
        return false
    }
    else
    { ; Image was found!
        ; Click the image
        Coordmode, % "mouse", % "screen"
        MouseGetPos, mouseX, mouseY
        Coordmode, % "pixel", % "screen"

        Click, % image.x " " image.y
        
        ; Keep previous mouse position
        MouseMove, % mouseX, % mouseY
        return true
    }
}