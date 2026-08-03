import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.common
import qs.common.components
import qs.common.utils

Rectangle {
    id: root
    implicitWidth: content.implicitWidth + 2 * Styling.gapsInBorderSmall
    implicitHeight: content.implicitHeight + 2 * Styling.gapsInBorderSmall
    color: Styling.colors.surface
    radius: Styling.rounding

    property var appList: DesktopEntries.applications.values.filter((application) => !application.noDisplay)
    property var appObjects: appList.map((app) => {
        return {
            "name": app.name,
            "icon": app.icon,
            "description": app.comment ? app.comment : "No description",
            "terminalBased": app.runInTerminal,
            "execCommand": app.command,
            "workingDirectory": app.workingDirectory
        }
    })
    property var appObjectsSorted: Searcher.query(input.text, appObjects, { all: true, key: "name" })
    property int maxDisplayed: 6
    property int totalResults: appObjectsSorted.length
    property int selected: 0
    property int bottomIndex: 0
    property int topIndex: maxDisplayed - 1

    function closeLauncher() {
        input.text = "";
        root.selected = 0
        root.bottomIndex = 0
        root.topIndex = root.maxDisplayed - 1
        GlobalShortcuts.launcherOpen = false
    }

    ColumnLayout {
        id: content
        anchors.centerIn: parent
        spacing: Styling.gapsInSmall

        Rectangle {
            implicitWidth: 300
            implicitHeight: 40
            Layout.alignment: Qt.AlignHCenter
            color: Styling.colors.surfaceContainer
            radius: height / 2
            
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 14
                spacing: Styling.gapsInMedium

                Icon {
                    name: Icons.search
                }

                TextField {
                    id: input
                    Layout.fillWidth: true
                    color: Styling.colors.onSurface
                    placeholderText: "Search..."
                    placeholderTextColor: Styling.colors.onSurface
                    background: Rectangle {
                        color: "transparent"
                    }
                    focus: true

                    Keys.onPressed: (event) => { 
                        if ((event.key == Qt.Key_J) && (event.modifiers & Qt.ControlModifier) || event.key == Qt.Key_Down) {
                            root.selected = Math.min(root.totalResults - 1, root.selected + 1);
                            if (root.selected > root.topIndex) { root.topIndex++; root.bottomIndex++; };
                        }
                        else if ((event.key == Qt.Key_K) && (event.modifiers & Qt.ControlModifier) || event.key == Qt.Key_Up) {
                            root.selected = Math.max(0, root.selected - 1);
                            if (root.selected < root.bottomIndex) { root.bottomIndex--; root.topIndex--; };
                        }
                        else if (event.key == Qt.Key_Escape) {
                            if (input.text !== "") { input.clear(); return; }
                            root.closeLauncher()
                        }

                    }

                    onAccepted: {
                        if (appObjectsSorted.length === 0) return;
                        const selectedApp = appObjectsSorted[selected];
                        const command = [...selectedApp.execCommand];
                        if (selectedApp.terminalBased) command.unshift("kitty");
                        Quickshell.execDetached({
                            command: command,
                            workingDirectory: selectedApp.workingDirectory
                        });
                        root.closeLauncher()
                    }
                }
            }
        }

        StyledText {
            text: root.bottomIndex > 0 ? "..." : ""
            font.pixelSize: 8
            Layout.alignment: Qt.AlignHCenter
        }
        Repeater {
            model: appObjectsSorted
            Rectangle {
                id: appEntryContainer
                implicitWidth: 300
                implicitHeight: appEntry.implicitHeight + 2 * Styling.gapsInBorderSmall
                Layout.alignment: Qt.AlignHCenter
                color: index === root.selected ? Styling.colors.surfaceContainerHighest : Styling.colors.surfaceContainer
                visible: index >= root.bottomIndex && index <= root.topIndex
                radius: Styling.rounding
                required property var modelData
                required property int index

                RowLayout {
                    id: appEntry
                    spacing: Styling.gapsInMedium
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: Styling.gapsInBorderSmall

                    IconImage {
                        source: Quickshell.iconPath(modelData.icon, "xsi-emblem-important-symbolic")
                        implicitSize: 40
                    }

                    ColumnLayout {
                        id: appEntryContent
                        spacing: Styling.gapsInSmall
                        Layout.fillWidth: true

                        StyledText {
                            text: modelData.name
                            Layout.fillWidth: true
                            font.bold: true
                            elide: Text.ElideRight
                        }
                        StyledText {
                            text: modelData.description
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                        }
                    }
                }
            }

        }
        StyledText {
            text: root.topIndex < root.totalResults - 1 ? "..." : ""
            font.pixelSize: 8
            Layout.alignment: Qt.AlignHCenter
        }
    }

    onTotalResultsChanged: {
        root.selected = 0;
        root.bottomIndex = 0;
        root.topIndex = Math.min(root.maxDisplayed - 1, root.totalResults - 1)
    }

}
