#!/bin/bash
set -e
set -o pipefail

if [[ $# -eq 0 ]] ; then
    echo 'Usage: create_appimage.sh TMUX_VERSION TMUX_RC_NUMBER(optional).'
    echo 'Example: ./create_appimage.sh 3.2a'
    exit 0
fi

TMUX_VERSION=$1
TMUX_RC=$2
TMUX_VER_FULL="$TMUX_VERSION$TMUX_RC-x86_64"

if [ $TMUX_VERSION == "master" ]; then
    TMUX_VER_FULL="$(git ls-remote https://github.com/tmux/tmux.git HEAD | cut -c 1-7)-x86_64"
fi

if
    docker pull antontkv/tmux-appimage:latest
    docker run -e TMUX_VERSION=$TMUX_VERSION -e TMUX_RC=$TMUX_RC --name tmuxappimage antontkv/tmux-appimage:latest
    docker cp tmuxappimage:/tmux-$TMUX_VER_FULL.appimage .
then
    docker rm tmuxappimage
    chmod +x tmux-$TMUX_VER_FULL.appimage
    echo ""
    echo "OK: tmux-$TMUX_VER_FULL.appimage created."
    echo "Recommendation: Move tmux-$TMUX_VER_FULL.appimage to location in your \$PATH."
    echo "Example: sudo mv tmux-$TMUX_VER_FULL.appimage /usr/local/bin/tmux"
else
    docker rm tmuxappimage
    echo "FAIL: tmux-$TMUX_VER_FULL.appimage failed."
fi

