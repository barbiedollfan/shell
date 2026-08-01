import Quickshell
import Quickshell.Services.UPower
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
        anchors.centerIn: parent
        spacing: Styling.gapsInSmall

        Icon {
            name: Battery.icon
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: Battery.percentage + "%"
            color: Styling.colors.onSurface
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: GlobalShortcuts.batteryPopupOpen = !GlobalShortcuts.batteryPopupOpen
    }

    LazyLoader {
        id: batteryPopupLoader
        loading: true
        active: GlobalShortcuts.batteryPopupOpen

        BatteryPopup {
            anchor.item: root
            anchor.margins.top: root.height + 15
            visible: GlobalShortcuts.batteryPopupOpen
        }
    }
}
