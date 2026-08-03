import Quickshell
import QtQuick
import qs.common
import qs.common.components
import qs.services

Rectangle {
    implicitWidth: 700
    implicitHeight: 500
    radius: Styling.rounding
    color: Styling.colors.surface

    Row {
        spacing: 10
        StyledText {
            text: SystemInfo.os 
        }
        StyledText {
            text: SystemInfo.architecture
        }
        StyledText {
            text: SystemInfo.device
        }
        StyledText {
            text: SystemInfo.host
        }
        StyledText {
            text: SystemInfo.user
        }
        StyledText {
            text: SystemInfo.uptime
        }
    }
}
