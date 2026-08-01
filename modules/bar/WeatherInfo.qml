import Quickshell
import QtQuick
import qs.common
import qs.common.components
import qs.services

Row {
    spacing: Styling.gapsInSmall

    Icon {
        name: Weather.currentWeatherIcon
        iconSize: 16
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        text: Weather.currentTemp + "°C"
        anchors.verticalCenter: parent.verticalCenter
        color: Styling.colors.onSurface
    }
}
