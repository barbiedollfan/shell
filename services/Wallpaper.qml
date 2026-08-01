pragma Singleton
import Quickshell
import Quickshell.Io
import qs.common

Singleton {
    property string currentWallpaper: wallpaperCache.text().trim()

    FileView {
        id: wallpaperCache
        path: `${Directories.wallpapersCache}/eDP-1`
    }

    onCurrentWallpaperChanged: {
        wallpaperCache.setText(currentWallpaper);
    }
}
