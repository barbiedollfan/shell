import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.common
import qs.common.components
import qs.services

StyledPopup {
    Row {
        anchors.centerIn: parent
        spacing: 100

        StyledText {
            text: "Bluetooth"
            font.bold: true
            font.pixelSize: 15
        }

        StyledSwitch {
            checked: Bluetooth.enabled
            onClicked: Bluetooth.toggle()
        }
    }
}
