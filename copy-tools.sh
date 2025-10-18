#!/usr/bin/env bash
if [ -f "xivlauncher-rb/usr/bin/busybox" ]; then
    rm -rf "xivlauncher-rb/usr/bin"
    mkdir -p "xivlauncher-rb/usr/bin"
fi
cd xivlauncher-rb/usr/bin
echo "Downloading busybox"
echo "==================="
wget https://github.com/ruanformigoni/busybox-static-musl/releases/download/7e2c5b6/busybox-x86_64 -O busybox
chmod +x busybox
./busybox --list | xargs -I % ln -s busybox %

echo ""
echo "Downloading aria2"
echo "================="
wget -qO- "https://github.com/abcfy2/aria2-static-build/releases/download/continuous/aria2-x86_64-linux-musl_static.zip" | zcat > aria2c
chmod +x aria2c