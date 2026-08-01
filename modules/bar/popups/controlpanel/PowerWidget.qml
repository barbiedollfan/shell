import Quickshell
import Quickshell.Io
import QtQuick
import qs.common
import qs.common.components
import qs.services

Row {
    id: powerRow
    spacing: width - idleContainer.width - powerContainer.width

    Rectangle {
        id: idleContainer
        implicitHeight: 40
        implicitWidth: 40
        radius: height / 2
        color: Styling.colors.surface
        border.color: Styling.colors.surfaceContainerHighest
        border.width: 2
        
        Icon {
            name: Idle.icon
            iconSize: Styling.fontLarge
            anchors.centerIn: parent
        }

        MouseArea {
            id: idleContainerArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: Idle.toggleIdleLock()
        }
    }

    Rectangle {
        id: powerContainer
        implicitHeight: 40
        implicitWidth: 40
        radius: height / 2
        color: Styling.colors.surface
        border.color: Styling.colors.surfaceContainerHighest
        border.width: 2

        Icon {
            name: Icons.power
            iconSize: Styling.fontLarge
            anchors.centerIn: parent
        }

        MouseArea {
            id: powerContainerArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: suspendProc.running = true

            Process {
                id: suspendProc
                command: ["sh", "-c", "systemctl suspend"]
            }
        }
    }
}
