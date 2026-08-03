pragma Singleton
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property bool launcherOpen: false
    property bool wallpaperSwitcherOpen: false
    property bool statusPanelOpen: false

    property bool batteryPopupOpen: false
    property bool memoryPopupOpen: false
    property bool storagePopupOpen: false
    property bool networkPopupOpen: false
    property bool bluetoothPopupOpen: false

    GlobalShortcut {
        appid: "quickshell"
        name: "controlPanel"
        onPressed: root.controlPanelOpen = !root.controlPanelOpen
    }

    GlobalShortcut {
        appid: "quickshell"
        name: "launcher"
        onPressed: root.launcherOpen = !root.launcherOpen
    }

    GlobalShortcut {
        appid: "quickshell"
        name: "wallpaperSwitcher"
        onPressed: root.wallpaperSwitcherOpen = !root.wallpaperSwitcherOpen
    }
    
    GlobalShortcut {
        appid: "quickshell"
        name: "statusPanel"
        onPressed: root.statusPanelOpen = !root.statusPanelOpen
    }
}
