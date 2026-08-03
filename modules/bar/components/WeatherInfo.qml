import Quickshell
import QtQuick
import qs.common
import qs.common.components
import qs.services

Info {
    iconName: Weather.currentWeatherIcon
    text: Weather.currentTemp + "°C"
}
