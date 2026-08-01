pragma Singleton
import Quickshell

Singleton {

    readonly property string home: Quickshell.env("HOME")
    readonly property string config: `${home}/.config`

    readonly property string videos: `${home}/Videos`
    readonly property string videoDownloads: `${videos}/Downloads`
    readonly property string videoRecordings: `${videos}/Recordings`

    readonly property string shellRoot: Quickshell.shellDir
    readonly property string shellCache: `${home}/.cache/quickshell`

    readonly property string assets: `${shellRoot}/assets`
    readonly property string scripts: `${shellRoot}/scripts`

    readonly property string wallpapers: `${assets}/wallpapers`
    readonly property string wallpapersCache: `${shellCache}/wallpapers`

}
