import Quickshell
import Quickshell.Io
import QtQuick
import qs.common
import qs.common.components
import qs.modules.bar.popups
import qs.services

Info {
    id: storageInfo

    property int selected: 0
    property list<string> trackedDisks: Storage?.trackedDisks ?? []
    property int trackedAmount: trackedDisks.length
    property string selectedDisk: trackedDisks[selected]
    property var selectedDiskInfo: Storage.usage ? Storage?.usage[selectedDisk] : {}
    property int usedPercent: selectedDiskInfo?.usedPercent ?? 0

    iconName: Icons.storage
    text: selectedDisk + ": " + usedPercent + "%"
    onToggled: (mouse) => { 
        if (mouse.button === Qt.LeftButton) GlobalShortcuts.storagePopupOpen = !GlobalShortcuts.storagePopupOpen;
        else if (mouse.button === Qt.RightButton) selected = (selected + 1) % trackedAmount;
    }

    StoragePopup {
        anchorItem: storageInfo
        active: GlobalShortcuts.storagePopupOpen
    }
}
