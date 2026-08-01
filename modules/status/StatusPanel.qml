import Quickshell
import QtQuick
import qs.common
import qs.services

Rectangle {
    implicitWidth: 700
    implicitHeight: 500
    radius: Styling.rounding
    color: Styling.colors.surface

    Row {
        spacing: 10
        Text {
            text: SystemInfo.os 
            color: Styling.colors.onSurface
        }
        Text {
            text: SystemInfo.architecture
            color: Styling.colors.onSurface
        }
        Text {
            text: SystemInfo.device
            color: Styling.colors.onSurface
        }
        Text {
            text: SystemInfo.host
            color: Styling.colors.onSurface
        }
        Text {
            text: SystemInfo.user
            color: Styling.colors.onSurface
        }
        Text {
            text: SystemInfo.uptime
            color: Styling.colors.onSurface
        }
    }
}
