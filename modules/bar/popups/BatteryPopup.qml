import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import qs.common
import qs.common.components
import qs.services

StyledPopup {
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        StyledText {        
            function formatSeconds(s: int): string {
                const hr = Math.floor(s / 3600) % 24;
                const min = Math.floor(s / 60) % 60;

                let components = [];
                if (hr > 0)
                    components.push(`${hr} hours`);
                if (min > 0)
                    components.push(`${min} mins`);

                return components.join(", ");
            }

            text: Battery.charging ? formatSeconds(UPower.displayDevice.timeToFull) ? formatSeconds(UPower.displayDevice.timeToFull) + " to charged" : Battery.percentage < 100 ? "Calculating..." : "Fully charged" : formatSeconds(UPower.displayDevice.timeToEmpty) ? formatSeconds(UPower.displayDevice.timeToEmpty) + " to empty" : "More than a minute probably"
            font.pixelSize: 13
        }

        StyledText {
            text: Battery.charging ? "Charge rate: " + UPower.displayDevice.changeRate.toFixed(2) + "W" : "Discharge rate: " + (UPower.displayDevice.changeRate).toFixed(2) + "W"
            font.pixelSize: 13
        }
        
        Rectangle {
            implicitHeight: 2
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            radius: this.height / 2
            color: Styling.colors.surfaceContainer
        }

        Rectangle {
            id: profilesOutline
            implicitHeight: profilesRow.implicitHeight
            implicitWidth: profilesRow.implicitWidth
            Layout.alignment: Qt.AlignHCenter
            radius: this.height / 2
            color: Styling.colors.surfaceContainer

            RowLayout {
                id: profilesRow
                anchors.centerIn: parent
                spacing: 0
                
                Repeater {
                    model: [
                        PowerProfile.PowerSaver,
                        PowerProfile.Balanced,
                        PowerProfile.Performance
                    ]
                    Rectangle {
                        required property var modelData
                        
                        implicitHeight: 50
                        implicitWidth: 50

                        radius: this.height / 2
                        color: PowerProfiles.profile === modelData ? Styling.colors.primaryContainer : Styling.colors.surfaceContainer

                        Icon {
                            name: Icons.getPowerProfileIcon(modelData)
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: PowerProfiles.profile = modelData
                        }
                    }
                }
            }
        }
    }
}
