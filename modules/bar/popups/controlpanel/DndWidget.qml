import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.common

Rectangle {
    implicitHeight: 70
    implicitWidth: 70
    radius: Styling.rounding
    color: Notifications.dnd ? Styling.colors.primaryContainer : Styling.colors.surfaceContainer

    Text {
        anchors.centerIn: parent
        text: Notifications.dndIcon
        font.pixelSize: 25
        color: Styling.colors.onSurface
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Notifications.toggleDnd()
    }
}
