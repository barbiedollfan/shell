pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
import qs.common

Singleton {
    property bool dnd: false
    property string dndIcon: dnd ? Icons.notificationsDisabled : Icons.notificationsEnabled

    property ObjectModel notifs: notifServer?.trackedNotifications ?? null
    property int notifCount: notifs.values.length

    NotificationServer {
        id: notifServer
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        bodySupported: true
        imageSupported: true
        keepOnReload: false
        persistenceSupported: true

        onNotification: (notification) => {
            notification.tracked = true
        }
    }

    function toggleDnd() {
        dnd = !dnd;
    }

    function dismissAll() {
        notifs.values.forEach((notif) => notif.dismiss());
    }
}
