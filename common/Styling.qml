pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import qs.services

Singleton {
    readonly property int rounding: 18
    
    // Mainly for visual layouts
    readonly property int gapsIn: 10
    readonly property int gapsInLarge: 14
    readonly property int gapsInBorder: 15
    readonly property int gapsInBorderTiny: 4
    readonly property int gapsInBorderSmall: 10

    // Mainly for items within pills
    readonly property int gapsInSmall: 2
    readonly property int gapsInMedium: 8

    readonly property int gapsOut: 15
    readonly property int gapsOutSmall: 4

    readonly property int pillPadding: 8
    readonly property int pillHeight: 30
    readonly property int pillSpacing: 6
    readonly property int pillSpacingLarge: 12

    readonly property int pillIconGaps: 4
    readonly property int pillElementGaps: 8

    readonly property int barPaddingTop: 5

    readonly property int toggleSphereDiameter: 40
    readonly property int toggleSphereDiameterLarge: 40
    
    readonly property int fontSmall: 14
    readonly property int fontIncremental: 13
    readonly property int fontMedium: 16
    readonly property int fontLarge: 20

    readonly property int infoEntrySpacing: 10

    FileView {
        id: colorsFile
        path: `${Directories.config}/matugen/colors.json`
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
    }

    // Available colors:
    // primary
    // onPrimary
    // primaryContainer
    // onPrimaryContainer
    // primaryFixed
    // primaryFixedDim
    // onPrimaryFixed
    // onPrimaryFixedVariant
    // inversePrimary
    // secondary
    // onSecondary
    // secondaryContainer
    // onSecondaryContainer
    // secondaryFixed
    // secondaryFixedDim
    // onSecondaryFixed
    // onSecondaryFixedVariant
    // tertiary
    // onTertiary
    // tertiaryContainer
    // onTertiaryContainer
    // tertiaryFixed
    // tertiaryFixedDim
    // onTertiaryFixed
    // onTertiaryFixedVariant
    // error
    // onError
    // errorContainer
    // onErrorContainer
    // surfaceDim
    // surface
    // surfaceTint
    // surfaceBright
    // surfaceContainerLowest
    // surfaceContainerLow
    // surfaceContainer
    // surfaceContainerHigh
    // surfaceContainerHighest
    // onSurface
    // onSurfaceVariant
    // inverseSurface
    // inverseOnSurface
    // surfaceVariant
    // shadow
    // scrim
    // outline
    // outlineVariant
    property var colors: JSON.parse(colorsFile.text())

    property string colorScheme: "vibrant"

    Process {
        id: genColorsProc
        command: ["sh", "-c", `matugen image ${Wallpaper.currentWallpaper} -t scheme-${colorScheme} --source-color-index 0`]
    }

    Connections {
        target: Wallpaper
        function onCurrentWallpaperChanged() {
            genColorsProc.running = true;
        }
    }
}
