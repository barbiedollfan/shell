import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.common
import qs.common.components

Rectangle {
    implicitWidth: 300
    implicitHeight: appEntry.implicitHeight + 2 * Styling.gapsInBorderSmall
    Layout.alignment: Qt.AlignHCenter
    color: isSelected ? Styling.colors.surfaceContainerHighest : Styling.colors.surfaceContainer
    radius: Styling.rounding

    required property var appObject
    required property bool isSelected

    RowLayout {
        id: appEntry
        spacing: Styling.gapsInMedium
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: Styling.gapsInBorderSmall

        IconImage {
            source: Quickshell.iconPath(appObject.icon, "xsi-emblem-important-symbolic")
            implicitSize: 40
        }

        ColumnLayout {
            id: appEntryContent
            spacing: Styling.gapsInSmall
            Layout.fillWidth: true

            StyledText {
                text: appObject.name
                Layout.fillWidth: true
                font.bold: true
                elide: Text.ElideRight
            }
            StyledText {
                text: appObject.description
                Layout.fillWidth: true
                elide: Text.ElideRight
            }
        }
    }
}
