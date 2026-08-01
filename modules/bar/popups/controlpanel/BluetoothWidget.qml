import Quickshell
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
            color: Bluetooth.enabled ? Styling.colors.primary : Styling.colors.secondary

            Icon {
                name: Bluetooth.icon
                anchors.centerIn: parent
                iconSize: Styling.fontLarge
                iconColor: Styling.colors.onPrimary
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Bluetooth.toggleBluetooth()
            }
        }
        Item {
            id: btInfo
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                id: btInfoColumn
                anchors.fill: parent
                spacing: -5

                Text {
                    text: "Bluetooth"
                    font.bold: true
                    font.pixelSize: Styling.fontIncremental
                    Layout.fillWidth: true
                    color: Styling.colors.onSurface
                }

                Text {
                    text: {
                        if (Bluetooth.numberConnectedDevices === 0) return "Not Connected";
                        if (Bluetooth.numberConnectedDevices === 1) return Bluetooth.connectedDevices[0].name;
                        return `${Bluetooth.numberConnectedDevices} connected devices`;
                    }
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    color: Styling.colors.onSurface
                }
            }

            MouseArea {
                id: btInfoArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: console.log("Uhhhhh")
            }
        }

        Rectangle {
            Layout.fillHeight: true
            implicitWidth: popupArrow.implicitWidth
            Layout.alignment: Qt.AlignLeft
            visible: btInfoArea.containsMouse
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
}
