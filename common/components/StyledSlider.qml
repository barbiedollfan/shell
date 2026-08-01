import Quickshell
import QtQuick
import QtQuick.Controls
import qs.common

Slider {
    id: control

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        anchors.fill: parent
        radius: height / 2
        color: Styling.colors.surfaceContainer

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: Styling.colors.primaryContainer
            topLeftRadius: height / 2
            bottomLeftRadius: height / 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 3
        height: control.height + 2
        radius: Styling.rounding
        color: Styling.colors.secondary
    }
}
