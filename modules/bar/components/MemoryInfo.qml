import Quickshell
import QtQuick
import qs.common
import qs.common.components
import qs.services
import qs.modules.bar.popups

Info {
    id: memoryInfo
    iconName: Icons.memory
    text: Memory.usedPercent + "%"
    onToggled: (mouse) => { if (mouse.button === Qt.LeftButton) GlobalShortcuts.memoryPopupOpen = !GlobalShortcuts.memoryPopupOpen; }

    MemoryPopup {
        anchorItem: memoryInfo
        active: GlobalShortcuts.memoryPopupOpen
    }
}
