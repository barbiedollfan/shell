import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.common
import qs.common.utils

PopupWindow {
    implicitHeight: bg.implicitHeight
    implicitWidth: bg.implicitWidth
    color: "transparent"

    property string displayedUnit: "GiB";
    property string usageUnit: Storage?.usageUnit;

    Rectangle {
        id: bg
        implicitHeight: content.implicitHeight + 2 * Styling.gapsOut
        implicitWidth: content.implicitWidth + 2 * Styling.gapsOut
        color: Styling.colors.surface
        radius: Styling.rounding

        ColumnLayout {
            id: content
            anchors.centerIn: parent
            spacing: 10

            Text {
                text: "Usage"
                font.bold: true
                font.pixelSize: 13
                color: Styling.colors.onSurface
            }

            Repeater {
                model: Storage?.trackedDisks

                Text {
                    property var current: Storage?.usage ? Storage?.usage[modelData] : {}
                    property string formattedUsed: Utils.convertRounded(current?.used ?? 0, usageUnit, displayedUnit, 1) 
                    property string formattedTotal: Utils.convertRounded(current?.total ?? 1, usageUnit, displayedUnit, 1) 

                    text: `${modelData}: ${formattedUsed} / ${formattedTotal} ${displayedUnit} (${current?.usedPercent ?? 0}%)`
                    font.pixelSize: 13
                    color: Styling.colors.onSurface

                    required property string modelData
                }
            }

            Rectangle {
                implicitHeight: 2
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                radius: this.height / 2
                color: Styling.colors.surfaceContainer
            }

            Text {
                text: "Breakdown"
                font.bold: true
                font.pixelSize: 13
                color: Styling.colors.onSurface
            }

            Repeater {
                property var categories: Storage?.usageCategories

                model: categories ? Object.entries(categories) : []

                Text {
                    text: `${Utils.capitalize(modelData[0])}: ${Utils.convertRounded(modelData[1], usageUnit, displayedUnit, 1)} ${displayedUnit}`
                    font.pixelSize: 13
                    color: Styling.colors.onSurface

                    required property list<var> modelData
                }
            }
        }
    }
}
