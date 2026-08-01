pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import qs.common

Singleton {
    property PwNodeAudio audioSink: Pipewire.defaultAudioSink?.audio ?? null 
    property real level: audioSink?.volume ?? 0
    property int percentage: Math.round(level * 100)
    property bool muted: audioSink?.muted ?? false
    property string icon: {
        if (muted) return Icons.volumeMuted;
        if (percentage < 30) return Icons.volumeLow;
        if (percentage < 60) return Icons.volumeMedium;
        return Icons.volumeHigh;
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
}

