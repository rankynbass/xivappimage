#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y \
    file \
    wget \
    curl \
    unzip \
    zsync \
    fuse3 \
    libjxr0 \
    libsdl2-2.0-0 \
    libsecret-1-0 \
    libicu-dev \
    dpkg-dev \
    pcregrep

./create-basedir.sh
./copy-tools.sh
./copy-deps.sh
./copy-xivlauncher.sh
./make-appimage.sh
