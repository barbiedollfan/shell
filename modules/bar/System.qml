import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.bar.popups.controlpanel
import qs.common
import qs.common.components

Item {
    id: root

    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth
    
    Row {
        id: content
        anchors.centerIn: parent
        spacing: Styling.gapsInMedium

        Icon {
            name: Network.icon
            iconSize: 16
            anchors.verticalCenter: parent.verticalCenter
        }

        Icon {
            name: Bluetooth.icon
            iconSize: 16
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: GlobalShortcuts.controlPanelOpen = !GlobalShortcuts.controlPanelOpen
    }

    LazyLoader {
        id: controlPanelLoader
        loading: true
        active: GlobalShortcuts.controlPanelOpen

        ControlPanel {
            anchor.item: root
            anchor.margins.top: root.height + 15
            visible: GlobalShortcuts.controlPanelOpen
        }
    }
}
