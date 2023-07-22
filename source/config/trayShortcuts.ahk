TRAY_LAYOUT := {
    id: "TRAYMENU",
    content:
        [{
            id: "ADMINISTRATIVE",
            text: "Administrate script",
            content: [{
                id: "MANAGE_SCRIPT",
                text: "Manage script",
                maxDisplay: 0,
                content:
                    [{
                        id: "RUN_AT_STARTUP",
                        text: "Run at startup",
                        switch: false,
                        call: "toggleRunAtStartup()",
                    }, {
                        id: "SUSPEND",
                        text: "Suspend",
                        switch: false,
                        call: "toggleSuspend()",
                    }, {
                        id: "EXIT",
                        text: "Exit",
                        call: "closeApp()",
                    },]
            }, {
                id: "SEND_KEYSTROKES",
                text: "Send keystrokes",
                maxDisplay: 0,
                content:
                    [{
                        id: "SEND_PAUSE",
                        text: "Send [Pause]",
                        delay: 2000,
                        send: "{Pause}",
                    }, {
                        id: "SEND_CTRLBREAK",
                        text: "Send [Break]",
                        delay: 2000,
                        send: "{CtrlBreak}",
                    },]
            },]
        }, {
            id: "CONFIGURE",
            text: "Configure",
            content: [{
                id: "MANAGE_HOTKEYS",
                text: "Toggle keyboard shortcuts",
                maxDisplay: 0,
                content:
                    [{
                        id: "HOTKEY_TOGGLE_CASE",
                        text: "Change word case using [CapsLock]",
                        switch: false,
                    }, {
                        id: "HOTKEY_LAUNCH_KEEWEB",
                        text: "Focus or launch KeeWeb using [Win + Shift + V]",
                        switch: true,
                    }, {
                        id: "HOTKEY_PASTE_KEEWEB",
                        text: "Paste or launch KeeWeb using [Ctrl + Shift + V]",
                        switch: true,
                    }, {
                        id: "HOTKEY_PASTE_DATE",
                        text: "Insert the date formatted as YYYY-MM-DD [Win + Alt + D]",
                        switch: true,
                    }, {
                        id: "HOTKEY_CYCLE_ZONE_WINDOW",
                        text: (
                            "Cycle window in zone using "
                            "[Win + Mouse Wheel Up] or [Win + Mouse Wheel Down]"
                        ),
                        switch: false,
                    },]
            }, {
                id: "DEFAULT_ACTION",
                text: "Set left click action",
                maxDisplay: 0,
                icon: "",
                choice: "NO_DEFAULT_ACTION",
                call: "applyDefaultAction()",
                content:
                    [{
                        id: "NO_DEFAULT_ACTION",
                        text: "None",
                    },
                    "MAIN_SHORTCUTS",
                ]
            },]
        }, {
            id: "MAIN_SHORTCUTS",
            text: "Main shortcuts",
            content:
                [{
                    id: "UPDATES",
                    text: "Application updates",
                    content:
                        [{
                            id: "SCHEDULE_ACTIONS",
                            text: "Run update actions periodically",
                            maxDisplay: 0,
                            icon: "",
                            content: [{
                                id: "NO_SCHEDULED_ACTIONS",
                                text: "Disable all schedules",
                            }, {
                                id: "SCHEDULE_WINGET_UPDATE",
                                text: "Weekly update all applications [Admin]",
                                run: "scripts\wingetUpdateAll.ps1",
                                switch: false,
                            }, {
                                id: "SCHEDULE_GIT_UPDATE",
                                text: "Weekly update all repositories",
                                run: "scripts\gitUpdateAll.ps1",
                                switch: false,
                            }, {
                                id: "SCHEDULE_REDDIT_WALLPAPER",
                                text: "Hourly apply reddit wallpaper hourly",
                                run: "scripts\applyRedditWallpaper.ps1",
                                switch: false,
                            },]
                        }, {
                            id: "WINGET_UPDATE",
                            text: "Update all applications [Admin]",
                            run: "scripts\wingetUpdateAll.ps1",
                            icon: "icons\software.png",
                        }, {
                            id: "GIT_UPDATE",
                            text: "Update all repositories",
                            run: "scripts\gitUpdateAll.ps1",
                            icon: "icons\git-compare.png",
                        }, {
                            id: "APPLY_REDDIT_WALLPAPER",
                            text: "Apply reddit wallpaper hourly",
                            run: "scripts\applyRedditWallpaper.ps1",
                            icon: "icons\wallpaper.png",
                        },]
                }, {
                    id: "WINDOWS_HELLO",
                    text: "Setup Windows Hello",
                    content:
                        [{
                            id: "SETUP_HELLO_FACE",
                            text: "Setup Hello Face",
                            run: "explorer ms-settings:signinoptions-launchfaceenrollment",
                            icon: "icons\face-recognition.png",
                        }, {
                            id: "SETUP_HELLO_FINGERPRINT",
                            text: "Setup Hello Fingerprint",
                            run: "explorer ms-settings:signinoptions-launchfingerprintenrollment",
                            icon: "icons\fingerprint.png",
                        }, {
                            id: "BLUETOOTH_FILE_TRANSFER",
                            text: "Transfer files using Bluetooth",
                            icon: "icons\bluetooth.png",
                            run: "fsquirt",
                        },]
                }, {
                    id: "CONVERTIBLE",
                    text: "Pen & touch screen utilities",
                    content:
                        [{
                            id: "CALIBRATE_DIGITIZER",
                            text: "Calibrate pen",
                            run: "tabcal",
                            icon: "icons\pen.png",
                        }, {
                            id: "TAKE_SCREENSHOT",
                            text: "Take Screenshot",
                            send: "#+s",
                            icon: "icons\screenshot.png",
                        },]
                },
            ]
        }
    ]
}