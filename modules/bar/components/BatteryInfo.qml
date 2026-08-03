import Quickshell
import Quickshell.Services.UPower
import QtQuick
import qs.common
import qs.common.components
import qs.services
import qs.modules.bar.popups

Info {
    id: batteryInfo
    iconName: Battery.icon
    text: Battery.percentage + "%"
    onToggled: (mouse) => { if (mouse.button === Qt.LeftButton) GlobalShortcuts.batteryPopupOpen = !GlobalShortcuts.batteryPopupOpen; }

    BatteryPopup {
        anchorItem: batteryInfo
        active: GlobalShortcuts.batteryPopupOpen
    }
}
