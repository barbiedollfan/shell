import Quickshell
import qs.services

Item {
    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth


    Icon {
        name: Network.icon
        iconSize: 16
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: console.log("Open")
    }
}

