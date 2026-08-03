import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.common
import qs.common.utils
import qs.common.components
import qs.services

StyledPopup {
    property string displayedUsageUnit: "GiB"
    property string displayedProcUnit: "MiB"
    property string dataUnit: Memory.unit

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Text {
            property string formattedUsed: Utils.convertRounded(Memory.used, dataUnit, displayedUsageUnit, 1)
            property string formattedTotal: Utils.convertRounded(Memory.total, dataUnit, displayedUsageUnit, 1)

            text: `Used: ${formattedUsed} / ${formattedTotal} ${displayedUsageUnit} (${Memory.usedPercent}%)`
            color: Styling.colors.onSurface
            font.pixelSize: 13
        }

        Text {
            text: `Quickshell: ${Utils.convertRounded(Memory.qsUsed, dataUnit, displayedProcUnit, 1)} ${displayedProcUnit}`
            color: Styling.colors.onSurface
            font.pixelSize: 13
        }

        Rectangle {
            implicitHeight: 2
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            radius: this.height / 2
            color: Styling.colors.surfaceContainer
        }

        Text {
            text: "Processes"
            font.pixelSize: 13
            font.bold: true
            color: Styling.colors.onSurface
        }

        GridLayout {
            columns: 3
            columnSpacing: 10
            Layout.fillWidth: true
            
            Repeater {
                model: Memory.processes.reduce((accumulator, current) => accumulator.concat([String(current.pid), current.command, `${Utils.convertRounded(current.used, dataUnit, displayedProcUnit, 1)} ${displayedProcUnit}`]), []) 

                Text {
                    text: modelData
                    color: Styling.colors.onSurface

                    required property string modelData
                }
            }
        }
    }
}
