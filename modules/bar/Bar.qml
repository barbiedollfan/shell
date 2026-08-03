import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import qs.modules.launcher
import qs.modules.wallpaper
import qs.modules.status
import qs.modules.bar.components
import qs.common
import qs.common.components
import qs.services

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property var modelData
            screen: modelData
            
            WlrLayershell.layer: WlrLayer.Top

            implicitHeight: Styling.pillHeight + 2 * Styling.barPaddingTop

            anchors {
                top: true
                left: true
                right: true
            }

            color: Styling.colors.surface

            HyprlandWindow.opacity: 0.95

            Row {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: Styling.infoEntrySpacing
                spacing: Styling.infoEntrySpacing

                Workspaces {}
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: Styling.infoEntrySpacing

                Clock {
                    anchors.verticalCenter: parent.verticalCenter
                } 

                VerticalSeparator {}

                WeatherInfo {} 
            }

            Row {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: Styling.infoEntrySpacing
                spacing: Styling.infoEntrySpacing

                KeyboardInfo {} 

                VerticalSeparator {}

                VolumeInfo {}

                VerticalSeparator {}

                StorageInfo {}

                VerticalSeparator {}

                MemoryInfo {}

                VerticalSeparator {}

                BatteryInfo {}

                VerticalSeparator {}
                
                Row {
                    spacing: 2

                    NetworkInfo {}
                    
                    BluetoothInfo {}
                }
            }

            LazyLoader {
                id: launcherLoader
                loading: true
                active: GlobalShortcuts.launcherOpen

                PopupWindow {
                    id: launcherWrapper
                    anchor.window: bar
                    anchor.rect.x: anchor.window.width / 2 - width / 2
                    anchor.rect.y: anchor.window.height + 3
                    implicitWidth: launcher.implicitWidth
                    implicitHeight: launcher.implicitHeight
                    color: "transparent"
                    visible: GlobalShortcuts.launcherOpen

                    Launcher {
                        id: launcher
                        anchors.centerIn: parent
                    }

                    HyprlandFocusGrab {
                        id: launcherFocusGrab
                        windows: [ launcherWrapper ]
                        active: GlobalShortcuts.launcherOpen
                    }
                }
            }

            LazyLoader {
                id: statusPanelLoader
                loading: true
                active: GlobalShortcuts.statusPanelOpen

                PopupWindow {
                    id: statusPanelWrapper
                    anchor.window: bar
                    anchor.rect.x: anchor.window.width / 2 - width / 2
                    anchor.rect.y: anchor.window.height + 3
                    implicitWidth: statusPanel.implicitWidth
                    implicitHeight: statusPanel.implicitHeight
                    color: "transparent"
                    visible: GlobalShortcuts.statusPanelOpen

                    StatusPanel {
                        id: statusPanel
                        anchors.centerIn: parent
                    }
                }
            }

            LazyLoader {
                id: wallpaperSwitcherLoader
                loading: true
                active: GlobalShortcuts.wallpaperSwitcherOpen

                PopupWindow {
                    id: wallpaperSwitcherWrapper
                    anchor.window: bar
                    anchor.rect.x: anchor.window.width / 2 - width / 2
                    anchor.rect.y: 500 - Styling.gapsOut
                    implicitWidth: wallpaperSwitcher.implicitWidth
                    implicitHeight: wallpaperSwitcher.implicitHeight
                    color: "transparent"
                    visible: GlobalShortcuts.wallpaperSwitcherOpen

                    WallpaperSwitcher {
                        id: wallpaperSwitcher
                        anchors.centerIn: parent
                    }

                    HyprlandFocusGrab {
                        id: wallpaperSwitcherFocusGrab
                        windows: [ wallpaperSwitcherWrapper ]
                        active: GlobalShortcuts.wallpaperSwitcherOpen
                    }
                }
            }
        }
    }

    component VerticalSeparator: Rectangle {
        implicitHeight: Styling.pillHeight * 0.6
        implicitWidth: 2
        anchors.verticalCenter: parent.verticalCenter
        radius: Styling.rounding
        color: Styling.colors.secondaryContainer
    }

    component IconAction: Item {
        id: root
        implicitHeight: content.implicitHeight
        implicitWidth: content.implicitWidth

        property alias iconName: content.name

        signal action 

        Icon {
            id: content
            iconSize: 17
            anchors.centerIn: parent
        }

        MouseArea {
            id: area
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: action()
        }
    }
}
