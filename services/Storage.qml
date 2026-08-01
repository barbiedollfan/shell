pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import qs.common

Singleton {
    property list<string> trackedDisks: ["/", "/mnt/shared"]
    property var usageCategories: {}
    property var usage: {}
    property string usageUnit: "K"

    property string home: Directories?.home

    Process {
        id: getUsageProc
        command: ["sh", "-c", `df -h -B ${usageUnit}`]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const tmpUsage = {};
                const output = this.text;
                const lines = output.split("\n");
                const pattern = new RegExp(`([^\\s]+)\\s+(\\d+)${usageUnit}\\s+(\\d+)${usageUnit}\\s+(\\d+)${usageUnit}\\s+(\\d+)%\\s+([^\\s]+)`, "i");
                lines.forEach((line) => {
                    const match = pattern.exec(line.trim());
                    if (match != null) {
                        if (!trackedDisks.includes(match[6])) return;
                        tmpUsage[match[6]] = {
                            "filesystem": match[1],
                            "blocks": parseInt(match[2]),
                            "used": parseInt(match[3]),
                            "total": parseInt(match[4]),
                            "usedPercent": parseInt(match[5])
                        };
                    }
                });
                usage = tmpUsage;
            }
        }
    }

    Process {
        id: getPackageUsageProc
        command: ["sh", "-c", `expac -H ${usageUnit} -s '%m' | awk '{sum += $1} END {printf \"%.0f\", sum}'`]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const clone = Object.assign({}, usageCategories);
                clone["packages"] = parseInt(this.text);
                usageCategories = clone;
            }
        }
    }

    Process {
        id: getHomeUsageProc
        command: ["sh", "-c", `du -s --exclude='.cache' -B ${usageUnit} ${home}`]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const clone = Object.assign({}, usageCategories);
                const output = this.text;
                const pattern = new RegExp(`([\\d]+)${usageUnit}\\s+${home}`);
                const match = pattern.exec(output);
                if (match === null) return;
                clone["home"] = parseInt(match[1]);
                usageCategories = clone;
            }
        }
    }

    Timer {
        interval: 300000
        repeat: true
        onTriggered: if (!getUsageProc.running) getUsageProc.running = true
    }

    Timer {
        interval: 300000
        repeat: true
        onTriggered: if (!getPackageUsageProc.running) getPackageUsageProc.running = true
    }

    Timer {
        interval: 300000
        repeat: true
        onTriggered: if (!getHomeUsageProc.running) getHomeUsageProc.running = true
    }
}

