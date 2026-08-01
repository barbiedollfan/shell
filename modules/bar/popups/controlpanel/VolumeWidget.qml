import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services
import qs.common
import qs.common.components

RowLayout {
    spacing: 10

    Rectangle {
        implicitHeight: 20
        implicitWidth: 20
        color: "transparent"

        Icon {
            name: Volume.icon
            anchors.centerIn: parent
        }
    }

    StyledSlider {
        from: 0
        to: 100
        value: Volume.percentage

        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}

