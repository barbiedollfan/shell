import QtQuick
import QtQuick.Controls
import qs.common

Switch {
    id: control
    property int pillHeight: 25
    property int pillWidth: 45
    property int indicatorGap: 2
    padding: 0

    contentItem: Item {
        implicitHeight: control.pillHeight
        implicitWidth: control.pillWidth
    }

    indicator: Rectangle {
        implicitHeight: control.pillHeight
        implicitWidth: control.pillWidth
        color: control.checked ? Styling.colors.primaryContainer : Styling.colors.surfaceContainerHighest
        radius: height / 2

        Rectangle {
            x: control.checked ? parent.width - width - indicatorGap : indicatorGap
            height: parent.height - 2 * indicatorGap
            width: height
            anchors.verticalCenter: parent.verticalCenter
            color: Styling.colors.onSurface
            radius: height / 2
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: false
        cursorShape: Qt.PointingHandCursor
    }
}
