pragma Singleton
import Quickshell
import Quickshell.Bluetooth
import qs.common

Singleton {
    property BluetoothAdapter adapter: Bluetooth?.defaultAdapter ?? null
    property bool enabled: adapter?.enabled ?? false
    property list<BluetoothDevice> connectedDevices: adapter?.devices?.values.filter(device => device.connected) ?? null
    property int numberConnectedDevices: connectedDevices?.length ?? 0
    property string icon: {
        if (!enabled) return Icons.bluetoothDisabled;
        if (numberConnectedDevices > 0) return Icons.bluetoothConnected;
        return Icons.bluetoothEnabled;
    }

    function toggle() {
        adapter.enabled = !adapter.enabled
    }
}
