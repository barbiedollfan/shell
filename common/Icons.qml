pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property string powerSaverProfile: "leaf"
    readonly property string balancedProfile: "balance"
    readonly property string performanceProfile: "rocket"
    
    readonly property string batteryCharging: "lightningBolt"
    readonly property string batteryCritical: "batteryCritical"
    readonly property string batteryEmpty: "batteryEmpty"
    readonly property string battery1: "battery1"
    readonly property string battery2: "battery2"
    readonly property string battery3: "battery3"
    readonly property string battery4: "battery4"
    readonly property string battery5: "battery5"
    readonly property string battery6: "battery6"
    readonly property string batteryFull: "batteryFull"

    readonly property string volumeMuted: "volumeMuted"
    readonly property string volumeLow: "volumeEmpty"
    readonly property string volumeMedium: "volumeLow"
    readonly property string volumeHigh: "volumeHigh"

    readonly property string brightnessLow: "sunDim"
    readonly property string brightnessHigh: "sun"

    readonly property string wifiUnconnected: "wifiX"
    readonly property string wifiDisabled: "wifiDisabled"
    readonly property string wifiNone: "wifiNone"
    readonly property string wifiLow: "wifiLow"
    readonly property string wifiMedium: "wifiMedium"
    readonly property string wifiHigh: "wifiHigh"
    readonly property string wifiFull: "wifiFull"

    readonly property string bluetoothDisabled: "bluetoothDisabled"
    readonly property string bluetoothEnabled: "bluetoothEnabled"
    readonly property string bluetoothConnected: "bluetoothConnected"

    readonly property string memory: "memory"
    readonly property string brainDigital: "brainDigital"
    readonly property string storage: "hardDrive"
    readonly property string keyboard: "keyboard"
    readonly property string search: "magnifyingGlass"
    readonly property string sunDim: "sunDim"

    readonly property string idleEnabled: "moon"
    readonly property string idleDisabled: "moonCrossed"

    readonly property string notificationsEnabled: "notificationsEnabled"
    readonly property string notificationsDisabled: "notificationsDisabled"

    readonly property string deleteAll: "trashSweep"
    readonly property string power: "power"

    readonly property string clearDay: "sunBright"
    readonly property string clearNight: "moonStars"
    readonly property string partlyCloudyDay: "cloudySun"
    readonly property string partlyCloudyNight: "cloudyMoon"
    readonly property string cloudy: "cloud"
    readonly property string foggy: "fog"
    readonly property string drizzle: "cloudRain"
    readonly property string rainy: "rain"
    readonly property string lightSnow: "cloudSnow"
    readonly property string snowy: "snowflake"
    readonly property string thunderstorm: "cloudThunder"


    function getPowerProfileIcon(powerProfile: var): string {
        if (powerProfile === PowerProfile.PowerSaver) return powerSaverProfile;
        if (powerProfile === PowerProfile.Balanced) return balancedProfile;
        return performanceProfile;
    }
}
