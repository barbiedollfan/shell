import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.common

PopupWindow {
    id: root
    implicitHeight: outline.implicitHeight
    implicitWidth: outline.implicitWidth
    color: "transparent"

    Rectangle {
        id: outline
        implicitHeight: content.implicitHeight + 2 * Styling.gapsOut
        implicitWidth: content.implicitWidth + 2 * Styling.gapsOut
        radius: Styling.rounding
        color: Styling.colors.surface

        ColumnLayout {
            id: content
            anchors.centerIn: parent
            spacing: Styling.gapsInLarge

            RowLayout {
                Layout.fillWidth: true

                WifiWidget {
                    implicitHeight: 70
                    Layout.fillWidth: true
                }
                BluetoothWidget {
                    implicitHeight: 70
                    Layout.fillWidth: true
                }
            }

            NotificationsWidget {
                implicitHeight: 400
                implicitWidth: 400
            }

            VolumeWidget {
                Layout.fillWidth: true
            }

            BrightnessWidget {
                Layout.fillWidth: true
            }

            PowerWidget {
                Layout.fillWidth: true
            }
        }
    }
}
