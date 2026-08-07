pragma Singleton
import QtQml
import Quickshell
import Quickshell.Networking
import qs.common

Singleton {
    property NetworkDevice wifiDevice: Networking.devices?.values.find((device) => device.type === DeviceType.Wifi) ?? null

    property bool connected: wifiDevice?.connected ?? false
    property bool enabled: Networking?.wifiEnabled ?? false
    property bool scanning: wifiDevice?.scannerEnabled ?? false
    property string status: ConnectionState.toString(wifiDevice?.state)

    property list<Network> networks: wifiDevice?.networks.values ?? null
    property list<Network> knownNetworks: networks?.filter((network) => network?.known) ?? null
    property list<Network> unknownNetworks: networks?.filter((network) => !network?.known) ?? null
    property Network connectedNetwork: connected ? (networks?.find(network => network?.connected) ?? null) : null ?? null
    property string connectedNetworkSsid: connected ? connectedNetwork?.name ?? "" : ""
    property string icon: {
        if (!enabled) return Icons.wifiDisabled;
        if (!connected) return Icons.wifiUnconnected;
        return wifiIcon(connectedNetwork?.signalStrength);
    }

    function wifiIcon(strength: real): string {
        if (strength < 0.25) return Icons.wifiNone;
        if (strength < 0.5) return Icons.wifiLow;
        if (strength < 0.75) return Icons.wifiMedium;
        return Icons.wifiHigh;
    }

    function toggleWifi() {
        Networking.wifiEnabled = !Networking.wifiEnabled;
    }

    Connections {
        target: GlobalShortcuts
        function onNetworkPopupOpenChanged() {
            if (GlobalShortcuts.networkPopupOpen) wifiDevice.scannerEnabled = true;
        }
    }
}
