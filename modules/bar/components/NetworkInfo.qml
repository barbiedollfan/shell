import QtQuick
import qs.common
import qs.common.components
import qs.services
import qs.modules.bar.popups.network

Info {
    id: networkInfo
    iconName: Network.icon
    onToggled: (mouse) => { if (mouse.button === Qt.LeftButton) GlobalShortcuts.networkPopupOpen = !GlobalShortcuts.networkPopupOpen; }

    NetworkPopup {
        anchorItem: networkInfo
        active: GlobalShortcuts.networkPopupOpen
    }
}

