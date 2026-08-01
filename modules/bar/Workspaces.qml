import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import qs.common

Row {
    spacing: Styling.pillSpacing

    Repeater {
        model: Hyprland.workspaces.values

        Rectangle {
            id: workspaceContainer
            implicitWidth: workspaceRow.implicitWidth + 2 * Styling.pillPadding
            implicitHeight: Styling.pillHeight
            color: modelData.active ? Styling.colors.primaryContainer : Styling.colors.surfaceContainerHigh
            radius: height / 2

            required property var modelData
            required property int index
            property list<HyprlandToplevel> toplevels: modelData.toplevels.values

            Row {
                id: workspaceRow
                anchors.centerIn: parent
                spacing: Styling.pillElementGaps

                Text {
                    id: workspaceIndex
                    text: modelData.id
                    anchors.verticalCenter: parent.verticalCenter
                    color: Styling.colors.onSurface
                }

                Row {
                    id: iconRow
                    spacing: Styling.pillIconGaps
                    anchors.verticalCenter: parent.verticalCenter

                    Repeater {
                        model: {
                            const instances = {};
                            toplevels.forEach((toplevel) => {
                                const id = toplevel.wayland?.appId;
                                if (instances.hasOwnProperty(id)) instances[id]++;
                                else instances[id] = 1;
                            });
                            return Object.entries(instances);
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 2

                            Rectangle {
                                implicitWidth: 20
                                implicitHeight: 20
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: "transparent"
                                IconImage {
                                    source: Quickshell.iconPath(DesktopEntries.heuristicLookup(modelData[0])?.icon, "xsi-emblem-important-symbolic")
                                    implicitSize: 20
                                    anchors.centerIn: parent
                                }
                            }
                            
                            Row {
                                spacing: 2
                                anchors.horizontalCenter: parent.horizontalCenter
                                visible: modelData[1] > 1

                                Repeater {
                                    model: modelData[1]

                                    Rectangle {
                                        color: Styling.colors.onSurface
                                        implicitHeight: 2
                                        implicitWidth: implicitHeight
                                        radius: height / 2
                                    }
                                }
                            }

                            required property var modelData
                        }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: modelData.activate()
            }
        }
    }
}
