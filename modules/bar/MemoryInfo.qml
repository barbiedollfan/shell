import Quickshell
import QtQuick
import qs.common
import qs.common.components
import qs.services
import qs.modules.bar.popups

Item {
    id: root

    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    Row {
        id: content
        spacing: Styling.gapsInSmall

        Icon {
            name: Icons.memory
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: Memory.usedPercent + "%"
            anchors.verticalCenter: parent.verticalCenter
            color: Styling.colors.onSurface
        }

    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: GlobalShortcuts.memoryPopupOpen = !GlobalShortcuts.memoryPopupOpen
    }

    LazyLoader {
        id: memoryPopupLoader
        loading: true
        activeAsync: GlobalShortcuts.memoryPopupOpen

        MemoryPopup {
            id: mempopup
            anchor.item: root
            anchor.margins.top: root.height + 15
            visible: GlobalShortcuts.memoryPopupOpen
        }
    }
}
