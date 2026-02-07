    #!/usr/bin/env bash
    set -ueox pipefail

    echo "Building cimgui and ImGuiImplSDL3"

    workingDir=$(pwd)

    build_dir="$workingDir"/build/imgui
    out_dir="$build_dir/_build"
    mkdir -p "$out_dir"

    cflags="-DIMGUI_USE_WCHAR32=1 -DIMGUI_ENABLE_FREETYPE=1 -DIMGUI_ENABLE_STB_TRUETYPE=1 -DIMGUI_DISABLE_OBSOLETE_FUNCTIONS=1 -fPIC -shared"
    ldflags="-Wl,--no-undefined"

    cimgui_cflags="-DCIMGUI_FREETYPE=1 -DCIMGUI_VARGS0 -DIMGUI_USER_CONFIG=\"$build_dir/cimgui/cimconfig.h\" $(pkg-config --cflags freetype2) $cflags"
    cimgui_ldflags="$(pkg-config --libs freetype2) $ldflags"

    if [ ! -d "$build_dir/imgui" ]; then
        git clone https://github.com/ocornut/imgui $build_dir/imgui -b v1.92.2b-docking --recurse-submodules
    fi

    if [ ! -x "$out_dir/cimgui.so" ]; then
        if [ ! -d "$build_dir/cimgui" ]; then
            cd "$build_dir"
            git clone https://github.com/JunaMeinhold/cimgui -b docking_inter --recurse-submodules
            (cd "$build_dir/cimgui" && git checkout d61baefa0ce2a9db938ffdeb29e64f90f44cc037)
            rm -rf "$build_dir/cimgui/imgui"
            ln -s "$build_dir/imgui" "$build_dir/cimgui/imgui"
        fi
        cd "$build_dir/cimgui"
        (cd ./generator && ./generator.sh)
        "g++" -o "$out_dir/cimgui.so" \
        -I. -Iimgui -Iimgui/misc/freetype \
        $cimgui_cflags \
        imgui/imgui{,_draw,_widgets,_tables,_demo}.cpp \
        imgui/misc/freetype/imgui_freetype.cpp \
        $build_dir/cimgui/{cimgui,cimgui_impl}.cpp \
        $cimgui_ldflags
    fi

    cimgui_impl_cflags="-DCIMGUI_USE_SDL3 -DCIMGUI_USE_SDL3Renderer -DCIMGUI_USE_SDLGPU3 $(pkg-config --cflags sdl3) $cimgui_cflags"
    cimgui_impl_ldflags="$(pkg-config --libs sdl3) $cimgui_ldflags"

    if [ ! -x "$out_dir/ImGuiImplSDL3.so" ]; then
        if [ ! -d "$build_dir/cimgui_impl" ]; then
            cd "$build_dir"
            git clone https://github.com/HexaEngine/cimgui_impl -b main --recurse-submodules
            (cd "$build_dir/cimgui_impl" && git checkout 7a459f54179587dc923749fed44ae34f78c370d3 && git submodule update --init --recursive)
        fi
        cd "$build_dir/cimgui_impl"
        "g++" \
        -o "$out_dir/ImGuiImplSDL3.so" \
        -Iimgui -Iimgui/backends -Iimgui/misc/freetype -Isrc -Iinclude \
        $cimgui_impl_cflags \
        src/cimgui_impl_{core,sdl3,sdl3renderer,sdlgpu3}.cpp \
        imgui/backends/imgui_impl_{sdl3,sdlrenderer3,sdlgpu3}.cpp \
        imgui/imgui{,_tables,_widgets,_draw,_demo}.cpp \
        imgui/misc/freetype/imgui_freetype.cpp \
        $cimgui_impl_ldflags
    fi

rm -f "$workingDir"/xivlauncher-rb/opt/xivlauncher-rb/{cimgui,ImGuiImplSDL3,libSDL3,libSDL3_image}.so

CopyLib () {
    libPath=/usr/lib/x86_64-linux-gnu/$1
    targetLib=$(realpath libPath)
    targetName=$1
    cp "$libPath" "$workingDir"/xivlauncher-rb/opt/xivlauncher-rb/"$1"
}

CopyLib libSDL3.so
CopyLib libSDL3_image.so
cp "$out_dir"/* "$workingDir"/xivlauncher-rb/opt/xivlauncher-rb/