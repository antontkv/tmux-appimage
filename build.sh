#!/bin/bash

set -x;
set -e;

mkdir -p /tmux-source
cd /tmux-source

if [ $TMUX_VERSION == "master" ]; then
    git clone --depth 1 https://github.com/tmux/tmux.git .
    export TMUX_VERSION=$(git log --format="%H" -n 1 | cut -c 1-7)
    sh autogen.sh
else
    wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION$TMUX_RC.tar.gz
    tar -zxf tmux-$TMUX_VERSION$TMUX_RC.tar.gz --strip-components=1
fi
./configure --prefix=/build/AppDir/usr
make install

cd /build

cat << 'EOF' > ./AppDir/AppRun
#!/bin/bash
unset ARGV0
exec "$(dirname "$(readlink  -f "${0}")")/usr/bin/tmux" ${@+"$@"}
EOF
chmod 755 ./AppDir/AppRun

cat << 'EOF' > ./AppDir/tmux.desktop
[Desktop Entry]
X-AppImage-Name=tmux
X-AppImage-Version=1.0.0
X-AppImage-Arch=x86_64
Name=Tmux
Exec=tmux
Icon=tmux-logo
Type=Application
Categories=Utility;
EOF

export OUTPUT=/tmux-$TMUX_VERSION$TMUX_RC-x86_64.appimage
export APPIMAGE_EXTRACT_AND_RUN=1

./linuxdeploy --appdir ./AppDir --output appimage -e ./AppDir/usr/bin/tmux
