import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import qs.common
import qs.common.components

Loader {
    id: root
    active: GlobalShortcuts.launcherOpen

    sourceComponent: PanelWindow {
        id: window

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight
        WlrLayershell.layer: WlrLayer.Top
        exclusionMode: ExclusionMode.Normal
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
        color: "transparent"
        visible: root.status === Loader.Ready

        LauncherContent {
            id: content
            anchors.centerIn: parent
        }

        HyprlandFocusGrab {
            windows: [ window ]
            active: root.active
        }
    }
}
