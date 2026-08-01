pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import qs.common

Singleton {
    property string icon: Icons.memory

    property string info: ""
    property list<string> entries: info.length > 0 ? info.split("\n") : []
    property int total: entries.length > 0 ? Number(entries[0].split(/\s+/)[1]) : "0"
    property int available: entries.length > 0 ? Number(entries[2].split(/\s+/)[1]) : 0
    property int used: total - available
    property int usedPercent: total > 0 ? Math.round(used / total * 100) : 0

    property int trackedProcesses: 5
    property list<var> processes: []

    property int qsUsed: 0

    property string unit: "KiB"

    Process {
        id: memProc
        command: ["sh", "-c", "cat /proc/meminfo"]
        stdout: StdioCollector {
            onStreamFinished: info = this.text
        }
        running: true
    }

    Process {
        id: qsMemProc
        command: ["sh", "-c", `ps -o rss -p ${Quickshell.processId}`]
        stdout: StdioCollector {
            onStreamFinished: {
                const output = this.text.split("\n");
                qsUsed = output.length > 1 ? output[1].trim() : 0;
            }
        }
        running: true
    }

    Process {
        id: genMemByProcessProc
        command: ["sh", "-c", `ps -eo pid,user,comm,rss,%mem --sort=-rss | head -n ${trackedProcesses + 1}`]
        stdout: StdioCollector {
            onStreamFinished: {
                processes = [];
                const entries = this.text.split("\n");
                entries.shift();
                const pattern = /^\s*(\d+)\s+([^\s]+)\s+([\S]+(?:\s[\S]+)*)\s+(\d+)\s+((?:0|[1-9]\d*)(?:\.\d+)?)$/;
                entries.forEach((entry) => {
                    const match = pattern.exec(entry.trim());
                    if (match != null) {
                        processes.push({
                            "pid": parseInt(match[1]),
                            "user": match[2],
                            "command": match[3],
                            "used": parseInt(match[4]),
                            "usedPercent": parseFloat(match[5])
                        });
                    }
                });
            }
        }
        running: true
    }

    Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: if (!memProc.running) memProc.running = true
    }

    Timer {
        interval: 5000
        repeat: true
        running: GlobalShortcuts.memoryPopupOpen
        triggeredOnStart: true
        onTriggered: if (!genMemByProcessProc.running) genMemByProcessProc.running = true
    }

    Timer {
        interval: 5000
        repeat: true
        running: GlobalShortcuts.memoryPopupOpen
        triggeredOnStart: true
        onTriggered: if (!qsMemProc.running) qsMemProc.running = true
    }
}
