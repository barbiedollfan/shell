import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.common
import qs.common.components

Rectangle {
    radius: Styling.rounding
    color: Styling.colors.surfaceContainer

    RowLayout {
        anchors.fill: parent
        anchors.margins: Styling.gapsInBorderSmall
        spacing: Styling.gapsIn

        Rectangle {
            implicitWidth: implicitHeight
            implicitHeight: Styling.toggleSphereDiameter
            radius: height / 2
            color: Network.enabled ? Styling.colors.primary : Styling.colors.secondary

            Icon {
                id: networkIcon
                name: Network.icon
                anchors.centerIn: parent
                iconSize: Styling.fontLarge
                iconColor: Styling.colors.onPrimary
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Network.toggleWifi()
            }
        }
        Item {
            id: wifiInfo
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                id: wifiInfoColumn
                anchors.fill: parent
                spacing: -5

                Text {
                    text: "Wi-Fi"
                    Layout.fillWidth: true
                    font.bold: true
                    font.pixelSize: Styling.fontIncremental
                    color: Styling.colors.onSurface
                }

                Text {
                    text: Network.connectedNetworkSsid ? Network.connectedNetworkSsid : "Not Connected"
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    color: Styling.colors.onSurface
                }
            }

            MouseArea {
                id: wifiInfoArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: { 
                    if (!nmtuiProc.running) nmtuiProc.running = true; 
                    GlobalShortcuts.controlPanelOpen = false;
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            implicitWidth: popupArrow.implicitWidth
            Layout.alignment: Qt.AlignLeft
            visible: wifiInfoArea.containsMouse
            color: Styling.colors.surfaceContainer

            Text {
                id: popupArrow
                text: ""
                anchors.centerIn: parent
                font.pixelSize: Styling.fontMedium
                color: Styling.colors.onSurface
            }
        }
    }

    Process {
        id: nmtuiProc
        running: false
        command: ["sh", "-c", "kitty nmtui"]
    }
}
