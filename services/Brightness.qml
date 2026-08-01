pragma Singleton
import Quickshell
import Quickshell.Io
import qs.common

Singleton {
    property string device: "intel_backlight"
    property string brightnessDir: "/sys/class/backlight/" + device
    property int maxBrightness: maxBrightnessFile.text()
    property int currentBrightness: currentBrightnessFile.text()
    property int percentage: maxBrightness > 0 ? Math.round(currentBrightness / maxBrightness * 100) : 0

    property string icon: {
        if (percentage < 50) return Icons.brightnessLow;
        return Icons.brightnessHigh;
    }

    FileView {
        id: maxBrightnessFile
        path: brightnessDir + "/max_brightness"
        blockLoading: true
        watchChanges: true

        onFileChanged: this.reload()
    }

    FileView {
        id: currentBrightnessFile
        path: brightnessDir + "/brightness"
        blockLoading: true
        watchChanges: true

        onFileChanged: this.reload()
    }
}

