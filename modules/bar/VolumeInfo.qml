import Quickshell
import QtQuick
import qs.services
import qs.common
import qs.common.components

Row {
    spacing: Styling.gapsInSmall

    Icon {
        name: Volume.icon
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        text: Volume.percentage + "%"
        anchors.verticalCenter: parent.verticalCenter
        color: Styling.colors.onSurface
    }
}
