import Quickshell
import Quickshell.Io
import QtQuick
import qs.common

Item {
    id: root

    implicitHeight: bg.implicitHeight
    implicitWidth: bg.implicitWidth

    property int elapsedSeconds: 0
    
    function endRecording() {
        recordingProc.signal(2);
        root.elapsedSeconds = 0;
    }

    function formatTimer(time: int): string {
        const minutes = Math.floor(time / 60);
        const seconds = time % 60;

        const minutesStr = String(minutes).padStart(2, '0');
        const secondsStr = String(seconds).padStart(2, '0');

        return `${minutesStr}:${secondsStr}`;
    }

    Rectangle {
        id: bg
        implicitHeight: content.implicitHeight
        implicitWidth: content.implicitWidth
        radius: height / 2
        color: Styling.colors.surfaceContainer

        Row {
            id: content
            anchors.centerIn: parent

            Rectangle {
                implicitHeight: Styling.pillHeight
                implicitWidth: implicitHeight
                anchors.verticalCenter: parent.verticalCenter
                radius: height / 2
                color: recordingProc.running ? Styling.colors.tertiary : Styling.colors.surfaceContainer

                Text {
                    text: ""
                    anchors.centerIn: parent
                    font.pixelSize: Styling.fontMedium
                    color: recordingProc.running ? Styling.colors.onTertiary : Styling.colors.onSurface

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            recordingProc.running ? root.endRecording() : recordingProc.running = true // Call SIGINT
                        }
                    }
                }
            }
            Rectangle {
                implicitWidth: timerLabel.implicitWidth + 2 * Styling.pillPadding
                implicitHeight: Styling.pillHeight
                radius: height / 2
                visible: recordingProc.running
                color: Styling.colors.surfaceContainer

                Text {
                    id: timerLabel
                    text: root.formatTimer(root.elapsedSeconds)
                    anchors.centerIn: parent
                    color: Styling.colors.onSurface
                }
            }
        }
    }
    
    Timer {
        id: recordingTimer
        interval: 1000
        running: recordingProc.running
        repeat: true

        onTriggered: root.elapsedSeconds++
    }

    Process {
        id: recordingProc
        running: false
        command: ['bash', '-c', `wf-recorder --audio -f $(date +"${Directories.videoRecordings}/%Y-%m-%d_%H-%M.mp4")`]
    }
}

