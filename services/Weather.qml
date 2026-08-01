pragma Singleton
import Quickshell
import Quickshell.Io
import QtQml
import qs.common

Singleton {
    property string icon: ""
    property real latitude: 45.459
    property real longitude: -73.904
    property string url: `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current=temperature_2m,apparent_temperature,weather_code,precipitation,is_day&timezone=America%2FNew_York`
    property var weatherData: {}
    property var currentWeatherData: weatherData?.current ?? {}
    property int currentTemp: Math.round(currentWeatherData?.temperature_2m ?? 0)
    property bool isDay: currentWeatherData?.is_day ?? true
    property int currentWeatherCode: currentWeatherData?.weather_code ?? 0

    property string currentWeatherIcon: getWeatherIcon(currentWeatherCode)

    function getWeatherIcon(weatherCode: int): string {
        if (weatherCode === 0 || weatherCode === 1) return isDay ? Icons.clearDay : Icons.clearNight;
        else if (weatherCode === 2) return isDay ? Icons.partlyCloudyDay : Icons.partlyCloudyNight;
        else if (weatherCode === 3) return Icons.cloudy; 
        else if (weatherCode === 45 || weatherCode === 48) return Icons.foggy;
        else if (weatherCode === 51 || weatherCode === 53 || weatherCode === 55 || weatherCode === 56 || weatherCode === 57) return Icons.drizzle;
        else if (weatherCode === 61 || weatherCode === 63 || weatherCode === 65 || weatherCode === 66 || weatherCode === 67 || weatherCode === 80 || weatherCode === 81 || weatherCode === 82) return Icons.rainy;
        else if (weatherCode === 71 || weatherCode === 77) return Icons.lightSnow;
        else if (weatherCode === 73 || weatherCode === 75 || weatherCode === 85 || weatherCode === 86) return Icons.snowy;
        else if (weatherCode === 95 || weatherCode === 96 || weatherCode === 99) return Icons.thunderstorm;
        else return Icons.unknown
    }

    function fetchWeather(url: string) {
        var request = new XMLHttpRequest()
        request.open('GET', url)
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    const res = JSON.parse(request.responseText)
                    weatherData = res
                }
            }
        }
        request.send()
    }

    Timer {
        id: fetchWeatherTimer
        interval: 600000
        running: true
        repeat: true
        onTriggered: fetchWeather(url)
    }

    Component.onCompleted: fetchWeather(url)
}

