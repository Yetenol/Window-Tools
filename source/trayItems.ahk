TRAY_ITEMS := 
[
    {
        type: TrayMenu.TYPES.SUBMENU,
        id: "SEND_KEYSTROKES",
        text: "Send keystrokes...",
        actions:
        [
            {
                id: "SEND_PAUSE",
                text: "Send Pause",
                delay: 2000,
                send: "{Pause}",
            },
            {
                id: "SEND_CTRLBREAK",
                text: "Send Ctrl + Pause",
                delay: 2000,
                send: "{CtrlBreak}",
            },
        ]
    },
    {
        type: TrayMenu.TYPES.CATEGORY,
        id: "WINDOWS_HELLO",
        text: "Setup Windows Hello",
        actions: 
        [
            {
                id: "SETUP_HELLO_FACE", 
                text: "Setup Hello Face", 
                run: "explorer ms-settings:signinoptions-launchfaceenrollment", 
                icon: A_WinDir "\System32\ddores.dll", 
                iconIndex: 87,
            },
            {
                id: "SETUP_HELLO_FINGERPRINT", 
                text: "Setup Hello Fingerprint",
                run: "explorer ms-settings:signinoptions-launchfingerprintenrollment", 
                icon: A_WinDir "\System32\sensorscpl.dll", 
                iconIndex: 11,
            },
        ]
    },
    {
        type: TrayMenu.TYPES.CATEGORY,
        id: "BLUETOOTH",
        text: "Bluetooth audio and file transfer",
        actions:
        [
            {
               id: "BLUETOOTH_FILE_TRANSFER", 
               text: "Transfer files using Bluetooth", 
               run: "fsquirt", 
               icon: A_WinDir "\System32\netshell.dll", 
               iconIndex: 104,
            },
            {
                id: "CONNECT_BLUETOOTH_DEVICE", 
                text: "Connect bluetooth device", 
                run: "explorer ms-settings:connecteddevices", 
                icon: A_WinDir "\System32\netshell.dll", 
                iconIndex: 104,
            },
        ]
    },
    {
        type: TrayMenu.TYPES.CATEGORY,
        id: "CONVERTIBLE",
        text: "Pen & touch screen utilities",
        actions:
        [
            {
                id: "CALIBRATE_DIGITIZER", 
                text: "Calibrate pen", 
                run: "tabcal", 
                icon: A_WinDir "\System32\ddores.dll", 
                iconIndex: 27,
            },
            {
                id: "TAKE_SCREENSHOT", 
                text: "Take Screenshot", 
                send: "{PrintScreen}", 
                icon: "*",
            },
        ]
    },
]