import Quickshell
import Quickshell.Networking as Net
import QtQuick
import QtQuick.Layouts
import qs.common
import qs.common.components
import qs.services

RowLayout {
    required property var network

    Rectangle {
        Layout.fillWidth: true
        implicitHeight: networkEntry.implicitHeight + 6
        radius: 5
        color: networkEntryArea.containsMouse ? Styling.colors.surfaceContainer : "transparent"

        RowLayout {
            id: networkEntry
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter

            Icon {
                name: Network.wifiIcon(network?.signalStrength)
            }
            StyledText {
                Layout.fillWidth: true
                text: `${network?.name}`
                font.pixelSize: 13
                elide: Text.ElideRight
            }

            Loader {
                active: network?.connected ?? false
                sourceComponent: Icon {
                    Layout.alignment: Qt.AlignRight
                    name: Icons.check
                    iconSize: 16
                }
            }
        }

        MouseArea {
            id: networkEntryArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onClicked: network.connected ? network.disconnect() : network.connect()
        }
    }

    Loader {
        active: network?.known ?? false
        sourceComponent: Rectangle {
            implicitWidth: forgetIcon.implicitWidth
            implicitHeight: forgetIcon.implicitHeight
            color: forgetArea.containsMouse ? Styling.colors.surfaceContainer : "transparent"
            radius: 5

            Icon {
                id: forgetIcon
                anchors.centerIn: parent
                name: Icons.trash
            }

            MouseArea {
                id: forgetArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onClicked: network.forget()
            }
        }
    }

    Connections {
        target: network
        function onConnectionFailed(reason) {
            console.log(Net.ConnectionFailReason.toString(reason));
        }
    }
}
