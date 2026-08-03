import QtQuick
import qs.common
import qs.common.components
import qs.services
import qs.modules.bar.popups

Info {
    id: bluetoothInfo
    iconName: Bluetooth.icon
    onToggled: (mouse) => { if (mouse.button === Qt.LeftButton) GlobalShortcuts.bluetoothPopupOpen = !GlobalShortcuts.bluetoothPopupOpen; }

    BluetoothPopup {
        anchorItem: bluetoothInfo
        active: GlobalShortcuts.bluetoothPopupOpen
    }
}

