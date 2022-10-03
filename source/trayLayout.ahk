trayLayout := {
    id: "TRAYMENU",
    content:
        [{
            id: "MANAGE_SCRIPT",
            text: "Manage script...",
            maxDisplay: 0,
            content:
                [{
                    id: "RUN_AT_STARTUP",
                    text: "Run at startup",
                    interactive: "switch",
                    run: "scripts\toggleRunAtStartup.ps1.bat",
                },
                    {
                        id: "SUSPEND",
                        text: "Suspend",
                    },
                        {
                            id: "EXIT",
                            text: "Exit",
                        },
                ]
        },
            {
                id: "SEND_KEYSTROKES",
                text: "Send keystrokes...",
                maxDisplay: 0,
                content:
                    [{
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
                    id: "SET_DEFAULT_ACTION",
                    text: "Set left click action...",
                    maxDisplay: 0,
                    icon: "*",
                    interactive: "choice",
                    content:
                        [{
                            id: "RESET_DEFAULT_ACTION",
                            text: "None",
                        },
                        "MAIN_SHORTCUTS",
                    ]
                },
                    {
                        id: "MAIN_SHORTCUTS",
                        text: "Main shortcuts",
                        content:
                            [{
                                id: "WINDOWS_HELLO",
                                text: "Setup Windows Hello",
                                content:
                                    [{
                                        id: "SETUP_HELLO_FACE",
                                        text: "Setup Hello Face",
                                        run: "explorer ms-settings:signinoptions-launchfaceenrollment",
                                        icon: [A_WinDir "\System32\ddores.dll", 87],
                                    },
                                        {
                                            id: "SETUP_HELLO_FINGERPRINT",
                                            text: "Setup Hello Fingerprint",
                                            run: "explorer ms-settings:signinoptions-launchfingerprintenrollment",
                                            icon: [A_WinDir "\System32\sensorscpl.dll", 11],
                                        },
                                    ]
                            },
                                {
                                    id: "BLUETOOTH",
                                    text: "Bluetooth audio and file transfer",
                                    icon: [A_WinDir "\System32\netshell.dll", 104],
                                    maxDisplay: 0,
                                    content:
                                        [{
                                            id: "BLUETOOTH_FILE_TRANSFER",
                                            text: "Transfer files using Bluetooth",
                                            run: "fsquirt",
                                        },
                                            {
                                                id: "CONNECT_BLUETOOTH_DEVICE",
                                                text: "Connect bluetooth device",
                                                run: "explorer ms-settings:connecteddevices",
                                            },
                                        ]
                                },
                                    {
                                        id: "UPDATES",
                                        text: "Application updates",
                                        content:
                                            [{
                                                id: "WINGET_UPDATE",
                                                text: "Update all applications",
                                                run: "scripts\wingetUpdateAll.ps1.bat",
                                                icon: [A_WinDir "\System32\shell32.dll", 239],
                                            },
                                                {
                                                    id: "GIT_UPDATE",
                                                    text: "Update all repositories",
                                                    run: "scripts\gitUpdateAll.ps1.bat",
                                                    icon: [A_WinDir "\System32\shell32.dll", 239],
                                                },
                                            ]
                                    },
                                        {
                                            id: "CONVERTIBLE",
                                            text: "Pen & touch screen utilities",
                                            content:
                                                [{
                                                    id: "CALIBRATE_DIGITIZER",
                                                    text: "Calibrate pen",
                                                    run: "tabcal",
                                                    icon: [A_WinDir "\System32\ddores.dll", 27],
                                                },
                                                    {
                                                        id: "TAKE_SCREENSHOT",
                                                        text: "Take Screenshot",
                                                        send: "#+s",
                                                        icon: "icons\ScreenSketch.ico",
                                                    },
                                                ]
                                        },
                            ]
                    }
        ]
}