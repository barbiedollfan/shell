import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.services

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData
        screen: modelData

        WlrLayershell.layer: WlrLayer.Background
        exclusionMode: ExclusionMode.Ignore
        anchors {
            top: true; 
            right: true; 
            bottom: true; 
            left: true; 
        }

        Image {
            source: Wallpaper.currentWallpaper
            anchors.fill: parent
        }
    }
}
