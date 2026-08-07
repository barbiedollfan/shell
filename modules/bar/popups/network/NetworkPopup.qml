import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.common
import qs.common.components
import qs.services
import qs.modules.bar.popups

StyledPopup {
    id: root

    content: ColumnLayout {
        anchors.centerIn: parent
        spacing: 10
        implicitWidth: 300
        
        ColumnLayout {
            spacing: 2
            Layout.fillWidth: true
            Layout.minimumWidth: 150
            Layout.preferredWidth: 300

            RowLayout {
                StyledText {
                    text: "Wi-Fi"
                    font.bold: true
                    font.pixelSize: 14
                    color: Styling.colors.secondary
                }

                Item {
                    Layout.fillWidth: true
                }

                StyledSwitch {
                    checked: Network.enabled
                    onClicked: Network.toggleWifi()
                }
            }

            StyledText {
                text: Network.enabled ? Network.status : "Disabled"
                font.pixelSize: 13
            }
        }

        Rectangle {
            implicitHeight: 2
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            radius: this.height / 2
            color: Styling.colors.surfaceContainer
        }

        StyledText {
            text: "Networks"
            font.bold: true
            font.pixelSize: 14
            color: Styling.colors.secondary
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 0

            StyledText {
                text: "Known Networks"
                font.bold: true
                font.pixelSize: 13
                color: Styling.colors.secondary
            }

            Repeater {
                model: Network.knownNetworks
                
                NetworkEntry {
                    Layout.fillWidth: true
                    network: modelData

                    required property var modelData
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            StyledText {
                text: "Other Networks"
                font.bold: true
                font.pixelSize: 13
                color: Styling.colors.secondary
            }
            
            ScrollView {
                Layout.fillWidth: true
                implicitHeight: 200
                clip: true

                ListView {
                    anchors.fill: parent
                    spacing: 0

                    model: Network.unknownNetworks
                    
                    delegate: NetworkEntry {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        network: modelData

                        required property var modelData
                    }
                }
            }
        }
    }
}
