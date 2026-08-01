pragma Singleton
import Quickshell
import Quickshell.Networking
import qs.common

Singleton {
    property NetworkDevice device: Networking.devices?.values.length > 0 ? Networking.devices.values[0] : null ?? null
    property ObjectModel networks: device?.networks ?? null
    property bool connected: device?.connected ?? false
    property bool enabled: Networking?.wifiEnabled ?? false
    property Network connectedNetwork: connected ? (networks.values.find(network => network.connected) ?? null) : null
    property string connectedNetworkSsid: connected ? connectedNetwork?.name ?? "" : ""
    property string icon: {
        if (!enabled) return Icons.wifiDisabled;
        if (!connected) return Icons.wifiUnconnected;
        const signalStrength = connectedNetwork?.signalStrength;
        if (signalStrength < 0.25) return Icons.wifiNone;
        if (signalStrength < 0.5) return Icons.wifiLow;
        if (signalStrength < 0.75) return Icons.wifiMedium;
        return Icons.wifiHigh;
    }

    function toggleWifi() {
        Networking.wifiEnabled = !Networking.wifiEnabled;
    }
}
