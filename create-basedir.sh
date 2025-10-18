#!/usr/bin/env bash

echo "Creating base directory structure"
echo "================================="
mkdir -p xivlauncher-rb/opt/xivlauncher-rb
mkdir -p xivlauncher-rb/usr/bin
mkdir -p xivlauncher-rb/usr/lib
mkdir -p xivlauncher-rb/usr/share/applications
mkdir -p xivlauncher-rb/usr/share/icons

echo ""
echo "Copying resources"
echo "================="
cp resources/xivlauncher-rb xivlauncher-rb/usr/bin/xivlauncher-rb
chmod +x xivlauncher-rb/usr/bin/xivlauncher-rb

cp resources/xivlauncher-rb.desktop xivlauncher-rb/usr/share/applications/xivlauncher-rb.desktop

cp resources/xivlauncher-rb.png xivlauncher-rb/usr/share/icons/xivlauncher-rb.png

cd xivlauncher-rb
ln -sf usr/bin/xivlauncher-rb AppRun
ln -sf usr/share/applications/xivlauncher-rb.desktop xivlauncher-rb.desktop
ln -sf usr/share/icons/xivlauncher-rb.png xivlauncher-rb.png
