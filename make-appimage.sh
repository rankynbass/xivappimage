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
update_data="gh-releases-zsync|rankynbass|XIVLauncher.Core|latest|xivlauncher-rb-x86_64.AppImage.zsync"
appdir="${current}/xivlauncher-rb"
output_name="xivlauncher-rb-x86_64.AppImage"

echo ""
echo "Creating AppImage"
echo "================="

if [ -z "$APP_VERSION" ]; then
    APP_VERSION=$(date --utc +%Y.%m.%d-%H.%M)
elif [ -n "$APP_RELEASE" ]; then
    APP_VERSION="$APP_VERSION-$APP_RELEASE"
fi

sed -i "s/X-AppImage-Version=\(.*\)/X-AppImage-Version=$APP_VERSION/" $current/xivlauncher-rb/usr/share/applications/xivlauncher-rb.desktop

squashfs-root/AppRun -u "$update_data" "$appdir" "$output_name"
mv xivlauncher-rb-x86_64.AppImage* output/
