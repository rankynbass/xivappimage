#!/usr/bin/env bash
depArray=("libjxr0" "libsdl2-2.0-0" "libsecret-1-0" "libicu-dev")
excludeArray=("c" "stdc++" "dl" "rt" "pthread" "m" "wayland-client" "wayland-cursor" "wayland-egl" "wayland-server" "xcb" "xkbcommon" "X11" "X11-xcb" "Xau" "Xcursor" "Xdmcp" "Xext" "Xfixes" "Xi" "Xrandr" "Xrendr" "Xss")
fileArray=()
finalArray=()
rxdpkg='^(.+\.so(\.\d)*)$'
rxldd='^(.+) => (.+) \(0x[0-9a-fA-F]+\)$'
for deps in ${depArray[@]}; do
    fileArray+=$(dpkg-query -L $deps | pcregrep "$rxdpkg" | xargs -I % ldd % | pcregrep -o2 "$rxldd")
done
for entry in ${fileArray[@]}; do
    excludeFile=0
    matchFile=""
    for excluded in ${excludeArray[@]}; do
        match="lib${excluded}.so"
        if [[ "$entry" =~ "$match" ]]; then
            excludeFile=1
            matchFile=$match
        fi
    done
    if [ "$excludeFile" == "1" ]; then
        echo "Excluding $entry for matching $matchFile"
    else
        echo "Copying $entry"
        cp $entry -t xivlauncher-rb/usr/lib/
    fi
done