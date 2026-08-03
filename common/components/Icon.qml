import Quickshell
import QtQuick
import QtQuick.Controls
import qs.common

Button {
    id: root
    property string name: "question"
    property alias iconColor: root.icon.color
    property int iconSize: 18
    
    icon.source: Qt.resolvedUrl(`${Directories.assets}/icons/${name}.svg`)
    icon.color: Styling.colors.onSurface
    icon.width: iconSize
    icon.height: iconSize

    layer.smooth: true
    
    background: Rectangle {
        width: 0
        height: 0
    }
}
