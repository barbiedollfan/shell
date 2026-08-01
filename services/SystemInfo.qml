pragma Singleton
import Quickshell
import Quickshell.Io
import QtQml
import qs.common

Singleton {
    property string os: ""
    property string architecture: ""
    property string device: ""
    property string host: ""
    property string user: ""
    property string uptime: ""

    FileView {
        id: osFile
        path: "/etc/os-release"
    }

    Process {
        id: infrastructureProc
        command: ["sh", "-c", "hostnamectl"]
        running: true

        stdout: StdioCollector {

            function parseEntries(entries: list<string>, key: string): string {
                return entries.find((line) => line.includes(key)).split(":")[1].trim();
            }
            onStreamFinished: {
                let output = this.text;
                let lines = output.split("\n");
                os = parseEntries(lines, "Operating System");
                architecture = parseEntries(lines, "Architecture");
                device = parseEntries(lines, "Hardware Model");
                host = parseEntries(lines, "Static hostname");
            }
        }
    }

    Process {
        id: userProc
        command: ["sh", "-c", "whoami"]
        running: true

        stdout: StdioCollector { onStreamFinished: user = this.text }
    }

    Process {
        id: uptimeProc
        command: ["sh", "-c", "uptime -p"]
        running: true

        stdout: StdioCollector { onStreamFinished: uptime = this.text }
    }

    Timer {
        interval: 60000
        repeat: true
        triggeredOnStart: true
        running: GlobalShortcuts.statusPanelOpen
        onTriggered: uptimeProc.running = true
    }
}
