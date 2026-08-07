import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.common
import qs.common.components
import qs.common.utils

StyledPopup {
    property string displayedUnit: "GiB";
    property string usageUnit: Storage?.usageUnit;

    content: ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        StyledText {
            text: "Usage"
            font.bold: true
            font.pixelSize: 13
            color: Styling.colors.secondary
        }

        Repeater {
            model: Storage?.trackedDisks

            StyledText {
                property var current: Storage?.usage ? Storage?.usage[modelData] : {}
                property string formattedUsed: Utils.convertRounded(current?.used ?? 0, usageUnit, displayedUnit, 1) 
                property string formattedTotal: Utils.convertRounded(current?.total ?? 1, usageUnit, displayedUnit, 1) 

                text: `${modelData}: ${formattedUsed} / ${formattedTotal} ${displayedUnit} (${current?.usedPercent ?? 0}%)`
                font.pixelSize: 13

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

        StyledText {
            text: "Breakdown"
            font.bold: true
            font.pixelSize: 13
            color: Styling.colors.secondary
        }

        Repeater {
            property var categories: Storage?.usageCategories

            model: categories ? Object.entries(categories) : []

            StyledText {
                text: `${Utils.capitalize(modelData[0])}: ${Utils.convertRounded(modelData[1], usageUnit, displayedUnit, 1)} ${displayedUnit}`
                font.pixelSize: 13

                required property list<var> modelData
            }
        }
    }
}
