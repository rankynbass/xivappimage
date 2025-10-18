#!/usr/bin/env bash

echo ""
echo "Downloading AppImage tool"
echo "========================="

current=$(pwd)
mkdir -p build/output
cd build
if [ ! -f "appimagetool" ]; then
    wget "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage" -O "appimagetool"
    chmod +x appimagetool
fi
./appimagetool --appimage-extract
update_data="gh-releases-zsync|rankynbass|xivlauncher-appimage|latest|xivlauncher-rb-x86_64.AppImage.zsync"
appdir="${current}/xivlauncher-rb"
output_name="xivlauncher-rb-x86_64.AppImage"

echo ""
echo "Creating AppImage"
echo "================="

squashfs-root/AppRun -u "$update_data" "$appdir" "$output_name"
mv xivlauncher-rb-x86_64.AppImage* output/
