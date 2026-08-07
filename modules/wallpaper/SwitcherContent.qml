import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.common
import qs.services

Rectangle {
    id: root
    implicitWidth: 700
    implicitHeight: 500
    radius: Styling.rounding
    color: Styling.colors.surface

    property list<string> wallpapers: []

    PathView {
        id: switcher
        anchors.fill: parent
        model: root.wallpapers
        delegate: Image {
            source: modelData
            width: 640
            height: 400
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectCrop
            clip: true
            visible: PathView.isCurrentItem

            required property var modelData
        }
        path: Path {
            startX: root.width / 2
            startY: root.height / 2
        }

        focus: true

        Keys.onPressed: (event) => {
            if (event.key == Qt.Key_Return) Wallpaper.currentWallpaper = currentItem.source
            else if (event.key == Qt.Key_Left) decrementCurrentIndex()
            else if (event.key == Qt.Key_Right) incrementCurrentIndex()
        }
    }

    Process {
        id: getWallpapersProc
        command: ["sh", "-c", `ls ${Directories.wallpapers}`]
        running: GlobalShortcuts.wallpaperSwitcherOpen
        stdout: StdioCollector {
            onStreamFinished: {
                root.wallpapers = text.trim().split("\n").map((wallpaper) => `${Directories.wallpapers}/${wallpaper}`);
            }
        }
    }
}
