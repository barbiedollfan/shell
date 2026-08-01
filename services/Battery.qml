pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import qs.common

Singleton {
    property UPowerDevice battery: UPower.displayDevice
    property int percentage: Math.round(battery.percentage * 100)
    property bool charging: !UPower.onBattery
    property string icon: {
        if (charging) return Icons.batteryCharging
        if (percentage < 5) return Icons.batteryCritical;
        if (percentage < 10) return Icons.batteryEmpty;
        if (percentage < 20) return Icons.battery1
        if (percentage < 35) return Icons.battery2
        if (percentage < 50) return Icons.battery3
        if (percentage < 65) return Icons.battery4
        if (percentage < 80) return Icons.battery5
        if (percentage < 95) return Icons.battery6
        return Icons.batteryFull
    }

    property bool panicking: battery.ready && !charging && percentage <= 2

    onPanickingChanged: if (!panicProc.running) panicProc.running = true

    Process {
        id: panicProc
        command: ["sh", "-c", "systemctl hibernate"]
      }
}
