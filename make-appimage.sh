#!/usr/bin/env bash
current=$(pwd)
mkdir -p build
cd build
if [ ! -f "appimagetool" ]; then
    wget "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage" -O "appimagetool"
    chmod +x appimagetool
fi
update_data="gh-releases-zsync|rankynbass|xivlauncher-appimage|latest|xivlauncher-rb-x86_64.AppImage.zsync"
appdir="${current}/xivlauncher-rb"
output_name="xivlauncher-rb-x86_64.AppImage"

./appimagetool -u "$update_data" "$appdir" "$output_name"
