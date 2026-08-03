import Quickshell
import QtQuick
import qs.common
import qs.common.components
import qs.services

Item {
    id: root

    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    property string date: {
        Qt.formatDateTime(clock.date, "ddd d")
    }

    property string time: {
        Qt.formatDateTime(clock.date, "h:mm AP")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Row {
        id: content
        anchors.centerIn: parent
        spacing: Styling.gapsInMedium

        StyledText {
            text: date
            anchors.verticalCenter: parent.verticalCenter
        }

        StyledText {
            text: time
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
