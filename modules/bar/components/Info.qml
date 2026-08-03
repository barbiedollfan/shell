import Quickshell
import QtQuick
import qs.common
import qs.common.components
import qs.services
import qs.modules.bar.popups

Item {
    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    property alias iconName: icon.name
    property alias text: text.text
    signal toggled(MouseEvent mouse)

    Row {
        id: content
        anchors.centerIn: parent
        spacing: Styling.gapsInSmall

        Icon {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
        }

        StyledText {
            id: text
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: (mouse) => toggled(mouse)
    }
}

