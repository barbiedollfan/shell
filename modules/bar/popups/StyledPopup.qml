import Quickshell
import QtQuick
import qs.common

LazyLoader {
    id: root
    default property Item content
    required property Item anchorItem

    component: PopupWindow {
        anchor.item: anchorItem
        anchor.margins.top: anchorItem.height + 10

        implicitHeight: outline.implicitHeight
        implicitWidth: outline.implicitWidth
        color: "transparent"
        visible: root.active

        Rectangle {
            id: outline
            implicitHeight: content ? content.implicitHeight + 2 * Styling.gapsOut : 100
            implicitWidth: content ? content.implicitWidth + 2 * Styling.gapsOut : 100
            anchors.centerIn: parent
            radius: Styling.rounding
            color: Styling.colors.surface
            children: [content]
        }
    }
}
