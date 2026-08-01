import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs.common
import qs.common.components
import qs.services

ClippingRectangle {
    radius: Styling.rounding
    color: Styling.colors.surfaceContainerLow
    
    Image {
        id: noNotifsIcon
        source: Quickshell.iconPath("xsi-notifications-disabled-symbolic")
        anchors.centerIn: parent
        width: 100
        height: 100
        visible: Notifications.notifCount === 0
    }

    ColorOverlay {
        source: noNotifsIcon
        anchors.fill: noNotifsIcon
        color: Styling.colors.onSurface
        visible: noNotifsIcon.visible
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Styling.gapsInBorderTiny

        ScrollView {
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            visible: Notifications.notifCount > 0

            ListView {
                id: notificationsList
                anchors.fill: parent
                spacing: Styling.gapsInSmall

                model: Notifications.notifs.values

                delegate: Rectangle {
                    id: notificationContainer
                    implicitHeight: notification.implicitHeight + 2 * Styling.gapsInBorderSmall
                    width: notificationsList.width
                    radius: Styling.rounding
                    color: Styling.colors.surfaceContainerHigh
                    required property var modelData
                        RowLayout {
                            id: notification
                            spacing: Styling.gapsIn
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.margins: Styling.gapsInBorderSmall

                            IconImage {
                                id: notificationIcon
                                source: modelData.image ? modelData.image : Quickshell.iconPath("xsi-notifications-symbolic")
                                mipmap: true
                                implicitSize: 40
                            }

                            ColumnLayout {
                                id: content
                                spacing: Styling.gapsInSmall
                                Layout.fillWidth: true

                                Text {
                                    text: modelData.appName
                                    Layout.fillWidth: true
                                    font.bold: true
                                    color: Styling.colors.onSurface
                                }
                                Text {
                                    text: modelData.body
                                    Layout.fillWidth: true
                                    elide: Text.ElideRight
                                    wrapMode: Text.Wrap
                                    color: Styling.colors.onSurface
                                }
                            }
                        }
                    }
            }
        }

        Rectangle {
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            implicitHeight: controlsRow.implicitHeight
            color: Styling.colors.surfaceContainerLow

            Row {
                id: controlsRow
                anchors.fill: parent
                spacing: width - dndContainer.width - clearContainer.width

                Rectangle {
                    id: dndContainer
                    implicitHeight: 40
                    implicitWidth: 40
                    radius: height / 2
                    color: dndContainerArea.containsMouse ? Styling.colors.surfaceContainerHigh : Styling.colors.surfaceContainerLow
                    
                    Icon {
                        name: Notifications.dndIcon
                        iconSize: Styling.fontLarge
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        id: dndContainerArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: Notifications.toggleDnd()
                    }
                }

                Rectangle {
                    id: clearContainer
                    implicitHeight: 40
                    implicitWidth: 40
                    radius: height / 2
                    color: clearContainerArea.containsMouse ? Styling.colors.surfaceContainerHigh : Styling.colors.surfaceContainerLow

                    Icon {
                        name: Icons.deleteAll
                        iconSize: Styling.fontLarge
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        id: clearContainerArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: Notifications.dismissAll()
                    }
                }
            }
        }
    }
}
