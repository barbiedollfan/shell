import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: root
    required default property Item content
    required property bool focused

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: ExclusionMode.Normal
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    color: "transparent"

    HyprlandFocusGrab {
        windows: [ root ]
        active: focused
    }
}
