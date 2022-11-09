TRAY_LAYOUT := {
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
                    switch : false,
                    icon: [A_WinDir "\System32\netshell.dll", 104],
                    run: "scripts\toggleRunAtStartup.ps1.bat",
                },
                {
                    id: "SUSPEND",
                    text: "Suspend",
                },
                {
                    id: "EXIT",
                    text: "Exit",
                },]
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
                id: "DEFAULT_ACTION",
                text: "Set left click action...",
                maxDisplay: 0,
                icon: "*",
                choice: "NO_DEFAULT_ACTION",
                content:
                    [{
                        id: "NO_DEFAULT_ACTION",
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
                                icon: "icons\face-id.ico",
                            },
                                {
                                    id: "SETUP_HELLO_FINGERPRINT",
                                    text: "Setup Hello Fingerprint",
                                    run: "explorer ms-settings:signinoptions-launchfingerprintenrollment",
                                    icon: "icons\add-fingerprint.ico",
                                },
                            ]
                    },
                        {
                            id: "BLUETOOTH",
                            text: "Bluetooth audio and file transfer",
                            maxDisplay: 1,
                            icon: "icons\bluetooth.ico",
                            content:
                                [{
                                    id: "BLUETOOTH_FILE_TRANSFER",
                                    text: "Transfer files using Bluetooth",
                                    run: "fsquirt",
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
                                        icon: "icons\software-installer.ico",
                                    },
                                        {
                                            id: "GIT_UPDATE",
                                            text: "Update all repositories",
                                            run: "scripts\gitUpdateAll.ps1.bat",
                                            icon: "icons\code-fork.ico",
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
                                            icon: "icons\whiteboard.ico",
                                        },
                                            {
                                                id: "TAKE_SCREENSHOT",
                                                text: "Take Screenshot",
                                                send: "#+s",
                                                icon: "icons\windows-snipping-tool.ico",
                                            },
                                        ]
                                },
                    ]
            }
        ]
    }