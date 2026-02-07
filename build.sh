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
    libsdl3-0 \
    libsecret-1-0 \
    libicu-dev \
    dpkg-dev \
    pcregrep \
    git \
    gcc \
    g++ \
    libsdl3-dev \
    libsdl3-image-dev \
    libfreetype-dev \
    luajit

./create-basedir.sh
./copy-tools.sh
./copy-deps.sh
./copy-xivlauncher.sh
./copy-imgui.sh
./make-appimage.sh
