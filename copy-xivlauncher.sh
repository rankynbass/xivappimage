#!/usr/bin/env bash
if [ -f "xivlauncher-rb/opt/xivlauncher-rb/XIVLauncher.Core" ]; then
    rm -rf "xivlauncher-rb/opt/xivlauncher-rb"
    mkdir -p "xivlauncher-rb/opt/xivlauncher-rb"
fi
if [ -z "$1" ]; then
    release="latest/download"
else
    release="download/$1"
fi
cd xivlauncher-rb/opt/xivlauncher-rb

echo ""
echo "Copying and extracting XIVLauncher-RB"
echo "====================================="
wget "https://github.com/rankynbass/XIVLauncher.Core/releases/${release}/XIVLauncher.Core.tar.gz" -O "XIVLauncher.Core.tar.gz"
tar -xf XIVLauncher.Core.tar.gz
rm XIVLauncher.Core.tar.gz
