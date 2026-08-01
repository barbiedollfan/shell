pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.common

Singleton {
    property bool inhibitorEnabled: false
    property string icon: inhibitorEnabled ? Icons.idleDisabled : Icons.idleEnabled

    function toggleIdleLock() {
        inhibitorEnabled = !inhibitorEnabled
    }

    IdleMonitor {
        id: monitor
        timeout: 180

        onIsIdleChanged: {
            if (inhibitorEnabled) return 
            if (isIdle) dimScreenProc.running = true
            else restoreBrightnessProc.running = true
        }
    }

    Process {
        id: dimScreenProc
        command: ["sh", "-c", `${Directories.scripts}/dimScreen.sh`]
    }

    Process {
        id: restoreBrightnessProc
        command: ["sh", "-c", "brightnessctl -r"]
    }
}
