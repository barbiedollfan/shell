import Quickshell
import QtQuick
import qs.common

Loader {
    id: root
    required property Item content
    required property Item anchorItem

    sourceComponent: PopupWindow {
        anchor.item: anchorItem
        anchor.margins.top: anchorItem.height + 10

        implicitHeight: outline.implicitHeight
        implicitWidth: outline.implicitWidth
        color: "transparent"
        visible: root.status === Loader.Ready

        Rectangle {
            id: outline
            implicitHeight: content.implicitHeight + 2 * Styling.gapsOut
            implicitWidth: content.implicitWidth + 2 * Styling.gapsOut
            anchors.centerIn: parent
            radius: Styling.rounding
            color: Styling.colors.surface
            // border.color: Styling.colors.outline
            children: [content]
        }
    }
}
