import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import qs.common
import qs.common.components

Item {
    id: root

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    property var keymapAbbreviations: {}
    property string currentKeymap: ""
    property bool showAbbreviated: true

    Row {
        id: content
        anchors.centerIn: parent
        spacing: Styling.gapsInSmall
        
        Icon {
            name: Icons.keyboard
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: root.showAbbreviated ? root.currentKeymap ? root.keymapAbbreviations[root.currentKeymap] : "" : root.currentKeymap
            anchors.verticalCenter: parent.verticalCenter
            color: Styling.colors.onSurface
        }

    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (mouse) => { 
            if (mouse.button === Qt.RightButton) root.showAbbreviated = !root.showAbbreviated
        }
    }

    Socket {
        path: `${Quickshell.env("XDG_RUNTIME_DIR")}/hypr/${Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")}/.socket2.sock`
        connected: true
        parser: SplitParser {
            property var regex: new RegExp("activelayout>>.*,(.+)");
            onRead: msg => {
                const match = regex.exec(msg);

                if (match != null) {
                    root.currentKeymap = match[1]
                }
            }
        }
    }

    Process {
        id: fetchActiveKeymapProc
        command: ["sh", "-c", "hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap'"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.currentKeymap = this.text.trim()
        }
    }

    Process {
        id: genKeymapList
        command: ["sh", "-c", "cat /usr/share/X11/xkb/rules/base.lst"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const tmpKeymaps = {};
                const chunks = this.text.split("\n\n");
                const maps = chunks.find((chunk) => chunk.includes("! layout")).split("\n");
                maps.shift();
                const pattern = /\s*([a-z]+)\s*(.+)/
                maps.forEach((map) => {
                    const match = pattern.exec(map.trim());
                    if (match != null) {
                        tmpKeymaps[match[2]] = match[1].toUpperCase();
                    }
                });
                root.keymapAbbreviations = tmpKeymaps;
            }
        }
    }
}
