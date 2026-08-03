import QtQuick
import QtQuick.Controls
import qs.common

Switch {
    id: control
    property int implicitHeight: 25
    property int implicitWidth: 45
    property int indicatorGap: 3

    indicator: Rectangle {
        implicitHeight: control.implicitHeight
        implicitWidth: control.implicitWidth
        color: control.checked ? Styling.colors.primaryContainer : Styling.colors.surfaceContainerHighest
        radius: height / 2

        Rectangle {
            x: control.checked ? parent.width - width - indicatorGap : indicatorGap
            height: parent.height - 2 * indicatorGap
            width: height
            anchors.verticalCenter: parent.verticalCenter
            color: Styling.colors.onPrimaryContainer
            radius: height / 2
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: false
        cursorShape: Qt.PointingHandCursor
    }
}
