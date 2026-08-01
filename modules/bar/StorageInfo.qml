import Quickshell
import Quickshell.Io
import QtQuick
import qs.common
import qs.common.components
import qs.modules.bar.popups
import qs.services

Item {
    id: root

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    property int selected: 0
    property list<string> trackedDisks: Storage?.trackedDisks ?? []
    property int trackedAmount: trackedDisks.length
    property string selectedDisk: trackedDisks[selected]
    property var selectedDiskInfo: Storage.usage ? Storage?.usage[selectedDisk] : {}
    property int usedPercent: selectedDiskInfo?.usedPercent ?? 0

    Row {
        id: content
        anchors.centerIn: parent
        spacing: Styling.gapsInSmall

        Icon {
            name: Icons.storage
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: root.selectedDisk + ": " + root.usedPercent + "%"
            anchors.verticalCenter: parent.verticalCenter
            color: Styling.colors.onSurface
        }

    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (mouse) => { 
            if (mouse.button === Qt.RightButton) root.selected = (root.selected + 1) % root.trackedAmount
            else GlobalShortcuts.storagePopupOpen = !GlobalShortcuts.storagePopupOpen
        }
    }

    LazyLoader {
        id: storagePopupLoader
        loading: true
        active: GlobalShortcuts.storagePopupOpen

        StoragePopup {
            anchor.item: root
            anchor.margins.top: root.height + 15
            visible: GlobalShortcuts.storagePopupOpen
        }
    }
}
